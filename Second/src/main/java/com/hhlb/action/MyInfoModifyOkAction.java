package com.hhlb.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.hhlb.controller.Action;
import com.hhlb.controller.ActionForward;
import com.hhlb.model.UserDAO;
import com.hhlb.model.UserDTO;

public class MyInfoModifyOkAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {

		String user_id = (String) request.getSession().getAttribute("user_id");
		String user_name = request.getParameter("user_name");
		String user_nick = request.getParameter("user_nick");
		String user_email = request.getParameter("user_email");
		String user_phone = request.getParameter("user_phone");
		String user_addr = request.getParameter("user_addr");
		
		UserDTO dto = new UserDTO();
		
		dto.setUser_id(user_id);
		dto.setUser_name(user_name);
		dto.setUser_nick(user_nick);
		dto.setUser_email(user_email);
		dto.setUser_phone(user_phone);
		dto.setUser_addr(user_addr);
		
		UserDAO dao = UserDAO.getInstance();
		
		int chk = dao.updateUser(dto);
		
		PrintWriter out = response.getWriter();
		
		if(chk > 0) {
			out.println("<script>");
			out.println("alert('개인정보수정 완료')");
			out.println("location.href='user_myInfo.go?id=" + user_id + "';");
			out.println("</script>");
		}else {
			out.println("<script>");
			out.println("alert('개인정보수정 실패')");
			out.println("history.back()");
			out.println("</script>");
			
		}
		return null;
	}

}
