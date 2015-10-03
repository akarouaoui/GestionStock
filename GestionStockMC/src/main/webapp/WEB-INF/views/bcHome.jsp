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
         	<table class="table table-bordered">
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
         					<td></td>
         					<td><a href="BonCommande/getBC?idBC=${b.idCommande}">Commande-${b.numCommande}</a></td>
         					<td><a>Accuser la reception</a>||<a>Supprimer</a></td>
         				</tr>
         			</c:forEach>
         		</tbody>
         	</table>
         </div>
        </div>
        </div>
       
    </div>
    
  </div><!-- mainpanel -->
  


<%@ include file="bott.jsp"%>
<script type="text/javascript">
jQuery(document).ready(function(){
	jQuery('#ligs').addClass('active');
});


</script>