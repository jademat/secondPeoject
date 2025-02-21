<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
request.setAttribute("pageTitle", "Thank you for signing up for our shop.");
%>


<script type="text/javascript"
	src="https://code.jquery.com/jquery-3.7.1.js"></script>
<script type="text/javascript">
	$(function() {
		// "아이디 중복체크" 라는 버튼에 마우스가 올라가면
		// 호출되는 무명함수
		$("#idCheck_btn")
				.click(
						function() {
							$("#idCheck").hide(); // span 태그를 숨기는 코드

							// 회원 id 입력했을 때, 값을 가져오라는 메서드
							let user_id = $("#user_id").val();

							// 아이디 정규식: 영문 대소문자 + 숫자만 허용
							var idRegex = /^[a-zA-Z0-9]+$/; // 영문 대소문자 + 숫자만 허용

							// 아이디가 소문자와 대문자가 구별되는지 체크
							if (!idRegex.test(user_id)) {
								let warningTxt = '<font color="red">아이디는 영문과 숫자만 입력이 가능하며, 대소문자를 구별합니다.</font>';
								$("#idCheck").text("");
								$("#idCheck").show();
								$("#idCheck").append(warningTxt);
								$("#user_id").val("").focus();
								return false;
							}

							// 입력한 아이디의 글자 길이가 16자 이상이면
							if ($.trim($("#user_id").val()).length > 16) {

								let warningTxt = '<font color="red"> 아이디는 16자리 미만이어야 합니다</font>';

								$("#idCheck").text(""); // span 태그 영역 초기화
								$("#idCheck").show(); // span 태그를 보여주는 기능
								$("#idCheck").append(warningTxt);
								$("#user_id").val("").focus();

								return false;
							}

							// 입력한 아이디의 글자 길이가 4자 미만이면
							if ($.trim($("#user_id").val()).length < 4) {
								let warningTxt = '<font color="red"> 아이디는 4자 이상이어야 합니다</font>';
								$("#idCheck").text(""); // span 태그 영역 초기화
								$("#idCheck").show(); // span 태그를 보여주는 기능
								$("#idCheck").append(warningTxt);
								$("#user_id").val("").focus();

								return false;
							}

							// 아이디 중복 여부 확인 - Ajax 기술을 이용하여 진행
							$
									.ajax({
										type : "post",
										url : "idCheck.jsp",
										data : {
											userId : user_id
										},
										dataType : "text",
										success : function(res) {
											if (res == -1) {

												// 중복인 경우
												let warningTxt = '<font color="red"> 중복 아이디 입니다. </font>';
												$("#idCheck").text(""); // span 태그 영역 초기화
												$("#idCheck").show(); // span 태그를 보여주는 기능
												$("#idCheck")
														.append(warningTxt);
												$("#user_id").val("").focus();
											} else {
												// 사용 가능한 아이디인 경우
												let warningTxt = '<font color="green"> 사용 가능한 아이디 입니다. </font>';

												$("#idCheck").text(""); // span 태그 영역 초기화
												$("#idCheck").show(); // span 태그를 보여주는 기능
												$("#idCheck")
														.append(warningTxt);
											}
										},
										error : function() {
											alert("데이터 통신 오류입니다 !! ");
										}
									});

						});
		// 리디렉션 후에도 아이디 중복 여부를 체크할 수 있도록 페이지 로드 시 메시지 표시
		const urlParams = new URLSearchParams(window.location.search);
		const errorId = urlParams.get('errorId'); // 서버에서 errorId가 넘어오는 경우

		if (errorId) {
			// 중복된 아이디라면 경고 메시지 표시
			let warningTxt = '<font color="red">아이디가 이미 존재합니다.</font>';
			$("#idCheck").text(""); // span 태그 영역 초기화
			$("#idCheck").show(); // span 태그를 보여주는 기능
			$("#idCheck").append(warningTxt);
		}

	});
</script>




<jsp:include page="../include/header.jsp" />

<!-- 회원가입 페이지 -->

<div class="container">
	<div class="input-form-backgroud row">
		<div class="input-form col-md-12 mx-auto">
			<h4 class="mb-3">회원가입</h4>


			<form class="validation-form"
				action="<%=request.getContextPath()%>/user_resgister.go"
				method="post"novalidate ">
				<div class="row">
					<div class="col-md-6 mb-3">
						<label for="name">이름</label> <input type="text"
							class="form-control" name="user_name" id="name" placeholder=""
							value="" required>
						<div class="invalid-feedback">이름을 입력해주세요.</div>
					</div>
					<div class="col-md-6 mb-3">
						<label for="nickname"> 사용할 닉네임 </label> <input type="text"
							class="form-control" name="user_nick" id="nickname"
							placeholder="" value="" required>
						<div class="invalid-feedback">별명을 입력해주세요.</div>
					</div>
				</div>




				<div class="mb-3">
					<label for="id">아이디</label> <br>

					<div class="d-flex align-items-center" style="width: 100%;">
						<input type="text" maxlength="20" class="form-control"
							name="user_id" id="user_id" placeholder="" required
							style="flex: 1; margin-right: 10px;">
					</div>
					<button type="button" id="idCheck_btn" class="btn btn-primary"
						style="width: 100px; margin-top: 10px;">중복 확인</button>

					<br> <span id="idCheck"></span>
				</div>



				<div class="mb-3">
					<label for="pwd">비밀번호</label>
					<div class="d-flex align-items-center" style="width: 100%;">
						<input type="password" class="form-control" name="user_pwd"
							id="pwd" maxlength="19" required
							style="flex: 1; margin-right: 10px;">
					</div>
					<button type="button" class="btn btn-primary"
						onclick="validatePassword()" style="width: 100px; margin-top: 10px;">확인</button> <br>

					<span id="result"></span>
				</div>




				<div class="mb-3">
					<label for="email">이메일</label> <input type="email"
						class="form-control" name="user_email" id="email"
						placeholder="you@example.com" required>
					<div class="invalid-feedback">이메일을 입력해주세요.</div>
				</div>

				<div class="mb-3">
					<label for="age">나이</label> <input type="text" class="form-control"
						name="user_age" id="age" maxlength='4'
						placeholder="숫자만 입력이 가능합니다. " required
						oninput="this.value = this.value.replace(/[^0-9]/g, '')">
					<div class="invalid-feedback">나이를 입력해주세요.</div>
				</div>


				<div class="mb-3">
					<label for="phone">전화번호</label> <input type="text"
						class="form-control" name="user_phone" id="phone"
						placeholder="' - ' 를 제외하고 입력해주세요. " maxlength='11' required
						oninput="validatePhone()">
					<div class="invalid-feedback">' - ' 를 제외하고 입력해주세요.</div>
				</div>

				<div class="mb-3">
					<label for="address">주소</label> <input type="text"
						class="form-control" name="user_address" id="address"
						placeholder="서울특별시 강남구" required>
					<div class="invalid-feedback">주소를 입력해주세요.</div>
				</div>


				<div class="row">
					<div class="col-md-8 mb-3">
						<label for="gender"> 성별 </label> <select
							class="custom-select d-block w-100" name="user_gender"
							id="gender" required>
							<option value=""></option>
							<option value="남자">남자(male)</option>
							<option value="여자">여자 (female)</option>
						</select>
  			 <div class="invalid-feedback" id="genderFeedback">성별을 선택해주세요.</div> </div>
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
	// 폰 번호에 - 이거 넣었을 시, 경고
	function validatePhone() {
		var phoneInput = document.getElementById('phone');
		var phoneValue = phoneInput.value;

		// Check if the phone number contains '-'
		if (phoneValue.includes('-')) {
			// Show an alert or change the border color
			phoneInput.classList.add('is-invalid');
			phoneInput.setCustomValidity('전화번호에 "-"을 포함하지 마세요.');
		} else {
			phoneInput.classList.remove('is-invalid');
			phoneInput.setCustomValidity('');
		}

	}
	function validatePassword() {
		var password = document.getElementById("pwd").value;
		var resultDiv = document.getElementById("result");

		// 비밀번호 조건: 특수문자 포함, 길이 6자 이상 20자 미만
		var passwordRegex = /^(?=.*[!@#$%^&*?_])(?=.*[a-zA-Z0-9]).{6,19}$/;

		if (passwordRegex.test(password)) {
			resultDiv.innerHTML = "유효한 비밀번호입니다.";
			resultDiv.style.color = "green";

			return true;
		} else {
			resultDiv.innerHTML = "비밀번호는 특수문자를 포함하고, 6자 이상 20자 미만이어야 합니다.";
			resultDiv.style.color = "red";
			document.getElementById("pwd").classList.add('is-invalid'); // invalid 추가
			resultDiv.classList.add('is-invalid'); // resultDiv에도 invalid 클래스를 추가
			return false;
		}
	}
</script>

<script>
	document
			.querySelector('form')
			.addEventListener(
					'submit',
					function(event) {
						let isValid = true;

						const userName = document.getElementById('name');
						const userNickName = document
								.getElementById('nickname');
						const userId = document.getElementById('user_id');
						const userPwd = document.getElementById('pwd');
						const userEmail = document.getElementById('email');
						const userAge = document.getElementById('age');
						const userPhone = document.getElementById('phone');
						const userAddress = document.getElementById('address');
						const userGender = document.getElementById('gender');
						const agreement = document.getElementById('aggrement');

						function validateField(field, condition, message) {
							const feedback = field.nextElementSibling || document.getElementById(field.id
											+ "Feedback"); // 오류 메시지 div를 가져옵니다.
							if (!condition) {
								field.classList.add('is-invalid'); // 오류 스타일 추가
								if (feedback)
									feedback.textContent = message; // 오류 메시지 표시
								isValid = false; // 유효성 검사 실패
							} else {
								field.classList.remove('is-invalid'); // 오류 스타일 제거
								if (feedback)
									feedback.textContent = ''; // 메시지 초기화
							}
						}

						// 이름 검사
						validateField(userName, userName.value.trim() !== '',
								'이름을 입력해주세요.');

						// 닉네임 검사
						validateField(userNickName,
								userNickName.value.trim() !== '',
								'닉네임을 입력해주세요.');

						// 아이디 검사
						validateField(userId, userId.value.trim().length >= 4,
								'아이디는 4자 이상이어야 합니다.');

						// 비밀번호 검사
						const passwordRegex = /^(?=.*[!@#$%^&*?_])(?=.*[a-zA-Z0-9]).{6,19}$/;
						validateField(userPwd, passwordRegex
								.test(userPwd.value),
								'비밀번호는 특수문자를 포함하고, 6자 이상 20자 미만이어야 합니다.');

						// 이메일 검사
						validateField(userEmail, userEmail.validity.valid,
								'올바른 이메일을 입력해주세요.');

						// 나이 검사
						validateField(userAge, userAge.value.trim() !== ''
								&& Number(userAge.value) > 0, '올바른 나이를 입력해주세요.');

						// 전화번호 검사
						validateField(userPhone,
								!userPhone.value.includes('-'),
								'전화번호에 "-"를 포함하지 마세요.');

						// 주소 검사
						validateField(userAddress,
								userAddress.value.trim() !== '', '주소를 입력해주세요.');

						// 성별 검사
						validateField(userGender, userGender.value !== '',
								'성별을 선택해주세요.');

						// 개인정보 동의 검사
						validateField(agreement, agreement.checked,
								'개인정보 수집 및 이용에 동의해주세요.');

						// 유효성 검사 실패 시 제출 차단
						if (!isValid) {
							event.preventDefault();
						} else {

						}
					});
</script>

<jsp:include page="../include/footer.jsp" />
