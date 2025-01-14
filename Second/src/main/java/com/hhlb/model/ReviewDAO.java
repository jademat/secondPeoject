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

public class ReviewDAO {
Connection con = null;
	
	PreparedStatement pstmt = null;

	ResultSet rs= null;
	
	String sql = null;

	private static ReviewDAO instance;
	
	private ReviewDAO() {  }  // 기본 생성자

	public static ReviewDAO getInstance() {
		
		if(instance == null) {
			instance = new ReviewDAO();
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
	

	public List<ReviewDTO> getReview(String id){
		List<ReviewDTO> rList = new ArrayList<ReviewDTO>();
		
		try {
			openConn();
			
			sql = "select * from sc_review where user_id = ?";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1,id);
		
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				ReviewDTO dto = new ReviewDTO();
				
				dto.setReview_no(rs.getInt("review_no"));
				dto.setUser_id(rs.getString("user_id"));
				dto.setProduct_no(rs.getInt("product_no"));
				dto.setCategory_no(rs.getInt("category_no"));
				dto.setReview_cont(rs.getString("review_cont"));
				dto.setReview_rank(rs.getInt("review_rank"));
				dto.setReview_image(rs.getString("review_image"));
				dto.setReview_date(rs.getString("review_date"));
				dto.setReview_update(rs.getString("review_update"));
				dto.setReview_hit(rs.getInt("review_hit"));
				
				rList.add(dto);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
		
		
		return rList;
	}
	
	public List<ReviewDTO> getReviewList(){
		List<ReviewDTO> rList = new ArrayList<ReviewDTO>();
		
		try {
			openConn();
			
			sql = "select * from sc_review order by review_no desc";
			
			pstmt = con.prepareStatement(sql);
		
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				ReviewDTO dto = new ReviewDTO();
				
				dto.setReview_no(rs.getInt("review_no"));
				dto.setUser_id(rs.getString("user_id"));
				dto.setProduct_no(rs.getInt("product_no"));
				dto.setCategory_no(rs.getInt("category_no"));
				dto.setReview_cont(rs.getString("review_cont"));
				dto.setReview_rank(rs.getInt("review_rank"));
				dto.setReview_image(rs.getString("review_image"));
				dto.setReview_date(rs.getString("review_date"));
				dto.setReview_update(rs.getString("review_update"));
				dto.setReview_hit(rs.getInt("review_hit"));
				
				rList.add(dto);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
		
		
		return rList;
	}
	
	
	
	// 상품번호에 해당하는 리뷰를 모두 가져오는 메서드
	public List<ReviewDTO> getReviewInfo(int pnum) {
			List<ReviewDTO> list = new ArrayList<ReviewDTO>();
			
			try {
				openConn();
				
				sql = "select * from sc_review where product_no = ? order by review_date desc";
				
				pstmt = con.prepareStatement(sql);
				
				pstmt.setInt(1, pnum);
				
				rs = pstmt.executeQuery();
				
				while(rs.next()) {
					ReviewDTO dto = new ReviewDTO();
					
					dto.setReview_no(rs.getInt("review_no"));
					dto.setUser_id(rs.getString("user_id"));
					dto.setProduct_no(rs.getInt("product_no"));
					dto.setCategory_no(rs.getInt("category_no"));
					dto.setReview_cont(rs.getString("review_cont"));
					dto.setReview_rank(rs.getInt("review_rank"));
					dto.setReview_image(rs.getString("review_image"));
					dto.setReview_date(rs.getString("review_date"));
					dto.setReview_update(rs.getString("review_update"));
					dto.setReview_hit(rs.getInt("review_hit"));
					
					list.add(dto);
				}
				
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} finally {
				closeConn(rs, pstmt, con);
			}
			return list;
	} // getReviewInfo() 메서드 end
}
