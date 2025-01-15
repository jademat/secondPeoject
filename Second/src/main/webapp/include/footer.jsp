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
            <p>'HHLB'는 고객에게 최상의 쇼핑을 제공하고 
입점 브랜드의 성장을 지원하는 것을 경영 목표로 하고 있습니다.<br>
스트릿 브랜드부터 캐주얼, 디자이너, 컨템포러리, 하이엔드, 명품 브랜드까지 
패션에 특화된 고객 맞춤형 상품을 제안하고 있습니다.</p>
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
                        <a class="text-dark mb-2" href="<%=request.getContextPath() %>/user_shop.go"><i class="fa fa-angle-right mr-2"></i>Shop</a>
                        <a class="text-dark mb-2" href="<%=request.getContextPath() %>/cart.go"><i class="fa fa-angle-right mr-2"></i>Shopping Cart</a>
                        <a class="text-dark mb-2" href="<%=request.getContextPath() %>/user_board_list.go?board_type=all"><i class="fa fa-angle-right mr-2"></i>Board</a>
                        <a class="text-dark" href="<%=request.getContextPath() %>/user_review_list.go"><i class="fa fa-angle-right mr-2"></i>Review</a>
                    </div>
                </div>

                <div class="col-md-4 mb-5">
                    <h5 class="font-weight-bold text-dark mb-4">운영정책</h5>
                    <div class="d-flex flex-column justify-content-start">
                        <a class="text-dark mb-2" href="<%=request.getContextPath()%>/user_board_list.go?board_type=all"><i class="fa fa-angle-right mr-2"></i>자주 묻는 질문</a>
                        <!-- 개인정보 처리 방침 링크 클릭 시 모달 띄우기 -->
                        <a class="text-dark mb-2" href="#" data-toggle="modal" data-target="#privacyPolicyModal"><i class="fa fa-angle-right mr-2"></i> 개인정보 처리 방침</a>
                     </div>  
                </div>


<script src="<%=request.getContextPath() %>/resource/js/main.js"></script> 

</body>
</html>