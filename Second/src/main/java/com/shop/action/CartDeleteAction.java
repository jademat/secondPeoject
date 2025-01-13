package com.shop.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.hhlb.controller.Action;
import com.hhlb.controller.ActionForward;
import com.hhlb.model.CartDAO;

public class CartDeleteAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// product/cart.jsp에서 deleteBtn 클릭 시 해당 리스트의 번호를 받아 삭제시키는 비지니스 로직
		
		int cart_no = Integer.parseInt(request.getParameter("no"));
		
		System.out.println(cart_no);
		
		CartDAO dao = CartDAO.getInstance();
		
		int check = dao.deleteCartData(cart_no);
		
		PrintWriter out = response.getWriter();
		
		out.println(check);
		
		return null;
	}

}
