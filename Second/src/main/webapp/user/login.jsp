<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
	
<%
	request.setAttribute("pageTitle", "Login");
%>

<jsp:include page="../include/header.jsp" />


<!-- 로그인 화면 창 -->

<form method = "post" action = "<%= request.getContextPath()%>/user_login_ok.go">
	<div class="container" align="center">
		<label for="id"
			style="text-align: left; display: block; width: 500px;">아이디</label> <input
			type="text" class="form-control" id="id" placeholder="" required
			style="width: 500px;" name = "id">
		<div class="invalid-feedback">아이디를 입력해주세요.</div>
	</div>


      <div class="container" align="center">
            <label for="pwd" style="text-align:left; display:block; width:500px;">비밀번호</label>
            <input type="password" class="form-control" id="pwd" placeholder="" required style="width:500px;" name = "pwd">
            <div class="invalid-feedback">
              비밀번호를 입력해주세요.
            </div>

            <div style="text-align: left; width: 500px; margin-top: 5px;">
                <a href="<%=request.getContextPath() %>/user_findmyPwd.go" style="text-decoration: none; color: #007bff;">비밀번호를 잊으셨나요?</a>
            </div>

        </div>
   

    <div style="text-align: center;">
        <button type="submit" class="btn btn-primary">Login</button>
    </div>
</form>



<jsp:include page="../include/footer.jsp" />