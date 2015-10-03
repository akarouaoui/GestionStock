<%@ include file="top.jsp"%>

    <div class="contentpanel">
    <div class="row">
    	<div class="col-md-3">
    		<div class="panel panel-default panel-dark panel-alt">
    			<div class="panel-heading"><h4 class="panel-title">Opérations</h4></div>
    			<div class="panel-body">
    				<a class="btn btn-primary btn-block" href="<%=request.getContextPath()%>/GestionStock/historique">Consulter l'historique complet</a>
    				<button class="btn btn-primary btn-block" id="amClick">Ajouter mouvement</button>
    				<a class="btn btn-primary btn-block" href="<%=request.getContextPath()%>/GestionStock/BonCommande">Bons de commande</a>
    				<button class="btn btn-primary btn-block">Action 1</button>
    			</div>
    		</div>
    	</div>
    	<div class="col-md-9">
    	<div class="panel panel-default">
	        <div class="panel-heading">
	        	<h4>Historique des mouvements du stock</h4>
	        </div>
	        <div class="panel-body">
	        	<div class="table-responsive">
				<table class="table table-striped" id="table">
					<thead>
					
						<tr>
							<th>Date</th>
							<th>Type</th>
							<th>Réf. Produit</th>
							<th>Famille</th>
							<th>Quantité</th>
						</tr>
					</thead>
					<tbody>
					<c:forEach items="${hist}" var="i">
						<tr>
							<td><fmt:formatDate pattern="dd/MM/yyyy" value="${i.dateMouvement}"/></td>
							<td>
								<c:choose>
									<c:when test="${i.typeMouvement=='OUT' }">Sortie</c:when>
									<c:otherwise>Entrée</c:otherwise>
								</c:choose>
								
							
							</td>
							<td>${i.produit.nomProduit}</td>
							<td>${i.produit.famille.nomFamille }</td>
							<td>${i.quantite }</td>
						</tr>
					</c:forEach>
					</tbody>
					</table>
					</div>
	        </div>
        </div>
    	</div>
    
    </div>
    
  </div><!-- mainpanel -->
  
<!-- AjoutMouvement Modal -->
<div class="modal fade" id="AMModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h4 class="modal-title" id="myModalLabel">Ajouter mouvement</h4>
      </div>
      <div class="modal-body">
        <form class="form-horizontal form-bordered" action="saveMouvement" id="form" method="post">
	        <div class="form-group">
	        	<div class="col-sm-3 form-label">Famille :</div>
	        	<div class="col-sm-6">
	        	<select class="form-control" id="famille" name="idFamille">
	        		<option value="">--Faites un choix--</option>
	        	</select>
	        	</div>
	        </div>
	        <div class="form-group">
	        	<div class="col-sm-3 form-label">Produit :</div>
	        	<div class="col-sm-6">
	        	<select class="form-control" id="produit" disabled="disabled" name="idProduit">
	        		<option value="">--Faites un choix--</option>
	        	</select>
	        	</div>
	        </div>
	        <div class="form-group">
	        	<div class="col-sm-3 form-label">Type :</div>
	        	<div class="col-sm-6">
		        	<select class="form-control" name="type" id="typeM">
		        		<option value="">--Faites un choix--</option>
		        		<option value="OUT">Sortie</option>
		        		<option value="IN">Entrée</option>
		        	</select>
	        	</div>
	        </div>
	        <div class="form-group" id="destination" style="display:none;">
	        	<div class="col-sm-3 form-label">Stock :</div>
	        	<div class="col-sm-6">
		        	<select class="form-control" name="stock">
		        		<option value="">--Faites un choix--</option>
		        		<option value="3">Restaurant</option>
		        		<option value="2">Bar</option>
		        		<option value="4">Snack</option>
		        	</select>
	        	</div>
	        </div>
	        <div class="form-group">
	        	<div class="col-sm-3 form-label">Quantité :</div>
	        	<div class="col-sm-6"><input class="form-control" type="text" placeholder="XXX" name="quantite"/></div>
	        </div>
	       
	        <div class="form-group">
	        	<div class="col-sm-3 form-label">Date :</div>
	        	<div class="col-sm-6"><input id="dateM" class="form-control" type="text" name="dateM"/></div>
	        </div>
	        
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Fermer</button>
        <button type="button" class="btn btn-primary" id="send">Enregistrer</button>
      </div>
    </div><!-- modal-content -->
  </div><!-- modal-dialog -->
</div><!-- modal -->

<%@ include file="bott.jsp"%>
<script	src="<%=request.getContextPath()%>/resources/js/jquery.datatables.min.js"></script>
<script	src="<%=request.getContextPath()%>/resources/js/chosen.jquery.min.js"></script>
<script	src="<%=request.getContextPath()%>/resources/js/jquery.validate.min.js"></script>
<script type="text/javascript">
jQuery(document).ready(function(){
	//Page Setup
	jQuery('head').append('<link href=\'<%=request.getContextPath()%>/resources/css/jquery.datatables.css\' rel=\'stylesheet\'>');
	jQuery('#ligs').addClass('active');
	jQuery('#pageName').find('i').attr('class',jQuery('#ligs').find('i').attr('class'));
	jQuery('#pageName').find('i').after('Gestionnaire de stock');
	
	jQuery('#dateM').datepicker();
	jQuery('#amClick').click(function(){
		jQuery.ajax({
			url:'<%=request.getContextPath()%>/GestionProds/getAllFamilles',
			success:function(data){
				jQuery('#famille').find('option[value!=""]').remove();
				 jQuery.each(data,function(index,value){
					jQuery('#famille').append('<option value='+value.codeFamille+'>'+value.nomFamille+'</option>');
				});
				jQuery('#AMModal').modal('show'); 
			}
		});
		
		
	});
	//Fermeture de la fenetre modale
	jQuery('#AMModal').on('hidden.bs.modal', function () {
		jQuery('#famille').find('option[value!=0]').remove();
		jQuery('#produit').find('option[value!=0]').remove();
		jQuery('#dateM').val('');
		jQuery('#typeM').val('0');
		jQuery('#AMModal').find('input[name="quantite"]').val('');
		jQuery('#produit').attr('disabled',true);
		jQuery('#destination').hide();
		jQuery('#destination').val('');
	});
	jQuery('#famille').change(function(){
		if(jQuery(this).val()!='0'){
			jQuery.ajax({
				url:'<%=request.getContextPath()%>/GestionProds/getProdsByFamille',
				data:'famille='+jQuery('#famille').val(),
				success:function(data){
					//Vider les resultats
					jQuery('#produit').find('option[value!=""]').remove();
					 jQuery.each(data,function(index,value){
						jQuery('#produit').append('<option value='+value.codeProduit+'>'+value.nomProduit+'</option>');
					});
				}
			});
			jQuery('#produit').attr('disabled',false);
		}
	});
	
	
	jQuery('#AMModal').on('hidden.bs.modal', function () {
		 jQuery("#form").data('validator').resetForm();
	});
	
	//Validation du fomulaire :
	
	jQuery('#form').validate({
		 rules: {
			idFamille:{
				required:true
			},
			idProduit:{
				required:true
			},
		    quantite: {
		      required: true,
		      number: true
		    },
		    type:{
				required:true
			},
			dateM:{
				required:true
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
	
	jQuery('#send').click(function(){
		jQuery('#form').submit();
	});
	
	jQuery('#typeM').change(function(){
		if(jQuery(this).val()=='OUT'){
			jQuery('#destination').show();
		}else{
			jQuery('#destination').hide();
		}
	});
		
		
	
});


</script>