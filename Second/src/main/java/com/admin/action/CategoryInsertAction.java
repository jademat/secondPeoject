package com.admin.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.hhlb.controller.Action;
import com.hhlb.controller.ActionForward;
import com.hhlb.model.CategoryDAO;
import com.hhlb.model.CategoryDTO;

public class CategoryInsertAction implements Action {

    @Override
    public ActionForward execute(HttpServletRequest request, HttpServletResponse response) {
    	// 카테고리 등록 폼 페이지에서 넘어온 데이터들을 받아서
    	// sc_category 테이블에 저장시키는 비지니스 로직.
    	
    	// 폼에서 넘어온 카테고리 이름과 성별을 가져옵니다.
        String categoryName = request.getParameter("category_name");
        String categoryGender = request.getParameter("category_gender");

        // CategoryDAO 객체를 가져와서 카테고리 코드를 생성합니다.
        CategoryDAO dao = CategoryDAO.getInstance();
        String categoryCode = dao.generateCategoryCode(categoryGender, categoryName); // CategoryDAO에서 메서드 호출

        // CategoryDTO 객체를 생성하여 데이터를 설정합니다.
        CategoryDTO category = new CategoryDTO();
        
        category.setCategory_code(categoryCode);
        category.setCategory_name(categoryName);

        // CategoryDAO 객체를 가져와서 카테고리를 DB에 삽입합니다.
        boolean isSuccess = dao.insertCategory(category);

        // 성공 여부에 따라 리다이렉트 또는 포워딩을 설정합니다.
        ActionForward forward = new ActionForward();
        
        if (isSuccess) {
            forward.setRedirect(true);
            forward.setPath("category_list.go");  // 카테고리 목록 페이지로 리다이렉트
        } else {
            forward.setRedirect(false);
            forward.setPath("/error_404.jsp");  // 실패 시 에러 페이지로 포워딩
        }

        return forward;
    }
}
