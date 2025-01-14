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

	public List<BoardDTO> getBoardList(int page, int rowsize, String type) {
		List<BoardDTO> list = new ArrayList<BoardDTO>();

		// 해당 페이지에서 시작 글번호
		int startNo = (page * rowsize) - (rowsize - 1);

		// 해당 페이지에서 끝 글번호
		int endNo = (page * rowsize);
		try {
			openConn();
			
			sql = "select * from (select row_number() over (order by board_no desc) as rnum, b.* from sc_board b ";

			if (type.equals("all")) {
				sql += ")";

			} else if (type.equals("notice")) {
				sql += " where board_type = ?)";
			} else if (type.equals("exchange")) {
				sql += " where board_type = ?)";
			} else if (type.equals("refund")) {
				sql += " where board_type = ?)";
			} else if (type.equals("inquiry")) {
				sql += " where board_type = ?)";
			}
//			sql = "select * from" + "(select row_number() over (order by board_no desc) as rnum, b.* from sc_board b where board_type = ?)"
//					+ " where rnum >= ? and rnum <= ?";
			
			sql += "where rnum >= ? and rnum <= ?";

			pstmt = con.prepareStatement(sql);
			
			if(type.equals("notice")|| type.equals("exchange") || type.equals("refund") || type.equals("inquiry")) {
				pstmt.setString(1, type);
				pstmt.setInt(2, startNo);
				pstmt.setInt(3, endNo);
			}else {
				pstmt.setInt(1, startNo);
				pstmt.setInt(2, endNo);
			}
			
			rs = pstmt.executeQuery();

			while (rs.next()) {
				BoardDTO dto = new BoardDTO();

				dto.setBoard_no(rs.getInt("board_no"));
				dto.setUser_id(rs.getString("user_id"));
				dto.setBoard_title(rs.getString("board_title"));
				dto.setBoard_cont(rs.getString("board_title"));
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

	public int insertBoard(BoardDTO dto) {
		int result = 0, count = 0;

		try {
			openConn();

			sql = "select max(board_no) from sc_board";

			pstmt = con.prepareStatement(sql);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				count = rs.getInt(1);
			}

			sql = "insert into sc_board values(?,?,?,?,sysdate,'','',default,?,?)";

			pstmt = con.prepareStatement(sql);

			pstmt.setInt(1, count + 1);
			pstmt.setString(2, dto.getUser_id());
			pstmt.setString(3, dto.getBoard_title());
			pstmt.setString(4, dto.getBoard_cont());
			pstmt.setString(5, dto.getBoard_type());
			pstmt.setInt(6, dto.getBoard_visible());

			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
		return result;
	}

	public List<BoardDTO> getBoardType(String type) {
		List<BoardDTO> blist = new ArrayList<BoardDTO>();

		try {
			openConn();

			sql = "select * from sc_board where board_type = ? order by board_no desc";

			pstmt = con.prepareStatement(sql);

			pstmt.setString(1, type);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				BoardDTO dto = new BoardDTO();

				dto.setBoard_no(rs.getInt("board_no"));
				dto.setUser_id(rs.getString("user_id"));
				dto.setBoard_title(rs.getString("board_title"));
				dto.setBoard_cont(rs.getString("board_cont"));
				dto.setBoard_date(rs.getString("board_date"));
				dto.setBoard_update(rs.getString("board_update"));
				dto.setBoard_hit(rs.getInt("board_hit"));
				dto.setBoard_type(rs.getString("board_type"));
				dto.setBoard_visible(rs.getInt("board_visible"));

				blist.add(dto);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
		return blist;
	}

	public int deleteBoard(int no) {
		int result = 0;

		try {
			openConn();

			sql = "delete from sc_board where board_no = ?";

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

	public void updateSequence(int no) {
		try {
			openConn();

			sql = "update sc_board set board_no = board_no - 1 where board_no > ?";

			pstmt = con.prepareStatement(sql);

			pstmt.setInt(1, no);

			pstmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeConn(pstmt, con);
		}
	}

	public int getBoardCount(String type) {
		int count = 0;

		try {
			openConn();

			if (type.equals("all")) {
				sql = "select count(*) from sc_board";
			} else if (type.equals("notice")) {
				sql = "select count(*) from sc_board where board_type = ?";
			} else if (type.equals("exchange")) {
				sql = "select count(*) from sc_board where board_type = ?";
			} else if (type.equals("refund")) {
				sql = "select count(*) from sc_board where board_type = ?";
			} else if (type.equals("inquiry")) {
				sql = "select count(*) from sc_board where board_type = ?";
			}


			pstmt = con.prepareStatement(sql);
			if(type.equals("notice")|| type.equals("exchange") || type.equals("refund") || type.equals("inquiry")) {
				pstmt.setString(1, type);
			}
			rs = pstmt.executeQuery();

			if (rs.next()) {
				count = rs.getInt(1);
			}
			
			System.out.println("count >>> " + count);
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}

		return count;
	}
}
