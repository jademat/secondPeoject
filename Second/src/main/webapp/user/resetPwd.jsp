<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:include page="../include/header.jsp" />

<div class="container mt-5">

	<h3>비밀번호 재설정</h3>

	<form action="resetPassword.jsp" method="post">
		<div class="mb-3">
			<label for="id">아이디</label> <br> <input type="text"
				class="form-control" id="id" name="id" value="" readonly
				style="width: 80%;">
		</div>
		<div class="mb-3">
			<label for="password">새로운 비밀번호</label> <br> <input
				type="password" class="form-control" id="newpwd" name="user_newPwd"
				required style="width: 80%;">
			<div class="invalid-feedback">비밀번호를 입력해주세요.</div>
		</div>
		<div class="mb-3">
			<label for="confirm-password">비밀번호 확인</label> <br> <input
				type="password" class="form-control" id="confirm_password"
				name="confirm-password" required style="width: 80%;">
			<div class="invalid-feedback">비밀번호 확인란을 입력해주세요.</div>
		</div>
		<button type="submit" class="btn btn-primary" onclick="validatePwd()">비밀번호
			변경</button>
		<div id="result"></div>
	</form>
</div>

<script>
	function validatePwd(event) {
		
		event.preventDefault();
		
        var newPassword = document.getElementById("newpwd").value;
        var confirmPassword = document.getElementById("confirm_password").value;
        var resultDiv = document.getElementById("result");
		
		var passwordRegex = /^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[!@#$%^&*?_]).{8,16}$/;

		if (passwordRegex.test(newPassword)) {
			if (newPassword === confirmPassword) {
				resultDiv.innerHTML = '비밀번호가 일치하며 유효합니다.';
				resultDiv.style.color = 'green';
			} else {
				resultDiv.innerHTML = '비밀번호가 일치하지 않습니다.';
				resultDiv.style.color = 'red';
			}
		} else {
			resultDiv.innerHTML = '비밀번호는 최소 8자에서 16자까지, 영문자, 숫자 및 특수 문자를 포함해야 합니다.';
			resultDiv.style.color = 'red';
		}
	}}
</script>
<jsp:include page="../include/footer.jsp" />