<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<jsp:include page="../include/header.jsp" />
<!-- Categories Start -->
<style>
.row {
	display: flex;
	flex-wrap: wrap; 
	gap: 20px; 
}

.col-lg-3, .col-md-4, .col-sm-6 {
	flex: 0 0 22%;
	box-sizing: border-box;
}
.pagination {
    display: flex;
    justify-content: center;  /* 중앙 정렬 */
    align-items: center;
    margin-top: 30px;  /* 상단 여백 */
    list-style: none;
    padding-left: 0;
}
</style>
<div class="container-fluid pt-5">

	<c:set var="rList" value="${rList }" />
	<c:if test="${!empty rList }">
		<div class="row px-xl-5 pb-3">
			<c:forEach items="${rList }" var="dto">
				<div class="col-lg-3 col-md-4 col-sm-6 pb-1">
					<div class="cat-item d-flex flex-column border mb-4"
						style="padding: 30px;">

						<button type="button" class="btn btn-link" data-toggle="modal"
							data-target="#reviewModal" data-image="${dto.getReview_image()}"
							data-user="${dto.getUser_id()}"
							data-date="${dto.getReview_date()}"
							data-content="${dto.getReview_cont()}"
							data-rating="${dto.getReview_rank()}"
							data-title="${dto.getReview_title()}">
							<img class="img-fluid"
								src="<%= request.getContextPath() %>/resource/img/${dto.getReview_image()}"
								alt=""
								style="max-width: 100%; max-height: 300px; object-fit: cover;">
						</button>
						<h5 class="font-weight-semi-bold m-0">${dto.getUser_id() }님의
							리뷰</h5>
					</div>
				</div>
			</c:forEach>
		</div>
	</c:if>
	<c:if test="${empty rList }">
		<div align="center">
			<h3>
				리뷰가 존재하지 않습니다. <br> <br> 당신의 리뷰를 남겨주세요.
			</h3>
		</div>
	</c:if>

</div>
<div class="container">
	<ul class="pagination">
		<c:if test="${page > block }">
			<li class="page-item "><a class="page-link"
				href="user_review.go?page=${startBlock - 1 }">Previous</a></li>
		</c:if>
		<c:forEach begin="${startBlock }" end="${endBlock }" var="i">
			<c:if test="${i == page}">
				<li class="page-item active"><a class="page-link"
					href="user_review.go?&page=${i }">${i }</a></li>
			</c:if>
			<c:if test="${i != page}">
				<li class="page-item"><a class="page-link"
					href="user_review.go?page=${i }">${i }</a></li>
			</c:if>
		</c:forEach>
			<c:if test="${endBlock < allPage}">
			<li class="page-item"><a class="page-link" href="user_review.go?&page=${endBlock + 1 }">Next</a></li>
			</c:if>
	</ul>
</div>


<!-- Back to Top -->
<a href="#" class="btn btn-primary back-to-top"><i
	class="fa fa-angle-double-up"></i></a>

<jsp:include page="../modal/reviewModal.jsp" />
<jsp:include page="../include/footer.jsp" />
