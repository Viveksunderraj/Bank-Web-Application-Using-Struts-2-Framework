package com.bankaction;

import com.opensymphony.xwork2.Action;

public class testaction implements Action{

	@Override
	public String execute() throws Exception {
		System.out.println("INSIDE FUNCTION EXECUTE");
		return ERROR;
	}
	
	public String test() {
		System.out.println("INSIDE FUNCTION TEST");
		return SUCCESS;
	}

}
