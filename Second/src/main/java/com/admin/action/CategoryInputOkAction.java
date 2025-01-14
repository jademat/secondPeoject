package com.admin.action;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.hhlb.controller.Action;
import com.hhlb.controller.ActionForward;
import com.hhlb.model.CategoryDAO;

public class CategoryInputOkAction implements Action {

    @Override
    public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
        // 카테고리 이름, 성별, 카테고리 코드 폼에서 받는다.
        String categoryName = request.getParameter("category_name");
        String categoryGender = request.getParameter("category_gender");
        String categoryCode = request.getParameter("category_code"); // 클라이언트에서 생성된 카테고리 코드 받기

        // 카테고리 정보를 DB에 저장하는 로직
        CategoryDAO dao = CategoryDAO.getInstance();
        boolean isInserted = dao.insertCategory(categoryName, categoryCode, categoryGender);

        // 성공/실패에 따른 페이지 이동
        ActionForward forward = new ActionForward();
        if (isInserted) {
            forward.setPath("category_list.go"); // 카테고리 리스트 페이지로 이동
        } else {
            forward.setPath("category_input.go"); // 실패 시 입력 페이지로 이동
        }
        forward.setRedirect(true);
        return forward;
    }
}
