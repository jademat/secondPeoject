package com.hhlb.action;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.hhlb.controller.Action;
import com.hhlb.controller.ActionForward;
import com.hhlb.model.BoardDAO;
import com.hhlb.model.BoardDTO;

public class BoardTypeAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {

		String board_type = request.getParameter("board_type");

		System.out.println("type >>> " + board_type);
		
		BoardDAO dao = BoardDAO.getInstance();

		List<BoardDTO> btype = dao.getBoardType(board_type);

		request.setAttribute("blist", btype);

		ActionForward forward = new ActionForward();

		forward.setRedirect(false);

		forward.setPath("/board/board.jsp");

		return forward;

	}

}
