package com.elmorocco.geststock.entities;

import java.io.Serializable;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name="COMPOSITION")
public class Composition implements Serializable{

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private Long idComposition;
	@ManyToOne(cascade=CascadeType.REMOVE)
	@JoinColumn(name="codeCompose",referencedColumnName="codeProduit")
	private Produit produit;
	@ManyToOne
	@JoinColumn(name="codeComposant",referencedColumnName="codeProduit")
	private Produit composant;
	private Float qte;
	public Long getIdComposition() {
		return idComposition;
	}
	public void setIdComposition(Long idComposition) {
		this.idComposition = idComposition;
	}
	public Produit getProduit() {
		return produit;
	}
	public void setProduit(Produit produit) {
		this.produit = produit;
	}
	public Float getQte() {
		return qte;
	}
	public void setQte(Float qte) {
		this.qte = qte;
	}
	public Composition(Produit produit, Float qte) {
		super();
		this.produit = produit;
		this.qte = qte;
	}
	public Composition() {
		super();
	}
	public Produit getComposant() {
		return composant;
	}
	public void setComposant(Produit composant) {
		this.composant = composant;
	}
	
	
	
	
}
