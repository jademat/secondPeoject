<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 삭제</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/startbootstrap_admin_pages/css/style.css">
   	<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script>
    // 상품 번호 입력 시 상품명을 자동으로 가져오는 함수
    function fetchProductName() {
        const productId = document.getElementById("productId").value;

        if (productId.trim() !== "") {
            $.ajax({
                url: "fetch_product_name.jsp",
                type: "GET",
                data: { productId: productId },
                success: function(response) {
                    document.getElementById("productName").value = response.trim();
                },
                error: function() {
                    alert("상품명을 가져오는 중 오류가 발생했습니다.");
                }
            });
        } else {
            document.getElementById("productName").value = "";
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
    	
        <h2 class="text-center mb-4">상품 삭제</h2>
        <form action="product_delete_process.jsp" method="post">
            <!-- 상품 번호 -->
            <div class="mb-3">
                <label for="productId" class="form-label">상품 번호</label>
                <input type="text" class="form-control" id="productId" name="productId" placeholder="삭제할 상품 번호를 입력하세요" required oninput="fetchProductName()">
            </div>

            <!-- 상품명 (자동 표시) -->
            <div class="mb-3">
                <label for="productName" class="form-label">상품명</label>
                <input type="text" class="form-control" id="productName" name="productName" readonly>
            </div>

            <!-- 삭제 버튼 -->
            <div class="text-center">
                <button type="submit" class="btn btn-danger">상품 삭제</button>
            </div>
        </form>
    </div>

</body>
</html>
