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
			
			rs = pstmt.executeQuery();
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


	// 현재 로그인 중인 회원의 아이디에 해당하는 장바구니 목록을 가져오는 메서드
	public List<CartDTO> getCartList(String user_id) {
		List<CartDTO> list = new ArrayList<CartDTO>();
		
		try {
			openConn();
			
			sql = "select * from sc_cart where user_id = ? order by cart_no desc";
			pstmt= con.prepareStatement(sql);
			
			pstmt.setString(1,user_id);
			
			rs = pstmt.executeQuery();
			while (rs.next()) {
				CartDTO dto = new CartDTO();
				
				dto.setCart_no(rs.getInt("cart_no"));
				dto.setProduct_no(rs.getInt("product_no"));
				dto.setCategory_no(rs.getInt("category_no"));
				dto.setUser_id(rs.getString("user_id"));
				dto.setCart_deliveryfee(rs.getInt("cart_deliveryfee"));
				dto.setProduct_size(rs.getString("product_size"));
				dto.setProduct_qty(rs.getInt("product_qty"));
				dto.setProduct_price(rs.getInt("product_price"));
				dto.setProduct_image(rs.getString("product_image"));
				dto.setProduct_name(rs.getString("product_name"));
				
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
	
	
	// 장바구니에서 X버튼을 누를 시 실행되는 메서드
	public int deleteCartData(int cart_no) {
		int result = 0;
		
		try {
			openConn();
			
			sql = "delete from sc_cart where cart_no = ?";
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, cart_no);
			
			result = pstmt.executeUpdate();
			if (result > 0) {
				sql = "update sc_cart set cart_no = cart_no -1 where cart_no > ?";
				pstmt = con.prepareStatement(sql);
				
				pstmt.setInt(1, cart_no);
				pstmt.executeUpdate();
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}  finally {
			closeConn(rs, pstmt, con);
		}
		return result;
	} // deleteCartData() 메서드 end
	
	
	// 장바구니 페이지에 올라온 해당 유저의 상품의 합계를 구하는 메서드
	public int getCartTotalPrice(String user_id) {
		int proPrice = 0, proQty = 0, totalPrice = 0;
		
		try {
			openConn();
			
			sql = "select sum(product_price) from sc_cart where user_id = ?";
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, user_id);
			
			rs = pstmt.executeQuery();
			if (rs.next()) {
				proPrice = rs.getInt(1);
			}
			
			sql = "select sum(product_qty) from sc_cart where user_id = ?";
			pstmt = con.prepareCall(sql);
			
			pstmt.setString(1, user_id);
			
			rs = pstmt.executeQuery();
			if (rs.next()) {
				proQty = rs.getInt(1);
			}
			totalPrice = (proPrice * proQty);
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
		return totalPrice;
	} // getCartTotalPrice() 메서드 end
	
	
	// 주문서 페이지에서 결제가 완료 된 후 해당 유저의 장바구니 목록을 지우는 메서드
	public void deleteCartList(String user_id) {
		try {
			openConn();
			
			sql = "delete from sc_cart where user_id = ?";
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, user_id);
			
			pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
	} // deleteCartList() 메서드 end
	
}
		
