<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원 상세 정보</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resource/startbootstrap_admin_pages/css/style.css">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- SweetAlert2 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/sweetalert2@11.7.9/dist/sweetalert2.min.css" rel="stylesheet">
 	
 	<!-- SweetAlert2 JS -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.7.9/dist/sweetalert2.all.min.js"></script>

	<style>
        /* 회원 카드 테두리 색상 변경 */
        .member-card {
            border: 2px solid #4e73df; /* 카드 테두리 색상 */
            border-radius: 8px;
            padding: 20px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            margin-bottom: 30px;
        }

        /* 회원 이미지 스타일 */
        .member-card img {
            width: auto; /* 자동 크기 조정 */
            height: auto; /* 자동 크기 조정 */
            max-width: 100%; /* 최대 너비는 부모의 너비를 넘지 않도록 제한 */
            border-radius: 8px;
        }

        /* 버튼 스타일 */
        .btn-custom {
            margin-top: 20px;
            padding: 10px 20px;
        }

        /* 회원 정보 레이블 스타일 */
        .member-info {
            display: flex;
            justify-content: space-between;  /* 레이블과 값을 양옆으로 배치 */
            margin-bottom: 15px;
            align-items: center;  /* 세로로 중앙 정렬 */
        }

        .member-info label {
            font-weight: bold;
            color: #4e73df;  /* 레이블 글자 색상 */
            width: 150px;  /* 고정된 너비로 레이블 공간을 확보 */
            margin-right: 15px;  /* 레이블과 값 사이의 간격 */
        }

        .member-info p {
            margin: 0;
            flex-grow: 1;  /* 남은 공간을 채워서 레이블과 값이 더 가까워지지 않도록 */
        }
        
        

        /* 회원 상세 페이지 제목 색상 */
        h2 {
            color: #4e73df; /* 회원 상세 정보 제목 색상 */
        }

        /* 버튼 중앙 정렬 */
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
        <h2 class="text-center mb-4">회원 상세 정보</h2>
        
        <c:set var="mlist" value="${user}" />
		<c:if test="${!empty mlist }">
			<div class="member-card">
				<div class="member-info">
					<label>ID : </label>
					<p>${user.getUser_id() }</p>				
				</div>
				
				<div class="member-info">
					<label>PWD : </label>
					<p>${user.getUser_pwd() }</p>				
				</div>
				
				<div class="member-info">
					<label>이름 : </label>
					<p>${user.getUser_name() }</p>				
				</div>
				
				<div class="member-info">
					<label>닉네임 : </label>
					<p>${user.getUser_nick() }</p>				
				</div>
				
				<div class="member-info">
					<label>e-mail : </label>
					<p>${user.getUser_email() }</p>				
				</div>
				
				<div class="member-info">
					<label>나이 : </label>
					<p>${user.getUser_age() }</p>				
				</div>
				
				<div class="member-info">
					<label>성별 : </label>
					<p>${user.getUser_gender() }</p>				
				</div>
				
				<div class="member-info">
					<label>핸드폰 번호 : </label>
					<p>${user.getUser_phone() }</p>				
				</div>
				
				<div class="member-info">
					<label>주소 : </label>
					<p>${user.getUser_addr() }</p>				
				</div>
				
				<div class="member-info">
					<label>가입 일시 : </label>
					<p>${user.getUser_date() }</p>				
				</div>
			</div>
				
			<div class="button-container">
				<!-- 삭제 버튼 (SweetAlert2 적용) -->
                <button type="button" class="btn btn-danger btn-custom" onclick="confirmDelete('${member.getUser_id()}')">삭제</button>

                <a href="${pageContext.request.contextPath}/member_list.go" class="btn btn-primary mx-2 btn-custom">회원 목록</a>
            </div>
		</c:if>
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
                    // 삭제로 넘기기
                    window.location.href = "${pageContext.request.contextPath}/member_delete.go?userId=" + userId;
                }
            });
        }
    </script>





</body>
</html>