<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="header.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<title>Insert title here</title>
</head>
<body>
	<div class="panel-heading">
		<h3 align="left" class="panel-title">
			<span class="glyphicon glyphicon-user"></span> Administrator
			DashBoard
		</h3>
		<h3 align="center" class="panel-title">
			<span class="glyphicon glyphicon-home"></span><a href="admin">Home</a>
		</h3>
		<h3 align="right" class="panel-title">
			<span class="glyphicon glyphicon-log-out"></span><a href="#">Logout</a>
		</h3>
	</div>

	<div>
	 <form:form action="${pageContext.request.contextPath}/updateprod" modelAttribute="product" enctype="Multipart/form-data" method="post">
 
 <table align="center" cellspacing="2">
	<tr>
		<td colspan="2"><h1>Product Module</h1></td>
	</tr>
	<tr>
		<td>Product ID</td>
		 <td><form:input path="pid" type="hidden"/></td>
	</tr>
	<tr>
		<td>Product Name</td>
		 <td><form:input path="pname" required="required"/></td>
	</tr>
	<tr>
		<td>Product Desc</td>
		 <td><form:textarea path="description" required="required"/></td>
	</tr>
	
		<tr>
		<td> Product Stock</td>
		 <td><form:input path="quantity" required="required"/></td>
	</tr>
	
	<tr>
		<td>Product Price</td>
		<td><form:input path="pprice" required="required"/></td>
	</tr>
	   
	 <tr>
		<td>Category Id</td>
		<td><form:input path="catid" type="hidden" /></td>
	</tr>  
		 
		 
		 <tr>
				<td><h4><b>Category</b></h4></td>
				<td><form:select path="catid"   required="required">
						<form:option value="0" label="------Select----" />
						<form:options items="${catlist}" />
					</form:select>
				</td>
	</tr>	
	
	<tr>
				<td><h4><b>SubCategory</b></h4></td>
				<td><form:select path="subcatid"   required="required">
						<form:option value="0" label="------Select----" />
						<form:options items="${subcatlist}" />
					</form:select>
				</td>
	</tr>		
		 
	<tr>
		<td>Product Image</td>
		<td><form:input type="file" path="pimage" /></td>
	</tr>
		
	
	<tr>
		<td colspan="2">
			<center><input type="submit" value="updateproduct"/><a href="<c:url value="/viewproduct"/>" class="btn btn">Cancel</a></center>
		</td>
	</tr>
</table>
 
 
 </form:form>
	</div>
		
	
</body>
</html>