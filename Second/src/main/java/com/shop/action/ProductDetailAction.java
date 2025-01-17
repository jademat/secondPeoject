package com.shop.action;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.hhlb.controller.Action;
import com.hhlb.controller.ActionForward;
import com.hhlb.model.ProductDAO;
import com.hhlb.model.ProductDTO;
import com.hhlb.model.ReviewDAO;
import com.hhlb.model.ReviewDTO;

public class ProductDetailAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// 상품 리스트에서 선택 후 get 방식으로 넘어온 제품번호에 해당하는 제품의 상세정보를 조회하여
		// product/detail.jsp 페이지로 이동시키는 비지니스 로직
		
		int product_no = Integer.parseInt(request.getParameter("pnum"));
		
		// 한 페이지당 보여지는 게시물 수
		int rowsize = 4;

		// 아래에 보여지는 페이지의 최대 블럭 수 [1][2][3] / [4][5][6]
		int block = 3;

		// sc_product 테이블 상의 상품 목록 전체 수
		int totalRecord = 0;

		// 전체 페이지 수
		int allPage = 0;

		// 현제 페이지 변수
		int page = 0;

		// 보여줄 페이지 종류 설정하는 변수
		String product_type = "";
		
		if (request.getParameter("page") != null) {
			page = Integer.parseInt(request.getParameter("page"));
			//product_type = request.getParameter("board_type");
		} else {
			// main.jsp에서 shop.jsp 클릭 시 
			page = 1;	// 1 page 로 넘어감
			//product_type = request.getParameter("board_type");
		}
		
		// 이동하려는 페이지 종류 확인
		//System.out.println("type >>> " + product_type);

		// 해당 페이지에서 시작 글 번호
		int startNo = (page * rowsize) - (rowsize - 1);
		// 해당 페이지에서 시작 끝 번호
		int endNo = (page * rowsize);

		// 해당 페이지에서 시작 글 번호
		int startBlock = (((page - 1) / block) * block) + 1;
		// 해당 페이지에서 끝 글 번호
		int endBlock = (((page - 1) / block) * block) + block;

		ProductDAO productDAO = ProductDAO.getInstance();
		ReviewDAO reviewDAO = ReviewDAO.getInstance();

		// 해당 상품의 리뷰 개수를 가져오는 메서드
		totalRecord = productDAO.getProductRiviewCount(product_no);

		// 전체 상품 수를 한 페이지당 보여질 상품의 수로 나누어 주어 전체 페이지수 산출
		allPage = (int) Math.ceil(totalRecord / (double) rowsize);

		// 데이터가 없는 글 번호가 생기지 않게 하는 로직
		if (endBlock > allPage) {
			endBlock = allPage;
		}

		// 해당 게시물의 리뷰를 모두 가져오는 메서드
		List<ReviewDTO> review_list = reviewDAO.getReviewInfo(product_no, page, rowsize);
		
		// 해당 상품에 대한 정보를 가져오는 메서드
		ProductDTO cont = productDAO.getProductContent(product_no);
		
		// 해당 상품의 review_rank 를 가져오는 메서드
		int review_rank = productDAO.getProductRiviewRank(product_no);
		
		// 해당 상품의 리뷰 개수를 가져오는 메서드
		int review_count = productDAO.getProductRiviewCount(product_no);
		
		// 모든 상품의 정보를 가져오는 메서드(디테일 페이지 아래 이벤트 용 페이징 X)
		List<ProductDTO> product_list = productDAO.getAllProductData();
		
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
		
		request.setAttribute("ProductCont", cont);
		request.setAttribute("ReviewList", review_list);
		request.setAttribute("ReviewRank", review_rank);
		request.setAttribute("ReviewCount", review_count);
		request.setAttribute("ProductList", product_list);
		request.setAttribute("pnum", product_no);


		ActionForward forward = new ActionForward();
		
		forward.setRedirect(false);
		forward.setPath("product/detail.jsp");
		
		return forward;
		}
}
