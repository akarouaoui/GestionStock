package com.elmorocco.geststock.entities;

import java.io.Serializable;
import java.util.Collection;
import java.util.Date;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Entity
@Table(name="BON_COMMANDE")
public class BonCommande implements Serializable{
	
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private Long idCommande;
	private String numCommande;
	private Date dateCommande;
	private String statCommande;
	@ManyToOne
	@JoinColumn(name="codeFournisseur")
	private Fournisseur fournisseur;
	@OneToMany(fetch=FetchType.EAGER,cascade=CascadeType.ALL,mappedBy="commande")
	private Collection<Article> articles;
	
	public Long getIdCommande() {
		return idCommande;
	}
	public void setIdCommande(Long idCommande) {
		this.idCommande = idCommande;
	}
	public String getNumCommande() {
		return numCommande;
	}
	public void setNumCommande(String numCommande) {
		this.numCommande = numCommande;
	}
	public Date getDateCommande() {
		return dateCommande;
	}
	public void setDateCommande(Date dateCommande) {
		this.dateCommande = dateCommande;
	}
	public String getStatCommande() {
		return statCommande;
	}
	public void setStatCommande(String statCommande) {
		this.statCommande = statCommande;
	}
	
	
	public Fournisseur getFournisseur() {
		return fournisseur;
	}
	public void setFournisseur(Fournisseur fournisseur) {
		this.fournisseur = fournisseur;
	}
	
	public BonCommande(String numCommande, Date dateCommande, String statCommande,Fournisseur fournisseur) {
		super();
		this.numCommande = numCommande;
		this.dateCommande = dateCommande;
		this.statCommande = statCommande;
		this.fournisseur=fournisseur;
	}
	public BonCommande() {
		super();
	}
	public Collection<Article> getArticles() {
		return articles;
	}
	public void setArticles(Collection<Article> articles) {
		this.articles = articles;
	}
	
	
	
	
}
