package com.hhlb.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class OrderDAO {

	Connection con = null;
	
	PreparedStatement pstmt = null;

	ResultSet rs= null;
	
	String sql = null;

	private static OrderDAO instance;
	
	private OrderDAO() {  }  // 기본 생성자

	public static OrderDAO getInstance() {
		
		if(instance == null) {
			instance = new OrderDAO();
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
	
	
	// order.jsp 에서 넘어와서 sc_order 테이블에 저장하는 메서드
	public void InsertOrderData(String user_id, int totalPrice, String memo, List<CartDTO> cartList) {
			int count = 0;
		
			try {
				openConn();
				
				for (int i = 0; i < cartList.size(); i ++) {
					
					// max 값 구하는 코드
					sql = "select max(order_no) from sc_order";
					pstmt = con.prepareStatement(sql);
					
					rs = pstmt.executeQuery();
					if (rs.next()) {
						count = rs.getInt(1) + 1;
					}
					// 반복해서 데이터를 sc_order 테이블에 입력하는 코드
					sql = "insert into sc_order values(?, ?, ?, sysdate, ?, ?, ?, ?)";
					pstmt = con.prepareStatement(sql);
					
					pstmt.setInt(1, count);
					pstmt.setInt(2, cartList.get(i).getProduct_no());	
					pstmt.setInt(3, cartList.get(i).getCategory_no());	
					pstmt.setInt(4, cartList.get(i).getProduct_price());	
					pstmt.setInt(5, 1);	
					pstmt.setString(6, memo);	
					pstmt.setString(7, user_id);	
					
					pstmt.executeUpdate();
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} closeConn(rs, pstmt, con);
	} // InsertOrderData() 메서드 end
}
