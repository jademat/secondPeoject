package com.admin.action;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.hhlb.controller.Action;
import com.hhlb.controller.ActionForward;
import com.hhlb.model.AdminDAO;

public class AdminNickModifyAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		String adminId = request.getParameter("adminId");
        String newNickname = request.getParameter("newNickname");
		
        
        AdminDAO dao = AdminDAO.getInstance();
        
        boolean isUpdated = dao.updateAdminNickname(adminId, newNickname);
        
        // 응답 처리 (성공 여부를 텍스트로 반환)
        response.setContentType("text/plain; charset=UTF-8");
        if (isUpdated) {
            response.getWriter().write("success");
        } else {
            response.getWriter().write("fail");
        }

        return null;
    }
}
