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

	// category_code로 category_no 조회하는 메서드
	public int getCategoryNoByCode(String gender, String categoryCode) {

		int categoryNo = 0;

		try {
			openConn();

			String sql = "SELECT category_no FROM sc_category WHERE category_code LIKE ?";

			pstmt = con.prepareStatement(sql);

			// 카테고리 코드가 male이면 'e100%'로, female이면 'e200%'로 설정
			if (gender.equals("male")) {
				if (categoryCode.equals("1")) {
					pstmt.setString(1, "e1001"); // 남자 상의
				} else if (categoryCode.equals("2")) {
					pstmt.setString(1, "e1002"); // 남자 하의
				} else if (categoryCode.equals("3")) {
					pstmt.setString(1, "e1003"); // 남자 아우터
				}
			} else if (gender.equals("female")) {
				// categoryCode가 'female'인 경우
				if (categoryCode.equals("4")) {
					pstmt.setString(1, "e2001"); // 여자 상의
				} else if (categoryCode.equals("5")) {
					pstmt.setString(1, "e2002"); // 여자 하의
				} else if (categoryCode.equals("6")) {
					pstmt.setString(1, "e2003"); // 여자 아우터
				}
			}

			rs = pstmt.executeQuery();

			if (rs.next()) {

				categoryNo = rs.getInt("category_no"); // category_no 반환
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}

		return categoryNo; // 없으면 0을 반환
	}

	// 상품 등록 메서드
	public int insertProduct(ProductDTO dto) {

		int result = 0; // 기본값은 실패 (0)

		try {
			openConn();

			// 상품 번호 계산 (자동 증가 방식)
			sql = "SELECT MAX(product_no) FROM sc_product";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();

			int productNo = 1; // 기본값 설정

			if (rs.next()) {
				productNo = rs.getInt(1) + 1; // 가장 큰 product_no에 1을 더한 값
			}

			// 상품 정보 등록 SQL문
			sql = "INSERT INTO sc_product (product_no, category_no, product_name, product_price, product_spec, product_qty, product_hit, product_image, product_size, product_specInfo) "
					+ "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, productNo);
			pstmt.setInt(2, dto.getCategory_no()); // category_no 설정
			pstmt.setString(3, dto.getProduct_name());
			pstmt.setInt(4, dto.getProduct_price());
			pstmt.setString(5, dto.getProduct_spec());
			pstmt.setInt(6, dto.getProduct_qty());
			pstmt.setInt(7, 0); // 상품 히트 수는 기본 0
			pstmt.setString(8, dto.getProduct_image());
			pstmt.setString(9, dto.getProduct_size());
			pstmt.setString(10, dto.getProduct_specInfo());

			int chk = pstmt.executeUpdate();

			if (chk > 0) {
				result = 1; // 성공
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
			sql = "SELECT * FROM sc_product"; // 전체 상품을 조회하는 쿼리
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
				result = true; // 삭제 성공
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

		int result = 0; // 실패 == 0

		try {
			openConn();

			String sql = "UPDATE sc_product SET product_name = ?, product_spec = ?, product_qty = ?, product_size = ?, product_price = ?, category_no = ?, product_image = ?, product_specInfo = ? WHERE product_no = ?";

			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, dto.getProduct_name()); // 상품명
			pstmt.setString(2, dto.getProduct_spec()); // 상품 설명
			pstmt.setInt(3, dto.getProduct_qty()); // 상품 수량
			pstmt.setString(4, dto.getProduct_size()); // 상품 사이즈
			pstmt.setInt(5, dto.getProduct_price()); // 상품 가격
			pstmt.setInt(6, dto.getCategory_no()); // 카테고리 번호
			pstmt.setString(7, dto.getProduct_image()); // 상품 이미지
			pstmt.setString(8, dto.getProduct_specInfo()); // 상품 설명 정보
			pstmt.setInt(9, dto.getProduct_no()); // 상품 번호 (수정할 조건)

			result = pstmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeConn(pstmt, con);
		}

		return result; // 성공 == 1
	}

	// 모든 상품 리스트를 가져오는 메서드
	public List<ProductDTO> getAllProduct(int page, int rowsize) {
		List<ProductDTO> list = new ArrayList<ProductDTO>();

		// 해당 페이지에서 시작 글 번호
		int startNo = (page * rowsize) - (rowsize - 1);
		// 해당 페이지에서 끝 글번호
		int endNo = (page * rowsize);

		try {
			openConn();

			sql = "select * from (select row_number() over(order by product_no desc) as rnum, b.* from sc_product b) "
					+ " where rnum >= ? and rnum <= ?";
			pstmt = con.prepareStatement(sql);

			pstmt.setInt(1, startNo);
			pstmt.setInt(2, endNo);

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
					+ "   LEFT JOIN sc_review r ON p.PRODUCT_NO = r.PRODUCT_NO "
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


			sql = "select * from sc_product where category_no = 9";


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


			sql = "select * from sc_product where category_no = 10";


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


	public List<ProductDTO> womanOuter() {

         List<ProductDTO> list = new ArrayList<ProductDTO>();

         try {
            openConn();

				sql = "select * from sc_product where category_no = 11";


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


			sql = "select * from sc_product where category_no = 6";

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

			sql = "select * from sc_product where category_no = 7";
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

	public List<ProductDTO> manOuter() {

      List<ProductDTO> list = new ArrayList<ProductDTO>();

      try {
         openConn();

			sql = "select * from sc_product where category_no = 8";


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

			sql = "select * from sc_product where category_no in (9, 10,11) ";


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

	} // manAllProduct() 메서드 end

	// 주문서 페이지에서 결제가 성공 했을 경우 해당 상품의 product_hit를 올려주는 메서드
	public void updateProductHit(List<CartDTO> cartList) {
		int proNo = 0;

		try {
			openConn();

			for (int i = 0; i < cartList.size(); i++) {
				// 해당 상품 product_no의 hit 값을 찾는 메서드
				sql = "select max(product_hit) from sc_product where product_no = ?";
				pstmt = con.prepareStatement(sql);

				pstmt.setInt(1, cartList.get(i).getProduct_no());

				rs = pstmt.executeQuery();
				if (rs.next()) {
					proNo = rs.getInt(1) + 1;
				}

				// 반복해서 데이터를 sc_order 테이블에 입력하는 코드
				sql = "insert into sc_product (product_hit) values(?) where product_no = ?";
				pstmt = con.prepareStatement(sql);

				pstmt.setInt(1, proNo);
				pstmt.setInt(2, cartList.get(i).getProduct_no());

				pstmt.executeUpdate();
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
	} // updateProductHit() 메서드 end

	// 상품 최신순으로 가져오는 메서드
	public List<ProductDTO> getAllProductRecent(int page, int rowsize) {
		List<ProductDTO> list = new ArrayList<ProductDTO>();

		// 해당 페이지에서 시작 글 번호
		int startNo = (page * rowsize) - (rowsize - 1);
		// 해당 페이지에서 끝 글번호
		int endNo = (page * rowsize);

		try {
			openConn();

			sql = "select * from (select row_number() over(order by product_no asc) as rnum, b.* from sc_product b) "
					+ " where rnum >= ? and rnum <= ?";
			pstmt = con.prepareStatement(sql);

			pstmt.setInt(1, startNo);
			pstmt.setInt(2, endNo);

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
	} // getAllProductRecent() 메서드 end

	// 상품 인기순으로 가져오는 메서드
	public List<ProductDTO> getAllProductPop(int page, int rowsize) {
		List<ProductDTO> list = new ArrayList<ProductDTO>();

		// 해당 페이지에서 시작 글 번호
		int startNo = (page * rowsize) - (rowsize - 1);
		// 해당 페이지에서 끝 글번호
		int endNo = (page * rowsize);

		try {
			openConn();

			sql = "select * from (select row_number() over(order by product_hit desc) as rnum, b.* from sc_product b) "
					+ " where rnum >= ? and rnum <= ?";
			pstmt = con.prepareStatement(sql);

			pstmt.setInt(1, startNo);
			pstmt.setInt(2, endNo);

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
	} // getAllProductPop() 메서드 end

	// 상품 추천순으로 가져오는 메서드
	public List<ProductDTO> getAllProductReco(int page, int rowsize) {
		List<ProductDTO> list = new ArrayList<ProductDTO>();

		// 해당 페이지에서 시작 글 번호
		int startNo = (page * rowsize) - (rowsize - 1);
		// 해당 페이지에서 끝 글번호
		int endNo = (page * rowsize);

		try {
			openConn();

			sql = "select * from (select row_number() over(order by product_qty desc) as rnum, b.* from sc_product b) "
					+ " where rnum >= ? and rnum <= ?";
			pstmt = con.prepareStatement(sql);

			pstmt.setInt(1, startNo);
			pstmt.setInt(2, endNo);

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
	} // getAllProductReco() 메서드 end

	// 페이징에 사용하기 위한 해당하는 상품의 개수를 구하는 메서드
	public int getProductCount() {
		int count = 0;

		try {
			openConn();

			sql = "select count(*) from sc_product";
			pstmt = con.prepareStatement(sql);

			rs = pstmt.executeQuery();
			if (rs.next()) {
				count = rs.getInt(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
		return count;
	} // getProductCount() 메서드 end

	// 모든 상품의 리스트를 가져오는 메서드(페이징 안하는 버전)
	public List<ProductDTO> getAllProductData() {
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
   } 

	public List<ProductDTO> searchProduct(String search) {

		List<ProductDTO> list = new ArrayList<ProductDTO>();

		try {
			openConn();

			sql = "select * from sc_product where product_name  like ?";

			pstmt = con.prepareStatement(sql);

			pstmt.setString(1, "%" + search + "%");

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

	// 페이징에 사용하기 위한 해당하는 상품의 개수를 구하는 메서드(남성 상의)
	public int getProductCountManTop() {
		int count = 0;

		try {
			openConn();

			sql = "select count(*) from sc_product where category_no = 6";
			pstmt = con.prepareStatement(sql);

			rs = pstmt.executeQuery();
			if (rs.next()) {
				count = rs.getInt(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
		return count;
	} // getProductCountWomanTop() 메서드 end

	// 페이징에 사용하기 위한 해당하는 상품의 개수를 구하는 메서드(남성 하의)
	public int getProductCountManBottom() {
		int count = 0;

		try {
			openConn();

			sql = "select count(*) from sc_product where category_no = 7";
			pstmt = con.prepareStatement(sql);

			rs = pstmt.executeQuery();
			if (rs.next()) {
				count = rs.getInt(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
		return count;
	} // getProductCountWomanBottom() 메서드 end

	// 페이징에 사용하기 위한 해당하는 상품의 개수를 구하는 메서드(남성 아우터)
	public int getProductCountManOuter() {
		int count = 0;

		try {
			openConn();

			sql = "select count(*) from sc_product where category_no = 8";
			pstmt = con.prepareStatement(sql);

			rs = pstmt.executeQuery();
			if (rs.next()) {
				count = rs.getInt(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
		return count;
	} // getProductCountWomanOuter() 메서드 end

	// 페이징에 사용하기 위한 해당하는 상품의 개수를 구하는 메서드 (See All)
	public int getProductCountManAll() {
		int count = 0;

		try {
			openConn();

			sql = "select count(*) from sc_product where category_no in (6,7,8)";

			pstmt = con.prepareStatement(sql);

			rs = pstmt.executeQuery();
			if (rs.next()) {
				count = rs.getInt(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
		return count;
	} // getProductCountManAll() 메서드 end

	// 남성 상의 리스트를 가져오는 메서드
	public List<ProductDTO> getAllProductManTop(int page, int rowsize) {
		List<ProductDTO> list = new ArrayList<ProductDTO>();

		// 해당 페이지에서 시작 글 번호
		int startNo = (page * rowsize) - (rowsize - 1);
		// 해당 페이지에서 끝 글번호
		int endNo = (page * rowsize);

		try {
			openConn();

			sql = "select * from (select row_number() over(order by product_no desc) as rnum, b.* from sc_product b) "
					+ " where category_no = 6 and rnum >= ? and rnum <= ?";
			pstmt = con.prepareStatement(sql);

			pstmt.setInt(1, startNo);
			pstmt.setInt(2, endNo);

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
	} // getAllProductManTop() 메서드 end

	// 남성 하의 리스트를 가져오는 메서드
	public List<ProductDTO> getAllProductManBottom(int page, int rowsize) {
		List<ProductDTO> list = new ArrayList<ProductDTO>();

		// 해당 페이지에서 시작 글 번호
		int startNo = (page * rowsize) - (rowsize - 1);
		// 해당 페이지에서 끝 글번호
		int endNo = (page * rowsize);

		try {
			openConn();

			sql = "select * from (select row_number() over(order by product_no desc) as rnum, b.* from sc_product b) "
					+ " where category_no = 7 and rnum >= ? and rnum <= ?";
			pstmt = con.prepareStatement(sql);

			pstmt.setInt(1, startNo);
			pstmt.setInt(2, endNo);

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
	} // getAllProductManBottom() 메서드 end

	// 남성 아우터 리스트를 가져오는 메서드
	public List<ProductDTO> getAllProductManOuter(int page, int rowsize) {
		List<ProductDTO> list = new ArrayList<ProductDTO>();

		// 해당 페이지에서 시작 글 번호
		int startNo = (page * rowsize) - (rowsize - 1);
		// 해당 페이지에서 끝 글번호
		int endNo = (page * rowsize);

		try {
			openConn();

			sql = "select * from (select row_number() over(order by product_no desc) as rnum, b.* from sc_product b) "
					+ " where category_no =8 and rnum >= ? and rnum <= ?";
			pstmt = con.prepareStatement(sql);

			pstmt.setInt(1, startNo);
			pstmt.setInt(2, endNo);

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
	} // getAllProductManOuter() 메서드 end

	// 오류 수정 남자
	public List<ProductDTO> getAllProductMan1(int page, int rowsize) {
		List<ProductDTO> list = new ArrayList<ProductDTO>();

		int startNo = (page * rowsize) - (rowsize - 1);
		int endNo = (page * rowsize);

		try {
			openConn();

			sql = "select * from (select row_number() over(order by product_no desc) as rnum, b.* from sc_product b) "
					+ " where category_no in (6, 7, 8) and rnum >= ? and rnum <= ?";
			pstmt = con.prepareStatement(sql);

			pstmt.setInt(1, startNo);
			pstmt.setInt(2, endNo);

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

	// 남성 모든 리스트를 가져오는 메서드
	public List<ProductDTO> getAllProductMan(int page, int rowsize) {

		List<ProductDTO> list = new ArrayList<ProductDTO>();

		// 해당 페이지에서 시작 글 번호
		int startNo = (page * rowsize) - (rowsize - 1);
		// 해당 페이지에서 끝 글번호
		int endNo = (page * rowsize);

		try {

			openConn();

			sql = "select * from (select row_number() over(order by product_no desc) as rnum, b.* from sc_product b) "
					+ " where category_no in (6, 7, 8) and rnum >= ? and rnum <= ?";

			pstmt = con.prepareStatement(sql);

			pstmt.setInt(1, startNo);
			pstmt.setInt(2, endNo);

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
	} // getAllProductMan() 메서드 end

	// 페이징에 사용하기 위한 해당하는 상품의 개수를 구하는 메서드(여성 상의)

	public int getProductCountWomanTop() {
		int count = 0;

		try {
			openConn();

			sql = "select count(*) from sc_product where category_no = 9";
			pstmt = con.prepareStatement(sql);

			rs = pstmt.executeQuery();
			if (rs.next()) {
				count = rs.getInt(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
		return count;
	} // getProductCountWomanTop() 메서드 end

	// 페이징에 사용하기 위한 해당하는 상품의 개수를 구하는 메서드(여성 하의)
	public int getProductCountWomanBottom() {
		int count = 0;

		try {
			openConn();

			sql = "select count(*) from sc_product where category_no = 10";
			pstmt = con.prepareStatement(sql);

			rs = pstmt.executeQuery();
			if (rs.next()) {
				count = rs.getInt(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
		return count;
	} // getProductCountWomanBottom() 메서드 end

	// 페이징에 사용하기 위한 해당하는 상품의 개수를 구하는 메서드(여성 아우터)
	public int getProductCountWomanOuter() {
		int count = 0;

		try {
			openConn();

			sql = "select count(*) from sc_product where category_no = 11";
			pstmt = con.prepareStatement(sql);

			rs = pstmt.executeQuery();
			if (rs.next()) {
				count = rs.getInt(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
		return count;
	} // getProductCountWomanOuter() 메서드 end

	// 페이징에 사용하기 위한 해당하는 상품의 개수를 구하는 메서드 (See All)
	public int getProductCountWomanAll() {
		int count = 0;

		try {
			openConn();

			sql = "select count(*) from sc_product where category_no in (9,10,11)";

			pstmt = con.prepareStatement(sql);

			rs = pstmt.executeQuery();
			if (rs.next()) {
				count = rs.getInt(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
		return count;
	} // getProductCountWomanAll() 메서드 end

	// 여성 상의 리스트를 가져오는 메서드
	public List<ProductDTO> getAllProductWomanTop(int page, int rowsize) {
		List<ProductDTO> list = new ArrayList<ProductDTO>();

		// 해당 페이지에서 시작 글 번호
		int startNo = (page * rowsize) - (rowsize - 1);
		// 해당 페이지에서 끝 글번호
		int endNo = (page * rowsize);

		try {
			openConn();

			sql = "select * from (select row_number() over(order by product_no desc) as rnum, b.* from sc_product b) "
					+ " where category_no = 9 and rnum >= ? and rnum <= ?";
			pstmt = con.prepareStatement(sql);

			pstmt.setInt(1, startNo);
			pstmt.setInt(2, endNo);

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
	} // getAllProductWomanTop() 메서드 end

	// 여성 하의 리스트를 가져오는 메서드
	public List<ProductDTO> getAllProductWomanBottom(int page, int rowsize) {
		List<ProductDTO> list = new ArrayList<ProductDTO>();

		// 해당 페이지에서 시작 글 번호
		int startNo = (page * rowsize) - (rowsize - 1);
		// 해당 페이지에서 끝 글번호
		int endNo = (page * rowsize);

		try {
			openConn();

			sql = "select * from (select row_number() over(order by product_no desc) as rnum, b.* from sc_product b) "
					+ " where category_no = 10 and rnum >= ? and rnum <= ?";
			pstmt = con.prepareStatement(sql);

			pstmt.setInt(1, startNo);
			pstmt.setInt(2, endNo);

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
	} // getAllProductWomanBottom() 메서드 end

	// 여성 아우터 리스트를 가져오는 메서드
	public List<ProductDTO> getAllProductWomanOuter(int page, int rowsize) {
		List<ProductDTO> list = new ArrayList<ProductDTO>();

		// 해당 페이지에서 시작 글 번호
		int startNo = (page * rowsize) - (rowsize - 1);
		// 해당 페이지에서 끝 글번호
		int endNo = (page * rowsize);

		try {
			openConn();

			sql = "select * from (select row_number() over(order by product_no desc) as rnum, b.* from sc_product b) "
					+ " where category_no = 11 and rnum >= ? and rnum <= ?";
			pstmt = con.prepareStatement(sql);

			pstmt.setInt(1, startNo);
			pstmt.setInt(2, endNo);

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
	} // getAllProductWomanOuter() 메서드 end

	// 여성 모든 리스트를 가져오는 메서드
	public List<ProductDTO> getAllProductWoman(int page, int rowsize) {
		List<ProductDTO> list = new ArrayList<ProductDTO>();
		
		// 해당 페이지에서 시작 글 번호
		int startNo = (page * rowsize) - (rowsize - 1);
		// 해당 페이지에서 끝 글번호
		int endNo = (page * rowsize);
		
		try {
			openConn();
			
			sql = "select * from (select row_number() over(order by product_no desc) as rnum, b.* from sc_product b) "
					+ " where category_no in (9,10, 11) and rnum >= ? and rnum <= ?";
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, startNo);
			pstmt.setInt(2, endNo);
			
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
