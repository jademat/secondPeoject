package com.hhlb.action;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.hhlb.controller.Action;
import com.hhlb.controller.ActionForward;
import com.hhlb.model.CartDAO;
import com.hhlb.model.CartDTO;

public class CartListAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// header에서 장바구니 버튼 클릭시 접속중인 유저의 정보를 받아 이동하는 비지니스 로직
		
		String user_id = request.getParameter("id");
		
		CartDAO dao = CartDAO.getInstance();
		
		List<CartDTO> list = dao.getCartList(user_id);
		
		request.setAttribute("cartList", list);
		
		ActionForward forward = new ActionForward();
		
		forward.setRedirect(false);
		
		forward.setPath("/product/cart.jsp");
		
		return forward;
	}

}
