<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>상품 목록</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resource/startbootstrap_admin_pages/css/style.css">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">

    <!-- SweetAlert2 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/sweetalert2@11.7.0/dist/sweetalert2.min.css" rel="stylesheet">

    <!-- SweetAlert2 JS -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.7.0/dist/sweetalert2.min.js"></script>

    <style>
        /* h2 태그 글자색 변경 */
        .container h2 {
        	text-align: center;
            color: #4e73df; /* 상품 목록 제목 색상 */
        }
		
		/* 각 container 사이에 적당한 여백 추가 */
		.container {
			margin-top: 20px;
		}
		
        /* th 태그 글자색 변경 */
        th {
            color: #4e73df; /* 테이블 헤더 글자 색상 */
        }

        .btn-danger {
            background-color: #f8d7da;
            border-color: #f5c6cb;
            color: #721c24;
        }

        .btn-danger:hover {
            background-color: #f5c6cb;
            border-color: #f1a9b8;
        }
        
        /* sub 태그 스타일 */
	    sub {
	        color: #4e73df;
	        text-align: right;
	        display: block;
	        margin-top: 20px;
	        padding-right: 10px;
	        width: 100%;
	        font-size: 0.9rem; /* 글자 크기 조정 */
	        
	    }
    </style>

</head>
<body>

    <!-- 헤더 포함 -->
    <jsp:include page="/include/admin_header.jsp" />

    <!-- 네비게이션 바 포함 -->
    <jsp:include page="/include/admin_navbar.jsp" />

    <!-- 메인 콘텐츠 -->
    <div class="container">
    
    <br>
        <h2 class="text-primary">상품 목록</h2>
		<sub>* 해당 상품 이름 클릭 시 상세정보 확인 가능</sub>
		
		<br>
        <table class="table table-bordered">
            <thead>
                <tr align="center">
                    <th>상품 번호</th>
                    <th>카테고리 번호</th>
                    <th>이름</th>
                    <th>가격</th>
                    <th>조회수</th>
                    <th>이미지</th>
                    <th>수정</th>
                    <th>삭제</th>
                </tr>
            </thead>
            <tbody>
                <c:set var="list" value="${productList}" />  
                <c:if test="${!empty list}">         
                    <c:forEach items="${list}" var="product">
                        <tr>
                            <td align="center">${product.getProduct_no()}</td>
                            <td align="center">${product.getCategory_no()}</td>
                            <!-- 상품 이름을 클릭했을 때 상세 페이지로 이동 -->
                            <td align="center">
                                <a href="${pageContext.request.contextPath}/product_info.go?productId=${product.getProduct_no()}">${product.getProduct_name()}</a>
                            </td>
                            <td align="center">${product.getProduct_price()}</td>
                            <td align="center">${product.getProduct_hit()}</td>
                            <td align="center">
                                <img src="<%= request.getContextPath() %>/resource/img/${ product.getProduct_image() }" alt="상품 이미지" width="100" height="100"/>
                            </td>
                            <td align="center">
                                <!-- 수정 버튼 -->
                                <a href="${pageContext.request.contextPath}/product_modify.go?productId=${product.getProduct_no()}" class="btn btn-warning">수정</a>
                            </td>
                            <td align="center">
                                <!-- 삭제 버튼 -->
                                <button class="btn btn-danger" onclick="confirmDelete(${product.getProduct_no()})">삭제</button>
                            </td>
                        </tr>
                    </c:forEach>
                </c:if> 
            </tbody>
        </table>
    </div>

    <script>
        // 삭제 확인 알림창
        function confirmDelete(productId) {
            Swal.fire({
                title: '삭제하시겠습니까?',
                text: '이 작업은 되돌릴 수 없습니다.',
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: '예, 삭제합니다!',
                cancelButtonText: '아니요, 취소합니다!'
            }).then((result) => {
                if (result.isConfirmed) {
                    // 삭제 로직 구현
                    window.location.href = "${pageContext.request.contextPath}/product_delete.go?productId=" + productId;
                    Swal.fire(
                        '삭제 완료!',
                        '선택한 상품이 삭제되었습니다.',
                        'success'
                    );
                }
            });
        }
    </script>

</body>
</html>
