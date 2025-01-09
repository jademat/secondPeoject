<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:include page="../include/header.jsp" />

<style>
	textarea{
		width : 700px;
		height : 300px;
		resize : none;
		border : none;
	}


</style>
<div class="container">
	<table class="table table-borderless">
		<tr>
			<th>게시판타입</th>
		</tr>
		<tr>
			<th>아이디</th>
			<td>asd</td>
		</tr>
		<tr>
			<th>글제목</th>
			<td>asd</td>
		</tr>
		<tr>
			<th>글내용</th>
			<td><textarea rows="5" cols="30" >asd</textarea>
			</td>
		</tr>
	</table>
	<br>
	<br>
	
	<div align="center">
		<button type="button" class="btn btn-primary" data-toggle="modal"
			data-target="#exampleModal">게시판으로</button>
	</div>
	
	<br>
	<br>
	<!-- 관리자만 볼수 있음 -->
	<div align="center">
		<button type="button" class="btn btn-primary" data-toggle="modal"
			data-target="#exampleModal">답변하기</button>
	</div>

</div>





<jsp:include page="../include/footer.jsp" />