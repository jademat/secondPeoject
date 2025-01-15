package com.hhlb.action;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.hhlb.controller.Action;
import com.hhlb.controller.ActionForward;
import com.hhlb.model.ReviewDAO;
import com.hhlb.model.ReviewDTO;

public class ReviewListAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {

		int rowsize = 8;

		int block = 3;

		int totalRecord = 0;

		int allPage = 0;

		int page = 0;

		if (request.getParameter("page") != null) {
			page = Integer.parseInt(request.getParameter("page"));

		} else {
			page = 1;
		}
		// 해당 페이지에서 시작 글번호
		int startNo = (page * rowsize) - (rowsize - 1);

		// 해당 페이지에서 끝 글번호
		int endNo = (page * rowsize);

		// 해당 페이지에서 시작 블럭
		int startBlock = (((page - 1) / block) * block) + 1;
		// 해당 페이지에서 끝 블럭
		int endBlock = (((page - 1) / block) * block) + block;
		
		ReviewDAO dao = ReviewDAO.getInstance();
		
		totalRecord = dao.getReviewCount();
		
		allPage = (int) Math.ceil(totalRecord / (double) rowsize);

		if (endBlock > allPage) {
			endBlock = allPage;
		}

		List<ReviewDTO> list = dao.getReviewList(page, rowsize);
		request.setAttribute("page", page);
		request.setAttribute("rowsize", rowsize);
		request.setAttribute("block", block);
		request.setAttribute("totalRecord", totalRecord);
		request.setAttribute("allPage", allPage);
		request.setAttribute("startNo", startNo);
		request.setAttribute("endNo", endNo);
		request.setAttribute("startBlock", startBlock);
		request.setAttribute("endBlock", endBlock);
		request.setAttribute("rList", list);

		ActionForward forward = new ActionForward();

		forward.setRedirect(false);

		forward.setPath("/review/review.jsp");

		return forward;
	}

}
