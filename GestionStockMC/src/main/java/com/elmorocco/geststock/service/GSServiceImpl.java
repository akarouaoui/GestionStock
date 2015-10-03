package com.elmorocco.geststock.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;

import com.elmorocco.geststock.dao.IGSDao;
import com.elmorocco.geststock.entities.BonCommande;
import com.elmorocco.geststock.entities.Fournisseur;
import com.elmorocco.geststock.entities.MouvementStock;
import com.elmorocco.geststock.entities.Produit;


@Transactional
public class GSServiceImpl implements IGSService {

	private IGSDao dao;
	
	
	public void setDao(IGSDao dao) {
		this.dao = dao;
	}

	@Override
	public void addMouvement(MouvementStock m) {
		dao.addMouvement(m);
	}

	@Override
	public List<MouvementStock> getAllMouvements() {
		return dao.getAllMouvements();
	}

	@Override
	public List<MouvementStock> getMouvementByProduit(Long idProduit) {
		return dao.getMouvementByProduit(idProduit);
	}

	@Override
	public List<MouvementStock> getMouvementRecent() {
		return dao.getMouvementRecent();
	}

	@Override
	public void addBonCommande(BonCommande b) {
			dao.addBonCommande(b);
	}

	@Override
	public List<BonCommande> getAllBons() {
		return dao.getAllBons();
	}

	@Override
	public BonCommande getBC(Long idCommande) {
		return dao.getBC(idCommande);
	}

	@Override
	public List<Fournisseur> getAllFournisseurs() {
		return dao.getAllFournisseurs();
	}

}
