package com.bankaction;

import com.bank.Branch;
import com.bankDAO.BranchDAO;
import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
public class BranchAction extends ActionSupport{
	private String branchname;
	private String branchaddress;
	
	public String addBranch() {
		Branch newBranch = new Branch(getBranchname(), getBranchaddress());
		 
		 BranchDAO branchdao = new BranchDAO();
		 
		 if(!branchdao.addBranch(newBranch)) {
			 addActionError("Adding Branch Failed");
			 return ERROR;
		 }
		 addActionMessage("Succefully Added Branch");
		 return SUCCESS;
	}

	public String getBranchname() {
		return branchname;
	}

	public void setBranchname(String branchname) {
		this.branchname = branchname;
	}

	public String getBranchaddress() {
		return branchaddress;
	}

	public void setBranchaddress(String branchaddress) {
		this.branchaddress = branchaddress;
	}

}
