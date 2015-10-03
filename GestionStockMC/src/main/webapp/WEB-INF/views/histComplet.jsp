<%@ include file="top.jsp"%>

    <div class="contentpanel">
      <div class="panel panel-default">
        <div class="panel-heading">
        <h4>Historique des mouvements </h4>
        </div>
         <div class="panel-body">
			<a class="btn btn-primary" role="button" id="coll" data-toggle="collapse"
				href="#collapseExample" aria-expanded="false"
				aria-controls="collapseExample"> Ajouter des filtres </a>
			<br><br>
			<div class="collapse" id="collapseExample">
				<div class="well">
					 <br>
         <form class="form-horizontal">
         	<div class="form-group">
                  <label class="col-sm-1 control-label">Du:</label>
                  <div class="col-sm-3">
                    <input type="text" name="name" class="form-control" id="du">
                  </div>
                  <label class="col-sm-1 control-label">Au:</label>
                  <div class="col-sm-3">
                    <input type="text" name="name" class="form-control" id="au">
                  </div>
            </div>
         	<div class="form-group">
                  <label class="col-sm-1 control-label">Type:</label>
                  <div class="col-sm-3">
                   <select id="type" class="form-control"><option value="">--Faites un choix--</option><option value="IN">Entrée</option><option value="OUT">Sortie</option></select>
                  </div>
            </div>
            <div class="form-group">
                  <label class="col-sm-1 control-label">Famille:</label>
                  <div class="col-sm-3">
                    <select id="fprod" class="form-control"><option value="">--Faites un choix--</option></select>
                  </div>
                  <label class="col-sm-1 control-label">Produit:</label>
                  <div class="col-sm-3">
                    <select id="prod" class="form-control"><option value="0">--Faites un choix--</option></select>
                  </div>
            </div>
            <div  class="form-group"><button id="closeAcc" class="btn btn-default pull-right"  style="margin-right: 20px;">Fermer</button><button id="filter" class="btn btn-primary pull-right" style="margin-right: 5px;">Filtrer</button></div>
         
         </form>
				
				</div>
			</div>
			<div>
         
     	 	
         
         <div class="table-responsive">
				<table class="table table-striped" id="table">
					<thead>
						<tr>
							<th>Date</th>
							<th>Type</th>
							<th>Ref. Produit</th>
							<th>Famille</th>
							<th>Quantité</th>
						</tr>
					</thead>
					<tbody>
					</tbody>
				</table>
			</div>
        </div>
        </div>
       
    </div>
    
  </div><!-- mainpanel -->
  


<%@ include file="bott.jsp"%>
<script	src="<%=request.getContextPath()%>/resources/js/jquery.datatables.min.js"></script>
<script	src="<%=request.getContextPath()%>/resources/js/chosen.jquery.min.js"></script>
<script type="text/javascript">
jQuery(document).ready(function(){
	jQuery('#ligs').addClass('active');
	jQuery('#pageName').find('i').attr('class',jQuery('#ligs').find('i').attr('class'));
	jQuery('#pageName').find('i').after('Gestionnaire de stock');
	jQuery('head').append('<link href=\'<%=request.getContextPath()%>/resources/css/jquery.datatables.css\' rel=\'stylesheet\'>');
	jQuery('#table').dataTable({
		"sAjaxSource": "getHist?dateDeb=&dateFin=&type=&idProd=",
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
	jQuery("#fprod").chosen({
		  width:"95%",
	      'white-space': 'nowrap'
	    });
	jQuery("#prod").chosen({
		  width:"95%",
	      'white-space': 'nowrap'
	    });
	jQuery('#du').datepicker({
		onSelect:function(selected){
			jQuery('#au').datepicker('option','minDate',selected);
		}
	});
	jQuery('#au').datepicker();
	//Chargement des noms de familles: 
	jQuery.ajax({
			url:'<%=request.getContextPath()%>/GestionProds/getAllFamilles',
			success:function(data){
				 jQuery.each(data,function(index,value){
					jQuery('#fprod').append('<option value='+value.codeFamille+'>'+value.nomFamille+'</option>');
					jQuery('#fprod').trigger("chosen:updated");
				});
			}
		});
	//Chargement produits correspondants a la famille choisie
	jQuery('#fprod').change(function(){
		if(jQuery(this).val()!=''){
			jQuery.ajax({
				url:'<%=request.getContextPath()%>/GestionProds/getProdsByFamille',
				data:'famille='+jQuery('#fprod').val(),
				success:function(data){
					//Vider les resultats
					jQuery('#prod').find('option[value!=0]').remove();
					 jQuery.each(data,function(index,value){
						jQuery('#prod').append('<option value='+value.codeProduit+'>'+value.nomProduit+'</option>');
					});
					jQuery('#prod').trigger("chosen:updated");
				}
			});
			jQuery('#produit').attr('disabled',false);
		}
	});
	//Rechargement des nouveaux donnees
	jQuery('#filter').click(function(e){
		e.preventDefault();
		var dateDeb=jQuery('#du').val();
		var dateFin=jQuery('#au').val();
		var type=jQuery('#type').val();
		var idProd=jQuery('#prod').val();
		if(idProd==0){
			idProd='';
		}
		jQuery.ajax({
			url:'getHist',
			data:{
				dateDeb:dateDeb,
				dateFin:dateFin,
				type:type,
				idProd:idProd
			},
			success:function(data){
				jQuery('#table').dataTable().fnClearTable();
				jQuery('#table').dataTable().fnAddData(data.aaData);
			}
		});
	});
	jQuery('#closeAcc').click(function(e){
		e.preventDefault();
		jQuery('#coll').click();
	});
});


</script>