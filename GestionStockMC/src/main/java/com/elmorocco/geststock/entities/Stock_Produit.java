package com.elmorocco.geststock.entities;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name="STOCK_PRODUIT")
public class Stock_Produit implements Serializable{
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private Long idSP;
	@ManyToOne(cascade = CascadeType.MERGE)
	@JoinColumn(name="codeStock")
	private Stock stock;
	@ManyToOne(cascade = CascadeType.MERGE)
	@JoinColumn(name="codeProduit")
	private Produit produit;
	private Float quantite;
	private Date date;
	public Long getIdSP() {
		return idSP;
	}
	public void setIdSP(Long idSP) {
		this.idSP = idSP;
	}
	public Stock getStock() {
		return stock;
	}
	public void setStock(Stock stock) {
		this.stock = stock;
	}
	public Produit getProduit() {
		return produit;
	}
	public void setProduit(Produit produit) {
		this.produit = produit;
	}
	
	
	
	public Float getQuantite() {
		return quantite;
	}
	public void setQuantite(Float quantite) {
		this.quantite = quantite;
	}
	public Stock_Produit(Stock stock, Produit produit,Float quantite) {
		super();
		this.stock = stock;
		this.produit = produit;
		this.quantite=quantite;
	}
	public Stock_Produit() {
		super();
	}
	public Date getDate() {
		return date;
	}
	public void setDate(Date date) {
		this.date = date;
	}
	
	
	
	
	
}
