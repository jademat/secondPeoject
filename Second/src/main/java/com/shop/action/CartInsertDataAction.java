package com.shop.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.hhlb.controller.Action;
import com.hhlb.controller.ActionForward;
import com.hhlb.model.CartDAO;
import com.hhlb.model.CartDTO;

public class CartInsertDataAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// product/detail.jsp에서 Add to Cart 버튼을 클릭시 넘어온 데이터들을 sc_cart 테이블에 저장시키는 비지니스 로직
		
		String product_size = request.getParameter("size");
		int product_qty =Integer.parseInt(request.getParameter("qty"));
		
		int product_no = Integer.parseInt(request.getParameter("product_no"));
		int category_no = Integer.parseInt(request.getParameter("category_no"));
		String product_image = request.getParameter("product_image");
		String product_name = request.getParameter("product_name");
		int product_price = Integer.parseInt(request.getParameter("product_price"));
		String user_id = request.getParameter("user_id");
		
		CartDTO dto = new CartDTO();
		
		dto.setProduct_size(product_size);
		dto.setProduct_qty(product_qty);
		dto.setProduct_no(product_no);
		dto.setCategory_no(category_no);
		dto.setProduct_image(product_image);
		dto.setProduct_name(product_name);
		dto.setProduct_price(product_price);
		dto.setUser_id(user_id);
		
		CartDAO dao = CartDAO.getInstance();
		
		// product/detail.jsp에서 Add to Cart 버튼을 클릭시 해당 페이지 상품을 장바구니에 추가하는 메서드
		int check = dao.insertCartData(dto, user_id);
		
		PrintWriter out = response.getWriter();
		
		out.println(check);
		
		return null;
	}

}
