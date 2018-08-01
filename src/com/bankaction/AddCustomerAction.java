package com.bankaction;

import com.bank.Account;
import com.bank.Customer;
import com.bankDAO.AccountDAO;
import com.bankDAO.CustomerDAO;
import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
public class AddCustomerAction extends ActionSupport{
	
	private String customerfname;
	private String customerlname;
	private String customeraddress;
	private String customerphonenumber;
	private String dateofbirth;
	private String customerpassword;
	private String Branchid;
	private String Accounttype;
	private String customerid;
	
	public String addCustomer() {
		Customer newCustomer = new Customer(getCustomerfname(), getCustomerlname(), getCustomeraddress(), getCustomerphonenumber(), getDateofbirth());
		CustomerDAO customerdao = new CustomerDAO();
		
		int customerID = customerdao.addCustomer(newCustomer);
		
		if(customerID == 0) {
			 addActionError("Adding Customer Failed");
			 return ERROR;
		 }
		
		if(!customerdao.addCustomerPassword(customerID, getCustomerpassword())) {
			addActionError("Adding Customer Failed");
			 return ERROR;
		 }
		
		double accountBalance = 0;
		
		
		if(getAccounttype().equals("1")) {
			accountBalance = 1000;
		}
		
		 Account newAccount = new Account(Integer.parseInt(getBranchid()), customerID, Integer.parseInt(getAccounttype()), accountBalance);
		 AccountDAO accountdao = new AccountDAO();
		 
		 if(!accountdao.addcustomerAccount(newAccount)) {
			 addActionError("Adding Customer Account Failed");
			 return ERROR;
		 }
		 
		 addActionMessage("Succefully Added Customer");
		 return SUCCESS;
	}
	
	
	public String addCustomerPassword() {
		CustomerDAO customerdao = new CustomerDAO();
		
		String message = null;
		
		if(customerdao.validateCustomerInCustomerPassword(Integer.parseInt(getCustomerid()))){
			if(!customerdao.updateCustomerPassword(Integer.parseInt(getCustomerid()), getCustomerpassword())) {
				 addActionError("Adding Customer Password Falied");
				 return ERROR;
			}
			message = "Successfully Updated Customer Password";
		}
		
		else if(customerdao.validateCustomerID(Integer.parseInt(getCustomerid()))) {
			if(!customerdao.addCustomerPassword(Integer.parseInt(getCustomerid()), getCustomerpassword())) {
				 addActionError("Adding Customer Password Falied");
				 return ERROR;
			 }
			message = "Successfully Set Customer Password";
		}
		else {
			addActionError("Customer ID Not available");
			return ERROR;
		}
		
		addActionMessage(message);
		return SUCCESS;
		
	}
	
	public String addCustomerAccount() {
		double accountBalance = 0;
		if(getAccounttype().equals("1")) {
			accountBalance = 1000;
		}
		
		 Account newAccount = new Account(Integer.parseInt(getBranchid()), Integer.parseInt(getCustomerid()), Integer.parseInt(getAccounttype()), accountBalance);
		 AccountDAO accountdao = new AccountDAO();
		 
		 if(!accountdao.addcustomerAccount(newAccount)) {
			 addActionError("Adding Customer Account Failed");
			 return ERROR;
		 }
		 
		 addActionMessage("Succefully Added account for Customer");
		 return SUCCESS;
	}
	
	
	public String getCustomerfname() {
		return customerfname;
	}
	public void setCustomerfname(String customerfname) {
		this.customerfname = customerfname;
	}
	public String getCustomerlname() {
		return customerlname;
	}
	public void setCustomerlname(String customerlname) {
		this.customerlname = customerlname;
	}
	public String getCustomeraddress() {
		return customeraddress;
	}
	public void setCustomeraddress(String customeraddress) {
		this.customeraddress = customeraddress;
	}
	public String getCustomerphonenumber() {
		return customerphonenumber;
	}
	public void setCustomerphonenumber(String customerphonenumber) {
		this.customerphonenumber = customerphonenumber;
	}
	public String getDateofbirth() {
		return dateofbirth;
	}
	public void setDateofbirth(String dateofbirth) {
		this.dateofbirth = dateofbirth;
	}
	public String getCustomerpassword() {
		return customerpassword;
	}
	public void setCustomerpassword(String customerpassword) {
		this.customerpassword = customerpassword;
	}
	public String getBranchid() {
		return Branchid;
	}
	public void setBranchid(String branchid) {
		Branchid = branchid;
	}
	public String getAccounttype() {
		return Accounttype;
	}
	public void setAccounttype(String accounttype) {
		Accounttype = accounttype;
	}
	public String getCustomerid() {
		return customerid;
	}
	public void setCustomerid(String customerid) {
		this.customerid = customerid;
	}
	

}
