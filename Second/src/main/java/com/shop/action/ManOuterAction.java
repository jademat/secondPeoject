package com.shop.action;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.hhlb.controller.Action;
import com.hhlb.controller.ActionForward;
import com.hhlb.model.ProductDAO;
import com.hhlb.model.ProductDTO;

public class ManOuterAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		// 한 페이지당 보여지는 게시물 수
		int rowsize = 8;

		// 아래에 보여지는 페이지의 최대 블럭 수 [1][2][3] / [4][5][6]
		int block = 3;

		// sc_product 테이블 상의 상품 목록 전체 수
		int totalRecord = 0;

		// 전체 페이지 수
		int allPage = 0;

		// 현제 페이지 변수
		int page = 0;
		
		if (request.getParameter("page") != null) {
			page = Integer.parseInt(request.getParameter("page"));
		} else {
			// main.jsp에서 shop.jsp 클릭 시 
			page = 1;	// 1 page 로 넘어감
		}

		// 해당 페이지에서 시작 글 번호
		int startNo = (page * rowsize) - (rowsize - 1);
		// 해당 페이지에서 시작 끝 번호
		int endNo = (page * rowsize);

		// 해당 페이지에서 시작 글 번호
		int startBlock = (((page - 1) / block) * block) + 1;
		// 해당 페이지에서 끝 글 번호
		int endBlock = (((page - 1) / block) * block) + block;

		ProductDAO dao = ProductDAO.getInstance();

		// sc_product 테이블의 상품의 총 개수를 구하는 메서드
		totalRecord = dao.getProductCountManOuter();

		// 전체 상품 수를 한 페이지당 보여질 상품의 수로 나누어 주어 전체 페이지수 산출
		allPage = (int) Math.ceil(totalRecord / (double) rowsize);

		// 데이터가 없는 글 번호가 생기지 않게 하는 로직
		if (endBlock > allPage) {
			endBlock = allPage;
		}

		// 현제 페이지에 해당하는 게시물을 가져오는 로직
		List<ProductDTO> productList = dao.getAllProductManOuter(page, rowsize);
		
		// 페이징 작업 후 지금까지 페이징 처리 시에 작업했던 모든 정보들을 view page로 바인딩
		request.setAttribute("page", page);
		request.setAttribute("rowsize", rowsize);
		request.setAttribute("block", block);
		request.setAttribute("totalRecord", totalRecord);
		request.setAttribute("allPage", allPage);
		request.setAttribute("startNo", startNo);
		request.setAttribute("endNo", endNo);
		request.setAttribute("startBlock", startBlock);
		request.setAttribute("endBlock", endBlock);
		request.setAttribute("ProductList", productList);

		ActionForward forward = new ActionForward();

		forward.setRedirect(false);
		forward.setPath("product/manOuter.jsp");

		return forward;
	}

}
