package com.admin.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.hhlb.controller.Action;
import com.hhlb.controller.ActionForward;
import com.hhlb.model.CategoryDAO;

public class CategoryDeleteOkAction implements Action {

    @Override
    public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
        // 1. 삭제할 카테고리 번호를 받아오기
        int category_no = Integer.parseInt(request.getParameter("no"));
        
        // 2. 카테고리 번호가 비어있는지 확인
        if (category_no == 0) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "카테고리 번호가 누락되었습니다.");
            return null;
        }

        // 3. CategoryDAO를 통해 카테고리 삭제
        CategoryDAO dao = CategoryDAO.getInstance();
        int chk = dao.deleteCategory(category_no); // 카테고리 삭제

        // 4. 결과 처리
        ActionForward forward = new ActionForward();
        // PrintWriter out = response.getWriter();
        
        if (chk > 0) {
            // 삭제 성공
            forward.setRedirect(true);
            request.setAttribute("message", "카테고리가 성공적으로 삭제되었습니다.");
            request.setAttribute("messageType", "success");
            forward.setPath(request.getContextPath() + "/category_list.go"); // 카테고리 목록 페이지로 리다이렉트
        } else {
            // 삭제 실패
            forward.setRedirect(false);
            request.setAttribute("message", "카테고리 삭제에 실패했습니다.");
            request.setAttribute("messageType", "error");
            forward.setPath("admin/category_delete.jsp"); // 삭제 페이지로 다시 이동
        }

        return forward;
    }
}
