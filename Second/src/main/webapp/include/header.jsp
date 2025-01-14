<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>EShopper - Bootstrap Shop Template</title>
<meta content="width=device-width, initial-scale=1.0" name="viewport">
<meta content="Free HTML Templates" name="keywords">
<meta content="Free HTML Templates" name="description">

<!-- Favicon -->
<link href="../resource/img/favicon.ico" rel="icon">

<!-- Google Web Fonts -->
<link rel="preconnect" href="https://fonts.gstatic.com">
<link
	href="https://fonts.googleapis.com/css2?family=Poppins:wght@100;200;300;400;500;600;700;800;900&display=swap"
	rel="stylesheet">

<!-- Font Awesome -->
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css"
	rel="stylesheet">

<!-- Libraries Stylesheet -->
<link href="<%=request.getContextPath() %>/resource/lib/owlcarousel/assets/owl.carousel.min.css"
	rel="stylesheet">

<!-- Customized Bootstrap Stylesheet -->


<link href="<%=request.getContextPath() %>/resource/css/style.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.bundle.min.js"></script>
<script src="lib/easing/easing.min.js"></script>
<script src="lib/owlcarousel/owl.carousel.min.js"></script>

<!-- Contact Javascript File -->
<script src="mail/jqBootstrapValidation.min.js"></script>
<script src="mail/contact.js"></script>

<!-- Template Javascript -->
<script src="js/main.js"></script>

 <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/assets/owl.carousel.min.css">
 <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/assets/owl.theme.default.min.css">

</head>
<body>

        <!-- Topbar Start -->
        <div class="container-fluid">
            <div class="row bg-secondary py-2 px-xl-5">
                <div class="col-lg-6 d-none d-lg-block">
                    <div class="d-inline-flex align-items-center">
                        <a class="text-dark" href="<%=request.getContextPath() %>/user_board_list.go?board_type=all">FAQs</a>
                
                    </div>
                </div>
                
            </div>
            <div class="row align-items-center py-3 px-xl-5">
                <div class="col-lg-3 d-none d-lg-block">
                    <a href="<%=request.getContextPath() %>/user_main.go" class="text-decoration-none">
                        <h1 class="m-0 display-5 font-weight-semi-bold"><span class="text-primary font-weight-bold border px-3 mr-1">E</span>HHLB</h1>
                    </a>
                </div>
                
               
            </div>
        </div>
        <!-- Topbar End -->
    
    
        <!-- Navbar Start -->
        <div class="container-fluid">
            <div class="row border-top px-xl-5">
                <div class="col-lg-3 d-none d-lg-block">
                    <a class="btn shadow-none d-flex align-items-center justify-content-between bg-primary text-white w-100" data-toggle="collapse" href="#navbar-vertical" style="height: 65px; margin-top: -1px; padding: 0 30px;">
                        <h6 class="m-0">Categories</h6>
                        <i class="fa fa-angle-down text-dark"></i>
                    </a>
                    <nav class="collapse position-absolute navbar navbar-vertical navbar-light align-items-start p-0 border border-top-0 border-bottom-0 bg-light" id="navbar-vertical" style="width: calc(100% - 30px); z-index: 1;">
                        <div class="navbar-nav w-100 overflow-hidden" style="height: 410px">
                            <div class="nav-item dropdown">
                                <a href="#" class="nav-link" data-toggle="dropdown"> Woman<i class="fa fa-angle-down float-right mt-1"></i></a>
                                <div class="dropdown-menu position-absolute bg-secondary border-0 rounded-0 w-100 m-0">
                                    <a href="" class="dropdown-item"> Top </a>
                                    <a href="" class="dropdown-item"> Bottom </a>
                                    <a href="" class="dropdown-item"> Outer </a>
                                </div>
                            </div>
                            <div class="nav-item dropdown">
                                <a href="#" class="nav-link" data-toggle="dropdown"> Man <i class="fa fa-angle-down float-right mt-1"></i></a>
                                <div class="dropdown-menu position-absolute bg-secondary border-0 rounded-0 w-100 m-0">
                                    <a href="" class="dropdown-item"> Top </a>
                                    <a href="" class="dropdown-item"> Bottom </a>
                                    <a href="" class="dropdown-item"> Outer </a>
                                </div>
                    </nav>
                </div>
                <div class="col-lg-9">
                    <nav class="navbar navbar-expand-lg bg-light navbar-light py-3 py-lg-0 px-0">
                        <a href="../product/main.jsp" class="text-decoration-none d-block d-lg-none">
                            <h1 class="m-0 display-5 font-weight-semi-bold"><span class="text-primary font-weight-bold border px-3 mr-1">E</span>HHLB</h1>
                        </a>
                        <button type="button" class="navbar-toggler" data-toggle="collapse" data-target="#navbarCollapse">
                            <span class="navbar-toggler-icon"></span>
                        </button>
                        <div class="collapse navbar-collapse justify-content-between" id="navbarCollapse">
                            <div class="navbar-nav mr-auto py-0">
                                <a href="<%=request.getContextPath() %>/user_main.go" class="nav-item nav-link">Home</a>
                                <a href="<%=request.getContextPath() %>/user_shop.go" class="nav-item nav-link">Shop</a>
                           
                        
                                <div class="nav-item dropdown">
                                
                                    <div class="nav-item dropdown">
                                        <a href="#" class="nav-link dropdown-toggle" data-toggle="dropdown">Pages</a>
                                        <div class="dropdown-menu rounded-0 m-0">
                                            <a href="../product/cart.jsp" class="dropdown-item">Shopping Cart</a>
                                            <a href="" class="dropdown-item">여기 아마 QnA</a>
                                            <a href="" class="dropdown-item"> + 이거 됨?</a>
                                        </div>
                                    </div>
                                </div>

                                <a href="<%=request.getContextPath() %>/user_board_list.go?board_type=all" class="nav-item nav-link">Board</a>
                                <a href="<%=request.getContextPath() %>/user_review_list.go" class="nav-item nav-link">Review</a>

                            </div>
                            <div class="navbar-nav ml-auto py-0">
                            <c:if test="${empty user_id}">

                                <a href="<%=request.getContextPath() %>/user/login.jsp" class="nav-item nav-link">Login</a>
                                <a href="<%=request.getContextPath() %>/user/register.jsp" class="nav-item nav-link">Register</a>

                            </c:if>
                            <c:if test="${!empty user_id}">
                                <a href="<%=request.getContextPath() %>/user_myInfo.go?id=${sessionScope.user_id}" class="nav-item nav-link">myInfo</a>
                                <a href="<%=request.getContextPath() %>/user_logout.go" class="nav-item nav-link">Logout</a>
                            </c:if>
                            </div>
                            <div class="col-lg-3 col-6 d-flex" align = "right">
                                <a href="<%= request.getContextPath() %>/user_cart.go?id=${ user_id }" class="btn border ms-auto">
                                    <i class="fas fa-shopping-cart text-primary"></i>
                                    <span class="badge">0</span>
                                </a>
                            </div>
                        </div>
                    </nav>
                </div>
            </div>
        </div>

        <!-- Navbar End -->



	<!-- Page Header Start -->
    <div class="container-fluid bg-secondary mb-5">
        <div class="d-flex flex-column align-items-center justify-content-center" style="min-height: 300px">
            <h1 class="font-weight-semi-bold text-uppercase mb-3">HAEDER 입니다</h1>
            <div class="d-inline-flex">
                <p class="m-0"><a href="">Home</a></p>
                <p class="m-0 px-2">-</p>
                <p class="m-0">Shop</p>
            </div>
        </div>
    </div>
