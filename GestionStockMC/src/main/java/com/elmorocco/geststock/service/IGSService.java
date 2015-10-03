package com.elmorocco.geststock.service;

import java.util.List;

import com.elmorocco.geststock.entities.BonCommande;
import com.elmorocco.geststock.entities.Fournisseur;
import com.elmorocco.geststock.entities.MouvementStock;

public interface IGSService {
	
	public void addMouvement(MouvementStock m);
	public List<MouvementStock> getAllMouvements();
	public List<MouvementStock> getMouvementByProduit(Long idProduit);
	public List<MouvementStock> getMouvementRecent();
	public void addBonCommande(BonCommande b);
	public List<BonCommande> getAllBons();
	public BonCommande getBC(Long idCommande);
	public List<Fournisseur> getAllFournisseurs();
}
