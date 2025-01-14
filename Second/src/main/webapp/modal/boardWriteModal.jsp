<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<style>
textarea {
	resize: vertical;
}
</style>

<!-- board write modal -->
<div class="modal fade" id="boardWriteModal" tabindex="-1"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">게시물 작성</h5>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="container mt-3">
					<h3></h3>
					<p style="color: black;">문의사항이 있으면 말해주세요.</p>
					<form method="post" action="user_boardWrite.go">
						<!-- user_id를 hidden 필드로 추가 -->
						<input type="hidden" name="user_id" value="${user_id}">

						<!-- 게시글 타입 선택 -->
						<div class="input-group mb-3">
							<div class="input-group-prepend">
								<label class="input-group-text" for="inputGroupSelect01">Options</label>
							</div>
							<select class="custom-select" id="inputGroupSelect01" name = "board_type">
								<option selected>선택해주세요</option>
								<option value="exchange">교환</option>
								<option value="refund">환불</option>
								<option value="inquiry">상품문의</option>
							</select>
						</div>

						<div class="input-group mb-3">
							<div class="input-group-prepend">
								<span class="input-group-text" id="inputGroup-sizing-default">제목</span>
							</div>
							<input type="text" class="form-control"
								aria-label="Sizing example input"
								aria-describedby="inputGroup-sizing-default" name= "board_title">
						</div>

						<div class="input-group">
							<div class="input-group-prepend">
								<span class="input-group-text">내용</span>
							</div>
							<textarea class="form-control" aria-label="With textarea" name = "board_cont" required></textarea>
						</div>
						<br>

						<div class="input-group mb-3">
							<div class="input-group-prepend">
								<label class="input-group-text" for="inputGroupSelect01">Options</label>
							</div>
							<select class="custom-select" id="inputGroupSelect01" name = "board_visible">
								<option selected>공개설정</option>
								<option value="1">공개</option>
								<option value="0">비공개</option>
							</select>
						</div>
						
						<div class = "btn_area" align = "right">
							<input type = "submit" class = "btn btn-success" value = "작성">
							<input type = "reset" class = "btn btn-danger" value = "다시작성">
						</div>					
							
					</form>
					<!-- 여기에서 form 태그 닫힘 -->
				</div>
			</div>
		</div>
	</div>
</div>
<!-- board write modal end -->