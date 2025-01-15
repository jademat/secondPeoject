package com.admin.action;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.hhlb.controller.Action;
import com.hhlb.controller.ActionForward;
import com.hhlb.model.ProductDAO;
import com.hhlb.model.ProductDTO;

public class ProductListAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		
		ProductDAO dao = ProductDAO.getInstance();
        
        // 상품 목록 조회
        List<ProductDTO> productList = dao.getProductList();
        
        System.out.println("list >>> " + productList);
        
        // 조회된 상품 목록을 request 객체에 저장
        request.setAttribute("productList", productList);
        
        // 상품 목록 페이지로 이동
        ActionForward forward = new ActionForward();
        forward.setPath("admin/product_list.jsp");  // 상품 목록 페이지로 이동
        forward.setRedirect(false); 
        
        return forward;
    }

}
