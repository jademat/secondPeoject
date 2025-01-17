package com.admin.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.hhlb.controller.Action;
import com.hhlb.controller.ActionForward;
import com.hhlb.model.UserDAO;

public class MemberDeleteAction implements Action {

    @Override
    public ActionForward execute(HttpServletRequest request, HttpServletResponse response) {
        
        // URL에서 userId를 받아옵니다.
        String userId = request.getParameter("userId");
        
        // UserDAO 객체 생성
        UserDAO dao = UserDAO.getInstance();
        
        // 해당 userId를 사용하여 사용자 삭제
        boolean result = dao.deleteUserById(userId);
        
        ActionForward forward = new ActionForward();
        
        if (result) {
            // 삭제 성공 후 성공 메시지를 request에 담습니다.
            request.setAttribute("message", "삭제되었습니다.");
            
            // 회원 목록 페이지로 리다이렉트
            forward.setRedirect(false);
            forward.setPath("/admin/member_list.jsp");
        } else {
            // 실패 시 실패 메시지를 request에 담습니다.
            request.setAttribute("message", "삭제 실패. 다시 시도해주세요.");
            
            // 상세 페이지로 리다이렉트
            forward.setRedirect(false);
            forward.setPath("/admin/member_info.jsp");
        }
        
        return forward;
    }
}
