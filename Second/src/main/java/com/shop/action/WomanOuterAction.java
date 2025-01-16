package com.shop.action;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.hhlb.controller.Action;
import com.hhlb.controller.ActionForward;
import com.hhlb.model.ProductDAO;
import com.hhlb.model.ProductDTO;

public class WomanOuterAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {

		ProductDAO dao = ProductDAO.getInstance();

		List<ProductDTO> productList = dao.womanTop();

		request.setAttribute("ProductList", productList);

		System.out.println(" productList >>> " + productList);

		ActionForward forward = new ActionForward();

		forward.setRedirect(false);
		forward.setPath("product/womanOuter.jsp");

		return forward;
	}

}
