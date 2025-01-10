package com.hhlb.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class CartDAO {
	Connection con = null;
	
	PreparedStatement pstmt = null;

	ResultSet rs= null;
	
	String sql = null;

	private static CartDAO instance;
	
	private CartDAO() {  }  // 기본 생성자

	public static CartDAO getInstance() {
		
		if(instance == null) {
			instance = new CartDAO();
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
	
	
	// product/detail.jsp에서 Add to Cart 버튼을 클릭시 넘어온 데이터들을 sc_cart 테이블에 저장시기는 메서드
	public int insertCartData(CartDTO dto, String user_id) {
		int result = 0, count = 0;
		
		try {
			openConn();
			
			sql = "select max(cart_no) from sc_cart";
			pstmt = con.prepareStatement(sql);
			
			if (rs.next()) {
				count = rs.getInt(1) + 1;
			}
			
			sql = "insert into sc_cart values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, count);
			pstmt.setInt(2, dto.getProduct_no());
			pstmt.setInt(3, dto.getCategory_no());
			pstmt.setString(4, user_id);
			pstmt.setInt(5, 0);
			pstmt.setString(6, dto.getProduct_size());
			pstmt.setInt(7, dto.getProduct_qty());
			pstmt.setInt(8, dto.getProduct_price());
			pstmt.setString(9, dto.getProduct_image());
			pstmt.setString(10, dto.getProduct_name());
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
		return result;
	} // insertCartData() 메서드 end
}
