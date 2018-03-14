<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<html>
<head>
<title>HOME DECORS</title>
<meta name="viewport" content="width=device-width,initial-scale=1">
<meta charset="utf-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
</head>
<body background="C:\Users\SHIVANVITHAAMMULU\Desktop\project\46.jpg" background-size:100% ;">
<jsp:include page="/WEB-INF/views/header.jsp"></jsp:include>
<div class="container">
<h2>Product List For Admin</h2>
<table class="table table-hover bg-warning" id="apl" class="display" border="2" width="80" align="center">
<tr>
<th>S.No</th>
<th>PID</th>
<th>Product Name</th>
<th>Product Supplier</th>
<th>Product Category</th>
<th>Description</th>
<th>Stock</th>
<th>Price</th>
<th>Image</th>

<th class="span2">ACTION</th>
</tr>
<c:if test="${empty productList}">
<tr>
<td colspan="10" align="center">No record exists!!</td>
</tr>
</c:if>
<c:forEach var="product" varStatus="st" items="${productList}">
<tr>
<td><c:out value="${st.count}"></c:out></td>
<td><c:out value="${product.pid}"></c:out></td>
<td><c:out value="${product.name}"></c:out></td>
<td><c:out value="${product.supplier_id}"></c:out></td>
<td><c:out value="${product.category_id}"></c:out></td>
<td class="span3"><c:out value="${product.description}"></c:out></td>
<td><c:out value="${product.price}"></c:out></td>
<td><c:out value="${product.instock}"></c:out></td>

<td><img src="${pageContext.request.contextPath}/resources/${product.imagName}" height="50px" width="50px"></td>
<td><c:set var="contexRoot" value="${pageContext.request.contextPath}"></c:set>
<a class="btn btn-info" role="button" href="<c:url value="/prodDetails/${product.pid}"/>">Details</a>
<tr>
</c:forEach>
</table>
</div>

<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>


</body>
</html> 