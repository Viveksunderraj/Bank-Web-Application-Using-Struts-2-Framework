package com.bankaction;

import java.nio.channels.SeekableByteChannel;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.dispatcher.SessionMap;
import org.apache.struts2.interceptor.SessionAware;

import com.bank.Customer;
import com.bankDAO.CustomerDAO;
import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
public class AuthenticationAction extends ActionSupport implements SessionAware{
	
	private String userid;
	private String password;
	private SessionMap<String, Object> sessionMap;
	
	public String adminLogin() {
		if(getUserid().equals("admin") || getUserid().equals("Admin") && getPassword().equals("admin")) {
			sessionMap.put("customerid", getUserid());
			return SUCCESS;
		}
		addActionError("Invalid Username/Password");
		return LOGIN;
	}
	
	public String adminLogout() {
		if(sessionMap!=null){  
			System.out.println("IN NOT NULL");
	        sessionMap.invalidate();  
	    }  
	    return SUCCESS;  
		
	}
	
	public String customerLogin() {
		CustomerDAO customerdao = new CustomerDAO();
		
		if(!customerdao.validateCustomerPassword(Integer.parseInt(getUserid()), getPassword())) {
			addActionError("Invalid Username/Password");
			return LOGIN;
		}
		
		Customer loginCustomer = customerdao.getCustomerDetails(Integer.parseInt(getUserid()));
		sessionMap.put("customerid", getUserid());
		sessionMap.put("customerfname", loginCustomer.getCustomerFirstName());
		sessionMap.put("customerlname", loginCustomer.getCustomerLastName());
		return SUCCESS;
	}
	
	public String customerLogout() {
		HttpSession session = ServletActionContext.getRequest().getSession(false);
		if(session != null) {
			System.out.println("IN SESSION INVALIDATION");
			session.invalidate();
		}
		return SUCCESS;
	}
	
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}

	@Override
	public void setSession(Map<String, Object> map) {  
	    sessionMap = (SessionMap<String, Object>)map;  
	}  
	
	

}
