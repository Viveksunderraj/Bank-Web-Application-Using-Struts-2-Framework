package com.bankDAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import com.bank.BankApplication;
import com.bank.Branch;

public class BranchDAO {
	
	public boolean addBranch(Branch newBranch) {

		int affectedRows = 0;
		String sql = "insert into BranchMaster(BranchID, BankID, BranchName, BranchAddress) values(null, 1, ?,?)";
		
		try (Connection con = BankApplication.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);){
			pstmt.setString(1, newBranch.getBranchName());
			pstmt.setString(2, newBranch.getBranchAddress());
			affectedRows = pstmt.executeUpdate();
			if(affectedRows == 1)
				return true;
		}
		catch(SQLException ex)
		{
			System.out.println(ex.getMessage());
		}
		return false;
	}
	
	public Branch getBranchDetails(int branchID) {
		String sql = "select * from BranchMaster where BranchID=?";
		
		try (Connection con = BankApplication.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);){
			
			pstmt.setInt(1, branchID);
			
			try(ResultSet rs = pstmt.executeQuery();) {
				if(rs.next()) {
					Branch branch = new Branch();
					branch.setBranchID(rs.getInt("branchid"));
					branch.setBranchName(rs.getString("branchName"));
					branch.setBranchAddress(rs.getString("branchAddress"));
					return branch;
				}
			}
			
		}
		catch(SQLException ex)
		{
			System.out.println(ex.getMessage());
		}
		return null;
	}
	
	public static ArrayList<Branch> getAllBranches() {
		String sql = "select * from BranchMaster";
		
		try (Connection con = BankApplication.getConnection();
				Statement stmt = con.createStatement();
				ResultSet rs = stmt.executeQuery(sql);){
			
			 	ArrayList<Branch> branches = new ArrayList<>(); 
				while(rs.next()) {
					Branch branch = new Branch();
					branch.setBranchID(rs.getInt("branchid"));
					branch.setBranchName(rs.getString("branchName"));
					branch.setBranchAddress(rs.getString("branchAddress"));
					branches.add(branch);
				}
				return branches;
		}
		catch(SQLException ex)
		{
			System.out.println(ex.getMessage());
		}
		return null;
	}
	
}
