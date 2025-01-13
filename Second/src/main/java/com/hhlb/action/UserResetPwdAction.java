package com.hhlb.action;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.hhlb.controller.Action;
import com.hhlb.controller.ActionForward;
import com.hhlb.model.UserDAO;
import com.hhlb.model.UserDTO;

public class UserResetPwdAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {

		String userName = request.getParameter("user_name").trim();
		String userId = request.getParameter("user_id").trim();
		String userEmail = request.getParameter("user_email").trim();
		
		// 입력 값 검증
        if (userName.isEmpty() || userId.isEmpty() || userEmail.isEmpty()) {
            request.setAttribute("errorMessage", "모든 필드를 입력해야 합니다.");
            ActionForward forward = new ActionForward();
            forward.setPath("user/resetPwd.jsp");
            forward.setRedirect(false);
            return forward;
        }
        
        // db 에서 정보 조회 
		UserDAO dao = UserDAO.getInstance();
		UserDTO user = dao.findUser(userName , userId, userEmail);
		
		if (user != null) {
		    request.setAttribute("user_id", user.getUser_id()); // 사용자 아이디 전달
		    ActionForward forward = new ActionForward();
		    forward.setPath("user/resetPwd.jsp"); // 상대 경로로 수정
		    forward.setRedirect(false); // 포워딩 방식으로 변경
		    return forward;
		} else {
		    // 로그 작성
			   System.out.println("사용자 정보를 찾을 수 없습니다. 입력 값: " + userName + ", " + userId + ", " + userEmail);

			   request.setAttribute("errorMessage", "사용자 정보를 찾을 수 없습니다."); 
			   
	            ActionForward forward = new ActionForward();
	            forward.setPath("user/findmyPwd.jsp"); // 다시 비밀번호 찾기 페이지로
	            forward.setRedirect(false);
	            return forward;
	        }
	    }
	}
