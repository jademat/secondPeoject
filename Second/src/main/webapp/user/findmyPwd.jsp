<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<%
	request.setAttribute("pageTitle", "Forgot Password?");
%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="../include/header.jsp" />

<div class="container">
	<div class="input-form-backgroud row">
		<div class="input-form col-md-12 mx-auto">
			<h4 class="mb-3">비밀번호 찾기</h4>
			
<!-- 오류 메시지가 있을 경우 출력 -->
            <c:if test="${not empty errorMessage}"> <div class="alert alert-danger">
                    ${errorMessage}
                </div>
            </c:if>
			
			<p>비밀번호를 찾으려면 아래에 이메일을 입력하세요.</p>
			<form id="myForm" method="post"
				action="<%=request.getContextPath()%>/user_resetPwd.go">

				<div class="mb-3">
					<label for="name" class="form-label">이름</label> <input type="text"
						class="form-control" name="user_name" id="name"
						placeholder="이름을 입력하세요." required>
				</div>

				<div class="mb-3">
					<label for="id" class="form-label">아이디</label> <input type="text"
						class="form-control" name="user_id" id="id"
						placeholder="사용자 아이디를 입력하세요. " required>
				</div>

				<div class="mb-3">
					<label for="email" class="form-label">이메일 주소</label> <input
						type="email" class="form-control" name="user_email" id="email"
						placeholder="example@example.com" required>
				</div>
				<button type="submit" class="btn btn-primary" id="resetBtn">비밀번호
					찾기</button>
			</form>
		</div>
	</div>
</div>

<jsp:include page="../include/footer.jsp" />