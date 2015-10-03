package com.elmorocco.geststock.dao;

import java.util.List;

import com.elmorocco.geststock.entities.BonCommande;
import com.elmorocco.geststock.entities.MouvementStock;
import com.elmorocco.geststock.entities.Fournisseur;

public interface IGSDao {
	
	public void addMouvement(MouvementStock m);
	public List<MouvementStock> getAllMouvements();
	public List<MouvementStock> getMouvementByProduit(Long idProduit);
	public List<MouvementStock> getMouvementRecent();
	public void addBonCommande(BonCommande b);
	public List<BonCommande> getAllBons();
	public BonCommande getBC(Long idCommande);
	public List<Fournisseur> getAllFournisseurs();
	
}
