<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:include page="../include/header.jsp" />

<div class="container mt-5">

	<h3>비밀번호 재설정</h3>
	<form action="resetPassword.jsp" method="post">
		<div class="mb-3">
			<label for="id">아이디</label> <br> <input type="text"
				class="form-control" id="id" name="id" value="DB에서 불러 오기"
				readonly style="width: 80%;">
		</div>
		<div class="mb-3">
			<label for="password">새 비밀번호</label> <br> <input type="password"
				class="form-control" id="password" name="password" required
				style="width: 80%;">
			<div class="invalid-feedback">비밀번호를 입력해주세요.</div>
		</div>
		<div class="mb-3">
			<label for="confirm-password">비밀번호 확인</label> <br> <input
				type="password" class="form-control" id="confirm-password"
				name="confirm-password" required style="width: 80%;">
			<div class="invalid-feedback">비밀번호 확인란을 입력해주세요.</div>
		</div>
		<button type="submit" class="btn btn-primary">비밀번호 변경</button>
	</form>
</div>

<jsp:include page="../include/footer.jsp" />