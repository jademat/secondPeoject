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

	ResultSet rs= null;
	
	String sql = null;

	private static ProductDAO instance;
	
	private ProductDAO() {  }  // 기본 생성자

	public static ProductDAO getInstance() {
		
		if(instance == null) {
			instance = new ProductDAO();
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
	
	

	// category_code로 category_no 조회하는 메서드
    public int getCategoryNoByCode(String categoryCode) {
        
    	int categoryNo = 0;
        
    	

        try {
            openConn();
            
            String sql = "SELECT category_no FROM sc_category WHERE category_code LIKE ?";
            
            pstmt = con.prepareStatement(sql);
           
            // 카테고리 코드가 male이면 'e100%'로, female이면 'e200%'로 설정
            if (categoryCode.equals("male")) {
                pstmt.setString(1, "e100%");  // 'e100%'로 시작하는 카테고리 코드
            } else if (categoryCode.equals("female")) {
                pstmt.setString(1, "e200%");  // 'e200%'로 시작하는 카테고리 코드
            }
           
            rs = pstmt.executeQuery();

            if (rs.next()) {
                
            	categoryNo = rs.getInt("category_no");  // category_no 반환
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeConn(rs, pstmt, con);
        }

        return categoryNo;  // 없으면 0을 반환
    }

    // 상품 등록 메서드
    public int insertProduct(ProductDTO dto) {
        
    	int result = 0;  // 기본값은 실패 (0)

        try {
            openConn();

            // 상품 번호 계산 (자동 증가 방식)
            sql = "SELECT MAX(product_no) FROM sc_product";
            pstmt = con.prepareStatement(sql);
            rs = pstmt.executeQuery();

            int productNo = 1;  // 기본값 설정

            if (rs.next()) {
                productNo = rs.getInt(1) + 1;  // 가장 큰 product_no에 1을 더한 값
            }

            // 상품 정보 등록 SQL문
            sql = "INSERT INTO sc_product (product_no, category_no, product_name, product_price, product_spec, product_qty, product_hit, product_image, product_size, product_specInfo) " +
                  "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, productNo);
            pstmt.setInt(2, dto.getCategory_no());  // category_no 설정
            pstmt.setString(3, dto.getProduct_name());
            pstmt.setInt(4, dto.getProduct_price());
            pstmt.setString(5, dto.getProduct_spec());
            pstmt.setInt(6, dto.getProduct_qty());
            pstmt.setInt(7, 0);  // 상품 히트 수는 기본 0
            pstmt.setString(8, dto.getProduct_image());
            pstmt.setString(9, dto.getProduct_size());
            pstmt.setString(10, dto.getProduct_specInfo());

            int chk = pstmt.executeUpdate();
            
            

            if (chk > 0) {
                result = 1;  // 성공
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeConn(rs, pstmt, con);
        }

        
        return result;
    }

    public List<ProductDTO> getProductList() {
	    List<ProductDTO> productList = new ArrayList<ProductDTO>();
	    try {
	        openConn();
	        sql = "SELECT * FROM sc_product";  // 전체 상품을 조회하는 쿼리
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
	            
	            
	            productList.add(dto);
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    } finally {
	        closeConn(rs, pstmt, con);
	    }
	    return productList;
	}
    
 // 상품 삭제 메서드
    public boolean deleteProduct(int product_no) {
        boolean result = false;
        try {
            openConn();

            // 상품을 삭제하는 SQL문
            sql = "DELETE FROM SC_PRODUCT WHERE PRODUCT_NO = ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, product_no);

            // SQL 실행
            int chk = pstmt.executeUpdate();
            if (chk > 0) {
                result = true;  // 성공적으로 삭제된 경우
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeConn(pstmt, con);
        }

        return result;  // 삭제 성공 여부 반환
    }
    
    
    public ProductDTO getProductById(int productId) {
       
    	ProductDTO product = null;
        try {
            openConn();
            sql = "SELECT * FROM SC_PRODUCT WHERE PRODUCT_NO = ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, productId);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                product = new ProductDTO();
                product.setProduct_no(rs.getInt("PRODUCT_NO"));
                product.setCategory_no(rs.getInt("CATEGORY_NO"));
                product.setProduct_name(rs.getString("PRODUCT_NAME"));
                product.setProduct_price(rs.getInt("PRODUCT_PRICE"));
                product.setProduct_spec(rs.getString("PRODUCT_SPEC"));
                product.setProduct_qty(rs.getInt("PRODUCT_QTY"));
                product.setProduct_image(rs.getString("PRODUCT_IMAGE"));
                product.setProduct_size(rs.getString("PRODUCT_SIZE"));
                product.setProduct_specInfo(rs.getString("PRODUCT_SPECINFO"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeConn(rs, pstmt, con);
        }
        return product;
    }
	
	
	


	// 모든 상품 리스트를 가져오는 메서드
	public List<ProductDTO> getAllProduct() {
		List<ProductDTO> list = new ArrayList<ProductDTO>(); 
		
		try {
			openConn();
			
			sql ="select * from sc_product";
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
	} // getProductRiviewCount() 메서드 end

}
