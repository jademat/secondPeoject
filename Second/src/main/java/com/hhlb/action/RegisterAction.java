package com.hhlb.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.hhlb.controller.Action;
import com.hhlb.controller.ActionForward;
import com.hhlb.model.BoardDAO;
import com.hhlb.model.UserDAO;
import com.hhlb.model.UserDTO;

public class RegisterAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException  {
		// 회원가입 할 때 받은 정보 받기 
		
		   // 회원가입 할 때 받은 정보 받기
        String user_name = request.getParameter("user_name").trim();
        String user_nick = request.getParameter("user_nick").trim();
        String user_id = request.getParameter("user_id").trim();
        String user_pwd = request.getParameter("user_pwd").trim();
        String user_email = request.getParameter("user_email").trim();
        int user_age = Integer.parseInt(request.getParameter("user_age"));
        String user_phone = request.getParameter("user_phone").trim();
        String user_addr = request.getParameter("user_address").trim();
        String user_gender = request.getParameter("user_gender").trim();

            // 특수문자 패턴 정의
            String specialCharPattern = ".*[!@#$%^&*(),.?\":{}|<>].*";
            
            // 출력 
            PrintWriter out = response.getWriter();
            
            ActionForward forward = new ActionForward();
            
            // 특수문자가 없는 경우 1 출력
            if (!user_pwd.matches(specialCharPattern)) {
            	// 특수문자가 비밀번호에 포함되어 있지 않은 경우 block
            	out.println("<script>");
                out.println("alert('회원가입에 실패했습니다.')");
                out.println("history.back()");
                out.println("</script>");
                
              return null;
            }

        
        UserDTO dto = new UserDTO();

        dto.setUser_name(user_name);
        dto.setUser_nick(user_nick);
        dto.setUser_id(user_id);
        dto.setUser_pwd(user_pwd);
        dto.setUser_email(user_email);
        dto.setUser_age(user_age);
        dto.setUser_phone(user_phone);
        dto.setUser_addr(user_addr);
        dto.setUser_gender(user_gender);

        UserDAO dao = UserDAO.getInstance();

        int chk = dao.insertUser(dto);


        if (chk > 0) {
            out.println("<script>");
            out.println("alert('회원가입이 완료 됐습니다.')");
            out.println("location.href='product/main.jsp;'");
            out.println("</script>");
        } else {
            out.println("<script>");
            out.println("alert('회원가입에 실패했습니다.')");
            out.println("history.back()");
            out.println("</script>");
        }

        // 메서드가 항상 반환값을 가지도록 수정
        return null;
    }
}