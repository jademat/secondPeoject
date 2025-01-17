package com.admin.action;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.hhlb.controller.Action;
import com.hhlb.controller.ActionForward;
import com.hhlb.model.ProductDAO;
import com.hhlb.model.ProductDTO;

public class ProductInfoAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {

		// 파라미터로 받은 productId
        int productId = Integer.parseInt(request.getParameter("productId"));

        
        ProductDAO dao = ProductDAO.getInstance();
        
        ProductDTO detail = dao.getProductById(productId);
		
        request.setAttribute("Product", detail);
        
        ActionForward forward = new ActionForward();
        
        forward.setRedirect(false);
        
        forward.setPath("admin/product_info.jsp");
        
		return forward;
	}

}
