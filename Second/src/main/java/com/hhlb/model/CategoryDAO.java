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

    // 카테고리 정보를 DB에 삽입하는 메서드
    public boolean insertCategory(String categoryName, String categoryCode, String categoryGender) {
        boolean success = false;

        try {
            openConn();

            // 현재 가장 큰 category_no 값을 찾는 SQL문
            sql = "SELECT MAX(category_no) FROM sc_category";
            pstmt = con.prepareStatement(sql);
            rs = pstmt.executeQuery();

            int categoryNo = 1; // 기본값 설정
            if (rs.next()) {
                categoryNo = rs.getInt(1) + 1;  // 가장 큰 category_no에 1을 더한 값
            }

            // 카테고리 정보를 DB에 삽입하는 SQL문
            sql = "INSERT INTO sc_category (category_no, category_name, category_code, category_gender) VALUES (?, ?, ?, ?)";
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, categoryNo);  // 자동 증가된 category_no 값
            pstmt.setString(2, categoryName);  // 카테고리 이름
            pstmt.setString(3, categoryCode);  // 카테고리 코드
            pstmt.setString(4, categoryGender);  // 성별

            // SQL 실행
            int chk = pstmt.executeUpdate();
            if (chk > 0) {
                success = true;  // 성공적으로 저장된 경우
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeConn(rs, pstmt, con);
        }

        return success;
    }

    // 기존 카테고리 코드 목록을 가져오는 메서드
    public List<String> getCategoryCodes() {
        List<String> categoryCodes = new ArrayList<>();
        try {
            openConn();

            // 카테고리 코드 목록을 가져오는 SQL문
            sql = "SELECT category_code FROM sc_category ORDER BY category_code";
            pstmt = con.prepareStatement(sql);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                categoryCodes.add(rs.getString("category_code"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeConn(rs, pstmt, con);
        }

        return categoryCodes;
    }

    // 전체 카테고리 리스트를 가져오는 메서드
    public List<CategoryDTO> getCategoryList() {
        List<CategoryDTO> categoryList = new ArrayList<CategoryDTO>();

        try {
            openConn();

            // 전체 카테고리 리스트를 가져오는 SQL문
            sql = "SELECT * FROM SC_CATEGORY ORDER BY CATEGORY_NO ASC";
            pstmt = con.prepareStatement(sql);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                CategoryDTO category = new CategoryDTO();
                category.setCategory_no(rs.getInt("CATEGORY_NO"));
                category.setCategory_code(rs.getString("CATEGORY_CODE"));
                category.setCategory_name(rs.getString("CATEGORY_NAME"));
                category.setCategory_gender(rs.getString("CATEGORY_GENDER"));

                categoryList.add(category);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeConn(rs, pstmt, con);
        }

        return categoryList;  // 전체 카테고리 리스트 반환
    }

    // 카테고리 수정 메서드
    public int updateCategory(CategoryDTO category) {
        int result = 0;

        try {
            openConn();

            // 카테고리 수정 SQL문 작성
            sql = "UPDATE SC_CATEGORY SET CATEGORY_NAME = ? WHERE CATEGORY_NO = ?";
            pstmt = con.prepareStatement(sql);

            pstmt.setString(1, category.getCategory_name());
            pstmt.setInt(2, category.getCategory_no());

            result = pstmt.executeUpdate();  // 수정된 레코드 수 반환
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeConn(pstmt, con);
        }

        return result;
    }

    // 카테고리 삭제 메서드
    public int deleteCategory(int category_no) {
        int result = 0;

        try {
            openConn();

            sql = "SELECT COUNT(*) FROM SC_CATEGORY WHERE CATEGORY_NO = ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, category_no);
            rs = pstmt.executeQuery();

            if (rs.next() && rs.getInt(1) > 0) {
                // 카테고리가 존재하는 경우에만 삭제
                sql = "DELETE FROM SC_CATEGORY WHERE CATEGORY_NO = ?";
                pstmt = con.prepareStatement(sql);
                pstmt.setInt(1, category_no);
                result = pstmt.executeUpdate();
            } else {
                result = 0;  // 카테고리가 존재하지 않음
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeConn(pstmt, con);
        }

        return result;  // 성공 시 1, 실패 시 0 반환
    }
    
    
}

