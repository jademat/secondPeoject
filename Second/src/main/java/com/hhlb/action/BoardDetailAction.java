package com.hhlb.action;

import java.io.IOException;
import java.util.Iterator;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.hhlb.controller.Action;
import com.hhlb.controller.ActionForward;
import com.hhlb.model.BoardDAO;
import com.hhlb.model.BoardDTO;

public class BoardDetailAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {

		int board_no = Integer.parseInt(request.getParameter("no"));
		String userId = (String) request.getSession().getAttribute("user_id");

		BoardDAO dao = BoardDAO.getInstance();

		BoardDTO bCont = dao.getBoardDetail(board_no);

		if (bCont.getBoard_visible() == 0 && !bCont.getUser_id().equals(userId)) {
			
			response.setContentType("text/html; charset=UTF-8");
			response.getWriter().write("<script>alert('이 게시글은 비공개입니다.'); history.back();</script>");
			return null; // 처리 후 더 이상 진행하지 않음
		}

		// 비공개 글이 아니면 그대로 게시글 내용 설정
		request.setAttribute("bCont", bCont);

		ActionForward forward = new ActionForward();
		forward.setRedirect(false);
		forward.setPath("board/boardDetail.jsp");

		return forward;
	}

}
