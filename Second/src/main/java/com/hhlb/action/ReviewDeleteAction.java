package com.hhlb.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.hhlb.controller.Action;
import com.hhlb.controller.ActionForward;
import com.hhlb.model.ReviewDAO;

public class ReviewDeleteAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {

		int review_no = Integer.parseInt(request.getParameter("review_no"));
		String userId = (String) request.getSession().getAttribute("user_id");

		ReviewDAO dao = ReviewDAO.getInstance();

		int chk = dao.deleteReview(review_no);

		PrintWriter out = response.getWriter();

		if (chk > 0) {

			dao.updateReviewSequence(review_no);

			out.println("<script>");
			out.println("alert('게시글 삭제 성공')");
			out.println("location.href='user_myInfo.go?id=" + userId + "';");
			out.println("</script>");
		} else {
			out.println("<script>");
			out.println("alert('게시글 삭제 실패')");
			out.println("history.back()");
			out.println("</script>");
		}
		return null;
	}

}
