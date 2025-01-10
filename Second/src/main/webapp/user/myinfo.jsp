<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="../include/header.jsp" />

<div class="container">
	<h2>My page</h2>
	<div align="right">
		<button type="button" class="btn btn-primary" data-toggle="modal"
			data-target="#myInfoModal">개인정보수정</button>
	</div>
	<br>
	<c:set var="ucont" value="${uCont }" />
	<table class="table table-bordered">
		<tr>
			<th scope="row" width="20%">아이디</th>
			<td>${ucont.getUser_id() }</td>
		</tr>
		<tr>
			<th scope="row">이름</th>
			<td>${ucont.getUser_name() }</td>
		</tr>
		<tr>
			<th scope="row">닉네임</th>
			<td>${ucont.getUser_nick() }</td>
		</tr>
		<tr>
			<th scope="row">주소</th>
			<td>${ucont.getUser_addr() }</td>
		</tr>
		<tr>
			<th scope="row">연락처</th>
			<td>${ucont.getUser_phone() }</td>
		</tr>
	</table>
</div>
<br>
<br>

<div class="container">
	<h3>주문내역</h3>
	<br>
	<table class="table table-hover">
		<tr>
			<th width="20%">주문번호</th>
			<th width="40%">제품명</th>
			<th width="20%">구매일</th>
			<th width="20%">리뷰</th>
		</tr>
		<tr onclick="openOrderDetailModal()">
			<td>asd</td>
			<td>asd</td>
			<td>asd</td>
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
			<th scope="row" width="20%">제품명</th>
			<th width="65%">리뷰제목</th>
			<th>작성일</th>
		</tr>
		<c:set var="rCont" value="${ rCont}" />
		<c:if test="${!empty rCont }">
			<c:forEach items="${rCont }" var="rList">
				<tr>
					<td></td>
					<td></td>
					<td></td>
				</tr>
			</c:forEach>
		</c:if>
		<c:if test="${empty rList }">
			<tr>
				<td colspan="3" align="center">작성한 리뷰가 없습니다.</td>
			</tr>
		</c:if>
	</table>
</div>

<br>
<br>
<div class="container">
	<c:set var="bCont" value="${bCont }" />
	<h3>내가 쓴 게시판</h3>
	<br>
	<table class="table table-bordered">
		<tr>
			<th scope="row" width="10%">교환 환불</th>
			<th scope="row" width="50%">글 제목</th>
			<th scope="row" width="20%">작성일</th>
		</tr>


		<c:if test="${!empty bCont }">
			<c:forEach items="${bCont }" var="bCont">
				<tr>
					<td>${bCont.getBoard_type() }</td>
					<td>${bCont.getBoard_title() }</td>
					<td>${bCont.getBoard_date().substring(0,10) }</td>
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
	function openOrderDetailModal() {
		$('#orderDetailModal').modal('show');
	}

	function openReviewModal(event) {
		event.stopPropagation(); // 버튼 클릭 시 <tr> 클릭 이벤트 발생 방지
		$('#reviewWriteModal').modal('show');
	}
</script>
<jsp:include page="../modal/myInfoMoadl.jsp" />
<jsp:include page="../modal/reviewWriteModal.jsp" />
<jsp:include page="../modal/orderDetailModal.jsp" />
<jsp:include page="../include/footer.jsp" />

