<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/css/bootstrap.min.css" integrity="sha384-Smlep5jCw/wG7hdkwQ/Z5nLIefveQRIY9nfy6xoR1uRYBtpZgI6339F5dgvm/e9B" crossorigin="anonymous">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/js/bootstrap.min.js" integrity="sha384-o+RDsa0aLu++PJvFqy8fFScvbHFLtbvScb8AjopnFD+iEQ7wo/CG0xlczd+2O/em" crossorigin="anonymous"></script>
<link rel="stylesheet" href="jquery-ui-1.12.1.custom/jquery-ui.min.css">
<script type="text/javascript" src="jquery-ui-1.12.1.custom/external/jquery/jquery.js"></script>
<script type="text/javascript"  src="jquery-ui-1.12.1.custom/jquery-ui.min.js"></script>
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
 
  <a id="CustomerDashboard" href="CustomerDashboard.jsp" class="active" style="text-align: center;">CUSTOMER MENU</a>
  <a id="Deposit" href="Deposit.jsp">Deposit</a>
  
   <a id="Withdraw" href="Withdraw.jsp">Withdraw</a>
   <a id="TransferBetweenAccounts" href="TransferBetweenAccounts.jsp">Transfer Between Accounts</a>
   <a id="TransferWithinBank" href="TransferWithinBank.jsp">Transfer Within Bank</a>
   <a id="NEFTTransfer" href="NEFTTransfer.jsp">NEFT Transfer</a>
   <a id="AvailLoan" href="AvailLoan.jsp">Avail Loan</a>
   <a id="RepayLoan" href="RepayLoan.jsp">Repay Loan</a>
    
  <a id="AddBeneficiary" href="AddBeneficiary.jsp" >Add Beneficiary</a>
  <a id="ListBeneficiary" href="ListBeneficiary.jsp" >List Beneficiary</a>
  <a id="TransactionHistory" href="TransactionHistory.jsp">Transaction History</a>
  
  <a id="Logout" href="customerLogout">Logout</a>
</div>
</body>
</html>