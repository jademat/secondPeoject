package com.shop.action;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.hhlb.controller.Action;
import com.hhlb.controller.ActionForward;
import com.hhlb.model.CartDAO;
import com.hhlb.model.CartDTO;

public class CartListAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// main.jsp에서 shopping cart 이미지 클릭 시 로그인 된 회원의 장바구니 리스트를 보여주는 비지니스 로직
		
		HttpSession session = request.getSession();
		
		// 세션에서 로그인 중인 회원의 id 받기
		String user_id = (String)session.getAttribute("user_id");
		
		CartDAO dao = CartDAO.getInstance();
		
		List<CartDTO> cartList = dao.getCartList(user_id);
		
		request.setAttribute("CartList", cartList);
		
		ActionForward forward = new ActionForward();
		
		forward.setRedirect(false);
		forward.setPath("product/cart.jsp");
		
		return forward;
	}

}
