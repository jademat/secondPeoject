<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:include page="../include/header.jsp" />
<div class="container mt-3">
	
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
				<th>게시판 NO</th>
				<th>게시판 타입</th>
				<th>글 제목</th>
				<th>아이디</th>
				<th>작성일자</th>
			</tr>
			<tr>
				<td>1</td>
				<td>교환</td>
				<td>비밀글입니다.</td>
				<td>ㅁㄴㅇ</td>
				<td>2025.01.09</td>
			</tr>
			
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