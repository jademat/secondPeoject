<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="../include/header.jsp" />

<c:set var="uCont" value="${uCont }" />
<c:set var = "uList" value = "${uList }"/>
<c:set var="bCont" value="${bCont }" />
<div class="container">
	<h2>My page</h2>
	<div align="right">
	<button class="btn btn-primary" onclick = "location.href='user_myinfo_modify.go?user_id=${uCont.getUser_id()}'">개인정보수정</button>
</div>
	<br>
	<table class="table table-bordered">
		<tr>
			<th scope="row" width="20%">아이디</th>
			<td>${uCont.getUser_id() }</td>
		</tr>
		<tr>
			<th scope="row">이름</th>
			<td>${uCont.getUser_name() }</td>
		</tr>
		<tr>
			<th scope="row">닉네임</th>
			<td>${uCont.getUser_nick() }</td>
		</tr>
		<tr>
			<th scope="row">주소</th>
			<td>${uCont.getUser_addr() }</td>
		</tr>
		<tr>
			<th scope="row">연락처</th>
			<td>${uCont.getUser_phone() }</td>
		</tr>
	</table>
</div>
<br>
<br>

<div class="container">
	<h3>구매내역</h3>
	<br>
	<table class="table table-hover">
		<tr>
			<th width="20%">No.</th>
			<th width="40%">상품명</th>
			<th width="20%">구매일</th>
			<th width="20%">리뷰</th>
		</tr>
		<tr onclick="openuserDetailModal()">
			<td>a</td>
			<td>a</td>
			<td>a</td>
			<td>
				<button type="button" class="btn btn-primary"
					onclick="openReviewModal(event)">리뷰작성</button>
			</td>
		</tr>
	</table>
</div>
<br>
<br>

<div class="container">
	<h3>내가 쓴 리뷰</h3>
	<br>
	<table class="table table-bordered">
		<tr>
			<th width="10%">No.</th>
			<th width="60%">리뷰제목</th>
			<th width="20%">작성일</th>
			<th width="10%">삭제</th>
		</tr>
		<c:set var="rCont" value="${ rCont}" />
		<c:if test="${!empty rCont }">
			<c:forEach items="${rCont }" var="rCont">
				<tr>
					<td>${rCont.getReview_no() }</td>
					<td><button type="button" class="btn btn-link" data-toggle="modal"
							data-target="#reviewModal" data-image="${rCont.getReview_image()}"
							data-user="${rCont.getUser_id()}"
							data-date="${rCont.getReview_date()}"
							data-content="${rCont.getReview_cont()}"
							data-rating="${rCont.getReview_rank()}"
							data-title="${rCont.getReview_title()}">${rCont.getReview_title() }</button></td>
					<td>${rCont.getReview_date().substring(0,10) }</td>
					<td>
						<button class="btn btn-primary" onclick="confirmReviewDelete('${rCont.getReview_no()}')">삭제</button>
					</td>
				</tr>
			</c:forEach>
		</c:if>
		<c:if test="${empty rCont }">
			<tr>
				<td colspan="3" align="center">작성한 리뷰가 없습니다.</td>
			</tr>
		</c:if>
	</table>
</div>

<br>
<br>
<div class="container">
	<h3>내가 쓴 게시판</h3>
	<br>
	<table class="table table-bordered">
		<tr>
			<th width="5%">No.</th>
			<th width="10%">타입</th>
			<th width="50%">글 제목</th>
			<th width="15%">작성일</th>
			<th width="10%">삭제</th>
		</tr>


		<c:if test="${!empty bCont }">
			<c:forEach items="${bCont }" var="bCont">
				<tr>
					<td>${bCont.getBoard_no() }</td>
					<td>${bCont.getBoard_type() }</td>
					<td>${bCont.getBoard_title() }</td>
					<td>${bCont.getBoard_date().substring(0,10) }</td>
					<td><button class="btn btn-primary" onclick="confirmDelete('${bCont.getBoard_no()}')">삭제</button></td>
				</tr>
			</c:forEach>
		</c:if>

		<c:if test="${empty bCont }">
			<tr>
				<td colspan="4" align="center">작성한 게시물이 없습니다.</td>
			</tr>
		</c:if>
	</table>
	
</div>



<script>
	// 주문 상세 내역 모달 열기
function openuserDetailModal() {
    // 여기에 모달을 여는 코드 작성
    $('#orderDetailModal .modal-content').load('/modal/orderDetailModal.jsp');
    $('#orderDetailModal').modal();
}
		

	function openReviewModal(event) {
		event.stopPropagation(); // 버튼 클릭 시 <tr> 클릭 이벤트 발생 방지
		$('#reviewWriteModal').modal('show');
	}
	 function confirmReviewDelete(reviewNo) {
        var reviewConfirmed = confirm("정말로 삭제하시겠습니까?");
	        
        if (reviewConfirmed) {
        	    // 사용자가 확인을 눌렀으면 삭제 요청을 보냄
            location.href = "<%=request.getContextPath() %>/user_review_delete.go?review_no=" + reviewNo;
	        }
	    }
	 function confirmDelete(boardNo) {
        var userConfirmed = confirm("정말로 삭제하시겠습니까?");
	        
        if (userConfirmed) {
        	    // 사용자가 확인을 눌렀으면 삭제 요청을 보냄
            location.href = "<%=request.getContextPath() %>/user_board_delete.go?board_no=" + boardNo;
	        }
	    }
	 
</script>
<jsp:include page="../modal/reviewModal.jsp" />
<jsp:include page="../modal/reviewWriteModal.jsp" />
<jsp:include page="../modal/orderDetailModal.jsp" />
<jsp:include page="../include/footer.jsp" />

