package com.shop.action;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.hhlb.controller.Action;
import com.hhlb.controller.ActionForward;
import com.hhlb.model.ProductDAO;
import com.hhlb.model.ProductDTO;

public class SearchProductAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {

		String searchProduct = request.getParameter("search");

		ProductDAO dao = ProductDAO.getInstance();

		List<ProductDTO> products = dao.searchProduct(searchProduct);

				
		request.setAttribute("ProductList", products);

		System.out.println("search >>>>>>>>>"  + products);
		
		ActionForward forward = new ActionForward();

		forward.setRedirect(false);
		forward.setPath("product/shop.jsp");
		
		return forward;
	}

}
