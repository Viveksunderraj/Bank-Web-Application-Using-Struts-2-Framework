package com.bankaction;

import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.bank.Beneficiary;
import com.bankDAO.BeneficiaryDAO;
import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
public class BeneficiaryAction extends ActionSupport{
	private String beneficiaryType;
	private String IFSCcode;
	private String beneficiaryAccountNumber;
	
	public String addBeneficiary() {
		HttpSession session = ServletActionContext.getRequest().getSession(false);
		String stringCustomerID = (String) session.getAttribute("customerid");
		
		int customerID = Integer.parseInt(stringCustomerID);
		
		String message = null;
		 
		 Beneficiary newBeneficiary = new Beneficiary(customerID, Integer.parseInt(beneficiaryType), Integer.parseInt(beneficiaryAccountNumber), IFSCcode);
			BeneficiaryDAO beneficiarydao = new BeneficiaryDAO();
			if(!beneficiarydao.addBeneficiary(newBeneficiary)) {
				System.out.println("Could not add Beneficiary");
				return ERROR;
			}
		message = "Succefully Added Beneficiary!!!";
		addActionMessage(message);
		return SUCCESS;
	}
	
	public String getBeneficiaryType() {
		return beneficiaryType;
	}
	public void setBeneficiaryType(String beneficiaryType) {
		this.beneficiaryType = beneficiaryType;
	}
	public String getIFSCcode() {
		return IFSCcode;
	}
	public void setIFSCcode(String iFSCcode) {
		IFSCcode = iFSCcode;
	}
	public String getBeneficiaryAccountNumber() {
		return beneficiaryAccountNumber;
	}
	public void setBeneficiaryAccountNumber(String beneficiaryAccountNumber) {
		this.beneficiaryAccountNumber = beneficiaryAccountNumber;
	}

}
