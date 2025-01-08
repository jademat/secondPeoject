<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- Modal -->
<div class="modal fade" id="myInfoModal" data-backdrop="static"
	data-keyboard="false" tabindex="-1" aria-labelledby="myInfoModalLabel"
	aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="myInfoModalLabel">개인정보수정</h5>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<table class="table table">
					<tr>
						<th>아이디</th>
						<td><input name="id" readonly></td>
					</tr>
					<tr>
						<th>비밀번호</th>
						<td><input type="password" readonly></td>
					</tr>
					<tr>
						<th>닉네임</th>
						<td><input name="nick"></td>
					</tr>
					<tr>
						<th>이메일</th>
						<td><input name="email"></td>
					</tr>
					<tr>
						<th>연락처</th>
						<td><input name="phone"></td>
					</tr>
					<tr>
						<th>주소</th>
						<td><input name="addr"></td>
					</tr>
					<tr>
						<th>성별</th>
						<td><select name="gender">
								<option value="male">남자</option>
								<option value="female">여자</option>
						</select></td>
					</tr>
				</table>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
				<button type="submit" class="btn btn-primary">정보 수정</button>
			</div>
		</div>
	</div>
</div>
<!--infoModal-->