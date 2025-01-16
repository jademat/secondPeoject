package com.hhlb.action;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.hhlb.controller.Action;
import com.hhlb.controller.ActionForward;
import com.hhlb.model.BoardDAO;
import com.hhlb.model.BoardDTO;
import com.hhlb.model.OrderDAO;
import com.hhlb.model.OrderDetailsDTO;
import com.hhlb.model.ReviewDAO;
import com.hhlb.model.ReviewDTO;
import com.hhlb.model.UserDAO;
import com.hhlb.model.UserDTO;

public class UserMyInfoAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		String user_id = request.getParameter("id");
		
		UserDAO udao = UserDAO.getInstance();
		
		BoardDAO bdao = BoardDAO.getInstance();
		
		ReviewDAO rdao = ReviewDAO.getInstance();
		
		OrderDAO odao = OrderDAO.getInstance();
				
		UserDTO ucont = udao.getUser(user_id);
		
		List<BoardDTO> bcont = bdao.getBoard(user_id);
				
		List<ReviewDTO> rcont = rdao.getReview(user_id);
		
		List<OrderDetailsDTO> ocont = odao.getOrder(user_id);
		
		
		request.setAttribute("uCont", ucont);
		request.setAttribute("bCont", bcont);
		request.setAttribute("rCont", rcont);
		request.setAttribute("oCont", ocont);
		
		ActionForward forward = new ActionForward();
		
		forward.setRedirect(false);
		
		forward.setPath("user/myinfo.jsp");
		
		return forward;
	}

}
