<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>관리자 정보 페이지</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resource/startbootstrap_admin_pages/css/style.css">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
    
    <!-- Bootstrap Bundle (JS 포함) -->
    <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    <style>
        .container h2 {
            text-align: center;
            color: #4e73df;
        }

        .table {
            width: auto;
            margin: 0 auto;
        }

        .table th, .table td {
            padding: 8px;
            font-size: 14px;
            text-align: center;
            vertical-align: middle;
        }

        th {
            color: #4e73df;
        }

        .container {
            margin-top: 20px;
        }

        .nickname-link {
            color: #007bff;
            cursor: pointer;
            text-decoration: underline;
        }

        /* 닉네임 변경 모달 스타일 */
        .modal-header .modal-title {
            color: black; /* "닉네임 변경" 글자 색을 검은색으로 변경 */
        }

        .modal-body label {
            color: black; /* "새 닉네임" 글자 색을 검은색으로 변경 */
        }

        /* 저장 버튼 오른쪽 정렬 */
        .modal-footer {
            display: flex;
            justify-content: flex-end; /* 오른쪽 정렬 */
            align-items: center; /* 세로로 가운데 정렬 */
            padding: 1rem; /* 여백을 추가하여 버튼이 모달 끝에 붙지 않도록 조정 */
        }

        .modal-footer .btn {
            margin-left: 10px; /* 버튼 간격 추가 */
        }

        /* X 모양 버튼 스타일 */
        .btn-close {
            background: transparent;
            border: none;
            color: #000;
            font-size: 1.5rem; /* 버튼 크기 조정 */
            opacity: 1; /* 투명도 설정 */
            cursor: pointer;
        }

        .btn-close:hover {
            opacity: 0.7; /* 호버 시 투명도 변경 */
        }

        /* 버튼의 모양을 완전하게 하기 위한 추가 스타일 */
        .btn-close::after {
            content: "×"; /* X 모양을 직접 추가 */
            font-size: 2rem; /* X 모양의 크기 조정 */
            color: #000; /* X 색상 설정 */
        }
    </style>
</head>
<body>
    <jsp:include page="/include/admin_header.jsp" />
    <jsp:include page="/include/admin_navbar.jsp" />
    
    <div class="container mt-4">
        <h2>관리자 정보</h2>
        <table class="table table-striped table-hover table-bordered">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Nickname</th>
                </tr>
            </thead>
            <tbody>
                <c:set var="adminlist" value="${adminList}" />
                <c:if test="${!empty adminList}">
                    <c:forEach items="${adminList}" var="admin">
                        <tr>
                            <td>${admin.getAdmin_id()}</td>
                            <td>
                                <!-- 닉네임 클릭 시 모달 열기 -->
                                <span class="nickname-link" onclick="openNicknameModal('${admin.getAdmin_id()}', '${admin.getAdmin_nick()}')">
                                    ${admin.getAdmin_nick()}
                                </span>
                            </td>
                        </tr>
                    </c:forEach>
                </c:if>
            </tbody>
        </table>
    </div>

    <!-- 닉네임 변경 모달 -->
    <div class="modal fade" id="nicknameModal" tabindex="-1" aria-labelledby="nicknameModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="nicknameModalLabel">닉네임 변경</h5>
                    <!-- 닫기 버튼을 X 모양으로 설정 -->
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <!-- 폼 수정: 닉네임 수정 폼 추가 -->
                    <form id="nicknameForm" method="POST" action="${pageContext.request.contextPath}/admin_Nick_modify.go">
                        <input type="hidden" id="adminId" name="adminId">
                        <div class="mb-3">
                            <label for="newNickname" class="form-label">새 닉네임</label>
                            <input type="text" class="form-control" id="newNickname" name="newNickname" required>
                        </div>
                        <button type="submit" class="btn btn-primary">저장</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <script>
        // 닉네임 변경 모달 열기
        function openNicknameModal(adminId, currentNickname) {
            document.getElementById('adminId').value = adminId;
            document.getElementById('newNickname').value = currentNickname;
            var modal = new bootstrap.Modal(document.getElementById('nicknameModal'));
            modal.show();
        }

        // 닉네임 변경 폼 제출
        document.getElementById('nicknameForm').addEventListener('submit', function(event) {
            event.preventDefault(); // 기본 폼 제출 방지
            const adminId = document.getElementById('adminId').value;
            const newNickname = document.getElementById('newNickname').value;

            // 데이터 확인 (콘솔에 출력)
            console.log("adminId >>>", adminId);
            console.log("newNickname >>>", newNickname);

            // AJAX 요청으로 닉네임 변경 처리
            const params = new URLSearchParams();
            params.append('adminId', adminId);
            params.append('newNickname', newNickname);

            fetch('${pageContext.request.contextPath}/admin_Nick_modify.go', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded'
                },
                body: params.toString() // URLSearchParams 사용하여 데이터 전송
            })
            .then(response => response.text()) // 텍스트 응답 처리
            .then(data => {
                if (data === "success") {
                    Swal.fire({
                        icon: 'success',
                        title: '닉네임 변경 성공',
                        text: '닉네임이 성공적으로 변경되었습니다.'
                    }).then(() => {
                        location.reload(); // 페이지 새로고침
                    });
                } else {
                    Swal.fire({
                        icon: 'error',
                        title: '닉네임 변경 실패',
                        text: '닉네임 변경에 실패했습니다.'
                    });
                }
            })
            .catch(error => console.error('Error:', error));
        });
    </script>
</body>
</html>
