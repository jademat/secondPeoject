<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 수정</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/startbootstrap_admin_pages/css/style.css">
   	<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.js"></script>
<script>
    // 카테고리에 따라 하위 카테고리 표시
    function updateSubCategory() {
        const mainCategory = document.getElementById("productCategory").value;
        const subCategoryContainer = document.getElementById("subCategoryContainer");
        const subCategory = document.getElementById("productSubCategory");

        // 초기화
        subCategory.innerHTML = '<option value="" disabled selected>하위 카테고리를 선택하세요</option>';
        subCategoryContainer.style.display = "none";

        if (mainCategory === "male") {
            subCategoryContainer.style.display = "block";
            subCategory.innerHTML += `
                <option value="outer">아우터</option>
                <option value="top">상의</option>
                <option value="bottom">하의</option>
            `;
        } else if (mainCategory === "female") {
            subCategoryContainer.style.display = "block";
            subCategory.innerHTML += `
                <option value="outer">아우터</option>
                <option value="top">상의</option>
                <option value="bottom">하의</option>
            `;
        }
    }
</script>
</head>
<body>

    <!-- 헤더 포함 -->
    <jsp:include page="/include/admin_header.jsp" />

    <!-- 네비게이션 바 포함 -->
    <jsp:include page="/include/admin_navbar.jsp" />

    <div class="container mt-5">
    
    <br> <br>
        <h2 class="text-center mb-4">상품 수정</h2>
        <form action="product_modify_process.jsp" method="post" enctype="multipart/form-data">
           
           <%-- 상품 번호를 선택하면 상품명은 자동으로 입력되게(읽기전용으로) --%>
           
            <!-- 상품 번호 -->
            <div class="mb-3">
                <label for="productId" class="form-label">상품 번호</label>
                <input type="text" class="form-control" id="productId" name="productId" placeholder="수정할 상품 번호를 입력하세요" required>
            </div>

            <!-- 상품명 -->
            <div class="mb-3">
                <label for="productName" class="form-label">상품명</label>
                <input type="text" class="form-control" id="productName" name="productName" placeholder="변경할 상품명을 입력하세요">
            </div>

            <!-- 상품 가격 -->
            <div class="mb-3">
                <label for="productPrice" class="form-label">상품 가격 (원)</label>
                <input type="number" class="form-control" id="productPrice" name="productPrice" min="0" placeholder="변경할 상품 가격을 입력하세요">
            </div>

            <!-- 상품 카테고리 -->
            <div class="mb-3">
                <label for="productCategory" class="form-label">카테고리</label>
                <select class="form-select" id="productCategory" name="productCategory" onchange="updateSubCategory()">
                    <option value="" disabled selected>변경할 카테고리를 선택하세요</option>
                    <option value="male">남성</option>
                    <option value="female">여성</option>
                </select>
            </div>

            <!-- 하위 카테고리 -->
            <div class="mb-3" id="subCategoryContainer" style="display: none;">
                <label for="productSubCategory" class="form-label">하위 카테고리</label>
                <select class="form-select" id="productSubCategory" name="productSubCategory">
                    <option value="" disabled selected>변경할 하위 카테고리를 선택하세요</option>
                </select>
            </div>

            <!-- 상품 설명 -->
            <div class="mb-3">
                <label for="productDescription" class="form-label">상품 설명</label>
                <textarea class="form-control" id="productDescription" name="productDescription" rows="4" placeholder="변경할 상품 설명을 입력하세요"></textarea>
            </div>

            <!-- 상품 이미지 -->
            <div class="mb-3">
                <label for="productImage" class="form-label">상품 이미지</label>
                <input type="file" class="form-control" id="productImage" name="productImage" accept="image/*">
            </div>

            <!-- 상품 수량 -->
            <div class="mb-3">
                <label for="productQuantity" class="form-label">재고 수량</label>
                <input type="number" class="form-control" id="productQuantity" name="productQuantity" min="0" placeholder="변경할 재고 수량을 입력하세요">
            </div>

            <!-- 제출 버튼 -->
            <div class="text-center">
                <button type="submit" class="btn btn-primary">상품 수정</button>
            </div>
        </form>
    </div>
</body>
</html>
