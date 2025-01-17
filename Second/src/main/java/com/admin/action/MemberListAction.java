package com.admin.action;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.hhlb.controller.Action;
import com.hhlb.controller.ActionForward;
import com.hhlb.model.UserDAO;
import com.hhlb.model.UserDTO;

public class MemberListAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		UserDAO dao = UserDAO.getInstance();
		
		// 회원 목록 조회
		List<UserDTO> userList = dao.getUserList();
		
		System.out.println("userList >>> " + userList);	// 테스트
		
		// 조회된 화원 request에 저장
		request.setAttribute("userList", userList);
		
		ActionForward forward = new ActionForward();
		forward.setRedirect(false);
		forward.setPath("admin/member_list.jsp");
		
		
		return forward;
	}

}
