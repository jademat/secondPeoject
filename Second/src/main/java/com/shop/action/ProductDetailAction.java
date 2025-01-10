package com.shop.action;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.hhlb.controller.Action;
import com.hhlb.controller.ActionForward;
import com.hhlb.model.ProductDAO;
import com.hhlb.model.ProductDTO;

public class ProductDetailAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// 상품 리스트에서 선택 후 get 방식으로 넘어온 제품번호에 해당하는 제품의 상세정보를 조회하여
		// product/detail.jsp 페이지로 이동시키는 비지니스 로직
		
		int product_no = Integer.parseInt(request.getParameter("pnum"));
		
		ProductDAO dao = ProductDAO.getInstance();
		
		// 상품에 대한 정보를 가져오는 메서드
		ProductDTO cont = dao.getProductContent(product_no);
		
		//dto.리뷰 dto가져와야함, 가져와서 setAttribute 한 뒤 detail.jsp에서 리뷰 섹션 정비. 그럼 detail 끝. 그 후 더미 데이터도 만들고 리스트 페이지도 수정
		
		// 해당 상품의 review_rank 를 가져오는 메서드
		int review_rank = dao.getProductRiviewRank(product_no);
		
		// 해당 상품의 리뷰 개수를 가져오는 메서드
		int review_count = dao.getProductRiviewCount(product_no);
		
		request.setAttribute("ProductCont", cont);
		request.setAttribute("ReviewRank", review_rank);
		request.setAttribute("ReviewCount", review_count);
		
		ActionForward forward = new ActionForward();
		
		forward.setRedirect(false);
		forward.setPath("product/detail.jsp");
		
		return forward;
	}

}
