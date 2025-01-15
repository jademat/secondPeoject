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

public class ProductDAO {

	Connection con = null;

	PreparedStatement pstmt = null;

	ResultSet rs = null;

	String sql = null;

	private static ProductDAO instance;

	private ProductDAO() {
	} // 기본 생성자

	public static ProductDAO getInstance() {

		if (instance == null) {
			instance = new ProductDAO();
		}

		return instance;
	} // getInstance() 메서드 end

	public void openConn() {

		try {

			Context initCtx = new InitialContext();

			Context ctx = (Context) initCtx.lookup("java:comp/env");

			DataSource ds = (DataSource) ctx.lookup("jdbc/myoracle");

			con = ds.getConnection();

		} catch (Exception e) {

			e.printStackTrace();
		}

	}

	// DB에 연결되어 있던 자원 종료하는 메서드.
	public void closeConn(ResultSet rs, PreparedStatement pstmt, Connection con) {

		try {
			if (rs != null)
				rs.close();
			if (pstmt != null)
				pstmt.close();
			if (con != null)
				con.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	} // closeConn() 메서드 end

	// DB에 연결되어 있던 자원 종료하는 메서드.
	public void closeConn(PreparedStatement pstmt, Connection con) {

		try {
			if (pstmt != null)
				pstmt.close();
			if (con != null)
				con.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	} // closeConn() 메서드 end

	// 모든 상품 리스트를 가져오는 메서드
	public List<ProductDTO> getAllProduct() {
		List<ProductDTO> list = new ArrayList<ProductDTO>();

		try {
			openConn();

			sql = "select * from sc_product";
			pstmt = con.prepareStatement(sql);

			rs = pstmt.executeQuery();
			while (rs.next()) {
				ProductDTO dto = new ProductDTO();

				dto.setProduct_no(rs.getInt("product_no"));
				dto.setCategory_no(rs.getInt("category_no"));
				dto.setProduct_name(rs.getString("product_name"));
				dto.setProduct_price(rs.getInt("product_price"));
				dto.setProduct_spec(rs.getString("product_spec"));
				dto.setProduct_qty(rs.getInt("product_qty"));
				dto.setProduct_hit(rs.getInt("product_hit"));
				dto.setProduct_image(rs.getString("product_image"));
				dto.setProduct_size(rs.getString("product_size"));
				dto.setProduct_specInfo(rs.getString("product_specInfo"));

				list.add(dto);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
		return list;
	} // getAllProduct() 메서드 end

	// 제품 번호에 해당하는 제품의 상세 정보를 조회하는 메서드
	public ProductDTO getProductContent(int pnum) {
		ProductDTO dto = null;

		try {
			openConn();

			sql = "select * from sc_product where product_no = ?";
			pstmt = con.prepareStatement(sql);

			pstmt.setInt(1, pnum);

			rs = pstmt.executeQuery();
			if (rs.next()) {
				dto = new ProductDTO();

				dto.setProduct_no(rs.getInt("product_no"));
				dto.setCategory_no(rs.getInt("category_no"));
				dto.setProduct_name(rs.getString("product_name"));
				dto.setProduct_price(rs.getInt("product_price"));
				dto.setProduct_spec(rs.getString("product_spec"));
				dto.setProduct_qty(rs.getInt("product_qty"));
				dto.setProduct_hit(rs.getInt("product_hit"));
				dto.setProduct_image(rs.getString("product_image"));
				dto.setProduct_size(rs.getString("product_size"));
				dto.setProduct_specInfo(rs.getString("product_specInfo"));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
		return dto;
	} // getProductContent() 메서드 end

	// 해당 상품번호에 일치하는 상품의 review_rank 를 소수점 1자리로 가져오는 메서드
	public int getProductRiviewRank(int pnum) {
		int result = 0;

		try {
			openConn();

			sql = "SELECT ROUND(AVG(r.REVIEW_RANK), 1) AS AVG_REVIEW_RANK FROM sc_product p "
					+ " JOIN sc_review r ON p.PRODUCT_NO = r.PRODUCT_NO WHERE p.PRODUCT_NO = ?"
					+ "GROUP BY p.PRODUCT_NO";
			pstmt = con.prepareStatement(sql);

			pstmt.setInt(1, pnum);

			rs = pstmt.executeQuery();
			if (rs.next()) {
				result = rs.getInt(1);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
		return result;
	} // getProductRiviewRank() 메서드 end

	// 해당 상품번호에 일치하는 상품의 리뷰 개수를 가져오는 메서드
	public int getProductRiviewCount(int pnum) {
		int result = 0;

		try {
			openConn();

			sql = "SELECT COUNT(r.REVIEW_NO) AS REVIEW_COUNT FROM sc_product p "
					+ "	LEFT JOIN sc_review r ON p.PRODUCT_NO = r.PRODUCT_NO "
					+ " WHERE p.PRODUCT_NO = ? GROUP BY p.PRODUCT_NO";
			pstmt = con.prepareStatement(sql);

			pstmt.setInt(1, pnum);

			rs = pstmt.executeQuery();
			if (rs.next()) {
				result = rs.getInt(1);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
		return result;
	} 

	// 모든 상품 리스트를 가져오는 메서드
	public List<ProductDTO> popularProduct() {
		List<ProductDTO> list = new ArrayList<ProductDTO>();

		try {
			openConn();

			sql = "select * from sc_product order by product_hit desc";
			pstmt = con.prepareStatement(sql);

			rs = pstmt.executeQuery();
			while (rs.next()) {
				ProductDTO dto = new ProductDTO();

				dto.setProduct_no(rs.getInt("product_no"));
				dto.setCategory_no(rs.getInt("category_no"));
				dto.setProduct_name(rs.getString("product_name"));
				dto.setProduct_price(rs.getInt("product_price"));
				dto.setProduct_spec(rs.getString("product_spec"));
				dto.setProduct_qty(rs.getInt("product_qty"));
				dto.setProduct_hit(rs.getInt("product_hit"));
				dto.setProduct_image(rs.getString("product_image"));
				dto.setProduct_size(rs.getString("product_size"));
				dto.setProduct_specInfo(rs.getString("product_specInfo"));

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

// 여성  Top 상품 리스트를 가져오는 메서드
	public List<ProductDTO> womanTop() {

		List<ProductDTO> list = new ArrayList<ProductDTO>();

		try {
			openConn();

			sql = "select p. * from sc_category c " + " join sc_product p on c.category_no = p.category_no"
					+ " where c.category_no = '9' ";

			pstmt = con.prepareStatement(sql);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				ProductDTO dto = new ProductDTO();

				dto.setProduct_no(rs.getInt("product_no"));
				dto.setCategory_no(rs.getInt("category_no"));
				dto.setProduct_name(rs.getString("product_name"));
				dto.setProduct_price(rs.getInt("product_price"));
				dto.setProduct_spec(rs.getString("product_spec"));
				dto.setProduct_qty(rs.getInt("product_qty"));
				dto.setProduct_hit(rs.getInt("product_hit"));
				dto.setProduct_image(rs.getString("product_image"));
				dto.setProduct_size(rs.getString("product_size"));
				dto.setProduct_specInfo(rs.getString("product_specInfo"));

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

// 여성 하의 상품 리스트를 가져오는 메서드
	public List<ProductDTO> womanBottom() {

		List<ProductDTO> list = new ArrayList<ProductDTO>();

		try {
			openConn();

			sql = "select p. * from sc_category c " + " join sc_product p on c.category_no = p.category_no"
					+ " where c.category_no = '10' ";

			pstmt = con.prepareStatement(sql);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				ProductDTO dto = new ProductDTO();

				dto.setProduct_no(rs.getInt("product_no"));
				dto.setCategory_no(rs.getInt("category_no"));
				dto.setProduct_name(rs.getString("product_name"));
				dto.setProduct_price(rs.getInt("product_price"));
				dto.setProduct_spec(rs.getString("product_spec"));
				dto.setProduct_qty(rs.getInt("product_qty"));
				dto.setProduct_hit(rs.getInt("product_hit"));
				dto.setProduct_image(rs.getString("product_image"));
				dto.setProduct_size(rs.getString("product_size"));
				dto.setProduct_specInfo(rs.getString("product_specInfo"));

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
	// 여성 자켓 상품 리스트를 가져오는 메서드

		public List<ProductDTO> womanOuter() {

			List<ProductDTO> list = new ArrayList<ProductDTO>();

			try {
				openConn();

				sql = "select p. * from sc_category c " + " join sc_product p on c.category_no = p.category_no"
						+ " where c.category_no = '11' ";

				pstmt = con.prepareStatement(sql);

				rs = pstmt.executeQuery();

				while (rs.next()) {
					ProductDTO dto = new ProductDTO();

					dto.setProduct_no(rs.getInt("product_no"));
					dto.setCategory_no(rs.getInt("category_no"));
					dto.setProduct_name(rs.getString("product_name"));
					dto.setProduct_price(rs.getInt("product_price"));
					dto.setProduct_spec(rs.getString("product_spec"));
					dto.setProduct_qty(rs.getInt("product_qty"));
					dto.setProduct_hit(rs.getInt("product_hit"));
					dto.setProduct_image(rs.getString("product_image"));
					dto.setProduct_size(rs.getString("product_size"));
					dto.setProduct_specInfo(rs.getString("product_specInfo"));

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
		
// 남성  Top 상품 리스트를 가져오는 메서드
	public List<ProductDTO> manTop() {

		List<ProductDTO> list = new ArrayList<ProductDTO>();

		try {
			openConn();

			sql = "select p. * from sc_category c " + " join sc_product p on c.category_no = p.category_no"
					+ " where c.category_no = '6' ";

			pstmt = con.prepareStatement(sql);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				ProductDTO dto = new ProductDTO();

				dto.setProduct_no(rs.getInt("product_no"));
				dto.setCategory_no(rs.getInt("category_no"));
				dto.setProduct_name(rs.getString("product_name"));
				dto.setProduct_price(rs.getInt("product_price"));
				dto.setProduct_spec(rs.getString("product_spec"));
				dto.setProduct_qty(rs.getInt("product_qty"));
				dto.setProduct_hit(rs.getInt("product_hit"));
				dto.setProduct_image(rs.getString("product_image"));
				dto.setProduct_size(rs.getString("product_size"));
				dto.setProduct_specInfo(rs.getString("product_specInfo"));

				list.add(dto);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
		return list;
	} // getAllProduct() 메서드 end
	
// 남성  하의 상품 리스트를 가져오는 메서드

	public List<ProductDTO> manBottom() {

		List<ProductDTO> list = new ArrayList<ProductDTO>();

		try {
			openConn();

			sql = "select p. * from sc_category c " + " join sc_product p on c.category_no = p.category_no"
					+ " where c.category_no = '7' ";

			pstmt = con.prepareStatement(sql);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				ProductDTO dto = new ProductDTO();

				dto.setProduct_no(rs.getInt("product_no"));
				dto.setCategory_no(rs.getInt("category_no"));
				dto.setProduct_name(rs.getString("product_name"));
				dto.setProduct_price(rs.getInt("product_price"));
				dto.setProduct_spec(rs.getString("product_spec"));
				dto.setProduct_qty(rs.getInt("product_qty"));
				dto.setProduct_hit(rs.getInt("product_hit"));
				dto.setProduct_image(rs.getString("product_image"));
				dto.setProduct_size(rs.getString("product_size"));
				dto.setProduct_specInfo(rs.getString("product_specInfo"));

				list.add(dto);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
		return list;
	} // getAllProduct() 메서드 end

		// 남성 자켓 상품 리스트를 가져오는 메서드

	public List<ProductDTO> manOuter() {

		List<ProductDTO> list = new ArrayList<ProductDTO>();

		try {
			openConn();

			sql = "select p. * from sc_category c " + " join sc_product p on c.category_no = p.category_no"
					+ " where c.category_no = '8' ";

			pstmt = con.prepareStatement(sql);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				ProductDTO dto = new ProductDTO();

				dto.setProduct_no(rs.getInt("product_no"));
				dto.setCategory_no(rs.getInt("category_no"));
				dto.setProduct_name(rs.getString("product_name"));
				dto.setProduct_price(rs.getInt("product_price"));
				dto.setProduct_spec(rs.getString("product_spec"));
				dto.setProduct_qty(rs.getInt("product_qty"));
				dto.setProduct_hit(rs.getInt("product_hit"));
				dto.setProduct_image(rs.getString("product_image"));
				dto.setProduct_size(rs.getString("product_size"));
				dto.setProduct_specInfo(rs.getString("product_specInfo"));

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

	// 여자 상품 전체 보기
	public List<ProductDTO> womanAllProduct() {
		List<ProductDTO> list = new ArrayList<ProductDTO>();

		try {
			openConn();

			sql = "select p. * from sc_category c " + " join sc_product p on c.category_no = p.category_no"
					+ " where c.category_no in (9, 10,11) ";

			pstmt = con.prepareStatement(sql);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				ProductDTO dto = new ProductDTO();

				dto.setProduct_no(rs.getInt("product_no"));
				dto.setCategory_no(rs.getInt("category_no"));
				dto.setProduct_name(rs.getString("product_name"));
				dto.setProduct_price(rs.getInt("product_price"));
				dto.setProduct_spec(rs.getString("product_spec"));
				dto.setProduct_qty(rs.getInt("product_qty"));
				dto.setProduct_hit(rs.getInt("product_hit"));
				dto.setProduct_image(rs.getString("product_image"));
				dto.setProduct_size(rs.getString("product_size"));
				dto.setProduct_specInfo(rs.getString("product_specInfo"));

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
	// 남자 상품 전체 보기 
	public List<ProductDTO> manAllProduct() {
		List<ProductDTO> list = new ArrayList<ProductDTO>();
		
		try {
			openConn();
			
			sql = "select p. * from sc_category c " + " join sc_product p on c.category_no = p.category_no"
					+ " where c.category_no in (6,7,8) ";
			
			pstmt = con.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				ProductDTO dto = new ProductDTO();
				
				dto.setProduct_no(rs.getInt("product_no"));
				dto.setCategory_no(rs.getInt("category_no"));
				dto.setProduct_name(rs.getString("product_name"));
				dto.setProduct_price(rs.getInt("product_price"));
				dto.setProduct_spec(rs.getString("product_spec"));
				dto.setProduct_qty(rs.getInt("product_qty"));
				dto.setProduct_hit(rs.getInt("product_hit"));
				dto.setProduct_image(rs.getString("product_image"));
				dto.setProduct_size(rs.getString("product_size"));
				dto.setProduct_specInfo(rs.getString("product_specInfo"));
				
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
