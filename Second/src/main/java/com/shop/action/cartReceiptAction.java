package com.shop.action;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.hhlb.controller.Action;
import com.hhlb.controller.ActionForward;
import com.hhlb.model.CartDAO;
import com.hhlb.model.CartDTO;
import com.hhlb.model.UserDAO;
import com.hhlb.model.UserDTO;

public class cartReceiptAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// 장바구니에서 결제버튼 클릭시 받은 user_id에 해당하는 정보를 가지고 order.jsp로 넘어가는 비지니스 로직
		
		String user_id = request.getParameter("user_id");

		UserDAO userDao = UserDAO.getInstance();
		CartDAO cartDao = CartDAO.getInstance();
		
		// 해당 user의 정보를 가져오는 메서드
		UserDTO userInfo = userDao.getUser(user_id);
		
		// 장바구니 페이지에 해당 유저의 제품을 보여줌
		List<CartDTO> cartList = cartDao.getCartList(user_id);
				
		// 장바구니 페이지에 올라온 해당 유저의 상품의 합계를 구하는 메서드
		int totalPrice = cartDao.getCartTotalPrice(user_id);
		
		System.out.println("userInfo >>>>>>>>>>>>>>>>>>>>>>>>" + userInfo);
		
		request.setAttribute("UserInfo", userInfo);
		request.setAttribute("CartList", cartList);
		request.setAttribute("TotalPrice", totalPrice);
		
		ActionForward forward = new ActionForward();
		
		forward.setRedirect(false);
		forward.setPath("product/order.jsp");
		
		return forward;
	}

}
