<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>  
<head>  
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">   
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/css/bootstrap.min.css" integrity="sha384-Smlep5jCw/wG7hdkwQ/Z5nLIefveQRIY9nfy6xoR1uRYBtpZgI6339F5dgvm/e9B" crossorigin="anonymous">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/js/bootstrap.min.js" integrity="sha384-o+RDsa0aLu++PJvFqy8fFScvbHFLtbvScb8AjopnFD+iEQ7wo/CG0xlczd+2O/em" crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<style>

h3 {
  font-family: "Roboto", sans-serif;
  text-transform: uppercase;
  text-align: center;
  font-weight: 300;
  color: #f2f2f2;
}

body {
  background: #0b63ad; /* fallback for old browsers */
  font-family: "Roboto", sans-serif;
}
 
</style>
</head>  
<body>  

<%@page import="com.bank.*,com.bankDAO.*,java.util.*"%>  
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>  

<%
String customerID = (String)session.getAttribute("customerid");
String branchID = request.getParameter("val");
ArrayList<Account> accountList = AccountDAO.getAccountsForCustomer(Integer.parseInt(customerID), Integer.parseInt(branchID));

request.setAttribute("accountList", accountList);
%>

 <table border="2" width="90%" style="color:white">
 <tr><th>ACCOUNT NUMBER</th><th>ACCOUNT TYPE</th><th>ACCOUNT BALANCE</th></tr>  
  	<c:forEach items="${accountList}" var="account">
	  	<tr>
	  		<td>${account.getAccountNumber()}</td>
			<td>${account.getAccountName()}</td>
			<td>${account.getAccountBalance()}</td>
	  	</tr>
 	</c:forEach>
	</table>
</body>  
</html>  