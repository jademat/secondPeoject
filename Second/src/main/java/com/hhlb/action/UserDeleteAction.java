package com.hhlb.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.hhlb.controller.Action;
import com.hhlb.controller.ActionForward;
import com.hhlb.model.UserDAO;

public class UserDeleteAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {

		String user_id = (String) request.getSession().getAttribute("user_id");

		UserDAO dao = UserDAO.getInstance();

		int chk = dao.userDelete(user_id);

		PrintWriter out = response.getWriter();

		if (chk > 0) {

			request.getSession().invalidate();
			
			out.println("<script>");
			out.println("alert('회원 삭제 완료')");
			out.println("location.href='user_main.go'");
			out.println("</script>");
		} else {
			out.println("<script>");
			out.println("alert('회원 삭제 실패')");
			out.println("history.back()");
			out.println("</script>");
		}

		return null;
	}

}
