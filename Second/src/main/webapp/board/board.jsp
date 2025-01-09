<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="../include/header.jsp" />
<div class="container mt-3">

	<c:set var="list" value="${boardList }" />
	<table class="table table-hover">
		<thead>
			<tr align="center">
				<th><a href="#">전체보기</a></th>
				<th><a href="#">공지사항</a></th>
				<th><a href="#">교환</a></th>
				<th><a href="#">환불</a></th>
				<th><a href="#">상품문의</a></th>
			</tr>
			<tr>
				<th>게시글 NO</th>
				<th>게시글 타입</th>
				<th>글 제목</th>
				<th>아이디</th>
				<th>작성일자</th>
			</tr>
			<c:if test="${!empty list }">
				<c:forEach items="${list}" var = "dto">
					<tr onClick="location.href='user_boardDetail.go?no=${dto.getBoard_no() }'">
						<td>${dto.getBoard_no() }</td>
						<td>${dto.getBoard_type() }</td>
						<td>${dto.getBoard_title() }</td>
						<td>${dto.getBoard_id() }</td>
						<td>${dto.getBoard_date().substring(0,10) }</td>
					</tr>
				</c:forEach>
			</c:if>
			
			<c:if test = "${empty list }">
				<td colspan = "5" align = "center">
					게시물이 없습니다.
				</td>
			</c:if>
		</thead>
	</table>
</div>
<br>
<br>

<div align="center">
	<button type="button" class="btn btn-primary" data-toggle="modal"
		data-target="#exampleModal">글쓰기</button>
</div>

<jsp:include page="../modal/boardModal.jsp" />
<jsp:include page="../include/footer.jsp" />