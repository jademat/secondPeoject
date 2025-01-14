<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:include page="../include/header.jsp" />

<div class="container mt-5">

	<script>
		function validatePwd() {

			var newPassword = document.getElementById("newPassword").value;
			var confirmPassword = document.getElementById("confirmPassword").value;
			var resultDiv = document.getElementById("result");

			// 비밀번호 조건: 특수문자 포함, 길이 6자 이상 20자 미만
			var passwordRegex = /^(?=.*[!@#$%^&*?_])(?=.*[a-zA-Z0-9]).{6,20}$/;

		    if (!passwordRegex.test(newPassword)) {
		        resultDiv.innerHTML = "비밀번호는 특수문자를 포함하고, 6자 이상 20자 미만이어야 합니다.";
		        resultDiv.style.color = "red";
		        return false;
		    }

		    // 비밀번호 확인 일치 여부 확인
		    if (newPassword !== confirmPassword) {
		        resultDiv.innerHTML = "비밀번호가 일치하지 않습니다.";
		        resultDiv.style.color = "red";
		        return false;
		    }

		    resultDiv.innerHTML = "비밀번호가 일치하며 유효합니다.";
		    resultDiv.style.color = "green";
		    return true;
		}
	</script>

	<h3>비밀번호 재설정</h3>

	<form id="resetForm" action="<%=request.getContextPath()%>/user_pwdUpdate.go" method="post" onsubmit="return validatePwd()">
		<div class="mb-3">
			<label for="userId" class="form-label">아이디</label> 
			<input type="text" class="form-control" id="user_id" name="user_id" value="${user_id}"
				readonly required> 
				<label for="newPassword" class="form-label">새로운 비밀번호</label> 
				<input type="password" class="form-control" id="newPassword" name="newPassword" required>

			<label for="confirmPassword" class="form-label">비밀번호 확인</label>

			<input type="password" class="form-control" id="confirmPassword" name="confirmPassword" required>
	
		</div>
		
		 <div id="result"></div> 
		<button type="submit" class="btn btn-primary">비밀번호 재설정</button>
	</form>
</div>


<jsp:include page="../include/footer.jsp" />