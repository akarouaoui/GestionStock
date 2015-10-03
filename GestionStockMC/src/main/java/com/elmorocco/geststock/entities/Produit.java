package com.elmorocco.geststock.entities;

import java.io.Serializable;
import java.util.Collection;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
@Table(name="PRODUIT")
public class Produit implements Serializable{
	
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private Long codeProduit;
	private String nomProduit;
	private Float prixUnitaire;
	@ManyToOne
	@JoinColumn(name="codeFamille")
	private Famille famille;
	@ManyToOne
	@JoinColumn(name="codeFournisseur")
	private Fournisseur fournisseur;
	private Float stockMin;
	@Enumerated(EnumType.STRING)
	private Unite unite;
	private Boolean sortie_dose;
	private Float ratioB_D;
	private Float ptva;
	@JsonIgnore
	@OneToMany(mappedBy="produit")
	private Collection<Stock_Produit> sp;
	@JsonIgnore
	@OneToMany(mappedBy="produit",fetch=FetchType.EAGER,cascade=CascadeType.REMOVE)
	private Collection<Composition> compsants;
	@JsonIgnore
	@OneToMany(mappedBy="composant")
	private Collection<Composition> composes;
	
	public Long getCodeProduit() {
		return codeProduit;
	}
	public void setCodeProduit(Long codeProduit) {
		this.codeProduit = codeProduit;
	}
	public String getNomProduit() {
		return nomProduit;
	}
	public void setNomProduit(String nomProduit) {
		this.nomProduit = nomProduit;
	}
	public Float getPrixUnitaire() {
		return prixUnitaire;
	}
	public void setPrixUnitaire(Float prixUnitaire) {
		this.prixUnitaire = prixUnitaire;
	}
	public Famille getFamille() {
		return famille;
	}
	public void setFamille(Famille famille) {
		this.famille = famille;
	}
	public Produit(String nomProduit, Float prixUnitaire,Float stockInitial) {
		super();
		this.nomProduit = nomProduit;
		this.prixUnitaire = prixUnitaire;
	}
	public Produit() {
		super();
	}
	public Fournisseur getFournisseur() {
		return fournisseur;
	}
	public void setFournisseur(Fournisseur fournisseur) {
		this.fournisseur = fournisseur;
	}
	public Float getStockMin() {
		return stockMin;
	}
	public void setStockMin(Float stockMin) {
		this.stockMin = stockMin;
	}	
	public Unite getUnite() {
		return unite;
	}
	public void setUnite(Unite unite) {
		this.unite = unite;
	}
	public Boolean getSortie_dose() {
		return sortie_dose;
	}
	public void setSortie_dose(Boolean sortie_dose) {
		this.sortie_dose = sortie_dose;
	}
	public Float getRatioB_D() {
		return ratioB_D;
	}
	public void setRatioB_D(Float ratioB_D) {
		this.ratioB_D = ratioB_D;
	}
	public Collection<Stock_Produit> getSp() {
		return sp;
	}
	public void setSp(Collection<Stock_Produit> sp) {
		this.sp = sp;
	}
	public Float getPtva() {
		return ptva;
	}
	public void setPtva(Float ptva) {
		this.ptva = ptva;
	}
	public Collection<Composition> getCompsants() {
		return compsants;
	}
	public void setCompsants(Collection<Composition> compsants) {
		this.compsants = compsants;
	}
	public Collection<Composition> getComposes() {
		return composes;
	}
	public void setComposes(Collection<Composition> composes) {
		this.composes = composes;
	}
	
	
}