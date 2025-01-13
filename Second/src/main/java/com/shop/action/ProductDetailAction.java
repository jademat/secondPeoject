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
		
		ProductDAO productDAO = ProductDAO.getInstance();
		
		// 해당 상품에 대한 정보를 가져오는 메서드
		ProductDTO cont = productDAO.getProductContent(product_no);
		
		ReviewDAO reviewDAO = ReviewDAO.getInstance();
		// 해당 게시물의 리뷰를 모두 가져오는 메서드
		List<ReviewDTO> review_list = reviewDAO.getReviewInfo(product_no);
		
		// 해당 상품의 review_rank 를 가져오는 메서드
		int review_rank = productDAO.getProductRiviewRank(product_no);
		
		// 해당 상품의 리뷰 개수를 가져오는 메서드
		int review_count = productDAO.getProductRiviewCount(product_no);
		
		// 모든 상품의 정보를 가져오는 메서드
		List<ProductDTO> product_list = productDAO.getAllProduct();
		
		request.setAttribute("ProductCont", cont);
		request.setAttribute("ReviewList", review_list);
		request.setAttribute("ReviewRank", review_rank);
		request.setAttribute("ReviewCount", review_count);
		request.setAttribute("ProductList", product_list);
		
		ActionForward forward = new ActionForward();
		
		forward.setRedirect(false);
		forward.setPath("product/detail.jsp");
		
		return forward;
	}

}
