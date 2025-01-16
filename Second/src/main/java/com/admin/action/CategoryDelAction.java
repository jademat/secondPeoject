package com.admin.action;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.hhlb.controller.Action;
import com.hhlb.controller.ActionForward;
import com.hhlb.model.CategoryDAO;
import com.hhlb.model.CategoryDTO;

public class CategoryDelAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// 1. 카테고리 목록을 가져와서 화면에 출력하기 위해 CategoryDAO 사용
        CategoryDAO dao = CategoryDAO.getInstance();
        
        List<CategoryDTO> list = dao.getCategoryList();

        // 2. 카테고리 목록을 request 속성에 저장
        request.setAttribute("cList", list);

        // 3. 삭제 페이지로 이동
        ActionForward forward = new ActionForward();
        
        forward.setRedirect(false); // 포워딩 방식
        
        forward.setPath("admin/category_delete.jsp");

        return forward;
	}

}
