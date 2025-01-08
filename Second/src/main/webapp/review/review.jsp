<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ include file="/include/header.jsp"%>
<!-- Categories Start -->

<div class="container-fluid pt-5">
	<div class="row px-xl-5 pb-3">
		<div class="col-lg-4 col-md-6 pb-1">
			<div class="cat-item d-flex flex-column border mb-4"
				style="padding: 30px;">

				<a href="" class="cat-img position-relative overflow-hidden mb-3"
					data-toggle="modal" data-target="#exampleModal"> <img
					class="img-fluid" src="img/cat-1.jpg" alt="">
				</a>
				<h5 class="font-weight-semi-bold m-0">님의 리뷰페이지</h5>
			</div>
		</div>
		<div class="col-lg-4 col-md-6 pb-1">
			<div class="cat-item d-flex flex-column border mb-4"
				style="padding: 30px;">

				<a href="" class="cat-img position-relative overflow-hidden mb-3"
					data-toggle="modal" data-target="#exampleModal"> <img
					class="img-fluid" src="img/cat-2.jpg" alt="">
				</a>
				<h5 class="font-weight-semi-bold m-0">님의 리뷰페이지</h5>
			</div>
		</div>
		<div class="col-lg-4 col-md-6 pb-1">
			<div class="cat-item d-flex flex-column border mb-4"
				style="padding: 30px;">
				<a href="" class="cat-img position-relative overflow-hidden mb-3"
					data-toggle="modal" data-target="#exampleModal"> <img
					class="img-fluid" src="img/cat-3.jpg" alt="">
				</a>
				<h5 class="font-weight-semi-bold m-0">님의 리뷰페이지</h5>
			</div>
		</div>
		<div class="col-lg-4 col-md-6 pb-1">
			<div class="cat-item d-flex flex-column border mb-4"
				style="padding: 30px;">
				<a href="" class="cat-img position-relative overflow-hidden mb-3"
					data-toggle="modal" data-target="#exampleModal"> <img
					class="img-fluid" src="img/cat-4.jpg" alt="">
				</a>
				<h5 class="font-weight-semi-bold m-0">님의 리뷰페이지</h5>
			</div>
		</div>
		<div class="col-lg-4 col-md-6 pb-1">
			<div class="cat-item d-flex flex-column border mb-4"
				style="padding: 30px;">
				<a href="" class="cat-img position-relative overflow-hidden mb-3"
					data-toggle="modal" data-target="#exampleModal"> <img
					class="img-fluid" src="resource/img/cat-5.jpg" alt="">
				</a>
				<h5 class="font-weight-semi-bold m-0">님의 리뷰페이지</h5>
			</div>
		</div>
		<div class="col-lg-4 col-md-6 pb-1">
			<div class="cat-item d-flex flex-column border mb-4"
				style="padding: 30px;">
				<a href="" class="cat-img position-relative overflow-hidden mb-3"
					data-toggle="modal" data-target="#exampleModal"> <img
					class="img-fluid" src="img/cat-6.jpg" alt="">
				</a>
				<h5 class="font-weight-semi-bold m-0">님의 리뷰페이지</h5>
			</div>
		</div>
	</div>
</div>
<!-- Categories End -->



<!-- Button to Open the Modal -->

<!-- review modal -->
<div class="modal" id="reviewModal">
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
							<label for="usr">제목</label> <input type="text"
								class="form-control" id="usr">
						</div>
						<div class="form-group">
							<label for="pwd">리뷰</label>
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
				<button type="button" class="btn btn-primary" data-dismiss="modal">Close</button>
			</div>

		</div>
	</div>
</div>

<!-- Back to Top -->
<a href="#" class="btn btn-primary back-to-top"><i
	class="fa fa-angle-double-up"></i></a>

<jsp:include page="../modal/reviewModal.jsp" />

</body>

</html>