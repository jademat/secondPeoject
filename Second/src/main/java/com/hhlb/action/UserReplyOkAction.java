package com.hhlb.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.hhlb.controller.Action;
import com.hhlb.controller.ActionForward;
import com.hhlb.model.ReplyDAO;
import com.hhlb.model.ReplyDTO;

public class UserReplyOkAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {

		String userId = request.getParameter("id");
		int board_no = Integer.parseInt(request.getParameter("bno"));
		String cont = request.getParameter("content");

		ReplyDTO dto = new ReplyDTO();

		dto.setUser_id(userId);
		dto.setBoard_no(board_no);
		dto.setReply_cont(cont);

		ReplyDAO dao = ReplyDAO.getInstance();

		int result = dao.userInsertReply(dto);

		response.setContentType("text/html; charset=UTF-8");

		PrintWriter out = response.getWriter();

		// 결과값을 Ajax 에 보내주면 됨.
		out.println(result);

		return null;
	}

}
