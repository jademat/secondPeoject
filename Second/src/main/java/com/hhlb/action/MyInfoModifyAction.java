package com.hhlb.action;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.hhlb.controller.Action;
import com.hhlb.controller.ActionForward;
import com.hhlb.model.UserDAO;
import com.hhlb.model.UserDTO;

public class MyInfoModifyAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String user_id = (String) request.getSession().getAttribute("user_id");
		
		UserDAO dao = UserDAO.getInstance();
		
		UserDTO uCont = dao.getUser(user_id);
		
		request.setAttribute("Modify", uCont);
		
        // ActionForward 객체 생성 후, 포워딩할 경로 설정
        ActionForward forward = new ActionForward();
        forward.setPath("user/myInfoModify.jsp");  // 포워딩할 JSP 경로
        forward.setRedirect(false);  // 내부 포워딩 설정
        return forward;
	}
}
