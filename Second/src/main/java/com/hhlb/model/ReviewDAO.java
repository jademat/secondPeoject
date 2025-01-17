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
			
			sql = "select * from sc_review where user_id = ? order by review_no desc";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1,id);
		
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				ReviewDTO dto = new ReviewDTO();
				
				dto.setReview_no(rs.getInt("review_no"));
				dto.setUser_id(rs.getString("user_id"));
				dto.setProduct_no(rs.getInt("product_no"));
				dto.setReview_cont(rs.getString("review_cont"));
				dto.setReview_rank(rs.getInt("review_rank"));
				dto.setReview_image(rs.getString("review_image"));
				dto.setReview_date(rs.getString("review_date"));
				dto.setReview_update(rs.getString("review_update"));
				dto.setReview_hit(rs.getInt("review_hit"));
				dto.setReview_title(rs.getString("review_title"));
				
				rList.add(dto);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
		
		
		return rList;
	}
	
	public List<ReviewDTO> getReviewList(int page, int rowsize){
		List<ReviewDTO> rList = new ArrayList<ReviewDTO>();
		
		int startNo = (page * rowsize) - (rowsize - 1);

		int endNo = (page * rowsize);
		try {
			openConn();
			
			sql = "select * from" + "(select row_number() over (order by review_no desc) as rnum, r.* from sc_review r)"
					+ " where rnum >= ? and rnum <= ?";

			pstmt = con.prepareStatement(sql);

			pstmt.setInt(1, startNo);
			pstmt.setInt(2, endNo);
		
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				ReviewDTO dto = new ReviewDTO();
				
				dto.setReview_no(rs.getInt("review_no"));
				dto.setUser_id(rs.getString("user_id"));
				dto.setProduct_no(rs.getInt("product_no"));
				dto.setReview_cont(rs.getString("review_cont"));
				dto.setReview_rank(rs.getInt("review_rank"));
				dto.setReview_image(rs.getString("review_image"));
				dto.setReview_date(rs.getString("review_date"));
				dto.setReview_update(rs.getString("review_update"));
				dto.setReview_hit(rs.getInt("review_hit"));
				dto.setReview_title(rs.getString("review_title"));
				
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
	public List<ReviewDTO> getReviewInfo(int pnum, int page, int rowsize) {
			List<ReviewDTO> list = new ArrayList<ReviewDTO>();
			
			// 해당 페이지에서 시작 글 번호
			int startNo = (page * rowsize) - (rowsize - 1);
			// 해당 페이지에서 끝 글번호
			int endNo = (page * rowsize);
			
			try {
				openConn();
				
				sql = "select * from (select row_number() over(order by review_date desc) as rnum, b.* from sc_review b) "
						+ " where product_no = ? and rnum >= ? and rnum <= ?";
				
				pstmt = con.prepareStatement(sql);
				
				pstmt.setInt(1, pnum);
				pstmt.setInt(2, startNo);
				pstmt.setInt(3, endNo);
				
				rs = pstmt.executeQuery();
				
				while(rs.next()) {
					ReviewDTO dto = new ReviewDTO();
					
					dto.setReview_no(rs.getInt("review_no"));
					dto.setUser_id(rs.getString("user_id"));
					dto.setProduct_no(rs.getInt("product_no"));
					dto.setReview_cont(rs.getString("review_cont"));
					dto.setReview_rank(rs.getInt("review_rank"));
					dto.setReview_image(rs.getString("review_image"));
					dto.setReview_date(rs.getString("review_date"));
					dto.setReview_update(rs.getString("review_update"));
					dto.setReview_hit(rs.getInt("review_hit"));
					dto.setReview_title(rs.getString("review_title"));
					
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
	
	
	public ReviewDTO getuserReview(int no) {
		ReviewDTO dto = null;
		
		try {
			openConn();
			
			sql = "select * from sc_review where review_no = ?";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, no);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				dto = new ReviewDTO();
				
				dto.setReview_no(rs.getInt("review_no"));
				dto.setUser_id(rs.getString("user_id"));
				dto.setProduct_no(rs.getInt("product_no"));
				dto.setReview_cont(rs.getString("review_cont"));
				dto.setReview_rank(rs.getInt("review_rank"));
				dto.setReview_image(rs.getString("review_image"));
				dto.setReview_date(rs.getString("review_date"));
				dto.setReview_update(rs.getString("review_update"));
				dto.setReview_hit(rs.getInt("review_hit"));
				dto.setReview_title(rs.getString("review_title"));
				
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
		return dto;
	}
	public int getReviewCount() {
		int count = 0;
		
		try {
			openConn();
			
			sql = "select count(*) from sc_review";
			
			pstmt = con.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				count = rs.getInt(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
		return count;
	}
	
	public int deleteReview(int no) {
		int result = 0;
		
		try {
			openConn();
			
			sql = "delete from sc_review where review_no = ?";
		
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, no);
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeConn(pstmt, con);
		}
		
		return result;
	}
	
	public void updateReviewSequence(int no) {
		
		try {
			openConn();

			sql = "update sc_review set review_no = review_no - 1 where review_no > ?";

			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, no);

			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			closeConn(pstmt, con);
		}

	}
	public int insertReview(String id, int no, ReviewDTO dto) {
		int result = 0 , count = 0;
		
		try {
			openConn();
			
			sql = "select max(review_no) from sc_review";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				count = rs.getInt(1) + 1;
			}
			sql = "insert into sc_review values(?,?,?,?,?,?,sysdate,'',default,?)";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, count);
			pstmt.setString(2,id);
			pstmt.setInt(3,no);
			pstmt.setString(4,dto.getReview_cont());
			pstmt.setInt(5, dto.getReview_rank());
			pstmt.setString(6, dto.getReview_image());
			pstmt.setString(7,dto.getReview_title());
			
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
		
		return result;
	}
}
