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
	$('#ListBeneficiary').addClass('active');
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
	 
	ArrayList<Beneficiary> beneficiaryList = BeneficiaryDAO.getBeneficiary(Integer.parseInt(customerid));
	request.setAttribute("beneficiaryList",beneficiaryList);	
}

%>  
		
		<form>
		<div>
		<br><br><h3>BENEFICIARY LIST</h3><br> 
		<div class="row"> 
			<table border="2" width="90%" style="color:white">  
				<tr><th>BeneFiciary Acc No</th><th>IFSC Code</th><th>Beneficiary Type</th></tr>  
			<c:forEach items="${beneficiaryList}" var="beneficiary">  
				<tr>
					<td>${beneficiary.getBeneficiaryAccountNumber()}</td>
					<td>${beneficiary.getIFSCcode()}</td>
					<td>${beneficiary.getBeneficiaryTypeName()}</td>
				</tr>  
			</c:forEach>  
		</table>  
 	</div>
 	</div>
 	</form>
  </div>
  </div>
</div>
</body>  
</html> 