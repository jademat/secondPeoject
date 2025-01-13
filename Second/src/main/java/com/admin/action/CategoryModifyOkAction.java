package com.admin.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.hhlb.controller.Action;
import com.hhlb.controller.ActionForward;
import com.hhlb.model.CategoryDAO;
import com.hhlb.model.CategoryDTO;

public class CategoryModifyOkAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// 카테고리 수정 폼 페이지에서 넘어온 데이터들을
		// sc_category 테이블에서 수정하는 비지니스 로직.
		
		int category_no = Integer.parseInt(request.getParameter("no"));
		String categoryName = request.getParameter("category_name");
		
		// 2. category_no가 비어있는지 확인
		System.out.println("category_no: " + category_no); // 확인용
		
        if (category_no == 0) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "카테고리 번호가 누락되었습니다.");
            return null;
        }
		
        // 3. category_no를 int로 변환
        // int categoryNo = 0;
		
		CategoryDTO category = new CategoryDTO();
		
		category.setCategory_no(category_no);
		category.setCategory_name(categoryName);
		
		CategoryDAO dao = CategoryDAO.getInstance();

		int chk = dao.updateCategory(category);
		
		ActionForward forward = new ActionForward();
		
		PrintWriter out = response.getWriter();
		
		if(chk > 0) {
			// 1 == 수정 성공
			forward.setRedirect(true);
			request.setAttribute("message", "카테고리가 성공적으로 수정되었습니다.");
            request.setAttribute("messageType", "success");
            forward.setPath(request.getContextPath() + "/category_list.go");
//			out.println("<script>");
//			out.println("alert('카테고리 수정 성공!!!')");
//			out.println("location.href='category_list.go'");
//			out.println("</script>");
			
			
		}else {
			// 0 == 수정 실패
			forward.setRedirect(false);
			request.setAttribute("message", "카테고리 수정에 실패했습니다.");
            request.setAttribute("messageType", "error");
            forward.setPath("/admin/category_modify.jsp");
//			out.println("<script>");
//			out.println("alert('카테고리 수정 실패!!!')");
//			out.println("history.back()");
//			out.println("</script>");
		
		}
		
		
		return forward;
	}

}
