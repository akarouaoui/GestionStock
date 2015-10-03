package com.elmorocco.geststock.service;

import java.util.List;

import org.springframework.transaction.annotation.Transactional;

import com.elmorocco.geststock.dao.IGPDao;
import com.elmorocco.geststock.entities.Composition;
import com.elmorocco.geststock.entities.Famille;
import com.elmorocco.geststock.entities.Fournisseur;
import com.elmorocco.geststock.entities.Produit;
import com.elmorocco.geststock.entities.Stock;
import com.elmorocco.geststock.entities.Stock_Produit;


@Transactional
public class GPServiceImpl implements IGPService{

	private IGPDao dao;
	
	public void setDao(IGPDao dao) {
		this.dao = dao;
	}

	@Override
	public void addProduit(Produit p) {
		dao.addProduit(p);
	}

	@Override
	public void saveProduit(Produit p) {
		dao.saveProduit(p);
	}

	@Override
	public void deleteProduit(Long id) {
		dao.deleteSpByProduit(id);
		dao.deleteProduit(id);
	}

	@Override
	public Produit getProduitByID(Long id) {
		return dao.getProduitByID(id);
	}

	@Override
	public List<Produit> getAllProduits() {
		return dao.getAllProduits();
	}

	@Override
	public List<Produit> getProduitsByFamille(Long codeFamille) {
		return dao.getProduitsByFamille(codeFamille);
	}

	@Override
	public List<Famille> getAllFamilles() {
		return dao.getAllFamilles();
	}

	
	@Override
	public List<Fournisseur> getFournisseurs() {
		return dao.getFournisseurs();
	}

	@Override
	public List<Stock> getAllStocks() {
		return dao.getAllStocks();
	}

	@Override
	public void saveSP(Stock_Produit sp) {
			dao.saveSP(sp);
	}

	@Override
	public void deleteSpByProduit(Long codeProduit) {
		dao.deleteSpByProduit(codeProduit);
	}

	@Override
	public Stock_Produit getLatestSP(Long codeProduit, Long codeStock) {
		return dao.getLatestSP(codeProduit, codeStock);
	}

	@Override
	public List<Composition> getCompositionProduit(Long idProduit) {
		return dao.getCompositionProduit(idProduit);
	}

	@Override
	public void saveComposition(Composition c) {
		dao.saveComposition(c);
	}

	@Override
	public void clearCompositionByProduit(Long idProduit) {
		dao.clearCompositionByProduit(idProduit);
	}

}
