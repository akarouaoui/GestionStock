package com.elmorocco.geststock.controllers;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.AutoPopulatingList;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.servlet.ModelAndView;

import com.elmorocco.geststock.entities.Article;
import com.elmorocco.geststock.entities.BonCommande;
import com.elmorocco.geststock.entities.Fournisseur;
import com.elmorocco.geststock.entities.MouvementStock;
import com.elmorocco.geststock.entities.Produit;
import com.elmorocco.geststock.entities.Stock;
import com.elmorocco.geststock.entities.Stock_Produit;
import com.elmorocco.geststock.entities.Type;
import com.elmorocco.geststock.models.BonCommandeFormModel;
import com.elmorocco.geststock.service.IGPService;
import com.elmorocco.geststock.service.IGSService;

import net.sf.jasperreports.engine.JRDataSource;
import net.sf.jasperreports.engine.JRParameter;
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;

@Controller
@RequestMapping(value="/GestionStock")
public class GestStockController {

	@Autowired
	private IGSService service;
	
	@Autowired
	private IGPService serviceP;
	
	
	
	@RequestMapping(value="/")
	public String getHome(Model model){
		List<MouvementStock> mvt=service.getMouvementRecent();
		Comparator<MouvementStock> compare=(m1,m2)->m1.getDateMouvement().compareTo(m2.getDateMouvement());
		Collections.sort(mvt,Collections.reverseOrder(compare));
		if(mvt.size()>10){
			mvt=mvt.subList(0, 10);
		}
		model.addAttribute("hist",mvt);
		return "gsHome";
	}
	@RequestMapping(value="/saveMouvement",method=RequestMethod.POST)
	@ResponseStatus(value=HttpStatus.OK)
	public String saveMouvement(@RequestParam(required=true) Long idProduit,@RequestParam(required=true) String dateM,
			@RequestParam(required=true) Float quantite,@RequestParam(required=true) String type,@RequestParam(required=true) Long stock) throws ParseException{
		Produit p=new Produit();
		p.setCodeProduit(idProduit);
		Produit pTest=serviceP.getProduitByID(idProduit);
		Stock s=new Stock();
		s.setCodeStock(stock);
		SimpleDateFormat sdf=new SimpleDateFormat("dd/MM/yyyy");
		MouvementStock m=new MouvementStock(null, sdf.parse(dateM), quantite);
		if(type.equalsIgnoreCase("OUT")){
			Stock_Produit sp=new Stock_Produit();
			sp.setStock(s);
			sp.setProduit(p);
			sp.setDate(sdf.parse(dateM));
			Stock_Produit ancien=serviceP.getLatestSP(idProduit, stock);
			if(pTest.getSortie_dose() && (stock==2L || stock==3L )){
				sp.setQuantite(ancien.getQuantite()+(quantite*pTest.getRatioB_D()));
			}
			Stock_Produit spOrigine=new Stock_Produit();
			spOrigine.setProduit(p);
			Stock ss=new Stock();
			ss.setCodeStock(1L);
			spOrigine.setStock(ss);
			spOrigine.setDate(sdf.parse(dateM));
			Stock_Produit ancienOrigine=serviceP.getLatestSP(idProduit,1L);
			spOrigine.setQuantite(ancienOrigine.getQuantite()-quantite);
			serviceP.saveSP(spOrigine);
			serviceP.saveSP(sp);
			m.setTypeMouvement(Type.OUT);
		}else{
			Stock_Produit sp=new Stock_Produit();
			Stock ss=new Stock();
			ss.setCodeStock(1L);
			sp.setStock(ss);
			sp.setProduit(p);
			sp.setDate(sdf.parse(dateM));
			Stock_Produit ancien=serviceP.getLatestSP(idProduit, 1L);
			sp.setQuantite(ancien.getQuantite()+quantite);
			serviceP.saveSP(sp);
			m.setTypeMouvement(Type.IN);
		}
		m.setProduit(p);
		service.addMouvement(m);
		return "redirect:/GestionStock/";
	}
	@RequestMapping(value="/historique")
	public String getHistoHome(Model model){
		
		return "histComplet";
	}
	@RequestMapping(value="/getHist")
	@ResponseStatus(value=HttpStatus.ACCEPTED)
	public @ResponseBody HashMap<String,List<List<Object>>> getHistData(@RequestParam(required=false) String dateDeb,@RequestParam(required=false) String dateFin,
																		@RequestParam(required=false) String type,
																		@RequestParam(required=false) String idProd) throws ParseException{
		
		//Get all results from DB
		List<MouvementStock> dbres=service.getAllMouvements();
		SimpleDateFormat sdf=new SimpleDateFormat("dd/MM/yyyy");
		
		//Date filter
		if(!dateDeb.equalsIgnoreCase("") && !dateFin.equalsIgnoreCase("")){
			
			//Parse Dates first
			Date dateD=sdf.parse(dateDeb);
			Date dateF=sdf.parse(dateFin);
			
			
			dbres=dbres.stream().filter(m->m.getDateMouvement().after(dateD)).collect(Collectors.toCollection(ArrayList::new));
			dbres=dbres.stream().filter(m->m.getDateMouvement().before(dateF)).collect(Collectors.toCollection(ArrayList::new));
		}
		//Type Filter
		if(!type.equalsIgnoreCase("")){
			dbres=dbres.stream().filter(m->m.getTypeMouvement().name().equals(type)).collect(Collectors.toCollection(ArrayList::new));
		}
		if(!idProd.equalsIgnoreCase("")){
			dbres=dbres.stream().filter(m->m.getProduit().getCodeProduit().longValue()==Long.parseLong(idProd)).collect(Collectors.toCollection(ArrayList::new));
		}
		//Product Filter
		HashMap<String,List<List<Object>>> outs=new HashMap<>();
		List<List<Object>> finalist=new ArrayList<>();
		
		for(MouvementStock m : dbres){
			List<Object> out=new ArrayList<>();
			out.add(sdf.format(m.getDateMouvement()));
			out.add(m.getTypeMouvement().toString());
			out.add(m.getProduit().getNomProduit());
			out.add(m.getProduit().getFamille().getNomFamille());
			out.add(m.getQuantite());
			finalist.add(out);
		}
		
		
		outs.put("aaData", finalist);
		
		
		return outs;
	}
	
	@ModelAttribute(value="model")
	public BonCommandeFormModel setup(){
		BonCommandeFormModel bc=new BonCommandeFormModel();
		bc.setArticles(new AutoPopulatingList<Article>(Article.class));
		return bc;
		
	}
	@RequestMapping(value="/BonCommande")
	public String getBCHome(Model model){
		model.addAttribute("bons", service.getAllBons());
		return "bcHome";
	}
	
	@RequestMapping(value="/BonCommande/Creer")
	public String getBCForm(Model model){
		model.addAttribute("fournisseurs",service.getAllFournisseurs());
		model.addAttribute("model", setup());
		return "bcForm";
	}
	
	@RequestMapping(value="/BonCommande/save",method=RequestMethod.POST)
	public String saveBCForm(@ModelAttribute(value="model") BonCommandeFormModel bc){
		Fournisseur f=new Fournisseur();
		f.setCodeFournisseur(bc.getIdFournisseur());
		BonCommande b=new BonCommande("", new Date(), "new",f);
		//Set num serie de la commande
		
		List<Article> articles=bc.getArticles();
		for(Article a : articles){
			Produit p=serviceP.getProduitByID(a.getIdProduit());
			a.setNomArticle(p.getNomProduit());
			a.setCommande(b);
		}
		b.setArticles(articles);
		service.addBonCommande(b);
		return "redirect:/GestionStock/BonCommande";
	}
	@RequestMapping(value="/BonCommande/getBC")
	public ModelAndView  getBC(ModelAndView modelAndView,@RequestParam Long idBC){
		BonCommande b=service.getBC(idBC);
		JRDataSource datasource=new JRBeanCollectionDataSource(b.getArticles());
		Map<String,Object> parameterMap = new HashMap<String,Object>();
		parameterMap.put("date",b.getDateCommande());
		parameterMap.put("fournisseur",b.getFournisseur().getNomFournisseur());
		parameterMap.put("numero",b.getNumCommande());
		parameterMap.put("datasource", datasource);
		parameterMap.put(JRParameter.REPORT_LOCALE, Locale.FRANCE);
		modelAndView = new ModelAndView("pdfBon", parameterMap);
		return modelAndView;
	}
	@RequestMapping(value="/historique/getExtraction")
	public ModelAndView  getExctractionHebdo(ModelAndView modelAndView,@RequestParam String dfs) throws ParseException{
		SimpleDateFormat sdf=new SimpleDateFormat("dd/MM/yyyy");
		Date df=sdf.parse(dfs);
		Calendar cal=Calendar.getInstance();
		cal.setTime(df);
		cal.add(Calendar.DATE, -7);
		Date dd=cal.getTime();
		List<MouvementStock> dbres=service.getAllMouvements();
		dbres=dbres.stream().filter(m->m.getDateMouvement().after(dd)).collect(Collectors.toCollection(ArrayList::new));
		dbres=dbres.stream().filter(m->m.getDateMouvement().before(df)).collect(Collectors.toCollection(ArrayList::new));
		
		JRDataSource datasource=new JRBeanCollectionDataSource(dbres);
		Map<String,Object> parameterMap = new HashMap<String,Object>();
		//parameterMap.put("date",b.getDateCommande());
		parameterMap.put("datasource", datasource);
		parameterMap.put(JRParameter.REPORT_LOCALE, Locale.FRANCE);
		modelAndView = new ModelAndView("pdfHist", parameterMap);
		return modelAndView;
	}
}
