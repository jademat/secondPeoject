<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<jsp:include page="../include/header.jsp" />
<!-- Categories Start -->

<div class="container-fluid pt-5">

	<c:set var="rList" value="${rList }" />
	<c:if test="${!empty rList }"> 
		<c:forEach items="${rList }" var="dto"> 
			<div class="row px-xl-5 pb-3">
				<div class="col-lg-4 col-md-6 pb-1">
					<div class="cat-item d-flex flex-column border mb-4"
						style="padding: 30px;">

						<a href="" class="cat-img position-relative overflow-hidden mb-3"
							data-toggle="modal" data-target="#reviewModal"> 
							<img class="img-fluid" src="${dto.review_image}" alt="">
						</a>
						<h5 class="font-weight-semi-bold m-0">${dto.getUser_id() }님의 리뷰페이지</h5>
					</div>
				</div>
			</div>
		</c:forEach>
	</c:if>
	<c:if test = "${empty rList }">
		<div align = "center">
			<h3>
				리뷰가 존재하지 않습니다. <br><br>
				당신의 리뷰를 남겨주세요.
			</h3>
		</div>
	</c:if>

</div>



<!-- Back to Top -->
<a href="#" class="btn btn-primary back-to-top"><i
	class="fa fa-angle-double-up"></i></a>

<jsp:include page="../modal/reviewModal.jsp" />
<jsp:include page="../include/footer.jsp" />
