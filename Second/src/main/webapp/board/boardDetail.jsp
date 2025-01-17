<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<%
request.setAttribute("pageTitle", "Write an Inquiry");
%>

<jsp:include page="../include/header.jsp" />

<style>
textarea {
	width: 700px;
	resize: none;
	border: none;
}

.table-bordered {
	border: 3px solid black; /* 테이블의 외부 테두리 두께 */
}

.table-bordered th, .table-bordered td {
	border: 2px solid black; /* 테이블 셀의 테두리 두께 */
}
</style>
<div class="container">
	<c:set var="cont" value="${bCont }" />
	<table class="table table-bordered">
		<c:if test="${!empty cont }">

			<tr>
				<th>${cont.getBoard_type() }</th>
				<th style="text-align: right;">${cont.getBoard_date().substring(0,10) }</th>
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

</div>
<div align="center">
	<input type="button" class="btn btn-primary" value="전체목록"
		onclick="location.href = '<%=request.getContextPath()%>/user_board_list.go?board_type=all'">
</div>
<br>

<jsp:include page="../include/footer.jsp" />