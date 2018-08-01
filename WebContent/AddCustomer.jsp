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
	$('#AddCustomer').addClass('active');
});
</script>
<%@page import="com.bank.*,com.bankDAO.*,java.util.*"%>  
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
ArrayList<Branch> branchList = BranchDAO.getAllBranches();  
request.setAttribute("branchList",branchList);

ArrayList<AccountLookup> accountLookupList = AccountDAO.getAccountLookup();
request.setAttribute("accountLookupList",accountLookupList);
%>
  <div class="row">
  <div class="col-3">
 	<jsp:include page="AdminPage.jsp" />  
  </div>
  <div class="col-9 top">
  <div class=customer>
  <form action="addCustomer" method="post">
	<h3>Add Customer</h3><br>
	
	<div class="row">
		<div class="col-4">
			<p>Enter Your First Name : </p>
		</div>
		<div class="col-8">
			<input type="text" placeholder="First Name" name="customerfname"><br><br>
		</div>
	</div>
	
	<div class="row">
		<div class="col-4">
			<p>Enter Your Last Name : </p>
		</div>
		<div class="col-8">
			<input type="text" placeholder="Last Name" name="customerlname"><br><br>
		</div>
	</div>
	
	<div class="row">
		<div class="col-4">
			<p>Enter Your Address : </p>
			</div>
		<div class="col-8">
			<input type="text" placeholder="Address" name="customeraddress"><br><br>
		</div>
	</div>
	
	<div class="row">
		<div class="col-4">
			<p>Enter Your PhoneNumber : </p>
			</div>
		<div class="col-8">
			<input type="text" placeholder="Phone Number" name="customerphonenumber"><br><br>
		</div>
	</div>
	
	<div class="row">
		<div class="col-4">
			<p>Enter Your D.O.B : </p>
		</div>
		<div class="col-8">
			<input type="text" placeholder="YYYY-MM-DD" required pattern="(?:19|20)[0-9]{2}-(?:(?:0[1-9]|1[0-2])-(?:0[1-9]|1[0-9]|2[0-9])|(?:(?!02)(?:0[1-9]|1[0-2])/(?:30))|(?:(?:0[13578]|1[02])-31))" name="dateofbirth"><br><br>
		</div>
	</div>
	
	<div class="row">
		<div class="col-4">
			<p>Enter Password : </p>
		</div>
		<div class="col-8">
			<input type="password" placeholder="Password" name="customerpassword"><br><br>
		</div>
	</div>
	
	<div class="row">
		<div class="col-4">
			<p>Select A Branch : </p>
		</div>
		<div class="col-8">
			<select name="Branchid">
				<c:forEach items="${branchList}" var="u"> 
					<option value="${u.getBranchID()}">${u.getBranchName()}</option><br><br>
				</c:forEach>
			</select>
		</div>
	</div>
	
	
	<div class="row">
		<div class="col-4">
			<p>Select An Account : </p>
			</div>
		<div class="col-8">
			<select name="Accounttype">
				<c:forEach items="${accountLookupList}" var="u"> 
					<option value="${u.getAccountType()}">${u.getAccountName()}</option><br><br>
				</c:forEach>
			</select>
		</div>
	</div>
	
		<br>
    <input type="submit" value="Add Customer" />
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
  </div>
  </div>
  </div>

</body>  
</html>  