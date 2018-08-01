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

 <%@page import="com.bank.*,com.bankDAO.*,java.util.*,java.net.URLEncoder"%>  
  <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>  

<%
boolean loggedIn = session != null && session.getAttribute("customerid") != null;

if(!loggedIn) {
	 String message = "Please Login!";
		response.sendRedirect("CustomerLogin.jsp?message=" + URLEncoder.encode(message, "UTF-8"));
}
else {
	String customerID = (String)session.getAttribute("customerid");
	String accountNumber = request.getParameter("val");

	TransactionDAO transactiondao = new TransactionDAO();
	ArrayList<Transaction> transactionHistory = transactiondao.getTransactionHistory(Integer.parseInt(customerID), Integer.parseInt(accountNumber));

	request.setAttribute("transactionHistory", transactionHistory);
}

%>

 <table id="myTable" border="2" width="150%" style="color:white">
 	<tr><th>DATE AND TIME</th><th>REFERENCE NUMBER</th><th>TRANSACTION TYPE</th><th>NARRATION</th><th>TRANSACTION AMOUNT</th><th>CLOSING BALANCE</th></tr>  
  	<c:forEach items="${transactionHistory}" var="transaction">
	  	<tr>
	  		<td>${transaction.getTransactionDateTime()}</td>
			<td>${transaction.getTransactionID()}</td>
			<td>${transaction.getTransactionName()}</td>
			<td>${transaction.getDescription()}</td>
			<td>${transaction.getTransactionAmount()}</td>
			<td>${transaction.getAccountBalance()}</td>
	  	</tr>
 	</c:forEach>
	</table> 
</body>  
</html>  