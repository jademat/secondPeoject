package com.hhlb.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;



public class AdminDAO {

	
	// DB와 연동하는 객체.
		Connection con = null;
		
		// DB에 SQL문을 전송하는 객체.
		PreparedStatement pstmt = null;
		
		// SQL문을 실행한 후에 결과 값을 가지고 있는 객체.
		ResultSet rs, rs1 = null;
		
		// 쿼리문을 저장할 변수
		String sql = null;
		
		
		// AdminDAO 클래스를 싱글턴 방식으로 만들어 보자.
		// 1단계 : 싱글턴 방식을 객체를 만들기 위해서는 우선적으로
		//        기본생성자의 접근제어자를 public 이 아니라
		//        private 으로 바꾸어 주어야 한다.
		//        즉, 외부에서는 직접적으로 기본생성자를 호출하지
		//        못하게 하는 방식이다.
		
		// 2단계 : AdminDAO 클래스를 정적(static) 멤버로 s
		//        선언을 해 주어야 한다.
		private static AdminDAO instance;
		
		private AdminDAO() {  }  // 기본 생성자
		
		// 3단계 : 기본생성자 대신에 싱글턴 객체를 return 해 주는
		//        getInstance() 메서드를 만들어서 해당 
		//        getInstance() 메서드를 외부에서 접근할 수 있도록
		//        해 주면 됨.
		public static AdminDAO getInstance() {
			
			if(instance == null) {
				instance = new AdminDAO();
			}
			
			return instance;
		}  // getInstance() 메서드 end
		
		
		
		// DB를 연동하는 작업을 진행하는 메서드.
		public void openConn() {
			
			try {
				// 1단계 : JNDI 서버 객체 생성
				// 자바의 네이밍 서비스(JNDI)애서 이름과 실제 객체를
				// 연결해 주는 개념이 Context 객체이며, InitialContext
				// 객체는 네이밍 서비스를 이용하기 위한 시작점이 됨.
				Context initCtx = new InitialContext();
				
				// 2단계 : Context 객체를 얻어와야 함.
				// "java:comp/env" 라는 이름의 인수로 Context 객체를
				// 얻어옴. "java:comp/env"는 현재 웹 애플리케이션에서
				// 네이밍 서비스를 이용 시 루트 디렉토리라고 생각하면 됨.
				// 즉, 현재 웹 애플리케이션이 사용할 수 있는 모든 자원은
				// "java:comp/env" 아래에 위치를 하게 됨.
				Context ctx = 
					(Context)initCtx.lookup("java:comp/env");
				
				// 3단계 : lookup() 메서드를 이용하여 매칭되는 커넥션을
				//        찾게 됨.
				// "java:comp/env" 아래에 위치한 "jdbc/myoracle"
				// 자원을 얻어옴, 이자원이 바로 데이터소스(커넥션풀)임.
				// 여기서 "jdbc/myoracle" 은 context.xml 파일에
				// 추가했던 <Resource> 태그 안에 있던 name 속성의 값임.
				DataSource ds = 
						(DataSource)ctx.lookup("jdbc/myoracle");
				
				// 4단계 : DataSource 객체를 이용하여 커넥션을
				//        하나 가져온다.
				con = ds.getConnection();
				
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
		}  // openConn() 메서드 end
			
		
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
}
