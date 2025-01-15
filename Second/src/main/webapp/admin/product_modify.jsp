<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>상품 수정</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resource/startbootstrap_admin_pages/css/style.css">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
    <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.js"></script>
    <script>
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
                
                // 기본 선택 값 설정 (상품 정보에 맞게 하위 카테고리 선택)
                const selectedSubCategory = "${product.productSubCategory}";
                if (selectedSubCategory) {
                    subCategory.value = selectedSubCategory;
                }
            }
        }

        // 페이지 로드 시, 카테고리 선택에 맞게 하위 카테고리 초기화
        window.onload = function() {
            updateSubCategory();
        };
    </script>
</head>
<body>

    <!-- 헤더 포함 -->
    <jsp:include page="/include/admin_header.jsp" />

    <!-- 네비게이션 바 포함 -->
    <jsp:include page="/include/admin_navbar.jsp" />

    <div class="container mt-5">
        <h2 class="text-center mb-4">상품 수정</h2>
        <form action="<%=request.getContextPath() %>/product_modify_ok.go" method="post" enctype="multipart/form-data">
            
            <!-- 상품 번호 (읽기 전용) -->
            <div class="mb-3">
                <label for="productId" class="form-label">상품 번호</label>
                <input type="text" class="form-control" id="productId" name="productId" value="${product != null ? product.productId : ''}" readonly>
            </div>

            <!-- 상품명 -->
            <div class="mb-3">
                <label for="productName" class="form-label">상품명</label>
                <input type="text" class="form-control" id="productName" name="productName" value="${product != null ? product.productName : ''}" required>
            </div>

            <!-- 상품 카테고리 -->
            <div class="mb-3">
                <label for="productCategory" class="form-label">카테고리</label>
                <select class="form-select" id="productCategory" name="productCategory" required onchange="updateSubCategory()">
                    <option value="" disabled ${product != null && product.productCategory == '' ? 'selected' : ''}>카테고리를 선택하세요</option>
                    <option value="male" ${product != null && product.productCategory == 'male' ? 'selected' : ''}>남성</option>
                    <option value="female" ${product != null && product.productCategory == 'female' ? 'selected' : ''}>여성</option>
                </select>
            </div>

            <!-- 하위 카테고리 -->
            <div class="mb-3" id="subCategoryContainer" style="display: none;">
                <label for="productSubCategory" class="form-label">하위 카테고리</label>
                <select class="form-select" id="productSubCategory" name="productSubCategory">
                    <option value="" disabled selected>하위 카테고리를 선택하세요</option>
                </select>
            </div>

            <!-- 상품 설명 -->
            <div class="mb-3">
                <label for="productSpec" class="form-label">상품 설명</label>
                <textarea class="form-control" id="productSpec" name="productSpec" rows="4" required>${product != null ? product.productSpec : ''}</textarea>
            </div>

            <!-- 상품 이미지 -->
            <div class="mb-3">
                <label for="productImage" class="form-label">상품 이미지</label>
                <input type="file" class="form-control" id="productImage" name="productImage" accept="image/*">
            </div>

            <!-- 상품 이미지 추가(상품 상세설명 이미지) -->
            <div class="mb-3">
                <label for="productSpecInfo" class="form-label">상품 설명 이미지</label>
                <input type="file" class="form-control" id="productSpecInfo" name="productSpecInfo" accept="image/*">
            </div>

            <!-- 상품 수량(재고) -->
            <div class="mb-3">
                <label for="productQuantity" class="form-label">재고 수량</label>
                <input type="number" class="form-control" id="productQuantity" name="productQuantity" value="${product != null ? product.productQuantity : ''}" min="0" required>
            </div>

            <!-- 상품 사이즈 -->
            <div class="mb-3">
                <label class="form-label">상품 사이즈</label><br>
                <label>
                    <input type="radio" name="productSize" value="XS" ${product != null && product.productSize == 'XS' ? 'checked' : ''} required> XS &nbsp;&nbsp;
                </label>
                <label>
                    <input type="radio" name="productSize" value="S" ${product != null && product.productSize == 'S' ? 'checked' : ''}> S &nbsp;&nbsp;
                </label>
                <label>
                    <input type="radio" name="productSize" value="M" ${product != null && product.productSize == 'M' ? 'checked' : ''}> M &nbsp;&nbsp;
                </label>
                <label>
                    <input type="radio" name="productSize" value="L" ${product != null && product.productSize == 'L' ? 'checked' : ''}> L &nbsp;&nbsp;
                </label>
                <label>
                    <input type="radio" name="productSize" value="XL" ${product != null && product.productSize == 'XL' ? 'checked' : ''}> XL 
                </label>
            </div>

            <!-- 상품 가격 -->
            <div class="mb-3">
                <label for="productPrice" class="form-label">상품 가격 (원)<sub>&nbsp;&nbsp;5,000원씩 증감</sub></label>
                <input type="number" class="form-control" id="productPrice" name="productPrice" value="${product != null ? product.productPrice : ''}" min="0" step="5000" required>
            </div>

            <!-- 제출 버튼 -->
            <div class="text-center">
                <button type="submit" class="btn btn-primary">상품 수정</button>
            </div>
        </form>
    </div>

</body>
</html>
