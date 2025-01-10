package com.shop.action;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.hhlb.controller.Action;
import com.hhlb.controller.ActionForward;
import com.hhlb.model.ProductDAO;
import com.hhlb.model.ProductDTO;

public class ProductDetailAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// 상품 리스트에서 선택 후 get 방식으로 넘어온 제품번호에 해당하는 제품의 상세정보를 조회하여
		// product/detail.jsp 페이지로 이동시키는 비지니스 로직
		
		int product_no = Integer.parseInt(request.getParameter("pnum"));
		
		ProductDAO dao = ProductDAO.getInstance();
		
		ProductDTO cont = dao.getProductContent(product_no);
		
		request.setAttribute("ProductCont", cont);
		
		ActionForward forward = new ActionForward();
		
		forward.setRedirect(false);
		forward.setPath("product/detail.jsp");
		
		return forward;
	}

}
