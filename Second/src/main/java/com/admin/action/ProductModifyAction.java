package com.admin.action;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.hhlb.controller.Action;
import com.hhlb.controller.ActionForward;
import com.hhlb.model.ProductDAO;
import com.hhlb.model.ProductDTO;

public class ProductModifyAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		int product_id = 
			Integer.parseInt(request.getParameter("productId").trim());
		
		ProductDAO dao = ProductDAO.getInstance();
		
		ProductDTO cont = dao.getProductById(product_id);
		
		System.out.println("cont image >>> " + cont.getProduct_image());
		
		request.setAttribute("product", cont);
		
		ActionForward forward = new ActionForward();
		
		forward.setRedirect(false);
		
		forward.setPath("admin/product_modify.jsp");
		
		return forward;
	}

}
