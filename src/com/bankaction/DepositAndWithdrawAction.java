package com.bankaction;

import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;


import com.bank.Deposit;
import com.bank.Loan;
import com.bank.Withdraw;
import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
public class DepositAndWithdrawAction extends ActionSupport{
	private String Accountnumber;
	private String description;
	private String amount;
	
	public String deposit() {
		System.out.println("INSIDE DEPSOTE ACTION");
		HttpSession session = ServletActionContext.getRequest().getSession(false);
		String customerID = (String) session.getAttribute("customerid");
		
		int transactionAccountNumber1 = Integer.parseInt(getAccountnumber());		
		double transactionAmount = Double.parseDouble(getAmount());
		double accountBalance = 0;
		int transactionAccountNumber2 = 0, transactionSubType = 0, transactionType = 1;
		
		String message = null;
		
		Deposit newDeposit = new Deposit(transactionAmount, accountBalance, Integer.parseInt(customerID), transactionAccountNumber1, transactionAccountNumber2, transactionType, transactionSubType, null, description);
		if(!newDeposit.deposit()) {
			addActionError("Deposit Failed");
			return ERROR;
		}
		
		message = "Succefully Deposited!!!";
		
		addActionMessage(message);
		return SUCCESS;
		
	}
	
	public String withdraw() {
		HttpSession session = ServletActionContext.getRequest().getSession(false);
		String customerID = (String) session.getAttribute("customerid");
		
		int transactionAccountNumber1 = Integer.parseInt(getAccountnumber());		
		double transactionAmount = Double.parseDouble(amount);
		double accountBalance = 0;
		int transactionAccountNumber2 = 0, transactionSubType = 0, transactionType = 2;
		String message = null;
		
		Withdraw newWithdrawal = new Withdraw(transactionAmount, accountBalance, Integer.parseInt(customerID), transactionAccountNumber1, transactionAccountNumber2, transactionType, transactionSubType, null, description);
		if(!newWithdrawal.withDraw()) {
			addActionError("Withdraw Failed");
			return ERROR;
		}
		message = "Succefully Withdrawed!!!";
		
		addActionMessage(message);
		return SUCCESS;
	}
	
	public String availLoan() {
		
		HttpSession session = ServletActionContext.getRequest().getSession(false);
		String stringCustomerID = (String) session.getAttribute("customerid");
		
		int customerID = Integer.parseInt(stringCustomerID);
		
		int transactionAccountNumber1 = Integer.parseInt(getAccountnumber());		
		int transactionAccountNumber2 = 0;
		
		double transactionAmount = Double.parseDouble(amount) * (-1);
		double accountBalance = 0;
		int transactionSubType = 0, transactionType = 6;
		
		String message = null;
		
		Loan newLoan = new Loan(transactionAmount, accountBalance, customerID, transactionAccountNumber1, transactionAccountNumber2, transactionType, transactionSubType, null, description);
		
		if(!newLoan.availLoan()) {
			addActionError("Availing Loan Failed");
			return ERROR;
		}
		
		message = "Succefully Availed Loan!!!";
		addActionMessage(message);
		return SUCCESS;
	}
	
	public String replayloan() {
		HttpSession session = ServletActionContext.getRequest().getSession(false);
		String stringCustomerID = (String) session.getAttribute("customerid");
		
		int customerID = Integer.parseInt(stringCustomerID);
		
		int transactionAccountNumber1 = Integer.parseInt(getAccountnumber());		
		int transactionAccountNumber2 = 0;
		
		double transactionAmount = Double.parseDouble(amount);
		double accountBalance = 0;
		int transactionSubType = 0, transactionType = 7;
		
		String message = null;
		Deposit repayLoanDeposit = new Deposit(transactionAmount, accountBalance, customerID,transactionAccountNumber1, transactionAccountNumber2, transactionType, transactionSubType, null, description);
		if(!repayLoanDeposit.deposit()) {
			addActionError("Repay Loan Failed");
			return ERROR;
		}
		message ="Repay Success !!!!!!";
		addActionMessage(message);
		return SUCCESS;
	}
	
	
	public String getAccountnumber() {
		return Accountnumber;
	}
	public void setAccountnumber(String accountnumber) {
		Accountnumber = accountnumber;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getAmount() {
		return amount;
	}
	public void setAmount(String amount) {
		this.amount = amount;
	}
}
