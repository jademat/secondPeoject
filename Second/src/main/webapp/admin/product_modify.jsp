<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>상품 수정</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resource/startbootstrap_admin_pages/css/style.css">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
    <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.js"></script>
    <script>
        // 카테고리 변경 시 하위 카테고리 초기화
        function updateSubCategory() {
            const mainCategory = document.getElementById("productCategory").value;
            const subCategoryContainer = document.getElementById("subCategoryContainer");
            const subCategory = document.getElementById("productSubCategory");

            subCategory.innerHTML = '<option value="" disabled selected>하위 카테고리를 선택하세요</option>';
            subCategoryContainer.style.display = "none";

            if (mainCategory === "male" || mainCategory === "female") {
                subCategoryContainer.style.display = "block";
                subCategory.innerHTML += 
                    '<option value="top">상의</option>' +
                    '<option value="bottom">하의</option>' +
                    '<option value="outer">아우터</option>';
            }
        }

        // 폼 제출 전에 하위 카테고리 선택 여부 확인
        function validateForm() {
            const mainCategory = document.getElementById("productCategory").value;
            const subCategory = document.getElementById("productSubCategory").value;
            const errorMessage = document.getElementById("errorMessage");

            // 하위 카테고리 선택이 안 된 경우
            if ((mainCategory === "male" || mainCategory === "female") && !subCategory) {
                errorMessage.style.display = "block";  // 경고 메시지 표시
                return false;  // 폼 제출을 막음
            }

            errorMessage.style.display = "none";  // 경고 메시지 숨기기
            return true;  // 폼 제출 허용
        }

        // 페이지 로드 시, 카테고리 선택에 맞게 하위 카테고리 초기화
        window.onload = function() {
            updateSubCategory();
        };
    </script>
   
    <style>
    body {
        background-color: #f1f1f1;
        font-family: 'Arial', sans-serif;
    }

    .container {
        margin-top: 30px;
    }

    h2.text-center {
        color: #4e73df; /* h2 태그 색상 변경 */
    }

    .card {
        border: 2px solid #4e73df !important; /* 카드 테두리 색상 변경 */
    }

    .card-body {
        padding: 30px;
    }

    .form-label {
        color: #4e73df; /* 폼 라벨 색상 변경 */
        font-weight: bold; /* 폼 라벨을 볼드체로 */
    }

    .form-control {
        border-color: #4e73df; /* 입력 필드의 테두리 색상 변경 */
        font-weight: bold; /* 입력 필드를 볼드체로 */
    }

    .form-select {
        border-color: #ced4da; /* 선택 박스 색상 원래대로 */
        display: block; /* 선택박스를 블록 요소로 변경 */
        margin-top: 10px; /* 선택박스를 한 줄 밑으로 내리기 위해 마진 추가 */
    }

    .btn-primary {
        background-color: #4e73df; /* 제출 버튼 색상 변경 */
        border-color: #4e73df;
    }

    .btn-primary:hover {
        background-color: #3b60c0; /* 버튼 hover 색상 */
        border-color: #3b60c0;
    }

    .mb-3 .form-control, .mb-3 .form-select {
        margin-bottom: 20px;
    }

    /* 상품 사이즈 라디오 버튼 색상 변경 */
    input[type="radio"] {
        accent-color: #6c757d; /* 라디오 버튼 색상  (진한 회색) */
    }

    .radio-label {
        color: black; /* 라디오 버튼 옆 텍스트 색상 */
        font-weight: normal; /* 기본 글자 두께 */
    }

    label {
        color: #4e73df; /* 기본 라벨 색상 */
    }

    sub {
        color: black; /* sub 태그 */
    }
</style>
</head>
<body>

    <!-- 헤더 포함 -->
    <jsp:include page="/include/admin_header.jsp" />

    <!-- 네비게이션 바 포함 -->
    <jsp:include page="/include/admin_navbar.jsp" />

    <div class="container mt-5">
        <h2 class="text-center mb-4">상품 수정</h2>

        <!-- 카드 안에 폼 -->
        <div class="card">
            <div class="card-body">
                <form action="<%=request.getContextPath() %>/product_modify_ok.go" method="post" enctype="multipart/form-data" onsubmit="return validateForm()">
                   	
                    <!-- product 객체를 JSP로 전달 -->
                    <c:set var="product" value="${product}" />
                    <c:set var="list" value="${categoryList}" />
                   
                    <%-- <input type="hidden" name="productId" value="${product.getProduct_no()}">  --%>
                    
                    <!-- 상품 번호 (읽기 전용) -->
                    <div class="mb-3">
                        <label for="productId" class="form-label">상품 번호
                        	<sub>(* 변경 불가)</sub>
                        </label>
                        <input type="text" class="form-control" id="productId" name="productId" value="${product != null ? product.getProduct_no() : ''}" readonly>
                    </div>

                    <!-- 상품 카테고리 -->
                    <div class="mb-3">
                        <label for="productCategory" class="form-label">카테고리
                        	<sub>(* 변경 불가)</sub>
                        </label>
                        <select class="form-select" id="productCategory" name="productCategory" required onchange="updateSubCategory()"> 
                             <c:if test="${product.getCategory_no() == 1 || product.getCategory_no() == 2 || product.getCategory_no() == 3 }">
                                <option value="male">남자</option>          
                             </c:if>
                             
                             <c:if test="${product.getCategory_no() == 4 || product.getCategory_no() == 5 || product.getCategory_no() == 6 }">
                                <option value="female">여자</option>         
                             </c:if>
                             
                        </select>
                        
                    </div>
                    
                    <!-- 상품명 -->
                    <div class="mb-3">
                        <label for="productName" class="form-label">상품명</label>
                        <input type="text" class="form-control" id="productName" name="productName" value="${product != null ? product.getProduct_name() : ''}" required>
                    </div>

                    <!-- 하위 카테고리 -->
                    <div class="mb-3" id="subCategoryContainer" style="display: none;">
                        <label for="productSubCategory" class="form-label">하위 카테고리</label>
                        <select class="form-select" id="productSubCategory" name="productSubCategory" required>
                            <option value="" disabled selected>하위 카테고리를 선택하세요</option>
                        </select>
                    </div>

                    <!-- 경고 메시지 (말풍선 모양) -->
                    <!-- <div id="errorMessage" class="alert-warning">
                        <span class="alert-icon"><i class="fas fa-exclamation"></i></span>
                        하위 카테고리를 선택해주세요.
                    </div> -->

                    <!-- 상품 설명 -->
                    <div class="mb-3">
                        <label for="productSpec" class="form-label">상품 설명</label>
                        <textarea class="form-control" id="productSpec" name="productSpec" rows="4" required>${product != null ? product.getProduct_spec() : ''}</textarea>
                    </div>

                    <!-- 상품 이미지 -->
                    <div class="mb-3">
                        <label for="productImage" class="form-label">
                            상품 이미지<sub> (* 이미지는 변경하지 않으면 그대로 유지됩니다.)</sub>
                        </label>
                        <input type="file" class="form-control" id="productImage" name="productImage" accept="image/*">
                        <%-- 이미지를 수정하지 않고 그대로 제품수정(submit) 버튼을 누르면
                        상품 등록 시 입력했던 상품의 이미지를 그대로 사용하여 넘겨줄 예정. --%>
                        <input type="hidden" name="p_image_old" value="${product.getProduct_image() }">
                    </div>
                    
                    <!-- 상품 설명 이미지-->
                    <div class="mb-3">
                        <label for="productSpecInfo" class="form-label">
                            상품 설명 이미지
                            <sub> (* 이미지는 변경하지 않으면 그대로 유지됩니다.)</sub>
                        </label>
                        <input type="file" class="form-control" id="productSpecInfo" name="productSpecInfo" accept="image/*">
                        <%-- 이미지를 수정하지 않고 그대로 제품수정(submit) 버튼을 누르면
                        상품 등록 시 입력했던 상품의 이미지를 그대로 사용하여 넘겨줄 예정. --%>
                        <input type="hidden" name="p_imageDetail_old" value="${product.getProduct_specInfo() }">
                    </div>

                    <!-- 상품 수량(재고) -->
                    <div class="mb-3">
                        <label for="productQuantity" class="form-label">재고 수량</label>
                        <input type="number" class="form-control" id="productQuantity" name="productQuantity" value="${product != null ? product.getProduct_qty() : ''}" min="0" required>
                    </div>

                    <!-- 상품 사이즈 -->
					<div class="mb-3">
					    <label class="form-label">상품 사이즈</label><br>
					    <label class="radio-label">
					        <input type="radio" name="productSize" value="XS" ${product != null && product.getProduct_size() == 'XS' ? 'checked' : ''} required> XS &nbsp;&nbsp;
					    </label>
					    <label class="radio-label">
					        <input type="radio" name="productSize" value="S" ${product != null && product.getProduct_size() == 'S' ? 'checked' : ''}> S &nbsp;&nbsp;
					    </label>
					    <label class="radio-label">
					        <input type="radio" name="productSize" value="M" ${product != null && product.getProduct_size() == 'M' ? 'checked' : ''}> M &nbsp;&nbsp;
					    </label>
					    <label class="radio-label">
					        <input type="radio" name="productSize" value="L" ${product != null && product.getProduct_size() == 'L' ? 'checked' : ''}> L &nbsp;&nbsp;
					    </label>
					    <label class="radio-label">
					        <input type="radio" name="productSize" value="XL" ${product != null && product.getProduct_size() == 'XL' ? 'checked' : ''}> XL 
					    </label>
					</div>

                    <!-- 상품 가격 -->
                    <div class="mb-3">
                        <label for="productPrice" class="form-label">상품 가격 (원)<sub>&nbsp;&nbsp;5,000원씩 증감</sub></label>
                        <input type="number" class="form-control" id="productPrice" name="productPrice" value="${product != null ? product.getProduct_price() : ''}" min="0" step="5000" required>
                    </div>
                    
                    <br> <br>
                    
                    <!-- 제출 버튼 -->
                    <div class="text-center">
                        <button type="submit" class="btn btn-primary">상품 수정</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

</body>
</html>
