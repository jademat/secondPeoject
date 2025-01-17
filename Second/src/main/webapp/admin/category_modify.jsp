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

        /* 수정된 부분: 카드 테두리 색상 */
        .card {
            margin-top: 30px;
            border: 2px solid #4e73df !important; /* 카드 테두리 색상 */
        }
        
        .button-container {
            display: flex;
            justify-content: center; /* 수평 가운데 정렬 */
            align-items: center;     /* 수직 가운데 정렬 */
        }

        /* 수정할 카테고리 코드, 이름, 라벨 색상 변경 */
        .form-group label {
            color: #4e73df; /* 텍스트 색상 */
            font-weight: bold;
        }

        /* '카테고리 수정' 제목 색상 변경 */
        h2.text-center {
            color: #4e73df; /* 텍스트 색상 */
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
        <h2 class="text-center mb-4">카테고리 수정</h2>

        <!-- 수정 결과 메시지 출력 -->
        <c:if test="${not empty message}">
            <script>
                $(document).ready(function() {
                    Swal.fire({
                        title: '${message}',
                        icon: '${messageType == "success" ? "success" : "error"}',
                        confirmButtonText: '확인'
                    }).then(function(result) {
                        if (result.isConfirmed) {
                            window.location.href = "${pageContext.request.contextPath}/category_list.go";
                        }
                    });
                });
            </script>
        </c:if>

        <!-- 카드 안에 폼 -->
        <div class="card">
            <div class="card-body">
                <!-- 카테고리 수정 폼 -->
                <form id="categoryForm" action="${pageContext.request.contextPath}/category_modify_ok.go" method="POST" class="category-form">
                    <c:set var="cList" value="${categoryList }" />
                    
                    <div class="form-group">
                        <label for="category_no">수정할 카테고리 코드:</label>
                        <select name="no" class="form-control" required="required">
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

                    <div class="form-group">
                        <label for="category_name">수정할 카테고리 이름:</label>
                        <input type="text" id="category_name" name="category_name" class="form-control" value="${category.category_name}" required="required" />
                    </div>

                    <br>
                    
                    <div class="button-container">
                        <button type="button" class="btn btn-warning mx-2 btn-custom" onclick="confirmModify()">카테고리 수정</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- SweetAlert2 확인 팝업 스크립트 -->
    <script>
    function confirmModify() {
        var categoryNo = document.querySelector('select[name="no"]').value; // 선택된 카테고리 값

        // 카테고리가 선택되지 않은 경우 경고 팝업 띄우기
        if (categoryNo === "") {
            Swal.fire({
                title: '카테고리 목록을 선택해주세요!',
                icon: 'error',
                confirmButtonText: '확인'
            });
            return; // 카테고리가 선택되지 않으면 함수 종료
        }

        // 카테고리가 선택된 경우, 수정 확인 팝업 띄우기
        Swal.fire({
            title: '정말 수정하시겠습니까?',
            icon: 'warning',
            showCancelButton: true,
            confirmButtonText: '네',
            cancelButtonText: '아니오'
        }).then((result) => {
            if (result.isConfirmed) {
                // 네를 클릭하면 수정 완료 팝업
                Swal.fire({
                    title: '수정 완료!',
                    icon: 'success',
                    confirmButtonText: '확인'
                }).then(() => {
                    // 수정 완료 후 폼을 제출
                    document.getElementById('categoryForm').submit();
                });
            } else {
                // 아니오를 클릭하면 수정 취소 팝업
                Swal.fire({
                    title: '수정 취소!',
                    icon: 'error',
                    confirmButtonText: '확인'
                });
            }
        });
    }
</script>

</body>
</html>
