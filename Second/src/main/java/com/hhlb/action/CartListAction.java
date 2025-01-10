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
		CartDAO dao = CartDAO.getInstance();
		
		List<CartDTO> list = dao.getCartList();
		
		request.setAttribute("cartList", list);
		
		ActionForward forward = new ActionForward();
		
		forward.setRedirect(false);
		
		forward.setPath("/product/cart.jsp");
		
		return forward;
	}

}
