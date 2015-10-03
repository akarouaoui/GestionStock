<%@ include file="top.jsp"%>
<style type="text/css">
.has-error{
border-color:red;
}
.has-error:focus{
border-color:red;
}
</style>
    <div class="contentpanel">
      <div class="panel panel-default">
        <div class="panel-heading">
        <h3>Liste des produits</h3>
        </div>
         <div class="panel-body">
	         <div class="form-group">
	         	<label class="col-sm-2 control-label" style="text-align:right; padding-top: 7px;">Famille: </label>
	         	<div class="col-sm-4">
	         		<select id="selectF" class="form-control mb15">
	         			<option value="0">--Faites un choix--</option>
	         			<c:forEach items="${familles}" var="f">
	         				<option value="${f.codeFamille}">${f.nomFamille}</option>
	         			</c:forEach>
	         		</select>
	         	</div>
	         	
	         </div>
         	
         <div class="table-responsive">
				<table class="table table-striped" id="table">
					<thead>
						<tr>
							<th>Réference</th>
							<th>Fournisseur</th>
							<th>Prix unitaire</th>
							<th>Stock initial</th>
							<th></th>
						</tr>
					</thead>
					<tbody>
					<c:forEach items="${prods}" var="p">
						<tr>
							
							<td>${p.nomProduit }</td>
							<td>${p.fournisseur.nomFournisseur}</td>
							<td>${p.prixUnitaire }</td>
							<td><%-- ${p.stockInitial } --%></td>
							<td>
							<c:if test="${empty p.compsants}">
								<a class="modif" data-id="${p.codeProduit}" style="cursor:pointer;">Modifier</a>
							</c:if>
							<c:if test="${not empty  p.compsants}">
								<a class="modifC" data-id="${p.codeProduit}" style="cursor:pointer;">Modifier</a>
							</c:if>
							 || <a style="cursor:pointer;" class="suppr" data-id="${p.codeProduit}">Supprimer</a> </td>
						</tr>
					
					</c:forEach>
					</tbody>
				</table>
			</div>
			<br><br><br>
			<a class="btn btn-default col-sm-2" id="new">Nouvelle entrée</a>
        </div>
        </div>
       
    </div>
    
  </div><!-- mainpanel -->
<!-- Modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h4 class="modal-title" id="myModalLabel">Modal title</h4>
      </div>
      <div class="modal-body">
        <form action="saveProd" method="POST" id="form" class="form-horizontal form-bordered">
        	<input type="hidden" name="idProduit"/>
        	<div class="form-group">
        		<label class="col-sm-3 control-label">Nom du produit:</label>
        		<div class="col-sm-5"><input type="text" name="nomProd" placeholder="Nom du produit" class="form-control"/></div>
        	</div>
        	<div class="form-group">
        		<label class="col-sm-3 control-label">Famille:</label>
        		<div class="col-sm-5">
        			<select name="idFamille" class="form-control">
        				<option value="">--Faites un choix--</option>
        				<c:forEach items="${familles}" var="f">
	         				<option value="${f.codeFamille}">${f.nomFamille}</option>
	         			</c:forEach>
        			</select>
        		</div>
        	</div>
        	<div class="form-group" name="idFournisseur">
        		<label class="col-sm-3 control-label">Fournisseur:</label>
        		<div class="col-sm-5">
        			<select class="form-control" name="idFournisseur">
        				<option value="">--Faites un choix--</option>
        				<c:forEach items="${fournisseurs}" var="fo">
	         				<option value="${fo.codeFournisseur}">${fo.nomFournisseur}</option>
	         			</c:forEach>
        			</select>
				</div>
        	</div>
        	<div class="form-group">
        		<label class="col-sm-3 control-label">Prix unitaire HT:</label>
        		<div class="col-sm-5"><input type="text" placeholder="" class="form-control" name="prixUnitaire"/></div>
        	</div>
        	<div class="form-group">
        		<label class="col-sm-3 control-label">Pourcentage TVA:</label>
        		<div class="col-sm-5"><input type="text" placeholder="" class="form-control" name="tva" value="20"/></div><label class="col-sm-1 control-label"><b>%</b></label>
        	</div>
        	<div class="form-group">
        		<label class="col-sm-3 control-label">Stock Initial:</label>
        		<div class="col-sm-5"><input type="text" placeholder="" class="form-control" name="stockInitial"/></div>
        	</div>
        	<div class="form-group">
        		<label class="col-sm-3 control-label">Stock Minimal:</label>
        		<div class="col-sm-3"><input type="text" placeholder="" class="form-control" name="stockMinimal"/></div>
        		<div class="col-sm-5"><b>*Quantité minimale pour déclancher une alerte</b></div>
        	</div>
        	<div class="form-group">
        		<label class="col-sm-3 control-label">Unité:</label>
        		<div class="col-sm-5">
	        		<select  class="form-control" name="unite" id="unites">
	        			<option value="">--Faites un choix--</option>
	        			<option value="BOUTEILLE">Bouteille</option>
	        			<option value="PIECE">Piece</option>
	        			<option value="KG">KG</option>
	        		</select>
        		</div>
        	</div>
        	<div class="form-group" id="divsd" style="display:none;">
        		<label class="col-sm-3 control-label">Sortie en doses:</label>
        		<div class="col-sm-5"><div class="checkbox"><label><input id="sd" type="checkbox"  class="form-control"/></label></div></div>
        	</div>
        	<!-- To be hidden -->
        	<div class="form-group" style="display:none;" id="ratioDv">
        		<label class="col-sm-3 control-label">Ratio (Bouteille/Dose):</label>
        		<div class="col-sm-5"><input type="text" class="form-control" name="ratioBD"/></div>
        	</div>
       		<input id="sdo" type="hidden" name="sd"/>
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal" id="cancel">Annuler</button>
        <button type="button" class="btn btn-primary" id="valid">Enregistrer</button>
      </div>
    </div><!-- modal-content -->
  </div><!-- modal-dialog -->
</div><!-- modal -->


<!-- Modal pour les produits composés -->
<div class="modal fade" id="ModalPC" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h4 class="modal-title" id="myModalLabel1">Ajout d'un produit composé</h4>
      </div>
      <div class="modal-body">
        <form id="formComp">
        	<input type="hidden" id="idProdU" value='0'/>
        	<ul id="inputErr" style="color:red">
        	</ul>
        	<div class="form-group" >
        		<label class="col-sm-3 control-label">Rérefence produit:</label>
        		<div class="col-sm-5"><input type="text" class="form-control" name="refP"/></div>
        	</div>
        	<div class="form-group" >
        		<label class="col-sm-3 control-label">Prix HT:</label>
        		<div class="col-sm-5"><input type="text" class="form-control" name="pHT"  data-toggle="popover" data-content="Valeur Incorrecte"/></div>
        	</div>
        	<div class="form-group" >
        		<label class="col-sm-3 control-label">Pourcentage TVA:</label>
        		<div class="col-sm-5"><input type="text" class="form-control" name="tva" data-toggle="popover" data-content="Valeur Incorrecte"/></div>
        	</div>
        	<table class="table table-bordered">
				<thead>
					<tr>
						<th>Composant</th>
						<th>Quantité</th>
						<th><button class="btn btn-primary" id="addC"><span class="glyphicon glyphicon-plus"></span></button></th>
					
					</tr>
				
				</thead>
				<tbody id="comps"></tbody>        	
        	</table>
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Fermer</button>
        <button type="button" class="btn btn-primary" id="saveMPC">Sauvegarder</button>
      </div>
    </div><!-- modal-content -->
  </div><!-- modal-dialog -->
</div><!-- modal -->

<div id="dialog-confirm" title="Type de produit" style="display:none;">
  <p>Veuillez specifier le type de produit a créer</p>
</div>
<div id="dialog-delete" title="Confirmation de suppression" style="display:none;">
  <p><span class="glyphicon  glyphicon-warning-sign"></span>Voulez-vouz supprimer ce produit ?<br>  N.B: Cette operation est irreversible.</p>
</div>

<%@ include file="bott.jsp"%>
<script	src="<%=request.getContextPath()%>/resources/js/jquery.datatables.min.js"></script>
<script	src="<%=request.getContextPath()%>/resources/js/chosen.jquery.min.js"></script>
<script	src="<%=request.getContextPath()%>/resources/js/jquery.validate.min.js"></script>
<script	src="<%=request.getContextPath()%>/resources/js/chosen.jquery.min.js"></script>
<script type="text/javascript">
jQuery(document).ready(function(){
	jQuery('head').append('<link href=\'<%=request.getContextPath()%>/resources/css/jquery-ui.min.css\' rel=\'stylesheet\'>');
	jQuery('head').append('<link href=\'<%=request.getContextPath()%>/resources/css/jquery.datatables.css\' rel=\'stylesheet\'>');
	jQuery('#ligp').addClass('active');
	jQuery('#pageName').find('i').attr('class',jQuery('#ligp').find('i').attr('class'));
	jQuery('#pageName').find('i').after('Gestionnaire de produits');
	jQuery('#table').dataTable({
		"bSort" : false,
		"bLengthChange": false,
		"oLanguage": {
			  "sLengthMenu": "Afficher _MENU_ entreés par page",
			  "sZeroRecords": "Pas de résultats ",
			  "sInfo": "Affichage _START_ à _END_ de _TOTAL_ entrées",
			  "sInfoEmpty": "Affichage de 0 à 0 de 0 entrées",
			  "sInfoFiltered": "(filteré de _MAX_ entrées)",
			  "sSearch":"Chercher",
			  "oPaginate": {	           
		            "sNext":    "Suivant",
		            "sPrevious": "Précédent"
		        }
			}
			
	});
	var prods=[];
	//Remise de la valeur selectionnee
	<c:if test="${not empty filter }">
  	jQuery('#selectF').val("${filter}");
  	</c:if>
  	//Changement de Liste au cas de choix de la famille
	jQuery('#selectF').change(function(){
		var val=jQuery('#selectF').val();
		if(val!=0){
			location.replace('<%=request.getContextPath()%>/GestionProds/Liste?filter='+val);
		}else{
			location.replace('<%=request.getContextPath()%>/GestionProds/Liste');
		}
		
	});
  	//Affichage de la fenetre modale :Ajout
  	//Determiner quel type de produit a creer : 
  	jQuery("#new").click(function(){
  		jQuery( "#dialog-confirm" ).dialog({
  	      resizable: false,
  	      height:'auto',
  	      width:'auto',
  	      modal: true,
  	      buttons: {
  	        "Produit simple": function() {
  	          jQuery( this ).dialog( "close" );
  	        	RAZ();
  	  			jQuery("#form").attr("action","saveProd");
  	  			jQuery("#myModalLabel").text("Ajouter un nouveau produit");
  	  			jQuery("#myModal").modal("show");
  	        },
  	        "Produit composé": function() {
  	          jQuery( this ).dialog( "close" );
  	        	jQuery('#idProdU').val(0);
  	          jQuery("#ModalPC").modal("show");
  	        },
  	        "Fermer": function() {
    	          jQuery( this ).dialog( "close" );
    	        }
  	      }
  	    });
  		
  	});
  	jQuery('#unites').change(function(){
  		if(jQuery(this).val()=='BOUTEILLE'){
  			jQuery('#divsd').show();
  		}else{
  			jQuery('#divsd').hide();
  		}
  	});
  	//Affichage de la fenetre modale : Modification 
  	jQuery("#table tbody").on('click',".modif",function(){
  		var id=jQuery(this).data('id');
  		jQuery.ajax({
  			url:'getProduit',
  			type:'GET',
  			data:'id='+id,
  			success:function(data){
  				jQuery("#myModalLabel").text("Modification du produit");
  				jQuery("#form").attr("action","updateProd");
  				jQuery("#form").find("input[name='idProduit']").val(data.codeProduit);
  				jQuery("#form").find("input[name='nomProd']").val(data.nomProduit);
  		  		jQuery("#form").find("select[name='idFamille']").val(data.famille.codeFamille);
  		  		jQuery("#form").find("select[name='idFournisseur']").val(data.fournisseur.codeFournisseur);
  		  		jQuery("#form").find("input[name='prixUnitaire']").val(data.prixUnitaire);
  				jQuery("#form").find("input[name='stockInitial']").val(data.stockInitial);
  				jQuery("#form").find("input[name='stockMinimal']").val(data.stockMin);
  				jQuery("#form").find("select[name='unite']").val(data.unite);
  				jQuery("#form").find("select[name='tva']").val(data.ptva);
  				if(data.sortie_dose==true){
  					jQuery('#sd').prop('checked',true);
  					jQuery("#form").find("input[name='ratioBD']").val(data.ratioB_D);
  					jQuery('#divsd').show();
  					jQuery('#ratioDv').show();
  				}
  				if(data.unite=='BOUTEILLE'){
  					jQuery('#divsd').show();
  				}
  		  		jQuery("#myModal").modal("show");
  			}
  		});
  		
  	});
  	Charger();
  	jQuery('#sd').click(function(){
  		if(jQuery(this).is(':checked')){
  			jQuery('#sdo').val('oui');
  			jQuery('#ratioDv').show();	
  		}else{
  			jQuery('#sdo').val('');
  			jQuery('#ratioDv').hide();
  		}
  		
  	});
  	jQuery("#valid").click(function(){
  			if(jQuery('#sd').is(':checked')){
  				jQuery('#sdo').val('oui');
  			}
			jQuery("#form").submit();
	});
  	jQuery("#cancel").click(function(){
  		RAZ();
  	});
  	function RAZ(){
  		$("#form").data('validator').resetForm();
  		jQuery.each(jQuery("#form").find("input"),function(index,value){
  			jQuery(value).closest('.form-group').removeClass('has-error');
  			jQuery(value).val("");
  		});
  		jQuery.each(jQuery("#form").find("select"),function(index,value){
  			jQuery(value).closest('.form-group').removeClass('has-error');
  			jQuery(value).val("");
  		});
  		jQuery('#sd').prop('checked',false);
		jQuery('#sdo').val('');
			
  	}
  	
  	function Charger(){
  		var familles=[1,2,3];
  		for(i=0;i<familles.length;i++){
  			jQuery.ajax({
  				url:'<%=request.getContextPath()%>/GestionProds/getProdsByFamille',
  				data:'famille='+familles[i],
  				success:function(data){
  					jQuery.each(data,function(index,value){
  						prods.push(value);
  					});
  				}
  			});
  		}
  	}
  	
  	jQuery("#table tbody").on('click','.suppr',function(){
  		var id=jQuery(this).data('id');
  		jQuery( "#dialog-delete" ).dialog({
    	      resizable: false,
    	      height:'auto',
    	      width:'auto',
    	      modal: true,
    	      buttons: {
    	        "Supprimer": function() {
    	        	jQuery.ajax({
    	  	  			url:'deleteProduit',
    	  	  			type:'POST',
    	  	  			data:'id='+id,
    	  	  			success:function(data){
    	  	  				location.replace("<%=request.getContextPath()%>/GestionProds/Liste");	
    	  	  			}
    	  	  		});
    	        },
    	        "Annuler": function() {
    	          jQuery( this ).dialog( "close" );
    	        }
    	      }
    	    });
  	});
  	//jQuery Validation :
  	jQuery('#form').validate({
  		 rules: {
  			idFamille:{
  				required:true
  			},
  			idFournisseur:{
  				required:true
  			},
  			nomProd:{
  				required:true
  			},
  		    prixUnitaire: {
  		      required: true,
  		      number: true
  		    },
  		    stockInitial: {
    		      required: true,
      		      number: true
      		    },
      		stockMinimal: {
    		      required: true,
      		      number: true
      		    },
      		  unite:{
      			required: true	  
      		  }
  		  },
  	    highlight: function(element) {
  	      jQuery(element).closest('.form-group').removeClass('has-success').addClass('has-error');
  	    },
  	    success: function(element) {
  	      jQuery(element).closest('.form-group').removeClass('has-error');
  	    }
  	  });
  	
  	jQuery.extend(jQuery.validator.messages, {
  		required: "Champ obligatoire.",
  		number: "Veuillez saisir un nombre valide."
  	});
  	
  	
  	//Composant du modal :
  	jQuery('#addC').click(function(e){
  		e.preventDefault();
  		var x=jQuery("<tr>"+
  				"<td><select class='form-control ids'><option value='0'>--Faites un choix--</option></select></td>"+
  				"<td><input type='text' class='form-control qtes' /></td>"+
  				"<td><button class='btn btn-danger remC'><span class='glyphicon glyphicon-remove'></span></button></td>"+
  				"</tr>").appendTo('#comps');
  		jQuery(x).find('.ids').chosen({
		  width:"95%",
	      'white-space': 'nowrap'
	    });
  		
  		jQuery.each(prods,function(index,value){
				jQuery(x).find('.ids').append('<option value='+value.codeProduit+'>'+value.nomProduit+'</option>');
			});
  		jQuery(x).find('.ids').trigger("chosen:updated");
  		
  	});
  	
  	jQuery('#comps').on('click','.remC',function(e){
  		e.preventDefault();
  		jQuery(this).closest('tr').remove();
  		jQuery(this).closest('tr').fadeOut(function(){
  			
  		});	
  	});
  	
  	jQuery('#saveMPC').click(function(){
  		if(validForm()){
  		var ids=[];
  		var qtes=[];
  		jQuery.each(jQuery('#comps').find('.qtes'),function(index,value){
  			qtes.push(jQuery(value).val());
  		});
		jQuery.each(jQuery('#comps').find('.ids'),function(index,value){
			ids.push(jQuery(value).val());
  		});
		if(jQuery('#idProdU').val()==0){
			jQuery.ajax({
	  			url: 'saveProdC',
	  			data:{
	  				refP:jQuery('#formComp').find("input[name='refP']").val(),
	  				pHt:jQuery('#formComp').find("input[name='pHT']").val(),
	  				tva:jQuery('#formComp').find("input[name='tva']").val(),
	  				ids:ids,
	  				qtes:qtes
	  			},
	  			type:'POST',
	  			success: function(data){
	  				location.replace("<%=request.getContextPath()%>/GestionProds/Liste");	
	  			}
	  		});
		}else if(jQuery('#idProdU').val()!=0){
			jQuery.ajax({
	  			url: 'updateProdC',
	  			data:{
	  				idP:jQuery('#idProdU').val(),
	  				refP:jQuery('#formComp').find("input[name='refP']").val(),
	  				pHt:jQuery('#formComp').find("input[name='pHT']").val(),
	  				tva:jQuery('#formComp').find("input[name='tva']").val(),
	  				ids:ids,
	  				qtes:qtes
	  			},
	  			type:'POST',
	  			success: function(data){
	  				location.replace("<%=request.getContextPath()%>/GestionProds/Liste");	
	  			}
	  		});
		}
  		}
  	});
  	
  	jQuery("#table tbody").on('click','.modifC',function(){
  		var id=jQuery(this).data('id');
  		jQuery('#idProdU').val(id);
  		jQuery("#myModalLabel1").text('Modification du produit');
  		jQuery.ajax({
  			url:'getProduit',
  			type:'GET',
  			data:'id='+id,
  			success:function(data1){
  				jQuery("#ModalPC").find("input[name='refP']").val(data1.nomProduit);
  				jQuery("#ModalPC").find("input[name='pHT']").val(data1.prixUnitaire);
  				jQuery("#ModalPC").find("input[name='tva']").val(data1.ptva);
  				jQuery.ajax({
  					url:'getComposants',
  					type:'GET',
  					data:'id='+id,
  					success:function(data){
  						jQuery.each(data,function(index,value){
  							var x=jQuery("<tr>"+
  					  				"<td><select class='form-control ids'><option value='0'>--Faites un choix--</option></select></td>"+
  					  				"<td><input type='text' class='form-control qtes' /></td>"+
  					  				"<td><button class='btn btn-danger remC'><span class='glyphicon glyphicon-remove'></span></button></td>"+
  					  				"</tr>").appendTo('#comps');
  							jQuery.each(prods,function(ind,val){
  								jQuery(x).find('.ids').append('<option value='+val.codeProduit+'>'+val.nomProduit+'</option>');
  							});
  							jQuery(x).find('.ids').chosen({
  							  width:"95%",
  						      'white-space': 'nowrap'
  						    }); 
  							jQuery(x).find('.qtes').val(value.qte);
  							jQuery(x).find('.ids').val(value.composant.codeProduit);
  							jQuery(x).find('.ids').trigger("chosen:updated");
  						});
  					}
  				});
  			}
  			});
  		
  		jQuery("#ModalPC").modal("show");
  		
  	});
  	
  	
  	jQuery('#ModalPC').on('hidden.bs.modal',function(){
  		jQuery(this).find('input').each(function(index){
  			jQuery(this).val('');
  			});
  		jQuery('#comps').find('tr').remove();
  		
  	});
  	//Validation du formulaire du Produit compose
  	
  	 function validForm(){
  		var validTable=true;
  		var validInput=false;
  		jQuery('#inputErr').empty();
  		jQuery('#formComp').find("input[type!=hidden]").each(function(index){
  			if(jQuery(this).val()==''){
  				jQuery(this).addClass('has-error');
  				jQuery(this).focus();
  				validInput=false;
  			}else{
  				if(jQuery(this).attr('name')!='refP'){
  					if(!jQuery.isNumeric(jQuery(this).val())){
  						jQuery(this).addClass('has-error');
  		  				jQuery(this).focus();
  		  				validInput=false;
  					}else{
  						jQuery(this).removeClass('has-error');
  		  				validInput=true;
  					}
  				}else{
  					jQuery(this).removeClass('has-error');
  	  				validInput=true;
  				}
  				
  			}
  		
  		});
  		if(!validInput){
  			jQuery('#inputErr').append("<li>Il existe des entrées invalides</li>");
  		}
  		var length=jQuery('#comps').find('tr').length;
  		if(length<2){validTable=false;jQuery('#inputErr').append("<li>Le produit doit avoir au moins deux composant</li>");}
  		else{
  			jQuery('#comps').find('tr').each(function(){
  				//alert(jQuery(this).find('.ids').val());
  				if(!validTr(jQuery(this))){
  					validTable=false;
  				}
  				
  			});
  			if(!validTable){
  	  			jQuery('#inputErr').append("<li>Il existe des entrées invalides dans la liste des composants</li>");
  	  		}
  		}
  		
  		
  		return validTable && validInput;	
  	} 
  	function validTr(Tr){
  		var v1=false;
  		var v2=false;
  		if(jQuery(Tr).find('.ids').val()==0){
				jQuery(Tr).find('.ids').addClass('has-error');
				jQuery(Tr).find('.ids').focus();
				v1=false;
		}else{
				jQuery(Tr).find('.ids').removeClass('has-error');
				v1=true;
		}
		if(jQuery(Tr).find('.qtes').val()==0){
				jQuery(Tr).find('.qtes').addClass('has-error');
				jQuery(Tr).focus();
				v2=false;
		}else{
				jQuery(Tr).find('.qtes').removeClass('has-error');
				v2=true;
		}
		return v1 && v2;
  	}
  	
});


</script>