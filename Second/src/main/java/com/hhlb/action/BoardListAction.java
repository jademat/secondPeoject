package com.hhlb.action;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.hhlb.controller.Action;
import com.hhlb.controller.ActionForward;
import com.hhlb.model.BoardDAO;
import com.hhlb.model.BoardDTO;

public class BoardListAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {

		int rowsize = 5;

		int block = 5;

		int totalRecord = 0;

		int allPage = 0;

		int page = 0;

		String board_type = "";
		
		if (request.getParameter("page") != null) {
			page = Integer.parseInt(request.getParameter("page"));
			board_type = request.getParameter("board_type");
		} else {
			page = 1;
			board_type = request.getParameter("board_type");
		}
		
		System.out.println("type >>> " + board_type);

		int startNo = (page * rowsize) - (rowsize - 1);

		int endNo = (page * rowsize);

		int startBlock = (((page - 1) / block) * block) + 1;

		int endBlock = (((page - 1) / block) * block) + block;

		BoardDAO dao = BoardDAO.getInstance();

		totalRecord = dao.getBoardCount(board_type);

		allPage = (int) Math.ceil(totalRecord / (double) rowsize);

		if (endBlock > allPage) {
			endBlock = allPage;
		}

		List<BoardDTO> blist = dao.getBoardList(page,rowsize,board_type);
		
		request.setAttribute("page", page);
		request.setAttribute("rowsize", rowsize);
		request.setAttribute("block", block);
		request.setAttribute("totalRecord", totalRecord);
		request.setAttribute("allPage", allPage);
		request.setAttribute("startNo", startNo);
		request.setAttribute("endNo", endNo);
		request.setAttribute("startBlock", startBlock);
		request.setAttribute("endBlock", endBlock);
		request.setAttribute("board_type", board_type);
		request.setAttribute("blist", blist);

		ActionForward forward = new ActionForward();

		forward.setRedirect(false);

		forward.setPath("/board/board.jsp");

		return forward;
	}

}
