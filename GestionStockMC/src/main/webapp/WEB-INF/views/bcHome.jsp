<%@ include file="top.jsp"%>

    <div class="contentpanel">
      <div class="panel panel-default">
        <div class="panel-heading">
        <h4>Liste des Bons de Commande</h4>
        </div>
         <div class="panel-body">
         <a href="<%=request.getContextPath()%>/GestionStock/BonCommande/Creer" class="btn btn-primary">Créer nouveau</a>
         <br/><br/>
         <div class="table-responsive">
         	<table class="table table-bordered" id="table">
         		<thead>
         			<tr>
         				<th>Num.</th>
         				<th>Fournisseur</th>
         				<th>Date d'issu</th>
         				<th>Statut</th>
         				<th>Visualiser</th>
         				<th></th>
         			</tr>
         			
         		</thead>
         		<tbody>
         			<c:forEach items="${bons}" var="b">
         				<tr>
         					<td>${b.numCommande}</td>
         					<td>${b.fournisseur.nomFournisseur}</td>
         					<td><fmt:formatDate value="${b.dateCommande}" pattern="dd/MM/yyyy"/></td>
         					<td>${b.statCommande}</td>
         					<td><a href="BonCommande/getBC?idBC=${b.idCommande}">Commande-${b.numCommande}</a></td>
         					<td><a data-id="${b.idCommande}" class="acc" style="cursor:pointer;">Accuser la récéption</a>||<a data-id="${b.idCommande}" class="suppr" style="cursor:pointer;">Supprimer</a></td>
         				</tr>
         			</c:forEach>
         		</tbody>
         	</table>
         </div>
        </div>
        </div>
       
    </div>
    
  </div><!-- mainpanel -->
  
  
<!-- Modal -->
<div class="modal fade" id="modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h4 class="modal-title" id="myModalLabel">Verification de la commande</h4>
      </div>
      <div class="modal-body">
      	<form>
      	<input type="hidden" id="idCommandeM" />
      		<div class="form-group">
      			<label class="col-md-3 form-label">Numero commande : </label>
      			<div class="col-md-5">
      				<input class="form-control" name="numCommande" disabled/>
      			</div>
      		</div>
      		<div class="form-group">
      			<label class="col-md-3 form-label"></label>
      			<div class="col-md-5">
      				<input class="form-control"/>
      			</div>
      		</div><div class="form-group">
      			<label class="col-md-3 form-label"></label>
      			<div class="col-md-5">
      				<input class="form-control"/>
      			</div>
      		</div><div class="form-group">
      			<label class="col-md-3 form-label"></label>
      			<div class="col-md-5">
      				<input class="form-control"/>
      			</div>
      		</div>
      		<table class="table table-bordered">
      			<thead>
      				<tr>
      					<th>Produit</th>
      					<th>Quantité</th>
      					<th>P.TVA</th>
      				</tr>
      			</thead>
      			<tbody >
      			</tbody>
      		</table>
      	</form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Annuler</button>
        <button type="button" class="btn btn-primary" id="validChange">Sauvegarder les changements</button>
      </div>
    </div><!-- modal-content -->
  </div><!-- modal-dialog -->
</div><!-- modal -->  

<div id="dialog-delete" title="Confirmation de suppression" style="display:none;">
  <p><span class="glyphicon  glyphicon-warning-sign"></span>Voulez-vouz supprimer cette entrée ?<br>  N.B: Cette operation est irreversible.</p>
</div>
<div id="dialog-accuser" title="Reception de la commande" style="display:none;">
  <p><span class="glyphicon  glyphicon-warning-sign"></span>Veuillez effectuer un choix : </p>
</div>
<%@ include file="bott.jsp"%>
<script	src="<%=request.getContextPath()%>/resources/js/jquery.datatables.min.js"></script>
<script type="text/javascript">
jQuery(document).ready(function(){
	jQuery('head').append('<link href=\'<%=request.getContextPath()%>/resources/css/jquery-ui.min.css\' rel=\'stylesheet\'>');
	jQuery('head').append('<link href=\'<%=request.getContextPath()%>/resources/css/jquery.datatables.css\' rel=\'stylesheet\'>');
	jQuery('#ligs').addClass('active');
	jQuery('#pageName').find('i').attr('class',jQuery('#ligp').find('i').attr('class'));
	jQuery('#pageName').find('i').after('Gestionnaire des Bons de commande');
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
    	  	  			url:'<%=request.getContextPath()%>/GestionStock/BonCommande/supprimer',
    	  	  			type:'POST',
    	  	  			data:'idCommande='+id,
    	  	  			success:function(data){
    	  	  				location.replace("<%=request.getContextPath()%>/GestionStock/BonCommande");	
    	  	  			}
    	  	  		});
    	        },
    	        "Annuler": function() {
    	          jQuery( this ).dialog( "close" );
    	        }
    	      }
    	    });
  	});
	jQuery("#table tbody").on('click','.acc',function(){
  		var id=jQuery(this).data('id');
  		jQuery( "#dialog-accuser" ).dialog({
    	      resizable: false,
    	      height:'auto',
    	      width:'auto',
    	      modal: true,
    	      buttons: {
    	        "Le BL correspand au BC": function() {
    	        	jQuery.ajax({
    	  	  			url:'<%=request.getContextPath()%>/GestionStock/BonCommande/validate',
    	  	  			type:'POST',
    	  	  			data:'idCommande='+id,
    	  	  			success:function(data){
    	  	  			location.replace("<%=request.getContextPath()%>/GestionStock/BonCommande");	
    	  	  			}
    	  	  		});
    	        },
    	        "Le BL et le BC ne correspandent pas": function() {
    	        	jQuery.ajax({
    	  	  			url:'<%=request.getContextPath()%>/GestionStock/BonCommande/get',
    	  	  			type:'GET',
    	  	  			data:'idCommande='+id,
    	  	  			success:function(data){
    	  	  				jQuery("#modal").find("input[name='numCommande']").val(data.numCommande);
    	  	  				jQuery.each(data.articles,function(index,value){
    	  	  					jQuery('#idCommandeM').val(id);
    	  	  					jQuery('#modal').find('table > tbody').append("<tr><td>"+value.nomArticle+"</td>"+
    	  	  					"<td><input data-id="+value.idArticle+" class='form-control' value='"+value.quantite+"'/></td>"+
    	  	  					"<td></td></tr>");
    	  	  				});
    	  	  				jQuery( "#dialog-accuser" ).dialog( "close" );
    	  	  				jQuery("#modal").modal("show");
    	  	  			}
    	  	  		});
    	        },
    	        "Annuler": function() {
    	          jQuery( this ).dialog( "close" );
    	        }
    	      }
    	    });
  	});
	jQuery("#validChange").click(function(){
		var ids=[];
		var qtes=[];
		jQuery('#modal').find('table > tbody > tr').each(function(index){
			qtes.push(jQuery(this).find("input").val());
			ids.push(jQuery(this).find("input").data("id"));
		});
		jQuery.ajax({
			url:'<%=request.getContextPath()%>/GestionStock/BonCommande/change',
			data:{
				idCommande:jQuery('#idCommandeM').val(),
				id:ids,
				qtes:qtes
			},
			type:'POST',
			success:function(data){
				location.replace("<%=request.getContextPath()%>/GestionStock/BonCommande");	
			}
		});
	});
});


</script>