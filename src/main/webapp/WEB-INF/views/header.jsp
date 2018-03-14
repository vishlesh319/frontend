<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>APPLE STORE</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<body>
<nav class="navbar navbar-inverse">
  <div class="container-fluid">
    <div class="navbar-header">
      <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>                        
      </button>
      <a class="navbar-brand" href="#">APPLE STORE</a>
    </div>
    <div class="collapse navbar-collapse" id="myNavbar">
      <ul class="nav navbar-nav">
        <li><a href="http://localhost:8080/HOMEDECORS1/">Home</a></li>
       <li><a href="contact"><i class="fa fa-adress-book" aria-hidden="true"></i></a>
            
      <ul class="nav navbar-nav navbar-right">
      <c:if test="${pageContext.request.userPrincipal.name==null}">
        <li><a href="${pageContext.request.contextPath}/goToRegister"><span class="glyphicon glyphicon-user"></span> Register</a></li>
        <li><a href="${pageContext.request.contextPath}/goToLogin"><span class="glyphicon glyphicon-log-in"></span> Login</a></li>
        </c:if>
        <c:if test="${pageContext.request.userPrincipal.name !=null}">
                <li><a>Welcome: ${pageContext.request.userPrincipal.name}</a></li>
                <li><a href="<c:url value="/j_spring_security_logout"/>">Logout</a></li>
       </c:if>
                 
        <c:if test="${pageContext.request.userPrincipal.name == 'vishleshreddy319@gmail.com'}">
       
        
<%--  <li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown" href="${pageContext.request.contextPath}/admin">Admin List<span class="caret"></span></a>
        <ul class="dropdown-menu"> --%>
        <ul class="nav navbar-nav navbar-right">
       <li><a href="category">Category</a></li>
       <li><a href="supplier">Supplier</a></li>
        <li><a href="product">Product</a></li>
      
          <c:choose>
		<c:when test="${ProductPageClicked}">
			<c:import url="/WEB-INF/views/ProductPage.jsp"></c:import>
		</c:when>
	</c:choose>
	<c:choose>
		<c:when test="${CategoryPageClicked}">
			<c:import url="/WEB-INF/views/CategoryPage.jsp"></c:import>
		</c:when>
	</c:choose>
	<c:choose>
		<c:when test="${SupplierPageClicked}">
			<c:import url="/WEB-INF/views/SupplierPage.jsp"></c:import>
		</c:when>
	</c:choose>           
        
        <!-- </ul>
        </li>  -->
        </c:if> 
        <li><a href="${pageContext.request.contextPath}/viewcart"><span class="glyphicon glyphicon-shopping-cart"></span>cart</a>
        <li class="dropdown"><a href="index.html"
						class="dropdown-toggle" data-toggle="dropdown" role="button"
						aria-haspopup="true" aria-expanded="false"> <span
							class="glyphicon glyphicon-list-alt" aria-hidden="true"></span>
							Category <span class="caret"></span></a>
						<ul class="dropdown-menu">
      <c:forEach var="catval" items="${catList}">
      <li><a href="${pageContext.request.contextPath}/productCustList?cid=${catval.cid}">${catval.categoryName}</a>
      </li>
      </c:forEach>
  
          
			</div>
		</div>
	</nav>
	<br>
	<br>
	<br>

	
	

</head>
<body>

</body>
</html>