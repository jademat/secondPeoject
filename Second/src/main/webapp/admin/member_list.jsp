<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원 목록</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resource/startbootstrap_admin_pages/css/style.css">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">

    <!-- SweetAlert2 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/sweetalert2@11.7.9/dist/sweetalert2.min.css" rel="stylesheet">

    <!-- SweetAlert2 JS -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.7.9/dist/sweetalert2.all.min.js"></script>

	<style>
	    /* 테이블을 화면 중앙에 배치 */
	    .table {
	        width: 100%; /* 테이블 너비를 100%로 설정 */
	        margin: 0 auto; /* 테이블을 수평 가운데 정렬 */
	    }
	
	    /* h2를 중앙 정렬 */
	    .container h2 {
	    	color: #4e73df;
	        text-align: center; /* 제목을 중앙에 배치 */
	    }
	
	    /* 각 container 사이에 적당한 여백 추가 */
	    .container {
	        margin-top: 20px;
	    }
	
	    /* 테이블 헤더 글자색 변경 */
	    th {
	        color: #4e73df; /* 테이블 헤더 글자 색상 */
	    }
	
	    /* 테이블의 td 요소에 버튼을 수평, 수직 중앙 정렬 */
	    td {
	        text-align: center; /* 버튼을 수평 중앙 정렬 */
	        vertical-align: middle; /* 버튼을 수직 중앙 정렬 */
	    }
	
	    /* 버튼을 flexbox로 중앙 정렬 */
	    .button-container {
	        display: flex;
	        justify-content: center;
	        align-items: center;
	        height: 100%; /* 버튼이 수직 중앙에 오도록 하기 위해 필요 */
	    }
	
	    /* 버튼 스타일 */
	    .btn-custom {
	        padding: 10px 20px;
	        font-size: 1rem;
	    }
	
	    /* SweetAlert2 스타일 */
	    .swal2-popup {
	        font-family: 'Arial', sans-serif;
	        font-size: 1.2rem;
	        text-align: center;
	    }
	
	    .swal2-title {
	        font-size: 1.5rem;
	        color: #4e73df;
	    }
	
	    .swal2-content {
	        font-size: 1.1rem;
	        margin: 10px 0;
	    }
	
	    .swal2-confirm {
	        background-color: #4e73df;
	        border-color: #4e73df;
	    }
	
	    .swal2-cancel {
	        background-color: #d33;
	        border-color: #d33;
	    }
	
	    .swal2-popup .swal2-button {
	        font-size: 1.1rem;
	        padding: 10px 25px;
	    }
	
	    /* SweetAlert2 성공 메시지 스타일 */
	    .swal2-success .swal2-title {
	        color: #28a745; /* 성공 메시지 색상 */
	    }
	
	    /* SweetAlert2 경고 메시지 스타일 */
	    .swal2-warning .swal2-title {
	        color: #ffc107; /* 경고 메시지 색상 */
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
	        margin-bottom: 20px;
	    }
	</style>


</head>
<body>

    <jsp:include page="/include/admin_header.jsp" />
    <jsp:include page="/include/admin_navbar.jsp" />

    <div class="container mt-5">
        <h2 class="text-center mb-4">회원 목록</h2>
		<sub>* 해당 회원 닉네임 클릭 시 상세정보 확인 가능</sub>


        <!-- 회원 목록 테이블 -->
        <table class="table table-bordered table-hover">
            <thead>
                <tr align="center">    
                    <th>ID</th>
                    <th>이름</th>
                    <th>닉네임</th>
                    <th>성별</th>
                    <th>가입일자</th>
                    <th>삭제</th>
                </tr>
            </thead>
            <tbody>
                <c:set var="mlist" value="${userList}" />
                <c:if test="${!empty mlist }">
                    <c:forEach items="${mlist }" var="member">
                        <tr align="center">
                            <td>${member.getUser_id() }</td>
                            <td>${member.getUser_name() }</td>
                            <td>
                                <a href="${pageContext.request.contextPath}/member_info.go?UserId=${member.getUser_id()}">${member.getUser_nick()}</a>
                            </td>
                            <td>${member.getUser_gender() }</td>
                            <td>${member.getUser_date() }</td>
                            <td>
                                <div class="button-container">
                                    <!-- 삭제 버튼 (SweetAlert2 적용) -->
                                    <button type="button" class="btn btn-danger btn-custom" onclick="confirmDelete('${member.getUser_id()}')">삭제</button>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                </c:if>
            </tbody>
        </table>    
    </div>

    <!-- 삭제 버튼 클릭 시 SweetAlert2  -->
    <script>
        function confirmDelete(userId) {
            Swal.fire({
                title: '정말 삭제하시겠습니까?',
                text: '이 작업은 취소할 수 없습니다.',
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: '예, 삭제합니다!',
                cancelButtonText: '아니요'
            }).then((result) => {
                if (result.isConfirmed) {
                    // 삭제 요청을 보낼 URL로 이동
                    window.location.href = "${pageContext.request.contextPath}/member_delete.go?userId=" + userId;
                }
            });
        }

        // 삭제 후 메시지 출력
        <c:if test="${not empty message}">
            Swal.fire({
                icon: 'success',
                title: '삭제되었습니다!',
                text: '${message}'
            }).then(() => {
                // 삭제 완료 후 목록 페이지로 리다이렉트
                window.location.href = '${pageContext.request.contextPath}/member_list.go';
            });
        </c:if>
    </script>

</body>
</html>
