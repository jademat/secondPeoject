<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style>
textarea {
	resize: vertical;
}
</style>

<!-- board write modal -->
<div class="modal fade" id="boardWriteModal" tabindex="-1"
	aria-labelledby="boardWriteModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="boardWriteModalLabel">게시물 작성</h5>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="container mt-3">
					<h3></h3>
					<p style="color: black;">문의사항이 있으면 말해주세요.</p>
					<form method="post" action="user_boardWrite.go" id = "boardForm">
						<!-- user_id를 hidden 필드로 추가 -->
						<input type="hidden" name="user_id" value="${user_id}">

						<!-- 게시글 타입 선택 -->
						<div class="input-group mb-3">
							<div class="input-group-prepend">
								<label class="input-group-text" for="boardTypeSelect">Options</label>
							</div>
							<select class="custom-select" id="boardTypeSelect" name = "board_type" >
								<option selected >선택해주세요</option>
								 <c:choose>
							        <c:when test="${sessionScope.user_id == 'admin'}">
							            <option value="notice">공지사항</option> <!-- admin일 때만 "공지사항" 옵션 보이기 -->
							        </c:when>
							        <c:otherwise>
							            <option value="exchange">교환</option> <!-- 일반 사용자에게만  옵션 보이기 -->
							            <option value="refund">환불</option> 
							            <option value="inquiry">상품문의</option>
							        </c:otherwise>
							    </c:choose>
							</select>
						</div>

						<div class="input-group mb-3">
							<div class="input-group-prepend">
								<span class="input-group-text" id="inputGroup-sizing-default" >제목</span>
							</div>
							<input type="text" class="form-control"
								aria-label="Sizing example input"
								aria-describedby="inputGroup-sizing-default" name= "board_title" required>
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
								<label class="input-group-text" for="boardVisibleSelect">Options</label>
							</div>
							<select class="custom-select" id="boardVisibleSelect" name = "board_visible" required>
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
<script>
    // 폼 제출 전 검증
    document.getElementById('boardForm').addEventListener('submit', function(event) {
        var boardTypeSelect = document.getElementById('boardTypeSelect');
        var boardVisibleSelect = document.getElementById('boardVisibleSelect');
        
        // "선택해주세요"로 남아 있는지 확인
        if (boardTypeSelect.value === "선택해주세요") {
            alert("게시글 타입을 선택해주세요.");
            event.preventDefault(); // 폼 제출을 막음
            return false; // 추가적인 검사를 중지
        }

        // 공개설정이 "공개설정" 상태일 경우
        if (boardVisibleSelect.value === "공개설정") {
            alert("공개설정을 선택해주세요.");
            event.preventDefault(); // 폼 제출을 막음
            return false;
        }
    });
</script>
