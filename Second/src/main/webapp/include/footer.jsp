<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:include page="../modal/infoPrivacyModal.jsp"/>

<!-- Footer Start -->
<div class="container-fluid bg-secondary text-dark mt-5 pt-5">
    <div class="row px-xl-5 pt-5">
        <div class="col-lg-4 col-md-12 mb-5 pr-3 pr-xl-5">
            <a href="index.html" class="text-decoration-none">
                <h1 class="mb-4 display-5 font-weight-semi-bold"><span class="text-primary font-weight-bold border border-white px-3 mr-1">E</span>HHLB</h1>
            </a>
            <p>Dolore erat dolor sit lorem vero amet. Sed sit lorem magna, ipsum no sit erat lorem et magna ipsum dolore amet erat.</p>
            <p class="mb-2"><i class="fa fa-map-marker-alt text-primary mr-3"></i>123 Street, Seoul, Korea</p>
            <p class="mb-2"><i class="fa fa-envelope text-primary mr-3"></i>info@example.com</p>
            <p class="mb-0"><i class="fa fa-phone-alt text-primary mr-3"></i>+012 345 67890</p>
        </div>
        <div class="col-lg-8 col-md-12">
            <div class="row">
                                
                <div class="col-md-4 mb-5">
                    <h5 class="font-weight-bold text-dark mb-4">Quick Links</h5>
                    <div class="d-flex flex-column justify-content-start">

                        <a class="text-dark mb-2" href="<%=request.getContextPath() %>/user_main.go"><i class="fa fa-angle-right mr-2"></i>Home</a>
                        <a class="text-dark mb-2" href="<%=request.getContextPath() %>/user_shop.go"><i class="fa fa-angle-right mr-2"></i>Our Shop</a>
                        <a class="text-dark mb-2" href="<%=request.getContextPath() %>/user_shop.go"><i class="fa fa-angle-right mr-2"></i>Shop</a>
                        <a class="text-dark mb-2" href="<%=request.getContextPath() %>/cart.go"><i class="fa fa-angle-right mr-2"></i>Shopping Cart</a>
                        <a class="text-dark mb-2" href="<%=request.getContextPath() %>/user_board_list.go"><i class="fa fa-angle-right mr-2"></i>Board</a>
                        <a class="text-dark" href="<%=request.getContextPath() %>/user_review_list.go"><i class="fa fa-angle-right mr-2"></i>Review</a>
                    </div>
                </div>

                <div class="col-md-4 mb-5">
                    <h5 class="font-weight-bold text-dark mb-4">운영정책</h5>
                    <div class="d-flex flex-column justify-content-start">
                        <a class="text-dark mb-2" href=""><i class="fa fa-angle-right mr-2"></i>자주 묻는 질문</a>
                        <!-- 개인정보 처리 방침 링크 클릭 시 모달 띄우기 -->
                        <a class="text-dark mb-2" href="#" data-toggle="modal" data-target="#privacyPolicyModal"><i class="fa fa-angle-right mr-2"></i> 개인정보 처리 방침</a>
                     </div>  
                </div>

	<!-- JavaScript Libraries -->
	<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.bundle.min.js"></script>
	<script src="../resource/lib/easing/easing.min.js"></script>
	<script src="../resource/lib/owlcarousel/owl.carousel.min.js"></script>
	
	<!-- Contact Javascript File -->
	<script src="../resource/mail/jqBootstrapValidation.min.js"></script>
	<script src="../resource/mail/contact.js"></script>
	
	<!-- Template Javascript -->
	<script src="../resource/js/main.js"></script>


</body>
</html>