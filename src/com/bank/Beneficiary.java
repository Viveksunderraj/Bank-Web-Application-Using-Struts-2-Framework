package com.bank;

public class Beneficiary {
	
	private int customerID;
	private int beneficiaryType;
	private String beneficiaryTypeName;
	private int beneficiaryAccountNumber;
	private String IFSCcode;
	
	
	public Beneficiary() {
		super();
	}

	public Beneficiary(int customerID, int beneficiaryType, int beneficiaryAccountNumber, String iFSCcode) {
		this.customerID = customerID;
		this.beneficiaryType = beneficiaryType;
		this.beneficiaryAccountNumber = beneficiaryAccountNumber;
		this.IFSCcode = iFSCcode;
	}

	public int getCustomerID() {
		return customerID;
	}

	public void setCustomerID(int customerID) {
		this.customerID = customerID;
	}

	public int getBeneficiaryType() {
		return beneficiaryType;
	}
	
	public String getBeneficiaryTypeName() {
		return beneficiaryTypeName;
	}

	public void setBeneficiaryTypeName(String beneficiaryTypeName) {
		this.beneficiaryTypeName = beneficiaryTypeName;
	}

	public void setBeneficiaryType(int beneficiaryType) {
		this.beneficiaryType = beneficiaryType;
	}

	public int getBeneficiaryAccountNumber() {
		return beneficiaryAccountNumber;
	}

	public void setBeneficiaryAccountNumber(int beneficiaryAccountNumber) {
		this.beneficiaryAccountNumber = beneficiaryAccountNumber;
	}

	public String getIFSCcode() {
		return IFSCcode;
	}

	public void setIFSCcode(String iFSCcode) {
		IFSCcode = iFSCcode;
	}	

}
