<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>  
<head>  
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">  
<title>View Users</title>  
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
<script>
$(document).ready(function(){
	$('a').removeClass('active');
	$('#CustomerDashboard').addClass('active');
});


function setSelectedIndex(s, v) {

    for ( var i = 0; i < s.options.length; i++ ) {
        if ( s.options[i].value == v ) {
            s.options[i].selected = true;
            return;
        }
    }
}

    
function showAccount(branchid) {
    	
    	
    var url = "CustomerAccounts.jsp?val="+branchid;
    
    if (branchid == "") {
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

   <%@page import="com.bank.*,com.bankDAO.*,java.util.*,java.net.URLEncoder"%>  
  <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>  

<%
boolean loggedIn = session != null && session.getAttribute("customerid") != null;

if(!loggedIn) {
	 String message = "Please Login!";
		response.sendRedirect("CustomerLogin.jsp?message=" + URLEncoder.encode(message, "UTF-8"));
}


String customerid=(String)session.getAttribute("customerid");
int custid = Integer.parseInt(customerid);
String branchid=(String)session.getAttribute("branchid");
ArrayList<Account> branchList = AccountDAO.getDistinctBranchesForCustomer(custid);

ArrayList<Account> accountList = AccountDAO.getAccountsForCustomer(custid, branchList.get(0).getBranchID());

request.setAttribute("accountList", accountList);

session.setAttribute("branchList",branchList);
%>  
	<form>
	<div>
	<br><br><h3>Welcome ${customerfname} ${customerlname}, Customer ID = ${customerid}</h3><br><br>
	<div class="row">
		<div class="col-6">
			<p>Select A Branch : </p>
		</div>
		<div class="col-5">
			<select name="Branchid" id="branchlist" onchange="showAccount(this.value)">
				<c:forEach items="${branchList}" var="u"> 
					<option value="${u.getBranchID()}">${u.getBranchName()}</option>
				</c:forEach>
			</select>
		</div>
	</div><br><br>
	<div id="txtHint" class="row"> 
		<div class="col-10">
			<table border="2" width="100%" style="color:white">
 				<tr><th>ACCOUNT NUMBER</th><th>ACCOUNT TYPE</th><th>ACCOUNT BALANCE</th></tr>  
  					<c:forEach items="${accountList}" var="account">
	  					<tr>
	  						<td>${account.getAccountNumber()}</td>
							<td>${account.getAccountName()}</td>
							<td>${account.getAccountBalance()}</td>
	  					</tr>
 					</c:forEach>
			</table>
		</div>
	</div>
	</div>
	</form>
	<br>
	
	
    
  </div>
  </div>
</div>
</body>  
</html> 