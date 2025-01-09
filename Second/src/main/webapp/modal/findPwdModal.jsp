<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<script>
	function resetform() {

		document.getElementById('myForm').reset();

	}
</script>

<!-- 비밀번호 찾기 -->

<div class="modal fade" id="findPasswordModal" tabindex="-1"
	aria-labelledby="findPasswordModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="findPasswordModalLabel">비밀번호 찾기</h5>
			</div>
			<div class="modal-body">
				<p>비밀번호를 찾으려면 아래에 이메일을 입력하세요.</p>
				<form id="myForm">
					<div class="mb-3">
						<label for="name" class="form-label">이름</label> <input type="text"
							class="form-control" id="name" placeholder="이름을 입력하세요." required>
					</div>

					<div class="mb-3">
						<label for="id" class="form-label">아이디</label> <input type="text"
							class="form-control" id="id" placeholder="사용자 아이디를 입력하세요. "
							required>
					</div>

					<div class="mb-3">
						<label for="email" class="form-label">이메일 주소</label> <input
							type="email" class="form-control" id="email"
							placeholder="example@example.com" required>
					</div>
					<button type="button" class="btn btn-primary" onclick="location.href='resetPwd.jsp'">비밀번호 찾기</button>
					</form>

				</form>
			</div>
			<!-- 모달 푸터 -->
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-dismiss="modal"
					onclick="resetform()">
					닫기 <span aria-hidden="true">&times;</span>
				</button>
			</div>
		</div>
	</div>
</div>