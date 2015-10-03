package com.elmorocco.geststock.controllers;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;

import com.elmorocco.geststock.entities.Composition;
import com.elmorocco.geststock.entities.Famille;
import com.elmorocco.geststock.entities.Fournisseur;
import com.elmorocco.geststock.entities.Produit;
import com.elmorocco.geststock.entities.Stock;
import com.elmorocco.geststock.entities.Stock_Produit;
import com.elmorocco.geststock.entities.Unite;
import com.elmorocco.geststock.service.IGPService;

@Controller
@RequestMapping(value="/GestionProds")
public class GestProdController {

	@Autowired
	private IGPService service;
	
	
	@RequestMapping(value="/Liste",method=RequestMethod.GET)
	public String getPage(Model model,@RequestParam(value="filter",required=false) Long filter){
		List<Famille> familles=service.getAllFamilles();
		List<Fournisseur> fournisseurs=service.getFournisseurs();
		List<Produit> produits=null;
		if(filter!=null){
			produits=service.getProduitsByFamille(filter);
			model.addAttribute("filter", filter);
		}else{
			produits=service.getAllProduits();
		}
		model.addAttribute("prods",produits);
		model.addAttribute("familles", familles);
		model.addAttribute("fournisseurs", fournisseurs);
		return "gpHome";
	}
	
	
	
	
	@RequestMapping(value="/saveProd",method=RequestMethod.POST)
	public String saveProduit(@RequestParam(value="",required=true) String nomProd,@RequestParam(value="",required=true) Long idFamille,@RequestParam(value="",required=true) Long idFournisseur,
			@RequestParam(value="",required=true) Float prixUnitaire,@RequestParam(value="",required=true) Float stockInitial,@RequestParam(value="",required=true) Float stockMinimal,
			@RequestParam(value="",required=true) String unite,@RequestParam(value="",required=false) String sd,@RequestParam(value="",required=false) Float ratioBD,
			@RequestParam(value="",required=false) Float tva){
		Produit p=new Produit(nomProd, prixUnitaire, stockInitial);
		p.setStockMin(stockMinimal);
		p.setUnite(Unite.valueOf(unite.toUpperCase()));
		p.setPtva(tva);
		if(sd.equalsIgnoreCase("oui")){
			p.setSortie_dose(Boolean.TRUE);
			p.setRatioB_D(ratioBD);
		}else{
			p.setSortie_dose(Boolean.FALSE);
			p.setRatioB_D(null);
		}
		Fournisseur ff=new Fournisseur();
		ff.setCodeFournisseur(idFournisseur);
		p.setFournisseur(ff);
		Famille f=new Famille();
		f.setCodeFamille(idFamille);
		p.setFamille(f);
		List<Stock> stocks=service.getAllStocks();
		for(Stock s : stocks){
			Stock_Produit sp=new Stock_Produit();
			sp.setDate(new Date());
			sp.setProduit(p);
			sp.setStock(s);
			sp.setQuantite(stockInitial);
			service.saveSP(sp);
		}
		return "redirect:/GestionProds/Liste";
	}
	
	
	
	@RequestMapping(value="/saveProdC",method=RequestMethod.POST)
	public String saveProduitCompose(@RequestParam("refP") String name,@RequestParam("pHt") Float pHt,
			@RequestParam("ids[]") List<Long> ids,@RequestParam("qtes[]") List<Float> qtes,@RequestParam("tva") Float ptva){
		Produit pc=new Produit();
		pc.setNomProduit(name);
		pc.setPrixUnitaire(pHt);
		pc.setSortie_dose(Boolean.FALSE);
		pc.setPtva(ptva);
		pc.setFournisseur(null);
		service.addProduit(pc);
		for(int i=0;i<qtes.size();i++){
			Composition c=new Composition();
			Produit p=service.getProduitByID(ids.get(i));
			c.setProduit(pc);
			c.setComposant(p);
			c.setQte(qtes.get(i));
			service.saveComposition(c);
		}
		return "redirect:/GestionProds/Liste";
	}
	
	@RequestMapping(value="/updateProdC",method=RequestMethod.POST)
	public String updateProduitCompose(@RequestParam("idP") Long idProduit,@RequestParam("refP") String name,@RequestParam("pHt") Float pHt,
			@RequestParam("ids[]") List<Long> ids,@RequestParam("qtes[]") List<Float> qtes,@RequestParam("tva") Float ptva){
		Produit pc=service.getProduitByID(idProduit);
		service.clearCompositionByProduit(idProduit);
		for(int i=0;i<qtes.size();i++){
			Composition c=new Composition();
			Produit p=service.getProduitByID(ids.get(i));
			c.setProduit(pc);
			c.setComposant(p);
			c.setQte(qtes.get(i));
			service.saveComposition(c);
		}
		return "redirect:/GestionProds/Liste";
	}
	

	@RequestMapping(value="/getProduit",method=RequestMethod.GET)
	@ResponseStatus(value=HttpStatus.OK)
	public @ResponseBody Produit getProduit(@RequestParam(value="id",required=true) Long idProduit){
		return service.getProduitByID(idProduit);
	}
	
	@RequestMapping(value="/getComposants",method=RequestMethod.GET)
	@ResponseStatus(value=HttpStatus.OK)
	public @ResponseBody List<Composition> getCompositionProduit(@RequestParam(value="id",required=true) Long idProduit){
		Produit p=service.getProduitByID(idProduit);
		return (List<Composition>) p.getCompsants();
	}
	
	@RequestMapping(value="/updateProd",method=RequestMethod.POST)
	public String updateProduit(@RequestParam(required=true) Long idProduit,@RequestParam(value="",required=true) String nomProd,@RequestParam(value="",required=true) Long idFamille,@RequestParam(value="",required=true) Long idFournisseur,
			@RequestParam(value="",required=true) Float prixUnitaire,@RequestParam(value="",required=true) Float stockInitial,@RequestParam(value="",required=true) Float stockMinimal,
			@RequestParam(value="",required=true) String unite,@RequestParam(value="",required=false) String sd,@RequestParam(value="",required=false) Float ratioBD){
		Produit p=service.getProduitByID(idProduit);
		p.setNomProduit(nomProd);
		p.setPrixUnitaire(prixUnitaire);
		p.setStockMin(stockMinimal);
		p.setUnite(Unite.valueOf(unite.toUpperCase()));
		if(sd.equalsIgnoreCase("oui")){
			p.setSortie_dose(Boolean.TRUE);
			p.setRatioB_D(ratioBD);
		}else{
			p.setSortie_dose(Boolean.FALSE);
			p.setRatioB_D(null);
		}
		Famille f=new Famille();
		f.setCodeFamille(idFamille);
		Fournisseur ff=new Fournisseur();
		ff.setCodeFournisseur(idFournisseur);
		p.setFamille(f);
		p.setFournisseur(ff);
		service.saveProduit(p);
		return "redirect:/GestionProds/Liste";
	}
	@RequestMapping(value="/deleteProduit",method=RequestMethod.POST)
	@ResponseStatus(value=HttpStatus.OK)
	public void deleteProduit(@RequestParam(value="id",required=true) Long idProduit){
		
		service.deleteProduit(idProduit);
		
	}
	
	@RequestMapping(value="/getAllFamilles")
	@ResponseStatus(value=HttpStatus.OK)
	public @ResponseBody List<Famille> getAllFamilles(){
		return service.getAllFamilles();
		}
	
	@RequestMapping(value="/getProdsByFamille")
	@ResponseStatus(value=HttpStatus.OK)
	public @ResponseBody List<Produit> getAllFamilles(@RequestParam(required=true) Long famille){
		return service.getProduitsByFamille(famille);
		}
	
	@RequestMapping(value="/getAllProds")
	@ResponseStatus(value=HttpStatus.OK)
	public @ResponseBody List<Produit> getAllProds(){
		return service.getAllProduits();
		}
}
