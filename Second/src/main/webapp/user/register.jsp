<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:include page="../include/header.jsp" />

<!-- 회원가입 페이지 -->

<div class="container">
	<div class="input-form-backgroud row">
		<div class="input-form col-md-12 mx-auto">
			<h4 class="mb-3">회원가입</h4>


			<form class="validation-form" novalidate>
				<div class="row">
					<div class="col-md-6 mb-3">
						<label for="name">이름</label> <input type="text"
							class="form-control" id="name" placeholder="" value="" required>
						<div class="invalid-feedback">이름을 입력해주세요.</div>
					</div>
					<div class="col-md-6 mb-3">
						<label for="nickname"> 사용할 닉네임 </label> <input type="text"
							class="form-control" id="nickname" placeholder="" value=""
							required>
						<div class="invalid-feedback">별명을 입력해주세요.</div>
					</div>
				</div>


				<div class="mb-3">
					<label for="id">아이디</label> <br> <input type="text"
						class="form-control" id="id" placeholder="" required
						style="width: 80%; display: inline-block;">
					<button type="button" id="check-duplicate"
						class="btn btn-primary mt-2" style="display: inline-block;">중복
						확인</button>
					<div class="invalid-feedback">아이디를 입력해주세요.</div>
					<div id="duplicate-message" class="mt-2"></div>
				</div>

				<div class="mb-3">
					<label for="pwd">비밀번호</label> <input type="password"
						class="form-control" id="pwd" placeholder="" required>
					<div class="invalid-feedback">(특수문자/6자 이상) 입력해주세요.</div>
				</div>

				<div class="mb-3">
					<label for="email">이메일</label> <input type="email"
						class="form-control" id="email" placeholder="you@example.com"
						required>
					<div class="invalid-feedback">이메일을 입력해주세요.</div>
				</div>

				<div class="mb-3">
					<label for="address">주소</label> <input type="text"
						class="form-control" id="address" placeholder="서울특별시 강남구" required>
					<div class="invalid-feedback">주소를 입력해주세요.</div>
				</div>

				<div class="mb-3">
					<label for="addrDetail">상세주소<span class="text-muted">&nbsp;(필수
							아님)</span></label> <input type="text" class="form-control" id="addrDetail"
						placeholder="상세주소를 입력해주세요.">
				</div>

				<div class="row">
					<div class="col-md-8 mb-3">
						<label for="gender"> 성별 </label> <select
							class="custom-select d-block w-100" id="gender" required>
							<option value=""></option>
							<option>남자(male)</option>
							<option>여자 (female)</option>
						</select>

					</div>

				</div>
				<hr class="mb-4">
				<div class="custom-control custom-checkbox">
					<input type="checkbox" class="custom-control-input" id="aggrement"
						required> <label class="custom-control-label"
						for="aggrement">개인정보 수집 및 이용에 동의합니다.</label>
				</div>
				<div class="mb-4"></div>
				<button class="btn btn-primary btn-lg btn-block" type="submit">가입
					완료</button>
			</form>
		</div>
	</div>
	<footer class="my-3 text-center text-small">
		<p class="mb-1">&copy; 2021 YD</p>
	</footer>
</div>
<script>
    window.addEventListener('load', () => {
      const forms = document.getElementsByClassName('validation-form');
    
      Array.prototype.filter.call(forms, (form) => {
        form.addEventListener('submit', function (event) {
          if (form.checkValidity() === false) {
            event.preventDefault();
            event.stopPropagation();
          }
    
          form.classList.add('was-validated');
        }, false);
      });
    }, false);
    </script>

</body>
</html>


<jsp:include page="../modal/myInfoMoadl.jsp" />
<jsp:include page="../modal/reviewWriteModal.jsp" />
<jsp:include page="../include/footer.jsp" />
