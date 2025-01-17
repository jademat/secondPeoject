package com.admin.action;

import java.io.IOException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.hhlb.controller.Action;
import com.hhlb.controller.ActionForward;
import com.hhlb.model.ProductDAO;
import com.hhlb.model.ProductDTO;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class ProductModifyOkAction implements Action {

    @Override
    public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
        
    	// 첨부파일 저장 경로
        String saveFolder = "C:\\Users\\admin\\git\\secondPeoject\\Second\\src\\main\\webapp\\resource\\img";
        
        // 최대 파일 사이즈 10MB
        int fileSize = 10 * 1024 * 1024; 
        
        // 파일 업로드를 위한 객체 생성
        MultipartRequest multi = new MultipartRequest(
                request,                        // request 객체
                saveFolder,                     // 첨부파일이 저장될 경로
                fileSize,                       // 첨부파일의 최대 크기
                "UTF-8",                        // 한글 인코딩 처리
                new DefaultFileRenamePolicy()   // 첨부파일 이름 중복 처리
        );
    	
    	// 상품 번호를 파라미터로 받아옴
        String productId = multi.getParameter("productId");
        
        System.out.println("productId >>> " + productId); // 테스트용
        
        if (productId == null || productId.trim().isEmpty()) {
            response.sendRedirect("error.jsp");  // 상품 번호가 없으면 에러페이지 근데 구분하려고 404로 안함
            return null;
        }
        
        
        // 수정 폼에 입력된 상품 정보
        int productNo = Integer.parseInt(multi.getParameter("productId"));
        String result = multi.getParameter("productCategory");
        String sub = multi.getParameter("productSubCategory");
        
        int productCategory = 0;
        String productName = multi.getParameter("productName");
        if(result.equals("male")) {
        	if(sub.equals("top")) {
        		productCategory = 1;
        	}else if(sub.equals("bottom")) {
        		productCategory = 2;
        	}else {
        		productCategory = 3;
        	}   
        }else {
        	if(sub.equals("top")) {
        		productCategory = 4;
        	}else if(sub.equals("bottom")) {
        		productCategory = 5;
        	}else {
        		productCategory = 6;
        	}
        }
        
        int category_no = productCategory;
        
        // String productSubCategory = multi.getParameter("productSubCategory");
        String productSpec = multi.getParameter("productSpec");
        String productImage_new = multi.getFilesystemName("productImage");
        
        
        if(productImage_new == null) {	// 상품 수정 폼에서 새로 상품 이미지를 넣지 않으면 
        	productImage_new = multi.getParameter("p_image_old"); // 상품 등록 시 저장한 상품 이미지
        }
        
        System.out.println("image >>> " + productImage_new);	// 확인용
        
        String productImageDetail_new = multi.getFilesystemName("productSpecInfo");
       
        if(productImageDetail_new == null) {	// 상품 수정 폼에서 새로 상품 상세설명 이미지를 넣지 않으면 
        	productImageDetail_new = multi.getParameter("p_imageDetail_old"); // 상품 등록 시 저장한 상품 상세설명 이미지
        }
        
        int productQty = 0;
        String productQtyParam = multi.getParameter("productQuantity");
        
        if (productQtyParam != null && !productQtyParam.trim().isEmpty()) {
            try {
                productQty = Integer.parseInt(productQtyParam);
            } catch (NumberFormatException e) {
                
                productQty = 0;  // 기본값 설정
            }
        }
        
        String productSize = multi.getParameter("productSize");
       
        int productPrice = 0;
        String productPriceParam = multi.getParameter("productPrice");
       
        if (productPriceParam != null && !productPriceParam.trim().isEmpty()) {
            try {
                productPrice = Integer.parseInt(productPriceParam);
            } catch (NumberFormatException e) {
                
                productPrice = 0;  // 기본값 설정
            }
        }
        
        ProductDTO dto = new ProductDTO();
        
        dto.setProduct_no(productNo);
        dto.setProduct_name(productName);
        dto.setCategory_no(category_no);
        dto.setProduct_spec(productSpec);
        dto.setProduct_image(productImage_new);
        dto.setProduct_specInfo(productImageDetail_new);
        dto.setProduct_qty(productQty);
        dto.setProduct_size(productSize);
        dto.setProduct_price(productPrice);
        
        
        
        ProductDAO dao = ProductDAO.getInstance();
        
        int updateResult = dao.updateProduct(dto);
        
        

        
        // 수정 폼 페이지로 이동
        ActionForward forward = new ActionForward();
        if (updateResult > 0) {	// 성공
        	forward.setRedirect(true);
        	forward.setPath("product_info.go?productId="+productNo);  // 상세정보 페이지로
            
        }else {	// 실패
        	forward.setRedirect(true);
            forward.setPath("error/error_404.jsp");
        }
        
        
        return forward;
    
   }
}
