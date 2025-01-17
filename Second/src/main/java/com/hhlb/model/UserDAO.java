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

public class UserDAO {
Connection con = null;
	
	PreparedStatement pstmt = null;

	ResultSet rs= null;
	
	String sql = null;

	private static UserDAO instance;
	
	private UserDAO() {  }  // 기본 생성자

	public static UserDAO getInstance() {
		
		if(instance == null) {
			instance = new UserDAO();
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
	

	// 입력받은 아이의 중복 여부를 체크하는 메서드.
	public int idCheck(String id) {
		
		int check = 0;
		
		
		try {
			openConn();
			
			sql = "select * from sc_user where user_id = ?";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				// 중복인 경우
				check = -1;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			
			closeConn(rs, pstmt, con);
		}
		return check;
	}

	public int insertUser(UserDTO dto) {

		int result = 0;
		
		try {
			
			
			openConn();
			
			sql="insert into sc_user values(?,?,?,?,?,?,?,?,?,sysdate)";
			
			pstmt= con.prepareStatement(sql);
			
			pstmt.setString(1, dto.getUser_id());
			pstmt.setString(2, dto.getUser_pwd());
			pstmt.setString(3, dto.getUser_name());
			pstmt.setString(4, dto.getUser_nick());
			pstmt.setString(5, dto.getUser_email());
			pstmt.setInt(6, dto.getUser_age());
			pstmt.setString(7, dto.getUser_gender());
			pstmt.setString(8, dto.getUser_phone());
			pstmt.setString(9, dto.getUser_addr());
			
			result = pstmt.executeUpdate();
	
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
		return result;
	}
	public int userCheck(String id, String pwd) {
		int result = 0;

		try {

			openConn();
			
			sql = "select * from sc_user where user_id = ?";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				if(pwd.equals(rs.getString("user_pwd"))) {
					result = 1;
				}else {
					result = -1;
				}
				
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
		return result;
	}
	
	public UserDTO getUser(String id) {
		UserDTO dto = null;
		
		try {
			openConn();
			
			sql = "select * from sc_user where user_id = ?";
		
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				dto = new UserDTO();
				
				dto.setUser_id(rs.getString("user_id"));
				dto.setUser_pwd(rs.getString("user_pwd"));
				dto.setUser_name(rs.getString("user_name"));
				dto.setUser_nick(rs.getString("user_nick"));
				dto.setUser_email(rs.getString("user_email"));
				dto.setUser_age(rs.getInt("user_age"));
				dto.setUser_gender(rs.getString("user_gender"));
				dto.setUser_phone(rs.getString("user_phone"));
				dto.setUser_addr(rs.getString("user_addr"));
				dto.setUser_date(rs.getString("user_date"));
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
		
		return dto;
	}
	
	public int updateUser(UserDTO dto) {
		int result = 0;
		
		try {
			openConn();
			
			sql = "update sc_user set user_nick = ?,user_email = ?, user_phone = ?, user_addr = ? where user_id = ?";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, dto.getUser_nick());
			pstmt.setString(2, dto.getUser_email());
			pstmt.setString(3, dto.getUser_phone());
			pstmt.setString(4, dto.getUser_addr());
			pstmt.setString(5, dto.getUser_id());
			
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeConn(pstmt, con);
		}
		return result;
	}

	public UserDTO findUser(String userName, String userId, String userEmail) {
		// db 에서 회원 정보 검색


	
		UserDTO dto = null;

		try {
			openConn();

			sql = "select * from sc_user where user_name=? and user_id=? and user_email=?";

			pstmt = con.prepareStatement(sql);

			pstmt.setString(1, userName);
			pstmt.setString(2, userId);
			pstmt.setString(3, userEmail);

			rs = pstmt.executeQuery();

			if (rs.next()) {

				dto = new UserDTO();

				dto.setUser_name(rs.getString("user_name"));
				dto.setUser_id(rs.getString("user_id"));
				dto.setUser_email(rs.getString("user_email"));

			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (con != null)
					con.close();
			} catch (SQLException e) {
			}
		}

		return dto; // 데이터가 없으면 null을 반환
	}

	public int updatePassword(String userId, String userNewPwd) {
	
		
		try {
			openConn();
			
			sql = "update sc_user set user_pwd=? where user_id=?";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, userNewPwd);
			pstmt.setString(2, userId);
			
			 
	        int result = pstmt.executeUpdate(); 
	        
	        return result; // 성공적으로 업데이트된 행 수 반환
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			
			closeConn(pstmt, con);
			
		}
		
			return 0;
	}

	public UserDTO findUserDetail(String userName, String userId, String userEmail) {
		
		UserDTO dto = null;
		
		try {
			
			openConn();
			
			sql = "select * from sc_user where user_name=? and user_id = ? and user_email = ?";
			
			pstmt= con.prepareStatement(sql);
			
			pstmt.setString(1, userName);
			pstmt.setString(2, userId);
			pstmt.setString(3, userEmail);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				
				dto = new UserDTO();
				
				dto.setUser_name(rs.getString("user_name"));
				dto.setUser_id(rs.getString("user_id"));
				dto.setUser_email(rs.getString("user_email"));
				
			}
		} catch (SQLException e) {
			 System.err.println("SQL 오류: " + e.getMessage());
		        e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
		
		return dto;
	}
	
	public int userDelete(String id) {
		int result = 0;
		
		try {
			openConn();
			
			sql = "delete from sc_user where user_id = ?";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeConn(pstmt, con);
		}
		return result;
	}
	
	// 회원 전체 리스트 -- hm
		public List<UserDTO> getUserList() {
			
			List<UserDTO> userlist = new ArrayList<UserDTO>();
			
			
			try {
				openConn();
				
				sql = "SELECT * FROM sc_user";
				
				pstmt = con.prepareStatement(sql);
				
				rs = pstmt.executeQuery();
				
				while (rs.next()) {
					UserDTO dto = new UserDTO();
					
					dto.setUser_id(rs.getString("user_id"));
					dto.setUser_pwd(rs.getString("user_pwd"));
					dto.setUser_name(rs.getString("user_name"));
					dto.setUser_nick(rs.getString("user_nick"));
					dto.setUser_email(rs.getString("user_email"));
					dto.setUser_age(rs.getInt("user_age"));
					dto.setUser_gender(rs.getString("user_gender"));
					dto.setUser_addr(rs.getString("user_addr"));
					dto.setUser_date(rs.getString("user_date"));
					
					userlist.add(dto);
				}
				
				
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}finally {
				closeConn(rs, pstmt, con);
			}
		
			return userlist;
		}

		// userId로 해당 회원 데이터 조회 -- hm
		public UserDTO getUserById(String userId) {
			
			UserDTO user = null;
			
			try {
				openConn();
				
				sql = "SELECT * FROM SC_USER WHERE USER_ID = ?";
				
				pstmt = con.prepareStatement(sql);
				
				pstmt.setString(1, userId);
				
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
					user = new UserDTO();
					user.setUser_id(rs.getString("USER_NAME"));
					user.setUser_name(rs.getString("USER_NAME"));
					user.setUser_nick(rs.getString("USER_NICK"));
					user.setUser_email(rs.getString("USER_EMAIL"));
					user.setUser_age(rs.getInt("USER_AGE"));
					user.setUser_gender(rs.getString("USER_GENDER"));
					user.setUser_phone(rs.getString("USER_PHONE"));
					user.setUser_addr(rs.getString("USER_ADDR"));
					user.setUser_date(rs.getString("USER_DATE"));
					
				}
				
				
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}finally {
				closeConn(rs, pstmt, con);
			}
			
			
			return user;
		}

		// userId로 해당 회원 삭제 -- hm
		public boolean deleteUserById(String userId) {
			
			boolean result = false;
	        
			try {
	            openConn();
	            
	            sql = "DELETE FROM SC_USER WHERE USER_ID = ?";
	            
	            pstmt = con.prepareStatement(sql);
	            
	            pstmt.setString(1, userId);

	            int chk = pstmt.executeUpdate();
	            
	            if (chk > 0) {
	                result = true; // 삭제 성공
	            }
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }finally {
	            closeConn(pstmt, con);
	        }
	        
	        return result;
	    }
	
	
}