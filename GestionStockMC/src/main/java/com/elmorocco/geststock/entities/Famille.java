package com.elmorocco.geststock.entities;

import java.io.Serializable;
import java.util.Collection;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
@Table(name="FAMILLE")
public class Famille implements Serializable{

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private Long codeFamille;
	private String nomFamille;
	@JsonIgnore
	@OneToMany(mappedBy="famille")
	private Collection<Produit> produits;
	public Long getCodeFamille() {
		return codeFamille;
	}
	public void setCodeFamille(Long codeFamille) {
		this.codeFamille = codeFamille;
	}
	public String getNomFamille() {
		return nomFamille;
	}
	public void setNomFamille(String nomFamille) {
		this.nomFamille = nomFamille;
	}
	public Collection<Produit> getProduits() {
		return produits;
	}
	public void setProduits(Collection<Produit> produits) {
		this.produits = produits;
	}
	public Famille(String nomFamille) {
		super();
		this.nomFamille = nomFamille;
	}
	public Famille() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	
}
