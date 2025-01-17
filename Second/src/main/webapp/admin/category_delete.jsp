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
        .product-card {
            border: 2px solid #4e73df; /* 카드 테두리 색상 변경 */
            border-radius: 8px;
            padding: 20px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            margin-bottom: 30px;
        }
        .button-container {
            display: flex;
            justify-content: center;
            margin-top: 30px;
        }

        /* 수정: 제목 색상 변경 */
        h2.text-center {
            color: #4e73df; /* 카테고리 삭제 제목 색상 */
        }

        /* 수정: 라벨 색상 변경 */
        .form-group label {
            color: #4e73df; /* 삭제할 카테고리 라벨 색상 */
            font-weight: bold;
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
        <h2 class="text-center mb-4">카테고리 삭제</h2>

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

        <!-- 카테고리 삭제 폼 카드 -->
        <div class="product-card">
            <form id="deleteForm" action="${pageContext.request.contextPath}/category_delete_ok.go" method="POST" class="category-form">
                <c:set var="cList" value="${cList}" />

                <div class="form-group">
                    <label for="category_no">삭제할 카테고리:</label>
                    <select name="no" id="category_no" class="form-control" required="required">
                        <c:if test="${empty cList}">
                            <option value="">:::카테고리 목록 없음:::</option>
                        </c:if>
                        <c:if test="${!empty cList}">
                        	<option value="">:::카테고리 목록 선택:::</option>
                            <c:forEach items="${cList}" var="dto">
                                <option value="${dto.getCategory_no()}">${dto.getCategory_name()} [${dto.getCategory_code()}]</option>
                            </c:forEach>
                        </c:if>
                    </select>
                </div>

                <div class="button-container">
                    <!-- 삭제 버튼을 클릭했을 때 SweetAlert2 팝업 띄우기 -->
                    <button type="button" class="btn btn-danger" onclick="confirmDelete()">카테고리 삭제</button>
                </div>
            </form>
        </div>

    </div>

    <script>
    // 삭제 버튼 클릭 시 팝업 띄우기
    function confirmDelete() {
        var categoryNo = document.getElementById("category_no").value; // 선택된 카테고리 값

        // 카테고리가 선택되지 않은 경우 경고 팝업 띄우기
        if (categoryNo === "") {
            Swal.fire({
                title: '카테고리 목록을 선택해주세요!',
                icon: 'error',
                confirmButtonText: '확인'
            });
            return; // 카테고리가 선택되지 않으면 함수 종료
        }

        // 카테고리가 선택된 경우, 삭제 확인 팝업 띄우기
        Swal.fire({
            title: '정말 삭제하시겠습니까?',
            icon: 'warning',
            showCancelButton: true,
            confirmButtonText: '예',
            cancelButtonText: '아니오'
        }).then((result) => {
            if (result.isConfirmed) {
                // 예를 클릭하면 삭제 완료 팝업을 띄운 후 폼 제출
                Swal.fire({
                    title: '삭제 완료!',
                    icon: 'success',
                    confirmButtonText: '확인'
                }).then(() => {
                    document.getElementById('deleteForm').submit(); // 폼 제출
                });
            } else {
                // 아니오를 클릭하면 삭제 취소 팝업을 띄운 후 아무 일도 일어나지 않음
                Swal.fire({
                    title: '삭제 취소!',
                    icon: 'error',
                    confirmButtonText: '확인'
                });
            }
        });
    }
</script>

</body>
</html>
