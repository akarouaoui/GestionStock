package com.elmorocco.geststock.entities;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name="MOUVEMENT_STOCK")
public class MouvementStock implements Serializable{

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private Long idMouvement;
	@Enumerated(EnumType.STRING)
	private Type typeMouvement;
	@Column
	@org.hibernate.annotations.Type(type="date")
	private Date dateMouvement;
	@ManyToOne
	@JoinColumn(name="codeProduit")
	private Produit produit;
	private Float quantite;
	private String destination;
	
	public Long getIdMouvement() {
		return idMouvement;
	}
	public void setIdMouvement(Long idMouvement) {
		this.idMouvement = idMouvement;
	}
	public Type getTypeMouvement() {
		return typeMouvement;
	}
	public void setTypeMouvement(Type typeMouvement) {
		this.typeMouvement = typeMouvement;
	}
	public Date getDateMouvement() {
		return dateMouvement;
	}
	public void setDateMouvement(Date dateMouvement) {
		this.dateMouvement = dateMouvement;
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
	public MouvementStock(Type typeMouvement, Date dateMouvement,Float quantite) {
		super();
		this.typeMouvement = typeMouvement;
		this.dateMouvement = dateMouvement;
		this.quantite=quantite;
	}
	public MouvementStock() {
		super();
	}
	public String getDestination() {
		return destination;
	}
	public void setDestination(String destination) {
		this.destination = destination;
	}
	
	
	
	
}
