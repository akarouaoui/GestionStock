package com.elmorocco.geststock.dao;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import org.springframework.dao.support.DataAccessUtils;

import com.elmorocco.geststock.entities.Composition;
import com.elmorocco.geststock.entities.Famille;
import com.elmorocco.geststock.entities.Fournisseur;
import com.elmorocco.geststock.entities.Produit;
import com.elmorocco.geststock.entities.Stock;
import com.elmorocco.geststock.entities.Stock_Produit;

public class GPDaoImpl implements IGPDao{
	
	@PersistenceContext
	private EntityManager em;

	@Override
	public void addProduit(Produit p) {
		em.persist(p);
	}

	@Override
	public void saveProduit(Produit p) {
		em.merge(p);
	}

	@Override
	public void deleteProduit(Long id) {
		Produit p=getProduitByID(id);
		if(p==null) throw new RuntimeException("Produit introuvable");
		em.remove(p);
	}

	@Override
	public Produit getProduitByID(Long id) {
		Produit p=em.find(Produit.class, id);
		return p;
	}

	@Override
	public List<Produit> getAllProduits() {
		Query q=em.createQuery("select p from Produit p");
		return q.getResultList();
	}

	@Override
	public List<Produit> getProduitsByFamille(Long codeFamille) {
		Query q=em.createQuery("select p from Produit p where p.famille.codeFamille=:x");
		q.setParameter("x", codeFamille);
		return q.getResultList();
	}

	@Override
	public List<Famille> getAllFamilles() {
		Query q=em.createQuery("select f from Famille f");
		return q.getResultList();
	}


	@Override
	public List<Fournisseur> getFournisseurs() {
		Query q=em.createQuery("select f from Fournisseur f");
		return q.getResultList();
	}

	@Override
	public List<Stock> getAllStocks() {
		Query q=em.createQuery("select s from Stock s");
		return q.getResultList();
	}

	@Override
	public void saveSP(Stock_Produit sp) {
		if(sp.getProduit().getCodeProduit()==null){
			em.persist(sp.getProduit());	
		}
		em.persist(sp);
				
	}

	@Override
	public void deleteSpByProduit(Long codeProduit) {
		Query q=em.createQuery("delete from Stock_Produit sp where sp.produit.codeProduit=:x");
		q.setParameter("x", codeProduit);
		q.executeUpdate();
	}

	@Override
	public Stock_Produit getLatestSP(Long codeProduit, Long codeStock) {
		Query q=em.createQuery("select sp from Stock_Produit sp where sp.produit.codeProduit=:x and sp.stock.codeStock=:y and sp.date=(select max(s.date) from Stock_Produit s where s.produit.codeProduit=:z and s.stock.codeStock=:a)");
		q.setParameter("x", codeProduit);
		q.setParameter("z", codeProduit);
		q.setParameter("y", codeStock);
		q.setParameter("a", codeStock);
		return (Stock_Produit) DataAccessUtils.singleResult(q.getResultList());
	}

	@Override
	public List<Composition> getCompositionProduit(Long idProduit) {
		Query q=em.createQuery("Select c from Composition c where c.produit.codeProduit=:x");
		q.setParameter("x", idProduit);
		return q.getResultList();
	}

	@Override
	public void saveComposition(Composition c) {
			em.persist(c);
	}

	@Override
	public void clearCompositionByProduit(Long idProduit) {
		Query q=em.createQuery("Delete from Composition c where c.produit.codeProduit=:x");
		q.setParameter("x", idProduit);
		q.executeUpdate();
	}

}
