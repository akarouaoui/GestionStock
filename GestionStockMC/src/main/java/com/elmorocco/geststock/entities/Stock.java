package com.elmorocco.geststock.entities;

import java.io.Serializable;
import java.util.Collection;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;
@Entity
@Table(name="STOCK")
public class Stock implements Serializable{

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private Long codeStock;
	private String intitStock;
	@OneToMany(mappedBy="stock")
	private Collection <Stock_Produit> sp;
	
	public Collection<Stock_Produit> getSp() {
		return sp;
	}
	public void setSp(Collection<Stock_Produit> sp) {
		this.sp = sp;
	}
	public Long getCodeStock() {
		return codeStock;
	}
	public void setCodeStock(Long codeStock) {
		this.codeStock = codeStock;
	}
	public String getIntitStock() {
		return intitStock;
	}
	public void setIntitStock(String intitStock) {
		this.intitStock = intitStock;
	}
	public Stock(String intitStock) {
		super();
		this.intitStock = intitStock;
	}
	public Stock() {
		super();
	}
	
	
	
	
	
}
