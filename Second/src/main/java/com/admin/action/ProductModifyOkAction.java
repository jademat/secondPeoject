package com.admin.action;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.hhlb.controller.Action;
import com.hhlb.controller.ActionForward;
import com.hhlb.model.ProductDAO;
import com.hhlb.model.ProductDTO;

public class ProductModifyOkAction implements Action {

    @Override
    public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
        // 상품 번호를 파라미터로 받아옴
        String productId = request.getParameter("productId");

        if (productId == null || productId.trim().isEmpty()) {
            response.sendRedirect("product_list.go");  // 상품 번호가 없으면 상품 목록 페이지로 리다이렉트
            return null;
        }

        // 상품 번호로 상품 정보를 조회
        ProductDAO productDAO = ProductDAO.getInstance();
        ProductDTO product = productDAO.getProductById(Integer.parseInt(productId));  // 상품 정보 조회

        if (product == null) {
            response.sendRedirect("product_list.go");  // 상품 정보가 없으면 상품 목록 페이지로 리다이렉트
            return null;
        }

        // 수정 폼 페이지로 이동
        request.setAttribute("product", product);  // 상품 정보를 request에 저장하여 JSP로 전달

        // 수정 폼 페이지로 이동
        ActionForward forward = new ActionForward();
        forward.setPath("admin/product_modify.jsp");  // 수정 페이지로 이동
        forward.setRedirect(false);  // 포워딩 방식으로 이동
        return forward;
    }
}
