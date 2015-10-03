package com.elmorocco.geststock.models;

import org.springframework.util.AutoPopulatingList;

import com.elmorocco.geststock.entities.Article;

public class BonCommandeFormModel {
	
		private AutoPopulatingList<Article> articles=null;
		private Long idFournisseur=0L;
		
		
		
		public Long getIdFournisseur() {
			return idFournisseur;
		}

		public void setIdFournisseur(Long idFournisseur) {
			this.idFournisseur = idFournisseur;
		}

		public AutoPopulatingList<Article> getArticles() {
			return articles;
		}

		public void setArticles(AutoPopulatingList<Article> articles) {
			this.articles = articles;
		}

		
		
}
