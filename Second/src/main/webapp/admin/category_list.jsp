<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>카테고리 목록</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resource/startbootstrap_admin_pages/css/style.css">
   	<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">

	<!-- <style>
        .modal-header {
            background-color: #5cb85c;
            color: white;
        }
        .modal-header.error {
            background-color: #d9534f;
        }
        .modal-footer button {
            width: 100px;
        }
    </style> -->

</head>
<body>

    <!-- 헤더 포함 -->
    <jsp:include page="/include/admin_header.jsp" />

    <!-- 네비게이션 바 포함 -->
    <jsp:include page="/include/admin_navbar.jsp" />

    <!-- 메인 콘텐츠 -->
    <div class="container">
    
    <br>
        <h2 class="text-center mb-4">카테고리 목록</h2>

	<%--  <!-- 수정 결과 메시지 출력 -->
        <c:if test="${not empty message}">
            <!-- 모달 시작 -->
            <div class="modal fade" id="messageModal" tabindex="-1" role="dialog" aria-labelledby="messageModalLabel" aria-hidden="true">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header ${messageType == 'success' ? '' : 'error'}">
                            <h5 class="modal-title" id="messageModalLabel">알림</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <p>${message}</p>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">확인</button>
                        </div>
                    </div>
                </div>
            </div>
            <!-- 모달 끝 -->
        </c:if> --%>


        <table class="table table-bordered">
            <thead>
                <tr align="center">
                	<th>카테고리 번호</th>
                    <th>카테고리 코드</th>
                    <th>카테고리 이름</th>
                </tr>
            </thead>
            <tbody>
	            <c:set var="list" value="${categoryList }" />  
	            <c:if test="${!empty list }">         
	                <c:forEach items="${list }" var="category">
	                    <tr>
	                        <td align="center">${category.getCategory_no() }</td>
	                        <td align="center">${category.getCategory_code() }</td>
	                        <td align="center">${category.getCategory_name() }</td>
	                    </tr>
	                </c:forEach>
                </c:if> 
            </tbody>
        </table>
    </div>

</body>
</html>
