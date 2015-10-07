package com.elmorocco.geststock.dao;

import java.util.List;

import com.elmorocco.geststock.entities.Composition;
import com.elmorocco.geststock.entities.Famille;
import com.elmorocco.geststock.entities.Fournisseur;
import com.elmorocco.geststock.entities.Produit;
import com.elmorocco.geststock.entities.Stock;
import com.elmorocco.geststock.entities.Stock_Produit;

public interface IGPDao {
	public void addProduit(Produit p);
	public void saveProduit(Produit p);
	public void deleteProduit(Long id);
	public Produit getProduitByID(Long id);
	public List<Produit> getAllProduits();
	public List<Produit> getProduitsByFamille(Long codeFamille);
	public List<Famille> getAllFamilles();
	public List<Fournisseur> getFournisseurs();
	
	public List<Stock> getAllStocks();
	public Stock getStock(Long codeStock);
	public void saveSP(Stock_Produit sp);
	public void deleteSpByProduit(Long codeProduit);
	public Stock_Produit getLatestSP(Long codeProduit,Long codeStock);
	public List<Stock_Produit> getAllSPByStock(Long codeStock);
	
	public List<Composition> getCompositionProduit(Long idProduit);
	public void saveComposition(Composition c);
	public void clearCompositionByProduit(Long idProduit);
	
	public List<Famille> getFamillesByFournisseur(Long codeFournisseur);
	public List<Produit> getProdsByFamilleAndFournisseur(Long codeFournisseur,Long codeFamille);
	
}
