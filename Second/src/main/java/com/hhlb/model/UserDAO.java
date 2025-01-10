package com.hhlb.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class UserDAO {
Connection con = null;
	
	PreparedStatement pstmt = null;

	ResultSet rs= null;
	
	String sql = null;

	private static UserDAO instance;
	
	private UserDAO() {  }  // 기본 생성자

	public static UserDAO getInstance() {
		
		if(instance == null) {
			instance = new UserDAO();
		}
		
		return instance;
	}  // getInstance() 메서드 end
	
	
	

	public void openConn() {
		
		try {
			
			Context initCtx = new InitialContext();
			
		
			Context ctx = 
				(Context)initCtx.lookup("java:comp/env");
			
			
			DataSource ds = 
					(DataSource)ctx.lookup("jdbc/myoracle");
			
		
			con = ds.getConnection();
			
		} catch (Exception e) {
		
			e.printStackTrace();
		}
		
	}  
		
	
	// DB에 연결되어 있던 자원 종료하는 메서드.
	public void closeConn(ResultSet rs,
			PreparedStatement pstmt, Connection con) {
		
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(con != null) con.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		
	}  // closeConn() 메서드 end
	
	
	// DB에 연결되어 있던 자원 종료하는 메서드.
	public void closeConn(
			PreparedStatement pstmt, Connection con) {
		
			try {
				if(pstmt != null) pstmt.close();
				if(con != null) con.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		
	}  // closeConn() 메서드 end
	

	// 입력받은 아이의 중복 여부를 체크하는 메서드.
	public int idCheck(String id) {
		
		int check = 0;
		
		
		try {
			openConn();
			
			sql = "select * from sc_user where user_id = ?";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				// 중복인 경우
				check = -1;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			
			closeConn(rs, pstmt, con);
		}
		return check;
	}

	public int insertUser(UserDTO dto) {

		int result = 0;
		
		try {
			
			
			openConn();
			
			sql="insert into sc_user values(?,?,?,?,?,?,?,?,?,sysdate)";
			
			pstmt= con.prepareStatement(sql);
			
			pstmt.setString(1, dto.getUser_id());
			pstmt.setString(2, dto.getUser_pwd());
			pstmt.setString(3, dto.getUser_name());
			pstmt.setString(4, dto.getUser_nick());
			pstmt.setString(5, dto.getUser_email());
			pstmt.setInt(6, dto.getUser_age());
			pstmt.setString(7, dto.getUser_gender());
			pstmt.setString(8, dto.getUser_phone());
			pstmt.setString(9, dto.getUser_addr());
			
			result = pstmt.executeUpdate();
	
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
		return result;
	}
	public int userCheck(String id, String pwd) {
		int result = 0;

		try {

			openConn();
			
			sql = "select * from sc_user where user_id = ?";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				if(pwd.equals(rs.getString("user_pwd"))) {
					result = 1;
				}else {
					result = -1;
				}
				
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
		return result;
	}
	
	public UserDTO getUser(String id) {
		UserDTO dto = null;
		
		try {
			openConn();
			
			sql = "select * from sc_user where user_id = ?";
		
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				dto = new UserDTO();
				
				dto.setUser_id(rs.getString("user_id"));
				dto.setUser_pwd(rs.getString("user_pwd"));
				dto.setUser_name(rs.getString("user_name"));
				dto.setUser_nick(rs.getString("user_nick"));
				dto.setUser_email(rs.getString("user_email"));
				dto.setUser_age(rs.getInt("user_age"));
				dto.setUser_gender(rs.getString("user_gender"));
				dto.setUser_phone(rs.getString("user_phone"));
				dto.setUser_addr(rs.getString("user_addr"));
				dto.setUser_date(rs.getString("user_date"));
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
		
		return dto;
	}

}