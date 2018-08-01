package com.bankaction;

import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.bank.Deposit;
import com.bank.Withdraw;
import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
public class TransferAction extends ActionSupport{
	private String FromAccountnumber;
	private String ToAccountnumber;
	private String amount;
	private String description;
	
	
	public String transferBetweenAccounts() {
		HttpSession session = ServletActionContext.getRequest().getSession(false);
		String stringCustomerID = (String) session.getAttribute("customerid");
		
		int customerID = Integer.parseInt(stringCustomerID);
		
		int transactionAccountNumber1 = Integer.parseInt(getFromAccountnumber());		
		int transactionAccountNumber2 = Integer.parseInt(getToAccountnumber());
		
		if(transactionAccountNumber1 == transactionAccountNumber2) {
			addActionError("From Account and To Account cannot be the same");
			return ERROR;
		}
		
		double transactionAmount = Double.parseDouble(amount);
		double accountBalance = 0;
		int transactionSubType = 0, transactionType = 3;
		
		String message = null;
		
		String description1 = description +" TR.To A\\c No: " + transactionAccountNumber2;
		String description2 = description +" TR.From A\\c No: " + transactionAccountNumber1;

		transactionSubType = 2;
		Withdraw transferWithdrawal = new Withdraw(transactionAmount, accountBalance, customerID, transactionAccountNumber1, transactionAccountNumber2, transactionType, transactionSubType, null, description1);
		if(!transferWithdrawal.withDraw()) {
			addActionError("Transfer Failed");
			return ERROR;
		}
		
		transactionSubType = 1;
		description2 = description +" TR.From A\\c No: " + transactionAccountNumber1;
		Deposit transferDeposit = new Deposit(transactionAmount, accountBalance, customerID, transactionAccountNumber2, transactionAccountNumber1, transactionType, transactionSubType, null, description2);
		if(!transferDeposit.deposit()) {
			addActionError("Transfer Failed");
			return ERROR;
		}
		
		message = "Succefully Transfered!!!";
		addActionMessage(message);
		return SUCCESS;
	}
	
	
	public String transferWithinBank() {
		HttpSession session = ServletActionContext.getRequest().getSession(false);
		String stringCustomerID = (String) session.getAttribute("customerid");
		
		int customerID = Integer.parseInt(stringCustomerID);
		
		int transactionAccountNumber1 = Integer.parseInt(getFromAccountnumber());		
		int transactionAccountNumber2 = Integer.parseInt(getToAccountnumber());
		
		double transactionAmount = Double.parseDouble(amount);
		double accountBalance = 0;
		int transactionSubType = 0, transactionType = 4;
		
		String message = null;
		
		String description1 = description +" TR.To A\\c No: " + transactionAccountNumber2;
		String description2 = description +" TR.From A\\c No: " + transactionAccountNumber1;

		transactionSubType = 2;
		Withdraw transferWithdrawal = new Withdraw(transactionAmount, accountBalance, customerID, transactionAccountNumber1, transactionAccountNumber2, transactionType, transactionSubType, null, description1);
		if(!transferWithdrawal.withDraw()) {
			addActionError("Transfer Failed");
			return ERROR;
		}
		
		transactionSubType = 1;
		Deposit transferDeposit = new Deposit(transactionAmount, accountBalance, customerID, transactionAccountNumber2, transactionAccountNumber1, transactionType, transactionSubType, null, description2);
		if(!transferDeposit.deposit()) {
			addActionError("Transfer Failed");
			return ERROR;
		}
		
		message = "Succefully Transfered!!!";
		addActionMessage(message);
		return SUCCESS;
	}
	
	
	public String NEFTTransfer() {
		HttpSession session = ServletActionContext.getRequest().getSession(false);
		String stringCustomerID = (String) session.getAttribute("customerid");
		
		int customerID = Integer.parseInt(stringCustomerID);
		
		int transactionAccountNumber1 = Integer.parseInt(getFromAccountnumber());		
		int transactionAccountNumber2 = Integer.parseInt(getToAccountnumber());
		
		double transactionAmount = Double.parseDouble(amount);
		double accountBalance = 0;
		int transactionSubType = 0, transactionType = 5;
		
		String message = null;
		
		description = description + " NEFT TR.To Beneficiary A\\c No: " + transactionAccountNumber2;

		transactionSubType = 2;
		Withdraw transferWithdrawal = new Withdraw(transactionAmount, accountBalance, customerID, transactionAccountNumber1, transactionAccountNumber2, transactionType, transactionSubType, null, description);
		if(!transferWithdrawal.withDraw()) {
			addActionError("Transfer Failed");
			return ERROR;
		}
		
		message = "Succefully Transfered!!!";
		addActionMessage(message);
		return SUCCESS;
	}
	
	
	public String getFromAccountnumber() {
		return FromAccountnumber;
	}
	public void setFromAccountnumber(String fromAccountnumber) {
		FromAccountnumber = fromAccountnumber;
	}
	public String getToAccountnumber() {
		return ToAccountnumber;
	}
	public void setToAccountnumber(String toAccountnumber) {
		ToAccountnumber = toAccountnumber;
	}
	public String getAmount() {
		return amount;
	}
	public void setAmount(String amount) {
		this.amount = amount;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	
	

}
