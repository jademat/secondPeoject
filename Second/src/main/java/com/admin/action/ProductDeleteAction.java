package com.admin.action;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.hhlb.controller.Action;
import com.hhlb.controller.ActionForward;
import com.hhlb.model.ProductDAO;

public class ProductDeleteAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {

		// 파라미터로 받은 productId를 가져옵니다.
        int productId = Integer.parseInt(request.getParameter("productId"));

        // ProductDAO를 통해 상품을 삭제합니다.
        ProductDAO productDAO = ProductDAO.getInstance();
        boolean isDeleted = productDAO.deleteProduct(productId);

        // 삭제 결과에 따라 알림 처리
        if (isDeleted) {
            // 삭제 성공 시 상품 목록 페이지로 리다이렉트
            ActionForward forward = new ActionForward();
            forward.setPath("product_list.go");  // 상품 목록으로 리다이렉트
            forward.setRedirect(true);
            return forward;
        } else {
            // 삭제 실패 시, 적절한 실패 메시지 표시 (예: 실패 페이지로 이동)
            response.getWriter().write("상품 삭제 실패");
            return null;
        }
    }
}