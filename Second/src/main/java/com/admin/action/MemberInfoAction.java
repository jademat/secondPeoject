package com.admin.action;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.hhlb.controller.Action;
import com.hhlb.controller.ActionForward;
import com.hhlb.model.UserDAO;
import com.hhlb.model.UserDTO;

public class MemberInfoAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		String userId = request.getParameter("UserId");
		
		System.out.println("userId >>> " + userId);	// 확인용ㅇ
		
		UserDAO dao = UserDAO.getInstance();
		
		UserDTO info = dao.getUserById(userId);
		
		request.setAttribute("user", info);
		
		// System.out.println("info >>> " + info);
		
		ActionForward forward = new ActionForward();
		
		forward.setRedirect(false);
		forward.setPath("admin/member_info.jsp");
		
		
		return forward;
	}

}
