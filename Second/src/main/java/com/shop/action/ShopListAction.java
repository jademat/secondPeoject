package com.shop.action;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.hhlb.controller.Action;
import com.hhlb.controller.ActionForward;
import com.hhlb.model.ProductDAO;
import com.hhlb.model.ProductDTO;

public class ShopListAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// header에서 shop 클릭 시 전체 상품 리스트를 load 하고 product/shop.jsp로 이동하는 비지니스 로직
		
		ProductDAO dao = ProductDAO.getInstance();
		
		List<ProductDTO> productList = dao.getAllProduct();
		
		request.setAttribute("ProductList", productList);
		
		System.out.println(" productList >>> " + productList);
		
		ActionForward forward = new ActionForward();
		
		forward.setRedirect(false);
		forward.setPath("product/shop.jsp");
		
		return forward;
	}

}
