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
	$('#CreateAccount').addClass('active');
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

<%  
ArrayList<Branch> branchList = BranchDAO.getAllBranches();  
request.setAttribute("branchList",branchList); 

ArrayList<Customer> customerList = CustomerDAO.getAllCustomers();
request.setAttribute("customerList",customerList); 

ArrayList<AccountLookup> accountLookupList = AccountDAO.getAccountLookup();
request.setAttribute("accountLookupList",accountLookupList);
%>  
 
	
	<form action="addCustomerAccounts" method="post">
	<h3>Add Accounts For A Customer</h3><br><br>
	
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
			<p>Select A Customer : </p>
			</div>
		<div class="col-8">
			<select name="customerid">
				<c:forEach items="${customerList}" var="u"> 
					<option value="${u.getCustomerID()}">${u.getCustomerID()}-${u.getCustomerFirstName()} ${u.getCustomerLastName()}</option><br><br>
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
	
	
    <input type="submit" value="Add " />
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