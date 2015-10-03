<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="f"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="description" content="Club EL MOROCCO">
  <meta name="author" content="AyoubKarouaoui">
  <meta http-equiv='X-UA-Compatible' content='IE=edge,chrome=1'>
  <link rel="shortcut icon" href="<%=request.getContextPath()%>/resources/images/favicon.png" type="image/png">

  <title>EL MOROCCO CLUB</title>
  <link href="<%=request.getContextPath()%>/resources/css/style.default.css" rel="stylesheet">
  <link href="<%=request.getContextPath()%>/resources/css/jquery.gritter.css" rel="stylesheet">
  <style type="text/css">
  td{
  text-align: center !important;
  vertical-align: middle !important;
  }
  th{
  text-align: center !important;
  vertical-align: middle !important;
  }
  </style>
  
  <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
  <!--[if lt IE 9]>
  <script type="text/javascript">
		window.location = "<%=request.getContextPath()%>/unsupported";
  </script>
  <script src="<%=request.getContextPath()%>/resources/js/html5shiv.js"></script>
  <script src="<%=request.getContextPath()%>/resources/js/selectivizr.js"></script>
  <![endif]-->
  
 <style type="text/css">
 	body{
 	font-family: 'Open Sans', sans-serif;
 	}
 	.new {
    background: antiquewhite;
 	
 	}
 	.ui-datepicker td a {
 	color : white !important;
 	}
 	.ui-datepicker-title {
 	font-family: 'Open Sans', sans-serif !important;
 	}
 	#theTitle {
 		color:#1d2939;
 	}
 	#theTitle:hover {
 		text-decoration: none;
 	}
 </style> 
</head>

<body>


<!-- Preloader -->
<div id="preloader">
    <div id="status"><i class="fa fa-spinner fa-spin"></i></div>
</div>
<div id="jGrowl" class="bottom-right jGrowl">
	<div id="cont" class="jGrowl-notification"></div>
</div>
<section >
  
  <div class="leftpanel">
    
    <div class="logopanel" >
        <h1 style="font-size: 24px;"><a id="theTitle" href="<%=request.getContextPath()%>"><span>[</span>EL MOROCCO CLUB<span>]</span></a></h1>
    </div><!-- logopanel -->
    
    <div class="leftpanelinner">
       <c:if test="${pageContext.request.userPrincipal.name == null}">
       <!-- This is only visible to small devices -->
        <%-- <div class="visible-xs hidden-sm hidden-md hidden-lg">   
            <div class="media userlogged">
                <img alt="" src="<%=request.getContextPath()%>/resources/images/photos/loggeduser.png" class="media-object">
                <div class="media-body">
                    <h4>John Doe</h4>
                    <span>"Life is so..."</span>
                </div>
            </div>
          
            <h5 class="sidebartitle actitle">Mon compte</h5>
            <ul class="nav nav-pills nav-stacked nav-bracket mb30">
              <li><a href="#"><i class="fa fa-cog"></i> <span>Paramètres</span></a></li>
              <li><a href="#"><i class="fa fa-question-circle"></i> <span>Aide</span></a></li>
              <li><a href="<c:url value="/j_spring_security_logout"/>"><i class="fa fa-sign-out"></i> <span>Déconnexion</span></a></li>
            </ul>
        </div> --%>
       </c:if>
        
        
      
      <h5 class="sidebartitle">Navigation</h5>
      <ul class="nav nav-pills nav-stacked nav-bracket">
        <li id="lihome"><a href="<%=request.getContextPath()%>" ><i class="fa fa-home"></i> <span>Accueil</span></a></li>
        <li id="ligp"><a href="<%=request.getContextPath()%>/GestionProds/Liste" ><i class="glyphicon glyphicon-list"></i> <span>Gestion de produits</span></a></li>
        <li id="ligs"><a href="<%=request.getContextPath()%>/GestionStock/" ><i class="fa fa-home"></i> <span>Gestion de stock</span></a></li>
      </ul>
      <div class="infosummary">
        <h5 class="sidebartitle">Informations Utiles</h5>
        <ul style="color:white;">
        
        </ul>
      </div>
      
      
    </div><!-- leftpanelinner -->
  </div><!-- leftpanel -->
    
  <div class="mainpanel">
    
    <div class="headerbar">
      
      <a class="menutoggle"><i class="fa fa-bars"></i></a>
      
      <%-- <form class="searchform" action="" method="post">
        <input type="text" class="form-control" name="keyword" placeholder="Chercher" />
      </form> --%>
      <div class="hidden-xs visible-sm visible-md visible-lg">
      <div class="header-right">
        <ul class="headermenu">
<!--         If user isn't connected  -->
        <c:if test="${pageContext.request.userPrincipal.name == null}">
          	 <li>
            <div class="btn-group">
              	<a href="<%=request.getContextPath()%>/login" id="save"><button class="btn btn-default dropdown-toggle tp-icon" >Se connecter</button></a>
            </div>
            </li>
        </c:if>
        
<!--         If user Is connected -->
        <c:if test="${pageContext.request.userPrincipal.name != null}">
          <li id="reseter">
            <div class="btn-group">
              <button class="btn btn-default dropdown-toggle tp-icon" data-toggle="dropdown" >
                <i class="glyphicon glyphicon-globe"></i>
                <span class="badge" id="notifCount">${sessionScope.ncount}</span>
              </button>
              <div class="dropdown-menu dropdown-menu-head pull-right">
                <h5 class="title"><c:if test="${sessionScope.ncount==0}">Pas de nouvelles notifications</c:if><c:if test="${sessionScope.ncount!=0}">Vous avez ${sessionScope.ncount} nouvelles notifications</c:if></h5>
                <ul class="dropdown-list gen-list" id="addhere">
                <c:forEach items="${sessionScope.notifs}" var="notif" end="6">
               	<li class="new">
                    <a href="<%=request.getContextPath()%>${notif.link}">
                    
                    <span class="desc">
                      <span class="name">${notif.message}<span class="badge badge-success"></span></span>
                      <span class="msg"></span>
                    </span>
                    </a>
                  </li>  
                </c:forEach>
                                  
                  <li class="new"><a href="<%=request.getContextPath()%>/Parametres/Profil#notifs">Afficher toutes les notifications</a></li>
                </ul>
              </div>
            </div>
          </li>
          
          
          
          <li>
            <div class="btn-group">
              
            
              
              <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">
              <sec:authentication property="principal.imgPath" var="img" scope="page" />
             	
                <c:if test="${not empty img}">
                 <img alt="" src="<%=request.getContextPath()%>/loadImage?path=${img}" >
                </c:if>
                <c:if test="${empty img}">
                 <img alt="" src="<%=request.getContextPath()%>/resources/images/thumb.png" >
                </c:if>
                	<sec:authentication property="principal.fullName" var="nm" scope="page" />
                	${nm}
                <span class="caret"></span>
              </button>
              <ul class="dropdown-menu dropdown-menu-usermenu pull-right">
<!--                 <li><a href="profile.html"><i class="glyphicon glyphicon-user"></i>Mon profil</a></li> -->
                <li><a href="<%=request.getContextPath()%>/Parametres/Profil"><i class="glyphicon glyphicon-cog"></i>Paramètres</a></li>
                <li><a href="<%=request.getContextPath()%>/Help"><i class="glyphicon glyphicon-question-sign"></i>Aide</a></li>
                <li><a href="<c:url value="/j_spring_security_logout"/>"><i class="glyphicon glyphicon-log-out"></i>Déconnexion</a></li>
              </ul>
             
            	
              
            </div>
          </li>
          
          <li>
            <button id="chatview" class="btn btn-default tp-icon chat-icon">
                <i class="glyphicon glyphicon-comment"></i>
            </button>
          </li>
          </c:if>
        </ul>
      </div><!-- header-right -->
      </div>
    </div><!-- headerbar -->
        
    <div class="pageheader">
      <h2 id="pageName"><i class="fa fa-home" id="pageIcon"></i></h2>
      <!-- 
      <div class="breadcrumb-wrapper">
        <span class="label">You are here:</span>
        <ol class="breadcrumb">
          <li><a href="index.html">Bracket</a></li>
          <li class="active">Blank</li>
        </ol>
      </div>
       -->
    </div>
    <c:if test="${pageContext.request.userPrincipal.name != null}">
    <sec:authentication property="principal.matricule" var="matricule"/>
    </c:if>