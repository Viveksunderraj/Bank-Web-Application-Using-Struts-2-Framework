<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>  
<head>  
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">  
<title>View Users</title>  
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/css/bootstrap.min.css" integrity="sha384-Smlep5jCw/wG7hdkwQ/Z5nLIefveQRIY9nfy6xoR1uRYBtpZgI6339F5dgvm/e9B" crossorigin="anonymous">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/js/bootstrap.min.js" integrity="sha384-o+RDsa0aLu++PJvFqy8fFScvbHFLtbvScb8AjopnFD+iEQ7wo/CG0xlczd+2O/em" crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<style>
.branch-list{
  padding: 8% 0 0;
  margin: auto;
 }


h3
 {
  font-family: "Roboto", sans-serif;
  text-transform: uppercase;
  font-size: 20px;
  color: white;
 }
 
 body {
  background: #0b63ad; /* fallback for old browsers */
  font-family: "Roboto", sans-serif;
}
 
</style>
</head>  
<body>  
<script>
$(document).ready(function(){
	$('a').removeClass('active');
	$('#Top5Customers').addClass('active');
});
</script>
  <div class="row">
  <div class="col-3">
 	<jsp:include page="AdminPage.jsp" />  
  </div>
  <div class="col-9">
  
  <%@page import="com.bank.*,com.bankDAO.*,java.util.*"%>  
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>  

  
<div class="branch-list">
<h3 style= "color:#f2f2f2;">Top Customers</h3>
<% 
ArrayList<TopCustomers> customerList = AccountDAO.getTopCustomers();
request.setAttribute("customerList",customerList);
%>  

<table border="2" width="90%" style="color:white">  
<tr><th>CUSTOMER ID</th><th>CUSTOMER NAME</th><th>ACCOUNT BALANCE</th></tr>
	<c:forEach items="${customerList}" var="customer">  
	<tr>
		<td>${customer.getCustomerID()}</td>
		<td>${customer.getCustomerName()}</td>
		<td>${customer.getAccountBalance()}</td>
	</tr>  
	</c:forEach>  
</table>  
</div>
  </div>
  </div>

</body>  
</html>  