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

public class ProductInputOkAction implements Action {

    @Override
    public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
        
        // 첨부파일 저장 경로
        String saveFolder = "C:\\Users\\bin43\\git\\secondPeoject\\Second\\src\\main\\webapp\\resource\\img";
        
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
        
        // 폼 데이터 추출
        String productName = multi.getParameter("productName");
        int productPrice = Integer.parseInt(multi.getParameter("productPrice"));
        String productSpec = multi.getParameter("productSpec");  // 상품 설명
        int productQty = Integer.parseInt(multi.getParameter("productQuantity"));  // 상품 수량
        String productCategory = multi.getParameter("productCategory"); // 카테고리 코드
        String productSubCategory = multi.getParameter("productSubCategory");
        String productImage = multi.getFilesystemName("productImage");
        String productSpecInfo = multi.getFilesystemName("productSpecInfo");  // 상품 상세설명 이미지
        String productSize = multi.getParameter("productSize");
        
        // 카테고리 코드에서 카테고리 번호로 변환
        int categoryNo = ProductDAO.getInstance().getCategoryNoByCode(productCategory, productSubCategory);
        
        // 카테고리 번호가 유효하지 않으면 상품 등록 X
        if (categoryNo == 0) {
            
            System.out.println("잘못된 카테고리 코드: " + productCategory);
            
            // 오류 메시지
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "유효하지 않은 카테고리 코드입니다. (잘못된 카테고리 코드: " + productCategory + ")");
            return null;  // 잘못된 카테고리 코드일 경우 오류
        }
        
        // ProductDTO 객체에 데이터 담기
        ProductDTO dto = new ProductDTO();
        dto.setCategory_no(categoryNo);
        dto.setProduct_name(productName);
        dto.setProduct_price(productPrice);
        dto.setProduct_spec(productSpec);
        dto.setProduct_qty(productQty);
        dto.setProduct_image(productImage);
        dto.setProduct_specInfo(productSpecInfo);
        dto.setProduct_size(productSize);
        
        System.out.println("Product Name: " + productName);
        System.out.println("Category No: " + categoryNo);
        System.out.println("Product Price: " + productPrice);
        
        // 상품 등록
        ProductDAO dao = ProductDAO.getInstance();
        int result = dao.insertProduct(dto);

        // 상품 등록 후 이동할 페이지 설정
        ActionForward forward = new ActionForward();
        if (result == 1) {	// 성공 시 상품 목록 페이지로
            forward.setPath("product_list.go");  
            forward.setRedirect(true);
        } else {	// 실패 시 다시 상품 등록 페이지로
            forward.setPath("product_input.go");  
            forward.setRedirect(true);
        }

        return forward;
    }
}
