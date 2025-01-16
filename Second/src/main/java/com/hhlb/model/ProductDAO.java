package com.hhlb.model;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import javax.naming.*;
import javax.sql.DataSource;

public class ProductDAO {

    private static ProductDAO instance;

    private ProductDAO() { }

    public static ProductDAO getInstance() {
        if (instance == null) {
            instance = new ProductDAO();
        }
        return instance;
    }

    Connection con = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    String sql = null;

    // DB 연결 메서드
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

    // DB 자원 종료 메서드 (ResultSet, PreparedStatement, Connection)
    public void closeConn(ResultSet rs, PreparedStatement pstmt, Connection con) {
        try {
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (con != null) con.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
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
    public int getCategoryNoByCode(String gender, String categoryCode) {
        
    	int categoryNo = 0;
        
    	

        try {
            openConn();
            
            String sql = "SELECT category_no FROM sc_category WHERE category_code LIKE ?";
            
            pstmt = con.prepareStatement(sql);
           
            // 카테고리 코드가 male이면 'e100%'로, female이면 'e200%'로 설정
            if(gender.equals("male")) {
            	if (categoryCode.equals("1")) {
                    pstmt.setString(1, "e1001");  // 남자 상의
                } else if (categoryCode.equals("2")) {
                    pstmt.setString(1, "e1002");  // 남자 하의
                } else if (categoryCode.equals("3")) {
                    pstmt.setString(1, "e1003");  // 남자 아우터
                } 
            }else if(gender.equals("female")) {
            	// categoryCode가 'female'인 경우
                if (categoryCode.equals("4")) {
                    pstmt.setString(1, "e2001");  // 여자 상의
                } else if (categoryCode.equals("5")) {
                    pstmt.setString(1, "e2002");  // 여자 하의
                } else if (categoryCode.equals("6")) {
                    pstmt.setString(1, "e2003");  // 여자 아우터
                }
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
            pstmt.setInt(2, dto.getCategory_no());
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

    // 전체 상품 목록
    public List<ProductDTO> getProductList() {
	    List<ProductDTO> productList = new ArrayList<ProductDTO>();
	    try {
	        openConn();
	        sql = "SELECT * FROM sc_product";
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

            sql = "DELETE FROM SC_PRODUCT WHERE PRODUCT_NO = ?";
            
            pstmt = con.prepareStatement(sql);
            
            pstmt.setInt(1, product_no);

            int chk = pstmt.executeUpdate();
            if (chk > 0) {
                result = true;  // 삭제 성공
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeConn(pstmt, con);
        }

        return result;
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
                product.setProduct_hit(rs.getInt("PRODUCT_HIT"));
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

    public int updateProduct(ProductDTO dto) {
        
    	int result = 0;  // 실패 == 0

        
        

        try {
            openConn();
            
            String sql = "UPDATE sc_product SET product_name = ?, product_spec = ?, product_qty = ?, product_size = ?, product_price = ?, category_no = ?, product_image = ?, product_specInfo = ? WHERE product_no = ?";

            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, dto.getProduct_name());  		// 상품명
            pstmt.setString(2, dto.getProduct_spec());  		// 상품 설명
            pstmt.setInt(3, dto.getProduct_qty());  			// 상품 수량
            pstmt.setString(4, dto.getProduct_size());  		// 상품 사이즈
            pstmt.setInt(5, dto.getProduct_price());  			// 상품 가격
            pstmt.setInt(6, dto.getCategory_no());  			// 카테고리 번호
            pstmt.setString(7, dto.getProduct_image());  		// 상품 이미지
            pstmt.setString(8, dto.getProduct_specInfo());  	// 상품 설명 정보
            pstmt.setInt(9, dto.getProduct_no());  				// 상품 번호 (수정할 조건)

            
            result = pstmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeConn(pstmt, con);
        }

        return result;  // 성공 == 1
    }
    
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