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

		// 파라미터로 받은 productId
        int productId = Integer.parseInt(request.getParameter("productId"));

        
        ProductDAO productDAO = ProductDAO.getInstance();
        
        boolean isDeleted = productDAO.deleteProduct(productId);

        
        if (isDeleted) {
            // 삭제 성공
            ActionForward forward = new ActionForward();
            forward.setPath("product_list.go");
            forward.setRedirect(true);
            return forward;
        } else {
            
            response.getWriter().write("상품 삭제 실패");
            return null;
        }
    }
}