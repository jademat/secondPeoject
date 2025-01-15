<%@page import="com.hhlb.model.ProductDTO"%>
<%@page import="java.util.List"%>
<%@page import="com.hhlb.model.ProductDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
		ProductDAO dao = ProductDAO.getInstance();

		List<ProductDTO> list = dao.popularProduct();
		
		request.setAttribute("ProductList", list);
		
		
		
%>



<jsp:include page="../include/header.jsp" />
<!-- jQuery -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<!-- Owl Carousel JS -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/owl.carousel.min.js"></script>
	
<!-- Featured Start -->
<div class="container-fluid pt-5">
	<div class="row px-xl-5 pb-3">
		<div class="col-lg-3 col-md-6 col-sm-12 pb-1">
			<div class="d-flex align-items-center border mb-4"
				style="padding: 30px;">
				<h1 class="fa fa-check text-primary m-0 mr-3"></h1>
				<h5 class="font-weight-semi-bold m-0">Quality Product</h5>
			</div>
		</div>
		<div class="col-lg-3 col-md-6 col-sm-12 pb-1">
			<div class="d-flex align-items-center border mb-4"
				style="padding: 30px;">
				<h1 class="fa fa-shipping-fast text-primary m-0 mr-2"></h1>
				<h5 class="font-weight-semi-bold m-0">Free Shipping</h5>
			</div>
		</div>
		<div class="col-lg-3 col-md-6 col-sm-12 pb-1">
			<div class="d-flex align-items-center border mb-4"
				style="padding: 30px;">
				<h1 class="fas fa-exchange-alt text-primary m-0 mr-3"></h1>
				<h5 class="font-weight-semi-bold m-0">14-Day Return</h5>
			</div>
		</div>
		<div class="col-lg-3 col-md-6 col-sm-12 pb-1">
			<div class="d-flex align-items-center border mb-4"
				style="padding: 30px;">
				<h1 class="fa fa-phone-volume text-primary m-0 mr-3"></h1>
				<h5 class="font-weight-semi-bold m-0">24/7 Support</h5>
			</div>
		</div>
	</div>
</div>
<!-- Featured End -->


<!-- Categories Start -->
<div class="container-fluid pt-5">
	<div id="header-carousel" class="carousel slide" data-ride="carousel">
		<div class="carousel-inner">
			<div class="carousel-item active" style="height: 410px;">
				<img class="img-fluid" src="<%=request.getContextPath()%>/resource/img/carousel-1.jpg"
					alt="Image">
				<div
					class="carousel-caption d-flex flex-column align-items-center justify-content-center">
					<div class="p-3" style="max-width: 700px;">
						<h4 class="text-light text-uppercase font-weight-medium mb-3">10%
							Off Your First Order</h4>
						<h3 class="display-4 text-white font-weight-semi-bold mb-4">Fashionable
							Dress</h3>
						<a href="" class="btn btn-light py-2 px-3">Shop Now</a>
					</div>
				</div>
			</div>
			<div class="carousel-item" style="height: 410px;">
				<img class="img-fluid" src="<%=request.getContextPath()%>/resource/img/carousel-2.jpg"
					alt="Image">
				<div
					class="carousel-caption d-flex flex-column align-items-center justify-content-center">
					<div class="p-3" style="max-width: 700px;">
						<h4 class="text-light text-uppercase font-weight-medium mb-3">10%
							Off Your First Order</h4>
						<h3 class="display-4 text-white font-weight-semi-bold mb-4">Reasonable
							Price</h3>
						<a href="" class="btn btn-light py-2 px-3">Shop Now</a>
					</div>
				</div>
			</div>
		</div>
		<a class="carousel-control-prev" href="#header-carousel"
			data-slide="prev">
			<div class="btn btn-dark" style="width: 45px; height: 45px;">
				<span class="carousel-control-prev-icon mb-n2"></span>
			</div>
		</a> <a class="carousel-control-next" href="#header-carousel"
			data-slide="next">
			<div class="btn btn-dark" style="width: 45px; height: 45px;">
				<span class="carousel-control-next-icon mb-n2"></span>
			</div>
		</a>
	</div>
</div>
<!-- Categories End -->


<!-- Offer Start -->
<div class="container-fluid offer pt-5">
	<div class="row px-xl-5">
		<div class="col-md-6 pb-4">
			<div
				class="position-relative bg-secondary text-center text-md-right text-white mb-2 py-5 px-5">
				<img src="<%=request.getContextPath()%>/resource/img/offer-1.png" alt="">
				<div class="position-relative" style="z-index: 1;">
					<h5 class="text-uppercase text-primary mb-3">20% off the all
						order</h5>
					<h1 class="mb-4 font-weight-semi-bold">Women's Collection</h1>
					<a href="<%=request.getContextPath() %>/user_womanAll.go" class="btn btn-outline-primary py-md-2 px-md-3">Shop
						Now</a>
				</div>
			</div>
		</div>
		<div class="col-md-6 pb-4">
			<div
				class="position-relative bg-secondary text-center text-md-left text-white mb-2 py-5 px-5">
				<img src="<%=request.getContextPath()%>/resource/img/men.png" alt="">
				<div class="position-relative" style="z-index: 1;">
					<h5 class="text-uppercase text-primary mb-3">20% off the all
						order</h5>
					<h1 class="mb-4 font-weight-semi-bold">Men's Collection</h1>
					<a href="<%=request.getContextPath() %>/user_manAll.go" class="btn btn-outline-primary py-md-2 px-md-3">Shop
						Now</a>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- Offer End -->
	
	<!--이 달의 인기상품 Start  -->
	
	<div class="container-fluid pt-5">
   	 <div class="text-center mb-4">
        <h2 class="section-title px-5">
            <span class="px-2"> 이 달의 인기상품</span>
     	   </h2>
    </div>

    <!-- 상품 리스트 -->
    <div class="row">
        <c:forEach items="${ProductList}" var="dto">
            <div class="col-lg-3 col-md-6 col-sm-12 pb-1">
                <div class="card product-item border-0 mb-4">
                    <div class="card-header product-img position-relative overflow-hidden bg-transparent border p-0">
                        <img class="img-fluid w-100" src="<%= request.getContextPath() %>/resource/img/${ dto.product_image }" alt="">
                    </div>
                    <div class="card-body border-left border-right text-center p-0 pt-4 pb-3">
                        <h6 class="text-truncate mb-3">${ dto.product_name }</h6>
                        <div class="d-flex justify-content-center">
                            <h6>${ dto.product_price }</h6><h6 class="text-muted ml-2"><del>${ dto.product_price }</del></h6>
                        </div>
                    </div>
                    <div class="card-footer d-flex justify-content-between bg-light border">
                        <a href="<%= request.getContextPath() %>/user_product_view.go?pnum=${ dto.product_no }" class="btn btn-sm text-dark p-0"><i class="fas fa-eye text-primary mr-1"></i>View Detail</a>
                        <a href="#" class="btn btn-sm text-dark p-0"><i class="fas fa-shopping-cart text-primary mr-1"></i>Add To Cart</a>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>

<!-- Products Start -->
<div class="container-fluid pt-5">
	<div class="text-center mb-4">
		<h2 class="section-title px-5">
			<span class="px-2"> 이 달의 추천</span>
		</h2>
	</div>
	<<div class="row">
        <c:forEach items="${ProductList}" var="dto">
            <div class="col-lg-3 col-md-6 col-sm-12 pb-1">
                <div class="card product-item border-0 mb-4">
                    <div class="card-header product-img position-relative overflow-hidden bg-transparent border p-0">
                        <img class="img-fluid w-100" src="<%= request.getContextPath() %>/resource/img/${ dto.product_image }" alt="">
                    </div>
                    <div class="card-body border-left border-right text-center p-0 pt-4 pb-3">
                        <h6 class="text-truncate mb-3">${ dto.product_name }</h6>
                        <div class="d-flex justify-content-center">
                            <h6>${ dto.product_price }</h6><h6 class="text-muted ml-2"><del>${ dto.product_price }</del></h6>
                        </div>
                    </div>
                    <div class="card-footer d-flex justify-content-between bg-light border">
                        <a href="<%= request.getContextPath() %>/user_product_view.go?pnum=${ dto.product_no }" class="btn btn-sm text-dark p-0"><i class="fas fa-eye text-primary mr-1"></i>View Detail</a>
                        <a href="#" class="btn btn-sm text-dark p-0"><i class="fas fa-shopping-cart text-primary mr-1"></i>Add To Cart</a>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>
<!-- Products End -->


<!-- Vendor Start -->
<div class="container-fluid py-5">
	<div class="row px-xl-5">
		<div class="col">
			<div class="owl-carousel vendor-carousel">
				<div class="vendor-item border p-4">
					<img src="<%=request.getContextPath()%>/resource/img/vendor-1.jpg"
						alt="">
				</div>
				<div class="vendor-item border p-4">
					<img src="<%=request.getContextPath()%>/resource/img/vendor-2.jpg"
						alt="">
				</div>
				<div class="vendor-item border p-4">
					<img src="<%=request.getContextPath()%>/resource/img/vendor-3.jpg"
						alt="">
				</div>
				<div class="vendor-item border p-4">
					<img src="<%=request.getContextPath()%>/resource/img/vendor-4.jpg"
						alt="">
				</div>
				<div class="vendor-item border p-4">
					<img src="<%=request.getContextPath()%>/resource/img/vendor-5.jpg"
						alt="">
				</div>
				<div class="vendor-item border p-4">
					<img src="<%=request.getContextPath()%>/resource/img/vendor-6.jpg"
						alt="">
				</div>
				<div class="vendor-item border p-4">
					<img src="<%=request.getContextPath()%>/resource/img/vendor-7.jpg"
						alt="">
				</div>
				<div class="vendor-item border p-4">
					<img src="<%=request.getContextPath()%>/resource/img/vendor-8.jpg"
						alt="">
				</div>
			</div>
		</div>
	</div>
</div>
<!-- Vendor End -->



<jsp:include page="../include/footer.jsp" />
