<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:include page="../include/header.jsp" />

<!-- 로그인 화면 창 -->
<form>
	<div class="container" align="center">
		<label for="id"
			style="text-align: left; display: block; width: 500px;">아이디</label> <input
			type="text" class="form-control" id="id" placeholder="" required
			style="width: 500px;">
		<div class="invalid-feedback">아이디를 입력해주세요.</div>
	</div>

	<div class="container" align="center">
		<label for="pwd"
			style="text-align: left; display: block; width: 500px;">비밀번호</label>
		<input type="password" class="form-control" id="pwd" placeholder=""
			required style="width: 500px;">
		<div class="invalid-feedback">비밀번호를 입력해주세요.</div>
	</div>

	<br>

	<div style="text-align: center;">
		<button type="submit" class="btn btn-primary">Login</button>
	</div>
</form>

</body>
</html>

<jsp:include page="../modal/myInfoMoadl.jsp" />
<jsp:include page="../modal/reviewWriteModal.jsp" />
<jsp:include page="../include/footer.jsp" />