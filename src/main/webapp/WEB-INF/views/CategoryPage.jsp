<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" isELIgnored="false"%>

<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Login Page</title>
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    
</head>
<body  background="C:\Users\SHIVANVITHAAMMULU\Desktop\project\46.jpg" background="100% 100%">
<div class="bs-example">
    <nav id="myNavbar" class="navbar navbar-inverse" role="navigation">
        <!-- Brand and toggle get grouped for better mobile display -->
        <div class="container">
            <div class="navbar-header">
              <!--   <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"> -->
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="#"></a>
            </div>
            <!-- Collect the nav links, forms, and other content for toggling -->
            <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                <ul class="nav navbar-nav">
                    <li><a href="http://localhost:8080/HOMEDECORS1/">HOME</a></li>
                      </ul>
                 </div>
    </nav>
</div>

</body>
<c:url var="actionUrl" value="saveCategory" />

<form:form  commandName="category" method="post" action="${actionUrl }" class="form-horizontal" id="btn-add">



<h3>
			<c:if test="$(category.cid==0}">
		       Add New Item
	            </c:if>
			<c:if test="${!empty category.cid}">
		      Update Category for Id: <c:out value="${category.cid}" />
				 <form:hidden path="cid"/> 
			</c:if>
			</h3>

		
	<div class="form-group">
		<div class="col-xs-4">
		<c:if test="${category.cid!=0}">
		<form:input type="hidden" name="cid" path="cid" iplaceholder="Category Id" class="form-control" />
			</c:if>
		</div>
	</div>



	<div class="form-group">
		<label for="category Name" class="col-xs-4 control-label">Category Name</label>
		<div class="col-xs-4">
			<form:input name="categoryName" path="categoryName" placeholder="Category Name" class="form-control" />
	        <form:errors path="categoryName" cssStyle="color:#ff0000"></form:errors>
		</div>
	</div>

	<div class="form-group">
		<label for="code" class="col-xs-4 control-label">Category description</label>
		<div class="col-xs-4">
			<form:input name="categoryDescription"  path="categoryDescription" placeholder="Category Description" class="form-control" />
			  <form:errors path="categoryDescription" cssStyle="color:#ff0000"></form:errors>
		
		</div>
	</div>



	<div class="form-group">
	<label for="code" class="col-xs-4 control-label"></label>
		
		<div class="col-xs-4">
		
			
		<c:if test="${category.cid==0}">
		<input type="submit" value="Add Category" id="btn-add" class="btn btn-primary" >
		
		</c:if> <c:if test="${category.cid!=0}">
		
	   <input type="submit" value="Update Category" id="btn-update" class="btn btn-primary" >
	  </c:if>
		
		
		</div>
	</div>
</form:form>



		<table class="table table-striped table-bordered"  style="width: 80%">
			<thead>
				<tr>
					<th width="2%">S.N</th>
					<th width="2%">Category ID</th>
					<th width="2%">Category Name</th>
					<th width="2%">Category Description</th>
					<th width="2%">Category Action</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${categoryList}" var="category" varStatus="loopCounter">
					<tr>
						<td><c:out value="${loopCounter.count}" /></td>
						<td><c:out value="${category.cid}" /></td>
						<td><c:out value="${category.categoryName}" /></td>
						<td><c:out value="${category.categoryDescription}" /></td>
						
						<td><nobr>
<a class="btn btn-primary" href="editcategory/${category.cid}"><span class="glyphicon glyphicon-pencil" aria-hidden="true"></span> Edit</a>

<a class="btn btn-primary"  href="removecategory/${category.cid}"><span class="glyphicon glyphicon-trash" aria-hidden="true"></span> Delete
								</a>

							</nobr></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>

	

