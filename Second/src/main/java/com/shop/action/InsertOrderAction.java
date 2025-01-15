package com.shop.action;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.hhlb.controller.Action;
import com.hhlb.controller.ActionForward;
import com.hhlb.model.CartDAO;
import com.hhlb.model.CartDTO;
import com.hhlb.model.OrderDAO;

public class InsertOrderAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// order 페이지에서 넘어온 데이터 들을받아 sc_order 테이블에 저장후 결제완료 페이지로 이동하는 비지니스 로직
		
		String user_id =request.getParameter("user_id");
		int totalPrice = Integer.parseInt(request.getParameter("totalPrice"));
		String cardName = request.getParameter("selectedCard");
		String memo = request.getParameter("memo");
		
		CartDAO cartDAO = CartDAO.getInstance();
		
		List<CartDTO> cartList = cartDAO.getCartList(user_id);
		
		OrderDAO dao = OrderDAO.getInstance();
			
		// 각 리스트마다의 값을 sc_order 테이블에 저장하는 메서드
		dao.InsertOrderData(user_id, totalPrice, memo, cartList);
		
		ActionForward forward = new ActionForward();
		
		forward.setRedirect(false);
		forward.setPath("product/orderOk.jsp");
		
		return forward;
	}

}
