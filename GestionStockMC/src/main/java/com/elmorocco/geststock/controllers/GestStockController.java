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
import org.springframework.web.HttpRequestMethodNotSupportedException;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.servlet.ModelAndView;

import com.elmorocco.geststock.entities.Article;
import com.elmorocco.geststock.entities.BonCommande;
import com.elmorocco.geststock.entities.Famille;
import com.elmorocco.geststock.entities.Fournisseur;
import com.elmorocco.geststock.entities.MouvementStock;
import com.elmorocco.geststock.entities.Produit;
import com.elmorocco.geststock.entities.Stock;
import com.elmorocco.geststock.entities.Stock_Produit;
import com.elmorocco.geststock.entities.Type;
import com.elmorocco.geststock.models.BonCommandeFormModel;
import com.elmorocco.geststock.service.EmailAPI;
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
	
	@Autowired
	private EmailAPI api;
	
	
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
			Stock_Produit ancien=serviceP.getLatestSP(idProduit, stock);
			Date dateMouvement=sdf.parse(dateM);
			if(ancien.getDate().compareTo(dateMouvement)==0){
				Calendar cal=Calendar.getInstance();
				cal.setTime(dateMouvement);
				cal.add(Calendar.MINUTE, 1);
				sp.setDate(cal.getTime());
			}else if(ancien.getDate().compareTo(dateMouvement)>0){
				Calendar cal=Calendar.getInstance();
				cal.setTime(ancien.getDate());
				cal.add(Calendar.MINUTE, 1);
				sp.setDate(cal.getTime());
			}else{
				sp.setDate(dateMouvement);
			}
			if(pTest.getSortie_dose() && (stock==2L || stock==3L )){
				sp.setQuantite(ancien.getQuantite()+(quantite*pTest.getRatioB_D()));
			}else{
				sp.setQuantite(ancien.getQuantite()+(quantite));
			}
			Stock_Produit spOrigine=new Stock_Produit();
			spOrigine.setProduit(p);
			Stock ss=new Stock();
			ss.setCodeStock(1L);
			spOrigine.setStock(ss);
			Stock_Produit ancienOrigine=serviceP.getLatestSP(idProduit,1L);
			if(ancienOrigine.getDate().compareTo(dateMouvement)==0){
				Calendar cal=Calendar.getInstance();
				cal.setTime(dateMouvement);
				cal.add(Calendar.MINUTE, 1);
				spOrigine.setDate(cal.getTime());
			}else if(ancienOrigine.getDate().compareTo(dateMouvement)>0){
				Calendar cal=Calendar.getInstance();
				cal.setTime(ancienOrigine.getDate());
				cal.add(Calendar.MINUTE, 1);
				spOrigine.setDate(cal.getTime());
			}else{
				spOrigine.setDate(dateMouvement);
			}
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
			Stock_Produit ancien=serviceP.getLatestSP(idProduit, 1L);
			Date dateMouvement=sdf.parse(dateM);
			if(ancien.getDate().compareTo(dateMouvement)==0){
				Calendar cal=Calendar.getInstance();
				cal.setTime(dateMouvement);
				cal.add(Calendar.MINUTE, 1);
				sp.setDate(cal.getTime());
			}else{
				sp.setDate(dateMouvement);
			}
			sp.setQuantite(ancien.getQuantite()+quantite);
			serviceP.saveSP(sp);
			m.setTypeMouvement(Type.IN);
			stock=1L;
		}
		m.setProduit(p);
		m.setDestination(serviceP.getStock(stock).getIntitStock());
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
			if(m.getTypeMouvement().toString().equalsIgnoreCase("OUT")){
				out.add("Sortie("+m.getDestination()+")");
			}else{
				out.add("Entrée");
			}
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
		String id=String.valueOf(service.getLatestBCID());
		if(id.equalsIgnoreCase("null")){
			id="1";
		}
		String sn="";
		if(id.length()==1){
			sn="000"+id;
		}else if(id.length()==2){
			sn="00"+id;
		}else if(id.length()==3){
			sn="0"+id;
		}
		Calendar cal=Calendar.getInstance();
		sn+="/"+String.valueOf(cal.get(Calendar.MONTH)+1)+String.valueOf(cal.get(Calendar.YEAR));
		b.setNumCommande(sn);
		List<Article> articles=bc.getArticles();
		for(Article a : articles){
			Produit p=serviceP.getProduitByID(a.getIdProduit());
			a.setNomArticle(p.getNomProduit());
			a.setCommande(b);
		}
		b.setArticles(articles);
		b.setStatCommande("Issue");
		service.addBonCommande(b);
		//Send mail : 
		//api.sendEmail("a.karouaoui@outlook.com","ayoub.karouaoui@gmail.com", "test","SENT FROM WITHIN MY APP");
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
	
	@RequestMapping(value="/BonCommande/supprimer",method=RequestMethod.POST)
	public String deleteBC(@RequestParam(value="idCommande",required=true) Long idCommande ){
		service.removeBC(idCommande);
		return "bcForm";
	}
	@RequestMapping(value="/BonCommande/get",method=RequestMethod.GET)
	public @ResponseBody BonCommande getBC(@RequestParam(value="idCommande",required=true) Long idCommande ){
		return service.getBC(idCommande);
	}
	@RequestMapping(value="/BonCommande/validate",method=RequestMethod.POST)
	@ResponseStatus(value = HttpStatus.OK)
	public void validateBC(@RequestParam(value="idCommande",required=true) Long idCommande ) throws ParseException{
		BonCommande bc=service.getBC(idCommande);
		SimpleDateFormat format=new SimpleDateFormat("dd/MM/yyyy");
		for(Article a : bc.getArticles()){
			saveMouvement(a.getIdProduit(),format.format(new Date()),a.getQuantite(),"IN",1L);
		}
		bc.setStatCommande("Reçue");
		service.updateBC(bc);
	}
	@RequestMapping(value="/BonCommande/change",method=RequestMethod.POST)
	@ResponseStatus(value = HttpStatus.OK)
	public void validateBCChange(@RequestParam(value="idCommande",required=true) Long idCommande,
			@RequestParam("id[]") List<Long> ids,@RequestParam("qtes[]") List<Float> qtes) throws ParseException{
		BonCommande bc=service.getBC(idCommande);
		SimpleDateFormat format=new SimpleDateFormat("dd/MM/yyyy");
		for(Article a : bc.getArticles()){
			for(Long id:ids){
				if(a.getIdArticle()==id){
					a.setQuantite(qtes.get(ids.indexOf(id)));
				}
			}
			saveMouvement(a.getIdProduit(),format.format(new Date()),a.getQuantite(),"IN",1L);
		}
		bc.setStatCommande("Reçue(Avec Rectification)");
		service.updateBC(bc);
	}
	
	@RequestMapping(value="/EtatStock/")
	public String getStatusHome(Model model){
		model.addAttribute("stocks",serviceP.getAllStocks());
		return "etatStock";
	}
	
	@RequestMapping(value="/getFamilleByFournisseurs")
	public @ResponseBody List<Famille> getFamillesByFournisseurs(@RequestParam("codeFournisseur") Long codeFournisseur){
		return serviceP.getFamillesByFournisseur(codeFournisseur);
	}
	
	@RequestMapping(value="/getProdsByFamFour")
	public @ResponseBody List<Produit> getProdsByFamilleAndFournisseurs(@RequestParam("codeFournisseur") Long codeFournisseur,
			@RequestParam("codeFamille") Long codeFamille){
		return serviceP.getProdsByFamilleAndFournisseur(codeFournisseur, codeFamille);
	}
	
	
	@RequestMapping(value="/getSPByStock",method=RequestMethod.GET)
	public @ResponseBody HashMap<String, List<List<Object>>> getSPByStock(@RequestParam Long idStock){
		HashMap<String,List<List<Object>>> finalout=new HashMap<>();
		List<Stock_Produit> dbres=serviceP.getStatProdByStock(idStock);
		List<List<Object>> outs=new ArrayList<List<Object>>();
		for(Stock_Produit sp : dbres){
			List<Object> out=new ArrayList<>();
			out.add(sp.getProduit().getFamille().getNomFamille());
			out.add(sp.getProduit().getNomProduit());
			out.add(sp.getQuantite());
			outs.add(out);
		}
		finalout.put("aaData", outs);
		return finalout;
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
