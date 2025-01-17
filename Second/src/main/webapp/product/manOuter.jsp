<%@page import="com.hhlb.model.ProductDTO"%>
<%@page import="java.util.List"%>
<%@page import="com.hhlb.model.ProductDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
request.setAttribute("pageTitle", "Outer");
%>
<jsp:include page="../include/header.jsp" />


<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
ProductDAO dao = ProductDAO.getInstance();

List<ProductDTO> list = dao.manOuter();

request.setAttribute("ProductList", list);
%>

<c:set var="list" value="${ ProductList }" />

<!-- Shop Start -->
<div class="container-fluid pt-5">
	<div class="row">

		<!-- Shop Product Start -->
		<div class="col-lg col-md-12">
			<div class="row pb-3  justify-content-center">
				<div class="col-12 pb-1">
					<div class="d-flex align-items-center justify-content-between mb-4">

					

						

					</div>
				</div>

				<!-- 상품 리스트 -->
				<c:forEach items="${ list }" var="dto">
					<div class="col-lg-3 col-md-6 col-sm-12 pb-1">
						<div class="card product-item border-0 mb-4">
							<div
								class="card-header product-img position-relative overflow-hidden bg-transparent border p-0">
								<img class="img-fluid w-100"
									src="<%= request.getContextPath() %>/resource/img/${ dto.getProduct_image() }"
									alt="">
							</div>
							<div
								class="card-body border-left border-right text-center p-0 pt-4 pb-3">
								<h6 class="text-truncate mb-3">${ dto.getProduct_name() }</h6>
								<div class="d-flex justify-content-center">
									<h6>${ dto.getProduct_price() }</h6>
									<h6 class="text-muted ml-2">
										<del>${ dto.getProduct_price() }</del>
									</h6>
								</div>
							</div>
							<div
								class="card-footer d-flex justify-content-between bg-light border">
								<a
									href="<%= request.getContextPath() %>/user_product_view.go?pnum=${ dto.getProduct_no() }"
									class="btn btn-sm text-dark p-0"><i
									class="fas fa-eye text-primary mr-1"></i>View Detail</a>

							</div>
						</div>
					</div>
				</c:forEach>
			</div>

			<!-- 페이지네이션 시작 -->
			<div class="container">
				<ul class="pagination justify-content-center mb-3">

					<!-- 처음으로 -->
					<c:if test="${page > block }">
						<li class="page-item"><a class="page-link"
							href="user_manOuter.go?page=1">⏪</a></li>
						<li class="page-item"><a class="page-link"
							href="user_manOuter.go?page=${startBlock - 1 }">◀</a></li>
					</c:if>

					<!-- 페이지 글 번호 -->
					<c:forEach begin="${startBlock }" end="${endBlock }" var="i">
						<c:if test="${i == page}">
							<li class="page-item active"><a class="page-link"
								href="user_manOuter.go?&page=${ i }">${ i }</a></li>
						</c:if>
						<c:if test="${i != page}">
							<li class="page-item"><a class="page-link"
								href="user_manOuter.go?page=${ i }">${ i }</a></li>
						</c:if>
					</c:forEach>

					<!-- 마지막으로 -->
					<c:if test="${endBlock < allPage}">
						<li class="page-item"><a class="page-link"
							href="user_manOuter.go?page=${endBlock + 1 }">▶</a></li>
						<li class="page-item"><a class="page-link"
							href="user_manOuter.go?page=${ allPage }">⏩</a></li>
					</c:if>
				</ul>
			</div>
			<!-- 페이지네이션 끝 -->

		</div>
		<!-- Shop Product End -->
	</div>
</div>
<!-- Shop End -->
<jsp:include page="../modal/reviewModal.jsp" />
<jsp:include page="../include/footer.jsp" />
