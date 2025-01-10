<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="../include/header.jsp" />

<style>
textarea {
	width: 700px;
	resize: none;
	border: none;
}
</style>
<div class="container">
	<c:set var="cont" value="${bCont }" />
	<table class="table table-borderless">
		<c:if test="${!empty cont }">
			
				<tr>
					<th>${cont.getBoard_type() }</th>
				</tr>
				<tr>
					<th>아이디</th>
					<td>${cont.getUser_id() }</td>
				</tr>
				<tr>
					<th>글제목</th>
					<td>${cont.getBoard_title() }</td>
				</tr>
				<tr>
					<th>글내용</th>
					<td><textarea rows="5" cols="30" readonly>${cont.getBoard_cont() }</textarea></td>
				</tr>
			
		</c:if>
	</table>
	<br> <br>

	<div align="center">
		<input type = "button" class = "btn btn-primary" value = "전체목록" onclick = "location.href = 'user_board_list.go'">
	</div>

	<br> <br>
	<!-- 관리자만 볼수 있음 -->
	<div align="center">
		<button type="button" class="btn btn-primary" >답변하기</button>
	</div>
</div>





<jsp:include page="../include/footer.jsp" />