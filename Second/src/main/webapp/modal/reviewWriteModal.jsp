<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="modal" id="reviewWriteModal">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">

			<!-- Modal Header -->
			<div class="modal-header">
				<h4 class="modal-title">리뷰작성</h4>
				<button type="button" class="close" data-dismiss="modal">&times;</button>
			</div>

			<!-- Modal body -->
			<form method="post" action="<%=request.getContextPath() %>/user_reviewWrite.go" enctype="multipart/form-data">
			<input type="hidden" name="product_no" id="product_no">
	        <input type="hidden" name="user_id" id="user_id">
				<div class="modal-body">
					<table class="table table-borderless">
						<tr>
							<div class="form-group">
								<label for="title">제목</label> 
								<input type="text" class="form-control" id="title" name = "title">
							</div>
							<div class="form-group">
								<label for="title">상품명</label> 
								<p id = "name" style = "color : black;"></p>
							</div>
							<div class="form-group">
								<span class="text-bold">제품 평가</span>
								<fieldset id="star">

									<input type="radio" name="star" value="5" id="rate1"> <label
										for="rate1">★</label> <input type="radio" name="star"
										value="4" id="rate2"> <label for="rate2">★</label> <input
										type="radio" name="star" value="3" id="rate3"> <label
										for="rate3">★</label> <input type="radio" name="star"
										value="2" id="rate4"> <label for="rate4">★</label> <input
										type="radio" name="star" value="1" id="rate5"> <label
										for="rate5">★</label>
								</fieldset>
							</div>
							<div class="form-group">
								<label for="review">리뷰</label>
								<textarea class="form-control" aria-label="With textarea"
									rows="5" cols="30" style="resize: none;" name ="cont"></textarea>
							</div>
							<div class="input-group mb-3">
								<div class="input-group-prepend">
									<span class="input-group-text" id="inputGroupFileAddon01">Upload</span>
								</div>
								<div class="custom-file">
									<input type="file" class="custom-file-input"
										id="inputGroupFile01" aria-describedby="inputGroupFileAddon01" name= "file" accept="image/*" required>
									<label class="custom-file-label" for="inputGroupFile01">사진첨부(필수)</label>
								</div>
							</div>
						</tr>

					</table>
				</div>

				<!-- Modal footer -->
				<div class="modal-footer">
					<input type="submit" class="btn btn-primary" id ="submitReview" value="작성"> 
					<input type="reset" class="btn btn-primary" data-dismiss="modal" value="취소">
				</div>
			</form>

		</div>
	</div>
</div>
<style>
#star {
	display: inline-block;
	direction: rtl;
	border: 0;
}

#star legend {
	text-align: right;
}

input[type=radio] {
	display: none;
}

#star label {
	font-size: 2em;
	color: transparent;
	text-shadow: 0 0 0 #f0f0f0;
}

#star label:hover {
	text-shadow: 0 0 0 rgba(250, 208, 0, 0.99);
}

#star label:hover ~ label {
	text-shadow: 0 0 0 rgba(250, 208, 0, 0.99);
}

#star input[type=radio]:checked ~ label {
	text-shadow: 0 0 0 rgba(250, 208, 0, 0.99);
}

.disable {
	background-color: darkgray;
}
</style>

<script>

	$('#reviewWriteModal').on('show.bs.modal', function (event) {
        var button = $(event.relatedTarget); 
        var name = button.data('name');
        var userId = button.data('userid'); // 'data-userid' 값
        var productNo = button.data('product'); // 'data-product' 값
        
        $(this).find('#name').text(name);
        $(this).find('#user_id').val(userId); // 사용자 ID
        $(this).find('#product_no').val(productNo); // 제품 번호
	});
	
	$('#submitReview').click(function () {
        // Add additional checks if needed (e.g., file selection or review star rating)
        var star = $("input[name='star']:checked").val();
        if (!star) {
            alert("별점을 선택해주세요.");
            return false; // Prevent form submission
        }
        $('#reviewWriteModal').modal('hide'); // 모달 닫기
        $('form').submit(); // 폼 제출
    });
	
	
</script>