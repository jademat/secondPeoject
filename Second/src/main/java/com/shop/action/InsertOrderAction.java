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
import com.hhlb.model.ProductDAO;

public class InsertOrderAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// order 페이지에서 넘어온 데이터 들을받아 sc_order 테이블에 저장후 결제완료 페이지로 이동하는 비지니스 로직
		
		String user_id =request.getParameter("user_id");
		int totalPrice = Integer.parseInt(request.getParameter("totalPrice"));
		String cardName = request.getParameter("selectedCard");
		String memo = request.getParameter("memo");
		String addr = request.getParameter("addr");
		
		
		CartDAO cartDAO = CartDAO.getInstance();
		
		// 해당 유저의 장바구니 상품을 가져오는 메서드
		List<CartDTO> cartList = cartDAO.getCartList(user_id);
		
		OrderDAO orderDAO = OrderDAO.getInstance();
			
		// 각 리스트마다의 값을 sc_order 테이블에 저장하는 메서드
		int check = orderDAO.InsertOrderData(user_id, totalPrice, memo, cartList, addr);
		
		if (check > 0) {
			ProductDAO proDAO = ProductDAO.getInstance();
			
			proDAO.updateProductHit(cartList);
			
			// 결제 성공 시(sc_order 테이블에 정상적으로 insert 된 경우) 장바구니 품목 삭제하는 메서드
			cartDAO.deleteCartList(user_id);
			
			
		}
		
		ActionForward forward = new ActionForward();
		
		forward.setRedirect(false);
		forward.setPath("product/orderOk.jsp");
		
		return forward;
	}

}
