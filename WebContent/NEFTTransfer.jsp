<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>  
<head>  
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">  
<title>View Users</title>  
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/css/bootstrap.min.css" integrity="sha384-Smlep5jCw/wG7hdkwQ/Z5nLIefveQRIY9nfy6xoR1uRYBtpZgI6339F5dgvm/e9B" crossorigin="anonymous">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/js/bootstrap.min.js" integrity="sha384-o+RDsa0aLu++PJvFqy8fFScvbHFLtbvScb8AjopnFD+iEQ7wo/CG0xlczd+2O/em" crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<style>
.customer{
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
	$('#NEFTTransfer').addClass('active');
	
	
	var currentBalance= 0;
	currentBalance = parseFloat($('#fromAccountList').find('option:selected').attr('id'));
	var currentAccType=  $('#fromAccountList').find('option:selected').attr('data-accType');
	var minBalance = parseFloat($('#fromAccountList').find('option:selected').attr('data-minBalance'));
	
	//console.log(currentBalance + "     " + currentAccType);
	
	$('#fromAccountList').on('change', function(){
		currentBalance = parseFloat($(this).find('option:selected').attr('id'));	
		currentAccType = $(this).find('option:selected').attr('data-accType');
		minBalance = parseFloat($(this).find('option:selected').attr('data-minBalance'));

		//console.log(currentBalance + "     " + currentAccType);
		$('#transferAmount').val("");
	});
		
	$('#transferAmount').on('keyup', function(){
		var amount = parseFloat($(this).val());
	//	console.log(amount   + "   ajsdhc - " + (amount > currentBalance));
		//if(amount > currentBalance){
		//	alert("Amount entered is greater than the Minimum Balance.");
		//}
		if((currentBalance - amount < minBalance)){
			alert("Minimum Balance of Rs." + minBalance +" should be maintained.");
		}
	});
	
});
</script>
  
    <div class="row">
  		<div class="col-3">
 			<jsp:include page="CustomerPage.jsp" />  
  		</div>
  	
  	<div class="col-9">
  	<div class="row">
  	</div>
  
  <div class="row">

   <%@page import="com.bank.*,com.bankDAO.*,java.util.*,java.net.URLEncoder"%>  
  <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>  

<%
boolean loggedIn = session != null && session.getAttribute("customerid") != null;

if(!loggedIn) {
	 String message = "Please Login!";
		response.sendRedirect("CustomerLogin.jsp?message=" + URLEncoder.encode(message, "UTF-8"));
}
else {
	String customerid=(String)session.getAttribute("customerid");

	ArrayList<Account> accounts = AccountDAO.getAccountsForCustomer(Integer.parseInt(customerid), MenuMethods.GetAccountType.SAVINGS_AND_CURRENT);  
	request.setAttribute("accounts",accounts);


	ArrayList<Beneficiary> beneficiaryList = BeneficiaryDAO.getBeneficiary(Integer.parseInt(customerid), 2);
	request.setAttribute("beneficiaryList",beneficiaryList);
}


%>  
	<form action="NEFTTransfer" method="post">
	<div>
	<br><br><h3>NEFT TRANSFER</h3><br>
	
	<div class="row">
		<div class="col-6">
			<p>Select From Account : </p>
		</div>
		<div class="col-6">
			<select name="FromAccountnumber" id="fromAccountList">
				<c:forEach items="${accounts}" var="account"> 
					<option value="${account.getAccountNumber()}" id="${account.getAccountBalance()}" data-accType="${account.getAccountType()}" data-minBalance="${account.getMinimumBalance()}" data-accNo="${account.getAccountNumber()}">${account.getAccountNumber()}-${account.getAccountName()} (${account.getBranchName()})</option><br><br>
				</c:forEach>
			</select>
		</div>
	</div>
	<br>
	
	<div class="row">
		<div class="col-6">
			<p>Select To Account : </p>
		</div>
		<div class="col-6">
			<select name="ToAccountnumber" id="toAccountList">
				<c:forEach items="${beneficiaryList}" var="beneficiary"> 
					<option>${beneficiary.getBeneficiaryAccountNumber()}</option><br><br>
				</c:forEach>
			</select>
		</div>
	</div>
	<br>
	
	<div class="row">
		<div class="col-6">
			<p>Enter the Amount : </p>
		</div>
		<div class="col-6">
			<input type="text" id="transferAmount" placeholder="Amount" name="amount"><br>
		</div>
	</div>
	<br>
	
	<div class="row">
		<div class="col-6">
			<p>Enter Message : </p>
		</div>
		<div class="col-6">
			<input type="text" placeholder="Message" name="description"><br>
		</div>
	</div>
   <br>
    
    <div class="row">
			<div class="col-6">
				<input type="submit" value="Transfer" />
			</div>
			<div class="col-6">
				<input type="submit" form="cancelform" value="Cancel"/>
			</div>	
	</div>
	</div>
	<br><br>
	<s:if test="hasActionErrors()">
      	<div style="color:red">
      		<s:actionerror/>
      	</div>
	</s:if>
	<s:if test="hasActionMessages()">
      	<div style="color:white">
      		<s:actionmessage/>
      	</div>
	</s:if>
	</form>
    
	
	<form id="cancelform" action="CustomerDashboard.jsp"></form>
     
  </div>
  </div>
</div>
</body>  
</html>