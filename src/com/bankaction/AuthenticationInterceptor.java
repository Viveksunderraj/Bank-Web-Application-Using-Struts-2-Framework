package com.bankaction;

import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;


import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.interceptor.Interceptor;

@SuppressWarnings("serial")
public class AuthenticationInterceptor extends ActionSupport implements Interceptor{

	@Override
	public void destroy() {
		//System.out.println("Calling Destroy method After action");
		
	}

	@Override
	public void init() {
		//System.out.println("INTERCEPTOR IS INTIALIZING");
		// TODO Auto-generated method stub
		
	}

	@Override
	public String intercept(ActionInvocation actionInvocation) throws Exception {
		HttpSession session = ServletActionContext.getRequest().getSession(false);
		
		boolean loggedIn = session != null && session.getAttribute("customerid") != null;
		//System.out.println("Calling Interceptor before action");
		if(!loggedIn) {
			addActionError("Please Login");
			return LOGIN;
		}
		return actionInvocation.invoke();
	}

}
