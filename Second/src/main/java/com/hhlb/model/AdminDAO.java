package com.hhlb.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class AdminDAO {
    
    // DB와 연결하는 객체
    Connection con = null;
    
    // DB에 SQL문을 전송하는 객체.
    PreparedStatement pstmt = null;
    
    // SQL문을 실행한 후에 결과값을 가지고 있는 객체.
    ResultSet rs = null;
    
    // SQL문을 저장할 변수.
    String sql = null;

    // AdminDAO 클래스를 싱글턴 방식으로 만들어 보자.
    private static AdminDAO instance = null;

    private AdminDAO() {  }   // 기본 생성자
    
    public static AdminDAO getInstance() {
        if (instance == null) {    // 인스턴스가 없다면 새로 생성
            instance = new AdminDAO();
        }
        return instance;    // 이미 존재하는 인스턴스를 반환
    }
        
    // DB 연동 작업을 하는 메서드.
    public void openConn() {
        try {
            Context init = new InitialContext();
            Context ctx = (Context) init.lookup("java:comp/env");
            DataSource ds = (DataSource) ctx.lookup("jdbc/myoracle");
            con = ds.getConnection();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    // DB에 연결되어 있던 자원 종료하기.
    public void closeConn(ResultSet rs, PreparedStatement pstmt, Connection con) {
        try {
            if (rs != null) { rs.close(); }
            if (pstmt != null) { pstmt.close(); }
            if (con != null) { con.close(); }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    // DB에 연결되어 있던 자원 종료하기.
    public void closeConn(PreparedStatement pstmt, Connection con) {
        try {
            if (pstmt != null) { pstmt.close(); }
            if (con != null) { con.close(); }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    
 // 관리자 리스트
 	public List<AdminDTO> getAdminList() {
 		
 		List<AdminDTO> adminList = new ArrayList<AdminDTO>();
 		

 		try {
 			openConn();
 			
 			sql = "select admin_id, admin_nick from sc_admin";
 			
 			pstmt = con.prepareStatement(sql);
 			
 			rs = pstmt.executeQuery();
 			
 			while(rs.next()) {
 				
 				AdminDTO admin = new AdminDTO();
 				
 				admin.setAdmin_id(rs.getString("admin_id"));
 				admin.setAdmin_nick(rs.getString("admin_nick"));
 				
 				adminList.add(admin);
 			}
 			
 		} catch (SQLException e) {
 			// TODO Auto-generated catch block
 			e.printStackTrace();
 		}finally {
 			closeConn(rs, pstmt, con);
 		}
 		
 		return adminList;
 	}

    // 닉네임 수정
	public boolean updateAdminNickname(String adminId, String newNickname) {
		
		boolean result = false;
	   
		try {
	       
	        openConn();

	        sql = "UPDATE SC_ADMIN SET ADMIN_NICK = ? WHERE ADMIN_ID = ?";
	        
	        pstmt = con.prepareStatement(sql);
	        pstmt.setString(1, newNickname);
	        pstmt.setString(2, adminId);
	        
	        System.out.println("newNickname >>> " + newNickname);

	        int rows = pstmt.executeUpdate();

	        if (rows > 0) {
	            result = true;
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    } finally {
	        closeConn(pstmt, con);
	    }
	    return result;
	}

	

	

    
    
    
    
}
