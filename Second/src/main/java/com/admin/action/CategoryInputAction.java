package com.admin.action;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.hhlb.controller.Action;
import com.hhlb.controller.ActionForward;

public class CategoryInputAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// 카테고리 입력 화면으로 포워딩
        ActionForward forward = new ActionForward();
        forward.setRedirect(false);
        forward.setPath("/admin/category_input.jsp");  // 카테고리 입력 화면 JSP로 포워딩
        
        return forward;
	}

}
