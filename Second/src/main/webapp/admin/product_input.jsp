<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 등록</title>
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
    <jsp:include page ="/include/admin_header.jsp" />

    <!-- 네비게이션 바 포함 -->
    <jsp:include page ="/include/admin_navbar.jsp" />

	<div class="container mt-5">
	
	<br> <br>
        <h2 class="text-center mb-4">상품 등록</h2>
        <form action="product_input_process.jsp" method="post" enctype="multipart/form-data">
            <!-- 상품명 -->
            <div class="mb-3">
                <label for="productName" class="form-label">상품명</label>
                <input type="text" class="form-control" id="productName" name="productName" required>
            </div>

            <!-- 상품 가격 -->
            <div class="mb-3">
                <label for="productPrice" class="form-label">상품 가격 (원)</label>
                <input type="number" class="form-control" id="productPrice" name="productPrice" min="0" required>
            </div>

            <!-- 상품 카테고리 -->
            <div class="mb-3">
                <label for="productCategory" class="form-label">카테고리</label>
                <select class="form-select" id="productCategory" name="productCategory" required onchange="updateSubCategory()">
                    <option value="" disabled selected>카테고리를 선택하세요</option>
                    <option value="male">남성</option>
                    <option value="female">여성</option>
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
                <label for="productDescription" class="form-label">상품 설명</label>
                <textarea class="form-control" id="productSpec" name="productDescription" rows="4" required></textarea>
            </div>

            <!-- 상품 이미지 -->
            <div class="mb-3">
                <label for="productImage" class="form-label">상품 이미지</label>
                <input type="file" class="form-control" id="productImage" name="productImage" accept="image/*" required>
            </div>

            <!-- 상품 수량 -->
            <div class="mb-3">
                <label for="productQuantity" class="form-label">재고 수량</label>
                <input type="number" class="form-control" id="productQuantity" name="productQuantity" min="0" required>
            </div>

            <!-- 제출 버튼 -->
            <div class="text-center">
                <button type="submit" class="btn btn-primary">상품 등록</button>
            </div>
        </form>
    </div>

	<%-- 
	sc_product 테이블 칼럼이 다들어가야되나?
	상품 번호	--> db에서 자동등록이 됐나??
	카테고리 번호 --> 외래키니까 카테고리와 하위 카테고리를 통해 선택된 값으로?
	상품 이름 ++
	상품 가격 ++
	상품 정보(설명) ++
	상품 수량(재고) ++
	상품 조회수 --> 기본값으로 하면 될듯
	상품 이미지 ++ 
	
	 --%>


	<%--
	상품 등록 버튼을 누르면 어디로 이동할지? or 창을 띄울지?(추가 등록 yes/no) 정하기
	 --%>


</body>
</html>
