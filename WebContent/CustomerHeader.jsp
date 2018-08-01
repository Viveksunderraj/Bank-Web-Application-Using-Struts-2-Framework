<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Header</title>

<style>
h2 {
  font-family: "Roboto", sans-serif;
  text-transform: uppercase;
  text-align: center;
  font-size: 36px;
  font-weight: 300;
  color: #f2f2f2;
}
body {
  background: #0b63ad; /* fallback for old browsers */
  font-family: "Roboto", sans-serif;
}
h3{
font-size: 20px;
color:#f2f2f2;
}
.custID{
	float: right;
	padding-left: 40px;
}
</style>
</head>
<body>

<script>
$(document).ready(function(){
	var branchid = $('#Branchid').attr('value');

	setSelectedIndex(document.getElementById('branchlist'),branchid);
	
	//$('#branchsubmit').click();
	
	$('#branchlist').on('change',function(){
		var branchid = ($(this).find('option:selected').attr('value'));
		
		getAccountDetails(branchid);
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


<div>
<div class="row">
<div class="col-11"> <h2>ZOHO BANK</h2></div>
	<div class="row">
  		<div class="col-3">
 			<jsp:include page="CustomerPage.jsp" />  
  		</div>
  	</div>

<h3>
<%
String customerfname=(String)session.getAttribute("customerfname"); 
String customerlname=(String)session.getAttribute("customerlname"); 
String customerid=(String)session.getAttribute("customerid");
int custid = Integer.parseInt(customerid);
out.print("Welcome " + customerfname + " " + customerlname + ", Customer ID = " + customerid);
%>
</h3>
<div class="custID">
<%

%>
</div>

<br><br>

</div>

<%@page import="com.bank.*,com.bankDAO.*,java.util.*"%>  
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>  

<%  
String branchid=(String)session.getAttribute("branchid");
ArrayList<Account> branchList = AccountDAO.getDistinctBranchesForCustomer(custid);

session.setAttribute("branchList",branchList);
%>  
<input type="hidden" value="${branchid}" id="Branchid"/>
<form action="CustomerAccounts.jsp" method="post" id="Branchform">
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
</div>

<div id="txtHint"><b>Person info will be listed here...</b></div>

</form>
</div>

</body>
</html>