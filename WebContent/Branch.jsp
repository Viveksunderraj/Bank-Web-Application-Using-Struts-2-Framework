<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="s" uri="/struts-tags" %>
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
	$('#Branch').addClass('active');
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
<h3 style= "color:#f2f2f2;">Branch List</h3>
<%  
ArrayList<Branch> list = BranchDAO.getAllBranches();  
request.setAttribute("list",list);  
%>  
  
<table border="2" width="90%" style="color:white">  
<tr><th>ID</th><th>NAME</th><th>ADDRESS</th></tr>  
	<c:forEach items="${list}" var="u">  
	<tr>
		<td>${u.getBranchID()}</td>
		<td>${u.getBranchName()}</td>
		<td>${u.getBranchAddress()}</td>
	</tr>  
	</c:forEach>  
</table>  
	<br><br>
	<form action="AddBranch.jsp" method="get">
    <input type="submit" value="Add Branch" />
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