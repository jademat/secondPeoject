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

public class CategoryDAO {

    // DB와 연결하는 객체
    private Connection con = null;

    // DB에 SQL문을 전송하는 객체.
    private PreparedStatement pstmt = null;

    // SQL문을 실행한 후에 결과값을 가지고 있는 객체.
    private ResultSet rs = null;

    // SQL문을 저장할 변수.
    private String sql = null;

    // CategoryDAO 클래스를 싱글턴 방식으로 만들어 보자.
    private static CategoryDAO instance = null;

    private CategoryDAO() {
    } // 기본 생성자

    public static CategoryDAO getInstance() {
        if (instance == null) { // 인스턴스가 없다면 새로 생성
            instance = new CategoryDAO();
        }
        return instance; // 이미 존재하는 인스턴스를 반환
    }

    // DB 연동 작업을 하는 메서드.
    private void openConn() {
        try {
            Context init = new InitialContext();
            Context ctx = (Context) init.lookup("java:comp/env");
            DataSource ds = (DataSource) ctx.lookup("jdbc/myoracle");
            con = ds.getConnection();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // DB에 연결되어 있던 자원 종료하기.
    private void closeConn(ResultSet rs, PreparedStatement pstmt, Connection con) {
        try {
            if (rs != null) {
                rs.close();
            }
            if (pstmt != null) {
                pstmt.close();
            }
            if (con != null) {
                con.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // DB에 연결되어 있던 자원 종료하기.
    private void closeConn(PreparedStatement pstmt, Connection con) {
        try {
            if (pstmt != null) {
                pstmt.close();
            }
            if (con != null) {
                con.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // 카테고리 목록을 가져오는 메서드
    public List<CategoryDTO> getCategoryList() {
        List<CategoryDTO> categoryList = new ArrayList<>();

        try {
            openConn();

            // 카테고리 리스트 조회 SQL문 작성 (카테고리 번호 포함)
            sql = "SELECT * FROM SC_CATEGORY";
            pstmt = con.prepareStatement(sql);

            // SQL 실행
            rs = pstmt.executeQuery();

            // 결과 처리
            while (rs.next()) {
                CategoryDTO category = new CategoryDTO();
                category.setCategory_no(rs.getInt("CATEGORY_NO"));
                category.setCategory_code(rs.getString("CATEGORY_CODE"));
                category.setCategory_name(rs.getString("CATEGORY_NAME"));

                categoryList.add(category);
            }
            
         // 디버깅을 위한 로그 추가
            System.out.println("Fetched " + categoryList.size() + " categories.");
            
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("Error during database operation: " + e.getMessage());
        } finally {
            closeConn(rs, pstmt, con);
        }

        return categoryList;
    }

    // 카테고리 추가 메서드
    public boolean insertCategory(CategoryDTO category) {
        boolean result = false;
        int count = 0;

        try {
            openConn();

            sql = "select max(category_no) from sc_category";
            
            pstmt = con.prepareStatement(sql);
            
            rs = pstmt.executeQuery();
            
            if(rs.next()) {
            	
            	count = rs.getInt(1);
            }
            
            // 카테고리 삽입 SQL문 작성
            sql = "INSERT INTO SC_CATEGORY(CATEGORY_NO, CATEGORY_CODE, CATEGORY_NAME) VALUES(?, ?, ?)";
            pstmt = con.prepareStatement(sql);

            // ?에 값 설정
            pstmt.setInt(1, count + 1);
            pstmt.setString(2, category.getCategory_code());
            pstmt.setString(3, category.getCategory_name());

            // SQL 실행
            int rowsAffected = pstmt.executeUpdate();
            if (rowsAffected > 0) {
                result = true;  // 성공
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeConn(rs, pstmt, con);
        }

        return result;
    }

    // 카테고리 코드 생성 로직
    public String generateCategoryCode(String categoryGender, String categoryName) {
        
    	String codePrefix = "";

        // 성별에 따른 접두사
        if ("남성".equals(categoryGender)) {
            codePrefix = "e100";  // 남성 카테고리
        } else if ("여성".equals(categoryGender)) {
            codePrefix = "e200";  // 여성 카테고리
        }

        // 카테고리 이름에 따른 구체적인 코드 생성
        String categoryCodeSuffix = "";
        if (categoryName.contains("상의")) {
            categoryCodeSuffix = "1";  // 상의
        } else if (categoryName.contains("하의")) {
            categoryCodeSuffix = "2";  // 하의
        } else if (categoryName.contains("아우터")) {
            categoryCodeSuffix = "3";  // 아우터
        }

        // 전체 카테고리 코드 반환
        return codePrefix + categoryCodeSuffix;
    }

    // 카테고리 수정메서드
    public int updateCategory(CategoryDTO category) {
        int result = 0;

        try {
            openConn();

            // 카테고리 수정 SQL문 작성
            sql = "UPDATE SC_CATEGORY SET CATEGORY_NAME = ? WHERE CATEGORY_NO = ?";
            pstmt = con.prepareStatement(sql);

            // ?에 값 설정
            pstmt.setString(1, category.getCategory_name());
            pstmt.setInt(2, category.getCategory_no());

            // SQL 실행
            result = pstmt.executeUpdate();  // 수정된 레코드 수 반환
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeConn(pstmt, con);
        }

        return result;  // 성공 시 1   실패 시 0 반환
    
    }
   
    
 // CategoryDAO 클래스에 카테고리 번호에 해당하는 카테고리 정보를 가져오는 메서드 추가
	/*
	 * public CategoryDTO getCategoryByNo(int categoryNo) {
	 * 
	 * CategoryDTO category = null;
	 * 
	 * try { openConn();
	 * 
	 * // 카테고리 번호로 카테고리 정보 조회 SQL문 작성 sql =
	 * "SELECT * FROM SC_CATEGORY WHERE CATEGORY_NO = ?"; pstmt =
	 * con.prepareStatement(sql); pstmt.setInt(1, categoryNo); // 카테고리 번호를 ?에 설정
	 * 
	 * rs = pstmt.executeQuery(); // 결과 실행
	 * 
	 * // 결과 처리 if (rs.next()) { category = new CategoryDTO();
	 * category.setCategory_no(rs.getInt("CATEGORY_NO"));
	 * category.setCategory_code(rs.getString("CATEGORY_CODE"));
	 * category.setCategory_name(rs.getString("CATEGORY_NAME")); } } catch
	 * (SQLException e) { e.printStackTrace(); } finally { closeConn(rs, pstmt,
	 * con); }
	 * 
	 * return category; // 카테고리 정보 반환 }
	 */
    
    
    
}
