<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>카테고리 수정</title>
    
    
    <!-- 로컬 CSS 파일 경로 -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resource/startbootstrap_admin_pages/css/styles.css">
    
    <!-- FontAwesome (외부 링크) -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
    
    <!-- Bootstrap 4 (외부 링크) -->
    <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.js"></script>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">

	<!-- SweetAlert2 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/sweetalert2@11.7.0/dist/sweetalert2.min.css" rel="stylesheet">

    <!-- SweetAlert2 JS -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.7.0/dist/sweetalert2.min.js"></script>

    <!-- jQuery (AJAX 요청을 보내기 위해 필요) -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	
    <style>
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
    </style>
</head>
<body>

    <!-- 헤더 포함 -->
    <jsp:include page="/include/admin_header.jsp" />

    <!-- 네비게이션 바 포함 -->
    <jsp:include page="/include/admin_navbar.jsp" />

    <!-- 메인 콘텐츠 -->
    <div class="container">
        <br><br>
        <hr width="65%">
        
        <h2 class="text-center mb-4">카테고리 수정</h2>
        
        <hr width="65%">
        <br><br>

        <!-- 수정 결과 메시지 출력 -->
        <c:if test="${not empty message}">
            <!-- 모달 시작 -->
            <div class="modal fade show" id="messageModal" tabindex="-1" role="dialog" aria-labelledby="messageModalLabel" aria-hidden="true">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header ${messageType == 'success' ? '' : 'error'}">
                            <h5 class="modal-title" id="messageModalLabel">알림</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <p>${message}</p>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">확인</button>
                        </div>
                    </div>
                </div>
            </div>
            <!-- 모달 끝 -->

            <!-- 모달 자동으로 열기 위한 스크립트 -->
            <script>
                // 페이지가 완전히 로드된 후 모달을 띄웁니다.
                $(document).ready(function() {
                    $('#messageModal').modal('show'); // 모달 자동으로 띄우기
                });
            </script>
        </c:if>

        <form action="<%=request.getContextPath() %>/category_modify_ok.go" method="POST" class="category-form">
            <c:set var="cList" value="${categoryList }" />
            
            <div class="form-group">
                <label for="category_no">수정할 카테고리 코드:</label>
                <select name="no">
                    <c:if test="${empty cList}">
                        <option value="">:::카테고리 목록 없음:::</option>
                    </c:if>
                    <c:if test="${!empty cList}">
                        <c:forEach items="${cList}" var="dto">
                            <option value="${dto.getCategory_no()}">${dto.getCategory_name()} [${dto.getCategory_code()}]</option>
                        </c:forEach>
                    </c:if>
                </select>
            </div>

            <div class="form-group">
                <label for="category_name">수정할 카테고리 이름:</label>
                <input type="text" id="category_name" name="category_name" class="form-control" value="${category.category_name}" required="required" />
            </div>

            <br>
            <div class="form-group">
                <input type="submit" value="카테고리 수정" class="btn btn-primary" />
            </div>
        </form>
    </div>

</body>
</html>
