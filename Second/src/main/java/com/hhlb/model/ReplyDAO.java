package com.hhlb.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class ReplyDAO {

Connection con = null;
	
	PreparedStatement pstmt = null;

	ResultSet rs= null;
	
	String sql = null;

	private static ReplyDAO instance;
	
	private ReplyDAO() {  }  // 기본 생성자

	public static ReplyDAO getInstance() {
		
		if(instance == null) {
			instance = new ReplyDAO();
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
	
	public String getUserReply(int no) {
		
		String str = "";
		
		try {	
			openConn();
			
			sql = "select * from sc_reply where board_no = ? order by reply_date desc";
		
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, no);
			
			rs = pstmt.executeQuery();
			str += "<replys>";
			
			while(rs.next()) {
				str += "<reply>";
				
				str += "<reply_no>" + rs.getInt("reply_no") + "</reply_no>";
				str += "<board_no>" + rs.getInt("board_no") + "</board_no>";
				str += "<user_id>" + rs.getString("user_id") + "</user_id>";
				str += "<reply_cont>" +rs.getString("reply_cont") + "</reply_cont>";
				str += "<reply_date>" +rs.getString("reply_date") + "</reply_date>";
				str += "<reply_update>" +rs.getString("reply_update") + "</reply_update>";
				
				str += "</reply>";
			}
			str += "</replys>";
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
		return str;
	}
	
	public int userInsertReply(ReplyDTO dto) {
		
		int result = 0, count = 0;
		
		try {

			openConn();
			
			sql = "select max(reply_no) from sc_reply";
			
			pstmt = con.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				count = rs.getInt(1) + 1;
			}
			
			sql = "insert into sc_reply values(?,?,?,?,sysdate,'')";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, count);
			pstmt.setInt(2,dto.getBoard_no());
			pstmt.setString(3, dto.getUser_id());
			pstmt.setString(4, dto.getReply_cont());
			
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
		return result;
	}
}
