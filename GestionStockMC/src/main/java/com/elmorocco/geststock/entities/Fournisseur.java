package com.elmorocco.geststock.entities;

import java.io.Serializable;
import java.util.Collection;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
@Table(name="FOURNISSEUR")
public class Fournisseur implements Serializable{
	
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private Long codeFournisseur;
	private String nomFournisseur;
	private String numContact;
	private String adresse;
	@OneToMany(mappedBy="fournisseur")
	@JsonIgnore
	private Collection<Produit> produits;
	@OneToMany(mappedBy="fournisseur")
	@JsonIgnore
	private Collection<BonCommande> bonsCmd;
	
	
	public Long getCodeFournisseur() {
		return codeFournisseur;
	}
	public void setCodeFournisseur(Long codeFournisseur) {
		this.codeFournisseur = codeFournisseur;
	}
	public String getNomFournisseur() {
		return nomFournisseur;
	}
	public void setNomFournisseur(String nomFournisseur) {
		this.nomFournisseur = nomFournisseur;
	}
	public String getNumContact() {
		return numContact;
	}
	public void setNumContact(String numContact) {
		this.numContact = numContact;
	}
	public String getAdresse() {
		return adresse;
	}
	public void setAdresse(String adresse) {
		this.adresse = adresse;
	}
	public Collection<Produit> getProduits() {
		return produits;
	}
	public void setProduits(Collection<Produit> produits) {
		this.produits = produits;
	}
	
	public Collection<BonCommande> getBonsCmd() {
		return bonsCmd;
	}
	public void setBonsCmd(Collection<BonCommande> bonsCmd) {
		this.bonsCmd = bonsCmd;
	}
	public Fournisseur(String nomFournisseur, String numContact, String adresse) {
		super();
		this.nomFournisseur = nomFournisseur;
		this.numContact = numContact;
		this.adresse = adresse;
	}
	public Fournisseur() {
		super();
	}
	
	
}
