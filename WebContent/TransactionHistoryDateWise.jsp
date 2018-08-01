<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>

</head>

<body>
<%@page import="com.bank.*,com.bankDAO.*,java.util.*"%>  
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>  

<%
String fromDate = request.getParameter("fromDate");
String toDate = request.getParameter("toDate");
toDate = toDate + " 23:59:59";
String accountNumber = request.getParameter("accountNumber");

TransactionDAO transactiondao = new TransactionDAO();
ArrayList<Transaction> transactionHistory = transactiondao.getTransactionHistoryDateWise(Integer.parseInt(accountNumber), fromDate, toDate);

request.setAttribute("transactionHistory", transactionHistory);
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
