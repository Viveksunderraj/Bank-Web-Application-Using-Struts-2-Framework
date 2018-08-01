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
  padding: 10% 0 0;
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
	$('#AddCustomerPassword').addClass('active');
});
</script>
  <div class="row">
  <div class="col-3">
 	<jsp:include page="AdminPage.jsp" />  
  </div>
  <div class="col-9 top">
  <div class=customer>
  <form action="addCustomerPassword" method="post">
	<h3>Add Customer Password</h3><br><br>
	
	<div class="row">
		<div class="col-4">
			<p>Enter The Customer ID : </p>
		</div>
		<div class="col-8">
			<input type="text" placeholder="Customer-ID" name="customerid"><br><br>
		</div>
	</div>
	
	<div class="row">
		<div class="col-4">
			<p>Enter the New Password : </p>
		</div>
		<div class="col-8">
			<input type="password" placeholder="Password" name="customerpassword"><br><br>
		</div>
	</div>
		<br><br>
    <input type="submit" value="Set Password" />
    
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
    <br>
  </div>
  </div>
  </div>

</body>  
</html>  