package com.hhlb.action;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.hhlb.controller.Action;
import com.hhlb.controller.ActionForward;
import com.hhlb.model.ReviewDAO;
import com.hhlb.model.ReviewDTO;

public class ReviewDetailAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {

		int review_no = Integer.parseInt(request.getParameter("no"));
		
		ReviewDAO dao = ReviewDAO.getInstance();
		
		ReviewDTO rCont = dao.getuserReview(review_no);
		
		System.out.println("rCont >>> " + rCont);

		request.setAttribute("rCont", rCont);
		
		
		ActionForward forward = new ActionForward();
		
		forward.setRedirect(false);
		
		forward.setPath("/modal/reviewModal.jsp");
		
		return forward;

	}

}
