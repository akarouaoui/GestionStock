package com.elmorocco.geststock.dao;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import org.springframework.dao.support.DataAccessUtils;

import com.elmorocco.geststock.entities.BonCommande;
import com.elmorocco.geststock.entities.Fournisseur;
import com.elmorocco.geststock.entities.MouvementStock;

public class GSDaoImpl implements IGSDao{

	@PersistenceContext
	private EntityManager em;

	@Override
	public void addMouvement(MouvementStock m) {
			em.persist(m);
	}

	@Override
	public List<MouvementStock> getAllMouvements() {
		Query q=em.createQuery("select m from MouvementStock m");
		return q.getResultList();
	}

	@Override
	public List<MouvementStock> getMouvementByProduit(Long idProduit) {
		Query q=em.createQuery("select m from MouvementStock m where m.produit.codeProduit:=x");
		q.setParameter("x", idProduit);
		return q.getResultList();
	}

	@Override
	public List<MouvementStock> getMouvementRecent() {
		Query q=em.createQuery("select m from MouvementStock m");
		return q.getResultList();
	}

	@Override
	public void addBonCommande(BonCommande b) {
			em.persist(b);
	}

	@Override
	public List<BonCommande> getAllBons() {
		Query q=em.createQuery("select b from BonCommande b");
		return q.getResultList();
	}

	@Override
	public BonCommande getBC(Long idCommande) {
		Query q=em.createQuery("select b from BonCommande b where b.idCommande=:x");
		q.setParameter("x", idCommande);
		return (BonCommande) DataAccessUtils.singleResult(q.getResultList());
	}

	@Override
	public List<Fournisseur> getAllFournisseurs() {
		Query q=em.createQuery("select f from Fournisseur f");
		return q.getResultList();
	}
	
}
