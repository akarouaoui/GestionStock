<div class="rightpanel">
    <!-- Nav tabs -->
    <ul class="nav nav-tabs nav-justified">
        <li class="active"><a href="#rp-alluser" data-toggle="tab"><i class="fa fa-users"></i></a></li>
        <li><a href="#rp-favorites" data-toggle="tab"><i class="fa fa-heart"></i></a></li>
        <li><a href="#rp-history" data-toggle="tab"><i class="fa fa-clock-o"></i></a></li>
        <li><a href="#rp-settings" data-toggle="tab"><i class="fa fa-gear"></i></a></li>
    </ul>
        
    <!-- Tab panes -->
    <div class="tab-content">
        <div class="tab-pane active" id="rp-alluser">
            <h5 class="sidebartitle">Online Users</h5>
            <ul class="chatuserlist">
                <li class="online">
                    <div class="media">
                        <a href="#" class="pull-left media-thumb">
                            <img alt="" src="<%=request.getContextPath()%>/resources/images/photos/user1.png" class="media-object">
                        </a>
                        <div class="media-body">
                            <span class="pull-right badge badge-danger">2</span>
                            <strong>Zaham Sindilmaca</strong>
                            <small>San Francisco, CA</small>
                        </div>
                    </div><!-- media -->
                </li>
                
            </ul>
            
            <div class="mb30"></div>
            
            <h5 class="sidebartitle">Offline Users</h5>
            <ul class="chatuserlist">
                <li>
                    <div class="media">
                        <a href="#" class="pull-left media-thumb">
                            <img alt="" src="<%=request.getContextPath()%>/resources/images/photos/user5.png" class="media-object">
                        </a>
                        <div class="media-body">
                            <strong>Eileen Sideways</strong>
                            <small>Los Angeles, CA</small>
                        </div>
                    </div><!-- media -->
                </li>
                
            </ul>
        </div>
        <div class="tab-pane" id="rp-favorites">
            <h5 class="sidebartitle">Favorites</h5>
            <ul class="chatuserlist">
                <li class="online">
                    <div class="media">
                        <a href="#" class="pull-left media-thumb">
                            <img alt="" src="<%=request.getContextPath()%>/resources/images/photos/user2.png" class="media-object">
                        </a>
                        <div class="media-body">
                            <strong>Eileen Sideways</strong>
                            <small>Los Angeles, CA</small>
                        </div>
                    </div><!-- media -->
                </li>
                
            </ul>
        </div>
        <div class="tab-pane" id="rp-history">
            <h5 class="sidebartitle">History</h5>
            <ul class="chatuserlist">
                <li class="online">
                    <div class="media">
                        <a href="#" class="pull-left media-thumb">
                            <img alt="" src="<%=request.getContextPath()%>/resources/images/photos/user4.png" class="media-object">
                        </a>
                        <div class="media-body">
                            <strong>Eileen Sideways</strong>
                            <small>Hi hello, ctc?... would you mind if I go to your...</small>
                        </div>
                    </div><!-- media -->
                </li>
            </ul>
        </div>
        <div class="tab-pane pane-settings" id="rp-settings">
            
            <h5 class="sidebartitle mb20">Settings</h5>
            <div class="form-group">
                <label class="col-xs-8 control-label">Show Offline Users</label>
                <div class="col-xs-4 control-label">
                    <div class="toggle toggle-success"></div>
                </div>
            </div>
            
            <div class="form-group">
                <label class="col-xs-8 control-label">Enable History</label>
                <div class="col-xs-4 control-label">
                    <div class="toggle toggle-success"></div>
                </div>
            </div>
            
            <div class="form-group">
                <label class="col-xs-8 control-label">Show Full Name</label>
                <div class="col-xs-4 control-label">
                    <div class="toggle-chat1 toggle-success"></div>
                </div>
            </div>
            
            <div class="form-group">
                <label class="col-xs-8 control-label">Show Location</label>
                <div class="col-xs-4 control-label">
                    <div class="toggle toggle-success"></div>
                </div>
            </div>
            
        </div><!-- tab-pane -->
        
    </div><!-- tab-content -->
  </div><!-- rightpanel -->
  
</section>
<script src="<%=request.getContextPath()%>/resources/js/jquery-1.11.2.js"></script>
<script src="<%=request.getContextPath()%>/resources/js/jquery-migrate-1.2.1.min.js"></script>
<script src="<%=request.getContextPath()%>/resources/js/bootstrap.min.js"></script>
<script src="<%=request.getContextPath()%>/resources/js/modernizr.min.js"></script>
<script src="<%=request.getContextPath()%>/resources/js/jquery.sparkline.min.js"></script>
<script src="<%=request.getContextPath()%>/resources/js/toggles.min.js"></script>
<script src="<%=request.getContextPath()%>/resources/js/retina.min.js"></script>
<script src="<%=request.getContextPath()%>/resources/js/jquery.cookies.js"></script>
<script src="<%=request.getContextPath()%>/resources/js/jquery.gritter.min.js"></script>
<script src="<%=request.getContextPath()%>/resources/js/custom.js"></script>
<script src="<%=request.getContextPath()%>/resources/js/moment.min.js"></script>
<script src="<%=request.getContextPath()%>/resources/js/jquery-ui.min.js"></script>
<script src="<%=request.getContextPath()%>/resources/js/datepicker-fr.js"></script>

<c:set value="<%=request.getContextPath()%>" var="x" scope="page"/>

<c:if test="${pageContext.request.userPrincipal.name != null}">
<script type="text/javascript">
jQuery(document).ready(function poll() {
	   setTimeout(function() {
		   jQuery.ajax({
				url:'<%=request.getContextPath()%>' + '/ajax/getn',
				type:'GET',
				datatype:'json',
				cache: false,
				success:function(data){
					var count=parseInt(jQuery('#notifCount').html);
					if(isNaN(count)){
						count=0;
					}
					jQuery.each(data,function(index,value){					
						count++;
						jQuery('#addhere').prepend('<li class=\'new\'><a href="${x}'+value.link+'"><span class=\'desc\'><span class=\'name\'>'+value.message+'<span class=\'badge badge-success\'></span></span><span class=\'msg\'></span></span></a></li>');
						var cls;
						switch(value.type){
						case 'info':
							cls='growl-info';
							break;
						case 'success':
							cls='growl-success';
							break;
						case 'fail':
							cls='growl-danger';
							break;
						default:
							cls='growl-info';
							break;
						}
						jQuery.gritter.add({
							title: 'Info',
							text: value.message,
					      	class_name: cls,
							sticky: false,
							time: ''
						 });
					});
					if(count!=0){
						
						jQuery('#notifCount').html(count);
						jQuery('#notifCount').show();
					}
					
					
				},complete:poll});
	    }, 20000);
	   
	   
	});
	
</script>
</c:if>

<script type="text/javascript">
jQuery(document).ready(function(){
	<c:if test="${pageContext.request.userPrincipal.name != null}">
		var count=parseInt(${sessionScope.ncount});
		jQuery('#notifCount').html(count);
			if(count==0){
				jQuery('#notifCount').hide();
			}else{
				jQuery('#notifCount').show();
			}
			jQuery.ajax({
				url:'<%=request.getContextPath()%>/getSysStats',
				data:'code=${matricule}',
				type:'POST',
				success:function(data){
					if(data.dcount!=null){
						jQuery('#lirdrh').find('span').text(data.dcount);
					}
					if(data.dsupcount!=null){
						jQuery('#liremps').find('span').text(data.dsupcount);					
					}
					if(data.iccount!=null){
						jQuery('#lirempa').find('span').text(data.iccount);
					}
					if(data.ivcount!=null){
						jQuery('#lird').find('span').text(data.ivcount);
					}
					if(data.dacount!=null){
						jQuery('#licda').find('span').text(data.dacount);
					}
				}
			});
	</c:if>
	
	jQuery('#save').click(function(){
		jQuery.ajax({
			url:'<%=request.getContextPath()%>'+'/saveUrl',
			data:'u='+'${requestScope['javax.servlet.forward.request_uri']}',
			type:'POST'
			
			
		});
	});
	<c:if test="${pageContext.request.userPrincipal.name == null}">
	jQuery('ul.nav li').click(function(){
		
		jQuery.ajax({
			url:'<%=request.getContextPath()%>'+'/saveUrl',
			data:'u='+jQuery(this).find('a').attr('href'),
			type:'POST'
			
			
		});
	});
	</c:if>
	
	jQuery('#reseter').click(function reset(){
		
		jQuery.ajax({
			url:'<%=request.getContextPath()%>/ajax/reset',
			type:'POST',
			success:function(data){jQuery('#notifCount').hide();}
		});

	});
	
	
});

</script>
</body>
</html>
