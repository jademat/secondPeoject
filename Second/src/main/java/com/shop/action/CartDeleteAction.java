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
		String user_id = request.getParameter("user_id");
		
		System.out.println(cart_no);
		
		CartDAO dao = CartDAO.getInstance();
		
		int check = dao.deleteCartData(cart_no);
		
		PrintWriter out = response.getWriter();
		
		if (check > 0) {
			out.println("<script>");
			out.println("alert('장바구니 삭제 성공')");
			out.println("location.href='user_cart.go?id=" + user_id + "'");
			out.println("</script>");
		} else {
			out.println("<script>");
			out.println("alert('장바구니 삭제 실패')");
			out.println("history.back()");
			out.println("</script>");
		}
		
		return null;
	}

}
