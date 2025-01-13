package com.hhlb.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.hhlb.controller.Action;
import com.hhlb.controller.ActionForward;
import com.hhlb.model.BoardDAO;
import com.hhlb.model.BoardDTO;

public class BoardWriteAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		HttpSession session = request.getSession();
		
		String user_id = (String)session.getAttribute("user_id");
		
		String board_type = request.getParameter("board_type");
		String board_title = request.getParameter("board_title");
		String board_cont = request.getParameter("board_cont");
		int board_visible = Integer.parseInt(request.getParameter("board_visible"));
		
		BoardDAO dao  = BoardDAO.getInstance();
		
		BoardDTO dto = new BoardDTO();
		
		dto.setUser_id(user_id);
		dto.setBoard_type(board_type);
		dto.setBoard_title(board_title);
		dto.setBoard_cont(board_cont);
		dto.setBoard_visible(board_visible);
		
		int chk = dao.insertBoard(dto);
		
		PrintWriter out = response.getWriter();

		if(chk > 0) {
			out.println("<script>");
			out.println("alert('게시글 등록 성공')");
			out.println("location.href = 'user_board_list.go'");
			out.println("</script>");
		}else {
			out.println("<script>");
			out.println("alert('게시글 등록 실패')");
			out.println("history.back()");
			out.println("</script>");
		}
		return null;
	}

}
