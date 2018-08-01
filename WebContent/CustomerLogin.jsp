<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Banking Application</title>
<link href="css/main.css" rel="stylesheet">
</head>
<body>
<h2><strong>ZOHO BANK</strong></h2>




<div class="login-page">
	<h3><strong>Customer Login</strong></h3>
  <div class="form">
    <form class="login-form" action="customerLogin" method="post">
      <input type="text" placeholder="User Id" name="userid"/>
      <input type="password" placeholder="password" name="Password"/>
      <input type="submit" value="Login"/>
      <s:if test="hasActionErrors()">
      	<div class="errors" style="color:red">
      		<s:actionerror/>
      	</div>
	  </s:if>
	  <div style="color:red">${param.message}</div>
    </form>
  </div>
</div>

</body>
</html>
