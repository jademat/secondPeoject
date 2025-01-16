<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 등록</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/startbootstrap_admin_pages/css/style.css">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.js"></script>
<!-- SweetAlert2 JS 추가 -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.7.9/dist/sweetalert2.all.min.js"></script>
<!-- SweetAlert2 CSS 추가 -->
<link href="https://cdn.jsdelivr.net/npm/sweetalert2@11.7.9/dist/sweetalert2.min.css" rel="stylesheet">

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
            subCategory.innerHTML += 
            	'<option value="1">상의</option>' +
                '<option value="2">하의</option>' +
                '<option value="3">아우터</option>' ;
        } else if (mainCategory === "female") {
            subCategoryContainer.style.display = "block";
            subCategory.innerHTML += 
            	'<option value="4">상의</option>' +
                '<option value="5">하의</option>' +
                '<option value="6">아우터</option>' ;
        }
    }

    // 상품 등록 완료 후 알림창 표시
    function showSuccessAlert(event) {
        event.preventDefault(); // 폼 제출을 일시적으로 막음

        // SweetAlert2 알림창
        Swal.fire({
            title: '상품 등록 성공!',
            text: '상품 목록 페이지로 이동합니다.',
            icon: 'success',
            confirmButtonText: '확인'
        }).then((result) => {
            if (result.isConfirmed) {
                // 알림창에서 "확인"을 클릭하면 폼을 제출
                event.target.submit();
            }
        });
    }
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
        accent-color: #6c757d; /* 라디오 버튼 색상 변경 (진한 회색) */
    }
    label {
        color: #4e73df; /* 라벨 색상 변경 */
    }
    sub {
        color: black; /* sub 태그 색상 원래대로 */
    }
    .radio-label {
        color: black; /* 상품 사이즈 라디오 버튼 텍스트 색상 */
    }
</style>
</head>
<body>

    <!-- 헤더 포함 -->
    <jsp:include page="/include/admin_header.jsp" />

    <!-- 네비게이션 바 포함 -->
    <jsp:include page="/include/admin_navbar.jsp" />

    <!-- 메인 콘텐츠 -->
    <div class="container mt-5">
        <h2 class="text-center mb-4">상품 등록</h2>

        <!-- 카드로 감싼 폼 -->
        <div class="card">
            <div class="card-body">
                <form action="<%=request.getContextPath() %>/product_input_ok.go" method="post" enctype="multipart/form-data" onsubmit="showSuccessAlert(event)">
                    <!-- 상품명 -->
                    <div class="mb-3">
                        <label for="productName" class="form-label">상품명</label>
                        <input type="text" class="form-control" id="productName" name="productName" required>
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
                        <label for="productSpec" class="form-label">상품 설명</label>
                        <textarea class="form-control" id="productSpec" name="productSpec" rows="4" required></textarea>
                    </div>

                    <!-- 상품 이미지 -->
                    <div class="mb-3">
                        <label for="productImage" class="form-label">상품 이미지</label>
                        <input type="file" class="form-control" id="productImage" name="productImage" accept="image/*" required>
                    </div>

                    <!-- 상품 이미지 추가(상품 상세정보 이미지) -->
                    <div class="mb-3">
                        <label for="productSpecInfo" class="form-label">상품 상세설명 이미지</label>
                        <input type="file" class="form-control" id="productSpecInfo" name="productSpecInfo" accept="image/*" required>
                    </div>

                    <!-- 상품 수량(재고) -->
                    <div class="mb-3">
                        <label for="productQuantity" class="form-label">재고 수량</label>
                        <input type="number" class="form-control" id="productQuantity" name="productQuantity" min="0" required>
                    </div>

                    <!-- 상품 사이즈 -->
                    <div class="mb-3">
                        <label class="form-label">상품 사이즈</label><br>
                        <label class="radio-label">
                            <input type="radio" name="productSize" value="XS" required> XS &nbsp;&nbsp;
                        </label>
                        <label class="radio-label">
                            <input type="radio" name="productSize" value="S"> S &nbsp;&nbsp;
                        </label>
                        <label class="radio-label">
                            <input type="radio" name="productSize" value="M"> M &nbsp;&nbsp;
                        </label>
                        <label class="radio-label">
                            <input type="radio" name="productSize" value="L"> L &nbsp;&nbsp;
                        </label>
                        <label class="radio-label">
                            <input type="radio" name="productSize" value="XL"> XL 
                        </label>
                    </div>

                    <!-- 상품 가격 -->
                    <div class="mb-3">
                        <label for="productPrice" class="form-label">상품 가격 (원)<sub>&nbsp;&nbsp;5,000원씩 증감</sub></label>
                        <input type="number" class="form-control" id="productPrice" name="productPrice" min="0" step="5000" required>
                    </div>
					
					<br>
					
                    <!-- 제출 버튼 -->
                    <div class="text-center">
                        <button type="submit" class="btn btn-primary">상품 등록</button>
                    </div>
                </form>
            </div>
        </div>

    </div>

    

</body>
</html>
