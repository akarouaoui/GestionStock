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
        <h5>Création d'un bon de commande</h5>
        </div>
         <div class="panel-body">
         <div id="errors" style="display:none;color:red;">
         	Il existe des erreurs dans votre saisie : 
         	<ul>
         	</ul>
         </div>
         <br><br>
         <f:form commandName="model" action="save" cssClass="form-horizontal" id="myForm">
         	<div class="form-group">
         		<label class="control-label col-sm-1">Fournisseur: </label>
         		<div class="col-sm-4">
         			<select class="form-control" name="idFournisseur">
         				<option value="0">--Faites un choix--</option>
         				<c:forEach items="${fournisseurs}" var="f">
         					<option value="${f.codeFournisseur }">${f.nomFournisseur }</option>
         				</c:forEach>
         			</select>
         		</div>
         		
         	
         	</div>
         	<div>
         	Liste des produits a commander:
         	<table class="table table-bordered" id="theTable">
         	<thead>
         		<tr>
         			<th>Famille</th>
         			<th>Produit</th>
         			<th>Quantité</th>
         			<th><button class="btn btn-primary" id="add"><span class="glyphicon glyphicon-plus"></span></button></th>
         		</tr>
         	</thead>
         	<tbody>
         	
         	</tbody>
         	
         	</table>
         	</div>
         	<input type="submit" value="valider" class="btn btn-primary" id="sub"/>
         	</f:form>
        </div>
        </div>
       
    </div>
    
  </div><!-- mainpanel -->
  


<%@ include file="bott.jsp"%>
<script type="text/javascript">
jQuery(document).ready(function(){
	jQuery('#ligs').addClass('active');
	var index=0;
	jQuery('#add').click(function(e){
		e.preventDefault();
		
		if(jQuery('#theTable >tbody >tr').length==0){
			appendTr();
		}else{
			if(validerTr(jQuery('#theTable').find('tr:last'))){
			 appendTr();	
			}
		}
		
		
		
		
	});
	
	function appendTr(){
		var x=jQuery('#theTable').append(
				"<tr>"+
				"<td><select class='form-control famille' id='x'><option value='0'>--Faites un choix--</option></select></td>"+
         		"<td><select class='form-control produit' name='articles["+index+"].idProduit' disabled='true'><option value='0'>--Faites un choix--</option></select></td>"+
         		"<td><input type='text' class='form-control qte' name='articles["+index+"].quantite'/></td>"+
         		"<td><button class='btn btn-danger delete'><span class='glyphicon glyphicon-remove'></span></button></td>"+
         		"</tr>");
		index++;
		addProds(x.find(".famille"));

		x.find(".delete").click(function(e){
			e.preventDefault();
			jQuery(this).closest('tr').fadeOut(function(){
				  index--;
				  var indexR=jQuery(this).index();
				  var nexts=jQuery(this).closest('tr').nextAll('tr');
				  jQuery.each(nexts,function(index,value){
					  jQuery(value).find('.produit').attr('name','articles['+indexR+'].idProduit');
					  jQuery(value).find('.qte').attr('name','articles['+indexR+'].quantite');
					  indexR++;
				  });
		          jQuery(this).remove();
		        });
		});
	}
	
	//addProds(jQuery('#tha'));
	function addProds(select){
		jQuery.ajax({
			url:'<%=request.getContextPath()%>/GestionProds/getAllFamilles',
			success:function(data){
				jQuery.each(data,function(index,value){
					jQuery(select).append('<option value='+value.codeFamille+'>'+value.nomFamille+'</option>');
				});
				
				
			}
		});
		jQuery(select).change(function(){
			var x=jQuery(this).closest('td').next('td').find('select');
			var val=jQuery(this).val();
			jQuery.ajax({
				url:'<%=request.getContextPath()%>/GestionProds/getProdsByFamille',
				data:'famille='+val,
				success:function(data){
					jQuery.each(data,function(index,value){
						jQuery(x).append('<option value='+value.codeProduit+'>'+value.nomProduit+'</option>');
					});
					jQuery(x).removeAttr('disabled');
				}
			});
		});
	};
	
	
	function validerTr(tr){
		var select=jQuery(tr).find(".produit");
		var qte=jQuery(tr).find(".qte");
		var valid1=true;
		var valid2=true;
		if(jQuery(select).val()=='0'){
			jQuery(select).focus();
			jQuery(select).closest('.form-control').removeClass('has-success').addClass('has-error');
			valid1=false;
		}
		if(jQuery(qte).val()=='' || !jQuery.isNumeric(jQuery(qte).val())){
			jQuery(qte).focus();
			jQuery(qte).closest('.form-control').addClass('has-error');
			valid2=false;
		}
		if(valid1){
			jQuery(select).closest('.form-control').removeClass('has-error');
		}
		if(valid2){
			jQuery(qte).closest('.form-control').removeClass('has-error');
		}
		return valid1 && valid2;
	}
	jQuery('#myForm').find('select[name="idFournisseur"]').focusout(function(){
		if(jQuery(this).val()!=0){
			jQuery(this).removeClass('has-error');
		}
	});
	jQuery('#sub').click(function(e){
		e.preventDefault();
		jQuery('#errors').hide();
		jQuery('#errors').find('ul').empty();
		var v1=true;
		var v2=true;
		if(jQuery('#myForm').find('select[name="idFournisseur"]').val()==0){
			jQuery('#myForm').find('select[name="idFournisseur"]').addClass('has-error');
			v1=false;
			jQuery('#errors').find('ul').append('<li>Le choix du fournisseur est obligatoire</li>');
		}else{
			v1=true;
		}
		if(jQuery('#theTable').find('tbody > tr').length!=0){
			jQuery.each(jQuery('#theTable').find('tbody > tr'),function(index,value){
				if(!validerTr(value)){
					v2=false;
				}
			});
		}else{
			jQuery('#errors').find('ul').append('<li>La commande doit contenir au moins un article</li>');
			v2=false;
		}
		if(jQuery('#errors').find('ul > li').length!=0){
			jQuery('#errors').show();
		}
		if(v1 && v2){
			jQuery('#myForm').submit();
		}
		
	});
});


</script>