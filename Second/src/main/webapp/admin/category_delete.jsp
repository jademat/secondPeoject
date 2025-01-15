<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>카테고리 삭제</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resource/startbootstrap_admin_pages/css/styles.css">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script> <!-- jQuery 추가 -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- SweetAlert2 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/sweetalert2@11.7.0/dist/sweetalert2.min.css" rel="stylesheet">

    <!-- SweetAlert2 JS -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.7.0/dist/sweetalert2.min.js"></script>

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
        <h2 class="text-center mb-4">카테고리 삭제</h2>
        <hr width="65%">
        <br><br>

        <!-- 삭제 결과 메시지 출력 -->
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
                $(document).ready(function() {
                    $('#messageModal').modal('show'); // 모달 자동으로 띄우기
                });
            </script>
        </c:if>

        <!-- 카테고리 삭제 폼 -->
        <form action="${pageContext.request.contextPath}/category_delete_ok.go" method="POST" class="category-form">
            <c:set var="cList" value="${cList}" />

            <div class="form-group">
                <label for="category_no">삭제할 카테고리:</label>
                <select name="no" id="category_no" class="form-control" required="required">
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
                <label for="category_name">카테고리 이름:</label>
                <input type="text" id="category_name" name="category_name" class="form-control" readonly />
            </div>

            <br>
            <div class="form-group">
                <input type="submit" value="카테고리 삭제" class="btn btn-danger" />
            </div>
        </form>
    </div>

    <script>
        // 카테고리 선택 시 이름 자동 입력
        $(document).ready(function() {
            $('#category_no').change(function() {
                var selectedOption = $(this).find('option:selected');
                var categoryName = selectedOption.text().split(' [')[0];
                $('#category_name').val(categoryName);
            });
        });
    </script>

</body>
</html>
