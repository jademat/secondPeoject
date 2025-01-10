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

public class BoardDAO {

	Connection con = null;

	PreparedStatement pstmt = null;

	ResultSet rs, rs1 = null;

	String sql = null;

	private static BoardDAO instance;

	private BoardDAO() {
	} // 기본 생성자

	public static BoardDAO getInstance() {

		if (instance == null) {
			instance = new BoardDAO();
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

	public List<BoardDTO> getBoard(String id) {

		List<BoardDTO> list = new ArrayList<BoardDTO>();

		try {

			openConn();

			sql = "select * from sc_board where user_id = ?";

			pstmt = con.prepareStatement(sql);

			pstmt.setString(1, id);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				BoardDTO dto = new BoardDTO();

				dto.setBoard_no(rs.getInt("board_no"));
				dto.setUser_id(rs.getString("user_id"));
				dto.setBoard_title(rs.getString("board_title"));
				dto.setBoard_cont(rs.getString("board_title"));
				dto.setBoard_pwd(rs.getString("board_pwd"));
				dto.setBoard_date(rs.getString("board_date"));
				dto.setBoard_update(rs.getString("board_update"));
				dto.setBoard_hit(rs.getInt("board_hit"));
				dto.setBoard_type(rs.getString("board_type"));
				dto.setBoard_visible(rs.getInt("board_visible"));

				list.add(dto);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
		return list;
	}

	public List<BoardDTO> getBoardList() {
		List<BoardDTO> list = new ArrayList<BoardDTO>();

		try {
			openConn();

			sql = "select * from sc_board order by board_no desc";

			pstmt = con.prepareStatement(sql);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				BoardDTO dto = new BoardDTO();

				dto.setBoard_no(rs.getInt("board_no"));
				dto.setUser_id(rs.getString("user_id"));
				dto.setBoard_title(rs.getString("board_title"));
				dto.setBoard_cont(rs.getString("board_title"));
				dto.setBoard_pwd(rs.getString("board_pwd"));
				dto.setBoard_date(rs.getString("board_date"));
				dto.setBoard_update(rs.getString("board_update"));
				dto.setBoard_hit(rs.getInt("board_hit"));
				dto.setBoard_type(rs.getString("board_type"));
				dto.setBoard_visible(rs.getInt("board_visible"));
				
				list.add(dto);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
		return list;
	}

	public BoardDTO getBoardDetail(int no) {
		BoardDTO dto = null;

		try {
			openConn();

			sql = "select * from sc_board where board_no = ?";

			pstmt = con.prepareStatement(sql);

			pstmt.setInt(1, no);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				dto = new BoardDTO();

				dto.setBoard_no(rs.getInt("board_no"));
				dto.setUser_id(rs.getString("user_id"));
				dto.setBoard_title(rs.getString("board_title"));
				dto.setBoard_cont(rs.getString("board_cont"));
				dto.setBoard_pwd(rs.getString("board_pwd"));
				dto.setBoard_date(rs.getString("board_date"));
				dto.setBoard_update(rs.getString("board_update"));
				dto.setBoard_hit(rs.getInt("board_hit"));
				dto.setBoard_type(rs.getString("board_type"));
				dto.setBoard_visible(rs.getInt("board_visible"));
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
		return dto;
	}

}
