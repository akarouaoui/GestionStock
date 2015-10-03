package com.elmorocco.geststock.entities;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
@Table(name="ARTICLE")
public class Article implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 6740997160888167157L;
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private Long idArticle;
	private Long idProduit;
	private String nomArticle;
	private Float quantite;
	@ManyToOne
	@JoinColumn(name="idCommande")
	@JsonIgnore
	private BonCommande commande;
	
	
	public Long getIdProduit() {
		return idProduit;
	}
	public void setIdProduit(Long idProduit) {
		this.idProduit = idProduit;
	}
	public Long getIdArticle() {
		return idArticle;
	}
	public void setIdArticle(Long idArticle) {
		this.idArticle = idArticle;
	}
	public String getNomArticle() {
		return nomArticle;
	}
	public void setNomArticle(String nomArticle) {
		this.nomArticle = nomArticle;
	}
	public Float getQuantite() {
		return quantite;
	}
	public void setQuantite(Float quantite) {
		this.quantite = quantite;
	}
	public BonCommande getCommande() {
		return commande;
	}
	public void setCommande(BonCommande commande) {
		this.commande = commande;
	}
	public Article(String nomArticle,Long idProduit, Float quantite, BonCommande commande) {
		super();
		this.nomArticle = nomArticle;
		this.quantite = quantite;
		this.commande = commande;
		this.idProduit=idProduit;
	}
	public Article() {
		super();
	}
	
	
}
