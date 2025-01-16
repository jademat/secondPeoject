<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div class="modal" id="reviewWriteModal">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">

			<!-- Modal Header -->
			<div class="modal-header">
				<h4 class="modal-title">리뷰작성</h4>
				<button type="button" class="close" data-dismiss="modal">&times;</button>
			</div>

			<!-- Modal body -->
			<div class="modal-body">
				<table class="table table-borderless">
					<tr>
						<div class="form-group">
							<label for="title">제목</label> 
							<input type="text" class="form-control" id="title">
						</div>
						<div class="form-group">
							<span class="text-bold">제품 평가</span>
							<fieldset id="star">

								<input type="radio" name="star" value="5" id="rate1"> 
								<label for="rate1">★</label> 
								<input type="radio" name="star" value="4" id="rate2">
								<label for="rate2">★</label>
								<input type="radio" name="star" value="3" id="rate3">
								<label for="rate3">★</label> 
								<input type="radio" name="star" value="2" id="rate4">
								<label for="rate4">★</label> 
								<input type="radio" name="star" value="1" id="rate5">
								<label for="rate5">★</label>
							</fieldset>
						</div>
						<div class="form-group">
							<label for="review">리뷰</label>
							<textarea class="form-control" aria-label="With textarea"
								rows="5" cols="30" style="resize: none;"></textarea>
						</div>
						<div class="input-group mb-3">
							<div class="input-group-prepend">
								<span class="input-group-text" id="inputGroupFileAddon01">Upload</span>
							</div>
							<div class="custom-file">
								<input type="file" class="custom-file-input"
									id="inputGroupFile01" aria-describedby="inputGroupFileAddon01">
								<label class="custom-file-label" for="inputGroupFile01">사진첨부(필수)</label>
							</div>
						</div>
					</tr>

				</table>
			</div>

			<!-- Modal footer -->
			<div class="modal-footer">
				<button type="button" class="btn btn-primary" data-dismiss="modal">작성</button>
				<button type="button" class="btn btn-primary" data-dismiss="modal">취소</button>
			</div>

		</div>
	</div>
</div>
<script>
$('#reviewWriteModal').on('show.bs.modal', function (event) {
	var button = $(event.relatedTarget); // 버튼 클릭 이벤트
});

</script>
<style>
    #star{
        display: inline-block;
        direction: rtl;
        border:0;
        }
        #star legend{
        text-align: right;
        }
        input[type=radio]{
        display: none;
        }
        #star label{
        font-size: 2em;
        color: transparent;
        text-shadow: 0 0 0 #f0f0f0;
        }
        #star label:hover{
        text-shadow: 0 0 0 rgba(250, 208, 0, 0.99);
        }
        #star label:hover ~ label{
        text-shadow: 0 0 0 rgba(250, 208, 0, 0.99);
        }
        #star input[type=radio]:checked ~ label{
        text-shadow: 0 0 0 rgba(250, 208, 0, 0.99);
        }
        .disable {
        background-color: darkgray;
        }
</style>