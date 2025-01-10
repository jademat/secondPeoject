package com.hhlb.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.hhlb.controller.Action;
import com.hhlb.controller.ActionForward;
import com.hhlb.model.UserDAO;
import com.hhlb.model.UserDTO;

public class UserLoginAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String user_id = request.getParameter("id");
		String user_pwd = request.getParameter("pwd");
			
		UserDAO dao = UserDAO.getInstance();
		
		int check = dao.userCheck(user_id,user_pwd);
		
		PrintWriter out = response.getWriter();
		
		ActionForward forward = new ActionForward();
		
		if(check > 0 ) {
			UserDTO cont = dao.getUser(user_id);
			
			HttpSession session = request.getSession();
			
			session.setAttribute("user_id", cont.getUser_id());
			session.setAttribute("user_pwd", cont.getUser_pwd());
			
			forward.setRedirect(true);
			forward.setPath("user_main.go");
			
		}else if(check == -1) {

			out.println("<script>");
			out.println("alert('비밀번호가 다릅니다')");
			out.println("history.back()");
			out.println("</script>");
		}else {
			// 회원이 아닌 경우
			out.println("<script>");
			out.println("alert('아이디가 없습니다.')");
			out.println("history.back()");
			out.println("</script>");
		}
		
		return forward;
	}

}
