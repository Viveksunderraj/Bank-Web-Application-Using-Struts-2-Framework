package com.bankDAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import com.bank.Account;
import com.bank.AccountLookup;
import com.bank.BankApplication;
import com.bank.MenuMethods;
import com.bank.TopCustomers;

public class AccountDAO {
	
	
	public boolean addcustomerAccount(Account newAccount) {
		int affectedRows = 0;
		String sql = "insert into Accounts(AccountNumber ,BranchID, CustomerID, AccountType, AccountBalance) values(null,?,?,?,?)";

		try (Connection con = BankApplication.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);){
			pstmt.setInt(1, newAccount.getBranchID());
			pstmt.setInt(2, newAccount.getCustomerID());
			pstmt.setInt(3, newAccount.getAccountType());
			pstmt.setDouble(4, newAccount.getAccountBalance());
			
			affectedRows = pstmt.executeUpdate();
			
			if(affectedRows == 1) {
				return true;
			}
			
		}
		catch(SQLException ex)
		{
			System.out.println(ex.getMessage());
		}
		return false;
	}
	
	
	
	
	public boolean validateAccountNumber(int accountNumber) {
		String sql = "select * from accounts where AccountNumber=?";
		
		try(Connection con = BankApplication.getConnection();
			PreparedStatement pstmt =  con.prepareStatement(sql);) {
			
			pstmt.setInt(1, accountNumber);
			
			try(ResultSet rs = pstmt.executeQuery();) {
				if(rs.next()) {
					return true;
				}
			}
		}
		catch(SQLException ex)
		{
			System.out.println(ex.getMessage());
		}
		return false;
	}
	
	public  static ArrayList<Account> getAccountsForCustomer(int customerID, int branchID, MenuMethods.GetAccountType accountType) {
		
		String sql = null;
		
		if(accountType == MenuMethods.GetAccountType.SAVINGS_AND_CURRENT) {
			sql = "SELECT acc.AccountNumber, act.AccountName, act.MinimumBalance, acc.AccountBalance, acc.AccountType, acc.BranchID, acc.CustomerID, branch.BranchName from accounts as acc INNER JOIN accountType as act ON acc.accountType=act.accountType INNER JOIN branchMaster as branch ON acc.BranchID=branch.branchID where (CustomerID=?) and (acc.BranchID=?) and (acc.AccountType=1 or acc.AccountType=2)";
		}
		else if(accountType == MenuMethods.GetAccountType.LOAN_ACCOUNT) {
			sql = "SELECT acc.AccountNumber, act.AccountName, act.MinimumBalance, acc.AccountBalance, acc.AccountType, acc.BranchID, acc.CustomerID, branch.BranchName from accounts as acc INNER JOIN accountType as act ON acc.accountType=act.accountType INNER JOIN branchMaster as branch ON acc.BranchID=branch.branchID where (CustomerID=?) and (acc.BranchID=?) and (acc.AccountType=3)";
		}
		else if(accountType == MenuMethods.GetAccountType.ALL_ACCOUNTS) {
			sql = "SELECT acc.AccountNumber, act.AccountName, act.MinimumBalance, acc.AccountBalance, acc.AccountType, acc.BranchID, acc.CustomerID, branch.BranchName from accounts as acc INNER JOIN accountType as act ON acc.accountType=act.accountType INNER JOIN branchMaster as branch ON acc.BranchID=branch.branchID where (CustomerID=?) and (acc.BranchID=?)";
		}
		
		ArrayList<Account> accountList = new ArrayList<Account>();
		
		try(Connection con = BankApplication.getConnection();
				PreparedStatement pstmt =  con.prepareStatement(sql);) {
			
			pstmt.setInt(1, customerID);
			pstmt.setInt(2, branchID);
			
			try(ResultSet rs = pstmt.executeQuery()){
			while(rs.next()) {
				
				Account account = extractAccountFromReselutSet(rs);
				accountList.add(account);
			}
			return accountList;
			}
		}
		catch(SQLException ex)
		{
			System.out.println(ex.getMessage());
		}
		return null;
	}
	
	public  static ArrayList<Account> getAccountsForCustomer(int customerID, MenuMethods.GetAccountType accountType) {
		
		String sql = null;
		
		if(accountType == MenuMethods.GetAccountType.SAVINGS_AND_CURRENT) {
			sql = "SELECT acc.AccountNumber, act.AccountName, act.MinimumBalance, acc.AccountBalance, acc.AccountType, acc.BranchID, acc.CustomerID, branch.BranchName from accounts as acc INNER JOIN accountType as act ON acc.accountType=act.accountType INNER JOIN branchMaster as branch ON acc.BranchID=branch.branchID where (CustomerID=?) and (acc.AccountType=1 or acc.AccountType=2)";
		}
		else if(accountType == MenuMethods.GetAccountType.LOAN_ACCOUNT) {
			sql = "SELECT acc.AccountNumber, act.AccountName, act.MinimumBalance, acc.AccountBalance, acc.AccountType, acc.BranchID, acc.CustomerID, branch.BranchName from accounts as acc INNER JOIN accountType as act ON acc.accountType=act.accountType INNER JOIN branchMaster as branch ON acc.BranchID=branch.branchID where (CustomerID=?) and (acc.AccountType=3)";
		}
		else if(accountType == MenuMethods.GetAccountType.ALL_ACCOUNTS) {
			sql = "SELECT acc.AccountNumber, act.AccountName, act.MinimumBalance, acc.AccountBalance, acc.AccountType, acc.BranchID, acc.CustomerID, branch.BranchName from accounts as acc INNER JOIN accountType as act ON acc.accountType=act.accountType INNER JOIN branchMaster as branch ON acc.BranchID=branch.branchID where (CustomerID=?)";
		}
		
		ArrayList<Account> accountList = new ArrayList<Account>();
		
		try(Connection con = BankApplication.getConnection();
				PreparedStatement pstmt =  con.prepareStatement(sql);) {
			
			pstmt.setInt(1, customerID);
			
			try(ResultSet rs = pstmt.executeQuery()){
			while(rs.next()) {
				
				Account account = extractAccountFromReselutSet(rs);
				accountList.add(account);
			}
			return accountList;
			}
		}
		catch(SQLException ex)
		{
			System.out.println(ex.getMessage());
		}
		return null;
	}
	
	public static Account extractAccountFromReselutSet(ResultSet rs) throws SQLException {
		Account account = new Account();
		account.setAccountNumber(rs.getInt("AccountNumber"));
		account.setAccountBalance(rs.getDouble("AccountBalance"));
		account.setAccountName(rs.getString("AccountName"));
		account.setAccountType(rs.getInt("AccountType"));
		account.setBranchName(rs.getString("BranchName"));
		account.setBranchID(rs.getInt("BranchID"));
		account.setCustomerID(rs.getInt("CustomerID"));
		account.setMinimumBalance(rs.getDouble("MinimumBalance"));
		return account;
		
	}
	
	
	public static ArrayList<Account> getAccountsForCustomer(int customerID, int branchID){
		String sql = "SELECT acc.AccountNumber, act.AccountName, act.MinimumBalance, acc.AccountBalance, acc.AccountType, acc.BranchID, acc.CustomerID, branch.BranchName from accounts as acc INNER JOIN accountType as act ON acc.accountType=act.accountType INNER JOIN branchMaster as branch ON acc.BranchID=branch.branchID where (CustomerID=?) and (acc.BranchID=?)";
		ArrayList<Account> accountList = new ArrayList<Account>();
		
		try(Connection con = BankApplication.getConnection();
				PreparedStatement pstmt =  con.prepareStatement(sql);) {
			
			pstmt.setInt(1, customerID);
			pstmt.setInt(2, branchID);
			
			try(ResultSet rs = pstmt.executeQuery()){
			while(rs.next()) {
				Account account = extractAccountFromReselutSet(rs);
				accountList.add(account);
			}
			return accountList;
			}
		}
		catch(SQLException ex)
		{
			System.out.println(ex.getMessage());
		}
		return null;
		
		
	}
	
	
	public static ArrayList<Account> getDistinctBranchesForCustomer(int customerID) {
		String sql = "SELECT DISTINCT acc.BranchID, branch.BranchName from accounts as acc INNER JOIN accountType as act ON acc.accountType=act.accountType INNER JOIN branchMaster as branch ON acc.BranchID=branch.branchID where (CustomerID=?)";
		ArrayList<Account> accountList = new ArrayList<Account>();
		
		try(Connection con = BankApplication.getConnection();
				PreparedStatement pstmt =  con.prepareStatement(sql);) {
			
			pstmt.setInt(1, customerID);
			
			try(ResultSet rs = pstmt.executeQuery()){
			while(rs.next()) {
				Account account = new Account();
				account.setBranchID(rs.getInt("BranchID"));
				account.setBranchName(rs.getString("BranchName"));
				accountList.add(account);
			}
			return accountList;
			}
		}
		catch(SQLException ex)
		{
			System.out.println(ex.getMessage());
		}
		return null;
		
		
		
	}
	
	public static ArrayList<Account> getAccountsForCustomer(int customerID) {
		
		String sql = "SELECT acc.AccountNumber, act.AccountName, acc.AccountBalance, acc.AccountType, acc.BranchID, acc.CustomerID, branch.BranchName from accounts as acc INNER JOIN accountType as act ON acc.accountType=act.accountType INNER JOIN branchMaster as branch ON acc.BranchID=branch.branchID where (CustomerID=?)";
				
		ArrayList<Account> accountList = new ArrayList<Account>();
		
		try(Connection con = BankApplication.getConnection();
				PreparedStatement pstmt =  con.prepareStatement(sql);) {
			
			pstmt.setInt(1, customerID);
			
			try(ResultSet rs = pstmt.executeQuery()){
			while(rs.next()) {
				Account account = extractAccountFromReselutSet(rs);
				accountList.add(account);
			}
			return accountList;
			}
		}
		catch(SQLException ex)
		{
			System.out.println(ex.getMessage());
		}
		return null;
	}
	
	
	public static double getAccountBalance(int accountNumber) {
		String sql = "select accountBalance from Accounts where AccountNumber=?";
		double balance = 0;
		try(Connection con = BankApplication.getConnection();
			PreparedStatement pstmt =  con.prepareStatement(sql);) {
			
			pstmt.setInt(1, accountNumber);
			try(ResultSet rs = pstmt.executeQuery();) {
				rs.next();
				balance = rs.getInt("AccountBalance");
				return balance;
			}	
		}
		catch(SQLException ex)
		{
			System.out.println(ex.getMessage());
		}
		return balance;
	}
	
	public static boolean updateAccountBalance(double accountBalance, int accountNumber) {
		String sql = "update Accounts SET AccountBalance=? where AccountNumber=?";
		int affectedRows = 0;
		try(Connection con = BankApplication.getConnection();
				PreparedStatement pstmt =  con.prepareStatement(sql);) {
			
			pstmt.setDouble(1, accountBalance);
			pstmt.setInt(2, accountNumber);
			affectedRows = pstmt.executeUpdate();
			if(affectedRows == 1) {
				return true;
			}
		}
		catch(SQLException ex)
		{
			System.out.println(ex.getMessage());
		}
		return false;
	}
	
	public static ArrayList<AccountLookup> getAccountLookup() {
		String sql = "select * from accounttype";
		
		try(Connection con = BankApplication.getConnection();
				Statement stmt = con.createStatement();
				ResultSet rs = stmt.executeQuery(sql);) {
			   
				ArrayList<AccountLookup> accountLookupList = new ArrayList<>();
				while(rs.next()) {
					AccountLookup accountlookup = new AccountLookup();
					
					accountlookup.setAccountType(rs.getInt("AccountType"));
					accountlookup.setAccountName(rs.getString("AccountName"));
					
					accountLookupList.add(accountlookup);
				}
				return accountLookupList;
				
			}
		catch(SQLException ex)
		{
			System.out.println(ex.getMessage());
		}
		return null;
	}
	
	public static int getAccountType(int accountNumber) {
		int accountType = 0;
		String sql = "select accountType from Accounts where AccountNumber=?";
		
		try(Connection con = BankApplication.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);) {
			pstmt.setInt(1, accountNumber);
			
			try(ResultSet rs = pstmt.executeQuery();) {
				rs.next();
				accountType = rs.getInt("AccountType");
				return accountType;
			}
			
		}
		catch(SQLException ex)
		{
			System.out.println(ex.getMessage());
		}
		return accountType;
		
	}
	
	public static ArrayList<TopCustomers> getTopCustomers() {
		
		String sql = "select sum(accountBalance) as sum, accounts.customerid, concat(cust.customerFName,' ',cust.customerLName) as CustomerName from accounts INNER JOIN customerMaster as cust ON accounts.customerid=cust.customerid where accounttype not in (3) group by accounts.customerid order by sum desc";
		
		try(Connection con = BankApplication.getConnection();
				Statement stmt = con.createStatement();
				ResultSet rs = stmt.executeQuery(sql);) {		
			
			ArrayList<TopCustomers> topCustomers = new ArrayList<>();
			while(rs.next()) {
				TopCustomers cust = new TopCustomers();
				//System.out.println(rs.getString("customerName"));
				cust.setAccountBalance(rs.getDouble("sum"));
				cust.setCustomerName(rs.getString("customerName"));
				cust.setCustomerID(rs.getInt("customerid"));
				
				topCustomers.add(cust);
			}
			return topCustomers;
		} 
		catch(Exception e) {
			e.printStackTrace();
			System.err.println(e.getClass().getName()+": "+e.getMessage());
		}
		return null;
	}
	
}
