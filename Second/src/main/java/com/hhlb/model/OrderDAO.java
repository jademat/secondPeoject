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
	public int InsertOrderData(String user_id, int totalPrice, String memo, List<CartDTO> cartList, String addr) {
			int result = 0, count = 0;
		
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
					sql = "insert into sc_order values(?, ?, ?, sysdate, ?, ?, ?, ?,?)";
					pstmt = con.prepareStatement(sql);
					
					pstmt.setInt(1, count);
					pstmt.setInt(2, cartList.get(i).getProduct_no());	
					pstmt.setInt(3, cartList.get(i).getCategory_no());	
					pstmt.setInt(4, cartList.get(i).getProduct_price());	
					pstmt.setInt(5, 1);	
					pstmt.setString(6, memo);	
					pstmt.setString(7, user_id);
					pstmt.setString(8, addr);	
					
					result = pstmt.executeUpdate();
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}  finally {
				closeConn(rs, pstmt, con);
			}
			return result;
	} // InsertOrderData() 메서드 end
	
	public List<OrderDetailsDTO> getOrder(String id){
		
		List<OrderDetailsDTO> list = new ArrayList<OrderDetailsDTO>();

		try {
			openConn();
			
			sql = "select o.user_id, o.order_date,o.order_total, p.product_name,u.user_phone, o.order_addr,o.order_memo,o.order_no "
					+ "from sc_order o "
					+ "join sc_product p on o.product_no = p.product_no "
					+ "join sc_user u on u.user_id = o.user_id "
					+ "where o.user_id = ? "
					+ " order by order_no desc";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				
				OrderDetailsDTO dto = new OrderDetailsDTO();
				
				dto.setUser_id(rs.getString("user_id"));
				dto.setOrder_date(rs.getString("order_date"));
				dto.setOrder_total(rs.getInt("order_total"));
				dto.setProduct_name(rs.getString("product_name"));
				dto.setUser_phone(rs.getString("user_phone"));
				dto.setOrder_addr(rs.getString("order_addr"));
				dto.setOrder_memo(rs.getString("order_memo"));
				dto.setOrder_no(rs.getInt("order_no"));
				
				list.add(dto);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
		return list;
	}
	
}
