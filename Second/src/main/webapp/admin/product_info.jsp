<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>상품 상세 정보</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resource/startbootstrap_admin_pages/css/style.css">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .product-card {
            border: 1px solid #ddd;
            border-radius: 8px;
            padding: 20px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            margin-bottom: 30px;
        }
        .product-card img {
            width: auto; /* 자동 크기 조정 */
            height: auto; /* 자동 크기 조정 */
            max-width: 100%; /* 최대 너비는 부모의 너비를 넘지 않도록 제한 */
            border-radius: 8px;
        }
        .btn-custom {
            margin-top: 20px;
            padding: 10px 20px;
        }
        .product-info {
            display: flex;
            justify-content: space-between;  /* 레이블과 값을 양옆으로 배치 */
            margin-bottom: 15px;
            align-items: center;  /* 세로로 중앙 정렬 */
        }
        .product-info label {
            font-weight: bold;
            width: 150px;  /* 고정된 너비로 레이블 공간을 확보 */
            margin-right: 15px;  /* 레이블과 값 사이의 간격 */
        }
        .product-info p {
            margin: 0;
            flex-grow: 1;  /* 남은 공간을 채워서 레이블과 값이 더 가까워지지 않도록 */
        }
        .button-container {
            display: flex;
            justify-content: center;
            margin-top: 30px;
        }
    </style>
</head>
<body>

    <!-- 헤더 포함 -->
    <jsp:include page="/include/admin_header.jsp" />

    <!-- 네비게이션 바 포함 -->
    <jsp:include page="/include/admin_navbar.jsp" />

    <div class="container mt-5">
        <h2 class="text-center mb-4">상품 상세 정보</h2>

        <c:set var="product" value="${Product}" />
        <c:if test="${!empty product}">
            <div class="product-card">
                <div class="product-info">
                    <label>상품 번호 :</label>
                    <p>${product.getProduct_no()}</p>
                </div>
                
                <div class="product-info">
                    <label>카테고리 번호 :</label>
                    <p>${product.getCategory_no()}</p>
                </div>
                
                <div class="product-info">
                    <label>상품명 :</label>
                    <p>${product.getProduct_name()}</p>
                </div>
                
                <div class="product-info">
                    <label>상품 가격 :</label>
                    <p>${product.getProduct_price()} 원</p>
                </div>
                
                <div class="product-info">
                    <label>상품 설명 :</label>
                    <p>${product.getProduct_spec()}</p>
                </div>
                
                <div class="product-info">
                    <label>상품 재고 :</label>
                    <p>${product.getProduct_qty()}</p>
                </div>
                
                <div class="product-info">
                    <label>상품 조회수 :</label>
                    <p>${product.getProduct_hit()}</p>
                </div>
                
                <div class="product-info">
                    <label>상품 사이즈 :</label>
                    <p>${product.getProduct_size()}</p>
                </div>
                
                <div class="product-info">
                    <label>상품 이미지 :</label>
                    <img src="${pageContext.request.contextPath}/upload/${product.getProduct_image()}" alt="상품 이미지" />
                </div>
                
                <div class="product-info">
                    <label>상품 상세 설명 이미지 :</label>
                    <img src="${pageContext.request.contextPath}/upload/${product.getProduct_specInfo()}" alt="상품 상세 이미지" />
                </div>
            </div>

            <!-- 버튼 -->
            <div class="button-container">
                <a href="${pageContext.request.contextPath}/product_modify.go?productId=${product.getProduct_no()}" class="btn btn-warning mx-2 btn-custom">수정</a>

                <form action="${pageContext.request.contextPath}/product_delete.go" method="post" onsubmit="return confirm('정말 삭제하시겠습니까?');" class="mx-2">
                    <input type="hidden" name="productId" value="${product.getProduct_no()}">
                    <button type="submit" class="btn btn-danger btn-custom">삭제</button>
                </form>

                <a href="${pageContext.request.contextPath}/product_list.go" class="btn btn-primary mx-2 btn-custom">상품 목록</a>
            </div>
        </c:if>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
