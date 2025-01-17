package com.hhlb.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.hhlb.controller.Action;
import com.hhlb.controller.ActionForward;
import com.hhlb.model.ReviewDAO;
import com.hhlb.model.ReviewDTO;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class ReviewWriteAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {

		String saveFolder = "C:\\Users\\user\\git\\secondPeoject\\Second\\src\\main\\webapp\\upload";

		// 최대 파일 사이즈 10MB
		int fileSize = 10 * 1024 * 1024;

		// 파일 업로드를 위한 객체 생성
		MultipartRequest multi = new MultipartRequest(request, // request 객체
													saveFolder, // 첨부파일이 저장될 경로
													fileSize, // 첨부파일의 최대 크기
													"UTF-8", // 한글 인코딩 처리
													new DefaultFileRenamePolicy() // 첨부파일 이름 중복 처리
		);
		String user_id = multi.getParameter("user_id");
		int product_no = Integer.parseInt(multi.getParameter("product_no"));
		String title = multi.getParameter("title");
		int star = Integer.parseInt(multi.getParameter("star"));
		String cont = multi.getParameter("cont");
		String file = multi.getFilesystemName("file");
		
		System.out.println("file >>> " + file );
		ReviewDTO dto = new ReviewDTO();
		dto.setReview_title(title);
		dto.setReview_rank(star);
		dto.setReview_cont(cont);
		dto.setReview_image(file);
		
		ReviewDAO dao = ReviewDAO.getInstance();
		
		int chk = dao.insertReview(user_id,product_no,dto);
		
		PrintWriter out = response.getWriter();
		
		if(chk > 0) {
			out.println("<script>");
			out.println("alert('리뷰 작성 성공')");
			out.println("location.href = 'user_myInfo.go?id=" + user_id + "'");
			out.println("</script>");
		}else {
			out.println("<script>");
			out.println("alert('리뷰 작성 실패')");
			out.println("history.back()");
			out.println("</script>");
		
		}
		
		return null;
	}

}
