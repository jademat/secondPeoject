package com.hhlb.action;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.hhlb.controller.Action;
import com.hhlb.controller.ActionForward;
import com.hhlb.model.UserDAO;

public class UserUpdatePwdAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		  // 클라이언트로부터 받은 파라미터
        String userId = request.getParameter("user_id").trim();
        String newPassword = request.getParameter("newPassword").trim();
        
        // 비밀번호 업데이트 처리
        UserDAO dao = UserDAO.getInstance();
        int result = dao.updatePassword(userId, newPassword); // 영향 받은 행 수 반환
        
        // 결과에 따라 이동할 경로 설정
        ActionForward forward = new ActionForward();
        if (result > 0) {  // 1 이상의 값이 반환되면 성공
            forward.setPath("user/login.jsp"); // 로그인 페이지로 이동 (예시)
            forward.setRedirect(true);
        } else {  // 0이면 실패
            request.setAttribute("errorMessage", "비밀번호 변경에 실패했습니다.");
            forward.setPath("user/resetPwd.jsp"); // 다시 비밀번호 재설정 페이지로 이동
            forward.setRedirect(false);
        }
        return forward;

	}

}
