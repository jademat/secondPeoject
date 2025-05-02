package com.admin.action;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.hhlb.controller.Action;
import com.hhlb.controller.ActionForward;
import com.hhlb.model.AdminDAO;
import com.hhlb.model.AdminDTO;

public class AdminInfoAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		
		AdminDAO dao = AdminDAO.getInstance();
		
		List<AdminDTO> adminList = dao.getAdminList();
        
        // 조회한 관리자 목록을 request에 저장
        request.setAttribute("adminList", adminList);

        // 포워딩할 뷰 페이지 설정
        ActionForward forward = new ActionForward();
        forward.setPath("admin/admin_info.jsp");
        forward.setRedirect(false);

        return forward;
	}

}
