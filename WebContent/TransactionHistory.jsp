<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>  
<head>  
<meta charset="UTF-8">
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
	$('#TransactionHistory').addClass('active');

	$( "#fromdate" ).datepicker({
		dateFormat: 'yy-mm-dd',
        autoclose: true,
        maxDate : new Date(),
        changeYear: true,
        onSelect: function(date) {
            $("#todate").datepicker('option', 'minDate', date);
          }
	});	
	var fromDate=0;
	//alert('hi');
	$("#fromdate").on('change',function(){
         fromDate = $(this).val();
         
	});
	$( "#todate" ).datepicker({
		dateFormat: 'yy-mm-dd',
        autoclose: true,
        changeYear: true,
        maxDate : new Date()
	});	
});

function setSelectedIndex(s, v) {

    for ( var i = 0; i < s.options.length; i++ ) {
        if ( s.options[i].value == v ) {
            s.options[i].selected = true;
            return;
        }
    }
}


function showDateFilter() {
	
	
	var fromDate = $('#fromdate').val();
	var toDate = $('#todate').val();
	var accountNumber = $('#accountNumber').val();
	var url = "TransactionHistoryDateWise.jsp?fromDate="+fromDate+"&toDate="+toDate+"&accountNumber="+accountNumber;
	
	if (fromDate == "" || toDate == "") {
        document.getElementById("txtHint").innerHTML = "";
        return;
    }
	
	if(window.XMLHttpRequest){  
		request = new XMLHttpRequest();  
		}  
		else if(window.ActiveXObject){  
		request = new ActiveXObject("Microsoft.XMLHTTP");  
		}  
		  
		try  
		{  
		request.onreadystatechange = getInfo;  
		request.open("GET",url,true);  
		request.send();  
		}  
		catch(e)  
		{  
		alert("Unable to connect to server");  
		}  
 }
	

function showAccount(accountnumber) {
    	
    	
    var url = "ShowTransactionHistory.jsp?val="+accountnumber;
    
    if (accountnumber == "") {
        document.getElementById("txtHint").innerHTML = "";
        return;
    }
    $('#fromdate').val("");
    $('#todate').val("");
    
	if(window.XMLHttpRequest){  
		request = new XMLHttpRequest();  
		}  
		else if(window.ActiveXObject){  
		request = new ActiveXObject("Microsoft.XMLHTTP");  
		}  
		  
		try  
		{  
		request.onreadystatechange = getInfo;  
		request.open("GET",url,true);  
		request.send();  
		}  
		catch(e)  
		{  
		alert("Unable to connect to server");  
		}  
 }

function getInfo(){  
	if(request.readyState==4){  
	var val=request.responseText;  
	document.getElementById("txtHint").innerHTML = val;
	}  
}  

</script>
  
    <div class="row">
  		<div class="col-3">
 			<jsp:include page="CustomerPage.jsp" />  
  		</div>
  	
  	<div class="col-9">
  	<div class="row">
  	</div>
  
  <div class="row">

  <%@page import="com.bank.*,com.bankDAO.*,java.util.*"%>  
  <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>  
 <%
String customerid=(String)session.getAttribute("customerid");
String branchid=(String)session.getAttribute("branchid");
ArrayList<Account> accounts = AccountDAO.getAccountsForCustomer(Integer.parseInt(customerid), MenuMethods.GetAccountType.ALL_ACCOUNTS);  

TransactionDAO transactiondao = new TransactionDAO();
ArrayList<Transaction> transactionHistory = transactiondao.getTransactionHistory(Integer.parseInt(customerid), accounts.get(0).getAccountNumber());

request.setAttribute("transactionHistory", transactionHistory);
request.setAttribute("accounts",accounts);
%>  
	<form>
	<br><br><h3>TRANSACTION HISTORY</h3><br>
	
	<div class="row">
		<div class="col-6">
			<p>Select An Account : </p>
		</div>
		<div class="col-6">
			<select name="Accountnumber" id="accountNumber" onchange="showAccount(this.value)">
				<c:forEach items="${accounts}" var="account"> 
					<option value="${account.getAccountNumber()}">${account.getAccountNumber()}-${account.getAccountName()}</option><br><br>
				</c:forEach>
			</select>
		</div>
	</div>
	
	<div class="row">
		<div class="col-6">
			<p>Select From Date : </p>
		</div>
		<div class="col-6">
			<input type="text" name="date" id="fromdate" disable="true">
		</div>
	</div>
	
	<div class="row">
		<div class="col-6">
			<p>Select To Date : </p>
		</div>
		<div class="col-6">
			<input type="text" name="todate" id="todate" disable="true">
		</div>
	</div>
	
	<input type="button" name="Filter" value="Filter" onclick="showDateFilter()" >

	<br><br><br>
    </form><br>
	
	
	<div id="txtHint">
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
	</div> 
  </div>
  </div>
</div>
</body>  
</html> 