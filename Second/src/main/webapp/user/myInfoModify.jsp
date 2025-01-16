<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	request.setAttribute("pageTitle", "Edit Profile");
%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="../include/header.jsp" />
<c:set var="dto" value="${Modify }" />
<div class="container">
	<h2>개인정보수정</h2>
	<form method="post" action="user_myinfo_modify_ok.go">
		<table class="table table-borderless">
			<tr>
				<th scope="col">아이디</th>
				<td><input type="text" class="form-control" name="user_id"
					value="${dto.getUser_id() }" readonly></td>
			</tr>
			<tr>
				<th scope="col">이름</th>
				<td><input type="text" class="form-control" name="user_name"
					value="${dto.getUser_name() }" readonly></td>
			</tr>
			<tr>
				<th scope="col">닉네임</th>
				<td><input type="text" class="form-control" name="user_nick"
					value="${dto.getUser_nick() }"></td>
			</tr>
			<tr>
				<th scope="col">이메일</th>
				<td><input type="text" class="form-control" name="user_email"
					value="${dto.getUser_email() }"></td>
			</tr>
			<tr>
				<th scope="col">주소</th>
				<td><input type="text" class="form-control" name="user_addr"
					value="${dto.getUser_addr() }"></td>
			</tr>
			<tr>
				<th scope="col">연락처</th>
				<td><input type="text" class="form-control" name="user_phone"
					value="${dto.getUser_phone() }"></td>
			</tr>
			<tr>
				<th scope="col">성별</th>
				<td><input type="text" class="form-control" name="user_gender"
					value="${dto.getUser_gender() }" readonly></td>
			</tr>
		</table>
		<br>
		<div align="right">
			<input type="submit" value="수정" class="btn btn-primary"> 
			<input type="button" value="탈퇴" class="btn btn-primary" onclick="deleteUser('${dto.getUser_id()}')">
		</div>
	</form>
</div>
<script type="text/javascript">
	function deleteUser(userId) {
		// 삭제 요청을 처리할 URL로 이동
		if (confirm("아이디를 삭제하시겠습니까?")) {
			window.location.href = '<%=request.getContextPath()%>/user_delete.go?user_id=' + userId;
		}
	}
</script>

<jsp:include page="../include/footer.jsp" />
