<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/css/bootstrap.min.css" integrity="sha384-Smlep5jCw/wG7hdkwQ/Z5nLIefveQRIY9nfy6xoR1uRYBtpZgI6339F5dgvm/e9B" crossorigin="anonymous">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/js/bootstrap.min.js" integrity="sha384-o+RDsa0aLu++PJvFqy8fFScvbHFLtbvScb8AjopnFD+iEQ7wo/CG0xlczd+2O/em" crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<style>


/* Add a background color to the button if it is clicked on (add the .active class with JS), and when you move the mouse over it (hover) */
.active, .collapsible:hover {
  background-color: #ccc;
}

/* Style the collapsible content. Note: hidden by default */
.content {
  padding: 0 18px;
  display: none;
  overflow: hidden;
  background-color: #f1f1f1;
}



.row{
  height: 100%;
}
.vertical-menu {
    width: 200px;
}

.vertical-menu a {
    background-color: #eee;
    color: black;
    display: block;
    padding: 12px;
    text-decoration: none;
}

.vertical-menu a:hover{
    background-color: #ccc;
}

.vertical-menu a:focus{
    background-color: #ccc;
}

.vertical-menu a.active {
    background-color: #0b2875;
    color: white;
}
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
h3, p{
color:#f2f2f2;
}
</style>
</head>
<body>

<script>
$(document).ready(function(){

	/*$('a').click(function(){
    $(this).parent('div').find('a').removeClass('active');
		$(this).addClass('active');
		var view = $(this).attr('value');
    $('#partial').load(view);
		//$('.viewname').v()=view;
	});
*/
$(document).keydown(
    function(e)
    {
        if (e.keyCode == 38) {
            $("a:focus").prev().focus();
        }
        if (e.keyCode == 40) {
            $("a:focus").next().focus();

        }
    }
);

});
</script>

<div class="vertical-menu">
  <a id="menu" href="#" class="active" style="text-align: center;">MENU</a>
  <a id="Branch" href="Branch.jsp">Branch</a>
  
   <a id="AddCustomer" href="AddCustomer.jsp">Add Customer</a>
   <a id="AddCustomerPassword" href="AddCustomerPassword.jsp">Reset Customer Password</a>
   <a id="ListAllCustomers" href="ListAllCustomers.jsp">List All Customers</a>
   <a id="Top5Customers" href="TopCustomers.jsp">Top 5 Customers</a>
    
  <a id="CreateAccount" href="CreateAccount.jsp" value="" >Add Customer Account</a>
  <a href="adminLogout">Logout</a>
</div>
</body>
</html>