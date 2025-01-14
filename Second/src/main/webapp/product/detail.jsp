<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
	
<jsp:include page="../include/header.jsp" />


    <!-- 상품 정보(상품 사진, 장바구니 버튼, 상품 설명 등) start -->
    <div class="container-fluid py-5">
    
    <c:set var="dto" value="${ ProductCont }"/>			<!-- 해당 상품의 정보 -->
    <c:set var="reviewDto" value="${ ReviewList }"/>	<!-- 해당 상품의 리뷰 리스트 -->
    <c:set var="reviewRank" value="${ ReviewRank }"/>	<!-- 리뷰의 점수 평균 -->
    <c:set var="reviewCount" value="${ ReviewCount }"/>	<!-- 해당 상품 리뷰 개수  -->
    <c:set var="productList" value="${ ProductList }"/>	<!-- 해당 상품 리뷰 개수  -->
    
    	<!-- 받아올 상품 데이터가 잡힌 경우 -->
    	<c:if test="${ !empty dto  }">
        <div class="row px-xl-5">
        	<!-- 상품 사진 -->
            <div class="col-lg-5 pb-5">
                <div id="product-carousel" class="carousel slide" data-ride="carousel">
                    <div class="carousel-inner border">
                        <div class="carousel-item active">
                            <img class="w-100 h-100" src="<%= request.getContextPath() %>/resource/img/${ dto.getProduct_image() }"
                            		alt="Image">
                        </div>
                    </div>
                </div>
            </div>

			<!-- 상품 사진 옆 결제 정보 창 -->
            <div class="col-lg-7 pb-5">
                <h3 class="font-weight-semi-bold">${ dto.getProduct_name() }</h3>
                <div class="d-flex mb-3">
                    <div class="text-primary mr-2">
                    	<small class="pt-1">${ reviewRank }</small>
                    </div>
                    <small class="pt-1">${ reviewCount } reviews</small>
                </div>
                <h3 class="font-weight-semi-bold mb-4">${ dto.getProduct_price() }</h3>
                <p class="mb-4">${ dto.getProduct_spec() }</p>
                
                
                <form method="post" name="goCart" id="goCart">
                
                <input type="hidden" name="product_no" value="${ dto.getProduct_no() }">
                <input type="hidden" name="category_no" value="${ dto.getCategory_no() }">
                <input type="hidden" name="product_image" value="${ dto.getProduct_image() }">
                <input type="hidden" name="product_name" value="${ dto.getProduct_name() }">
                <input type="hidden" name="product_price" value="${ dto.getProduct_price() }">
                <input type="hidden" name="user_id" value="${ user_id }">
                
                	<!-- 사이즈 라디오 버튼 -->
	                <div class="d-flex mb-3">
	                    <p class="text-dark font-weight-medium mb-0 mr-3">Sizes:</p>
	                        <div class="custom-control custom-radio custom-control-inline">
	                            <input type="radio" class="custom-control-input" id="size-1" name="size" value="XS">
	                            <label class="custom-control-label" for="size-1">XS</label>
	                        </div>
	                        <div class="custom-control custom-radio custom-control-inline">
	                            <input type="radio" class="custom-control-input" id="size-2" name="size" value="S">
	                            <label class="custom-control-label" for="size-2">S</label>
	                        </div>
	                        <div class="custom-control custom-radio custom-control-inline">
	                            <input type="radio" class="custom-control-input" id="size-3" name="size" value="M">
	                            <label class="custom-control-label" for="size-3">M</label>
	                        </div>
	                        <div class="custom-control custom-radio custom-control-inline">
	                            <input type="radio" class="custom-control-input" id="size-4" name="size" value="L">
	                            <label class="custom-control-label" for="size-4">L</label>
	                        </div>
	                        <div class="custom-control custom-radio custom-control-inline">
	                            <input type="radio" class="custom-control-input" id="size-5" name="size" value="XL">
	                            <label class="custom-control-label" for="size-5">XL</label>
	                        </div>
	                </div>
	                
	                <!-- 상품 수량 버튼 -->
	                <div class="d-flex align-items-center mb-4 pt-2">
						    <div class="input-group quantity mr-3" style="width: 130px;">
						        <div class="input-group-btn">
						            <button class="btn btn-primary btn-minus" type="button">
						                <i class="fa fa-minus"></i>
						            </button>
						        </div>
						        <input type="text" class="form-control bg-secondary text-center" name="qty" value="1" id="quantity-input">
						        <div class="input-group-btn">
						            <button class="btn btn-primary btn-plus" type="button">
						                <i class="fa fa-plus"></i>
						            </button>
						        </div>
						    </div>
						    
						    <!-- 선택한 상품 수량 버튼을 클릭시 값을 변경시키는 코드 -->
						    <script>
							    // 수량 증가 버튼 클릭 이벤트
							    document.querySelector('.btn-plus').addEventListener('click', function() {
							        var input = document.getElementById('quantity-input');
							        var currentValue = parseInt(input.value);
							        input.value = currentValue + 1;
							        updateQuantity(input.value);  // 수량 값 업데이트
							    });
							
							    // 수량 감소 버튼 클릭 이벤트
							    document.querySelector('.btn-minus').addEventListener('click', function() {
							        var input = document.getElementById('quantity-input');
							        var currentValue = parseInt(input.value);
							        
							        if (currentValue > 1) {  // 최소 수량을 1로 설정
							            input.value = currentValue - 1;
							            updateQuantity(input.value);  // 수량 값 업데이트
							        }
							    });
							</script>
	                    
	                    <!-- 선택한 사이즈, 수량을 가지고 장바구니 페이지로 넘어가는 버튼 -->
	                    <button class="btn btn-primary px-3" id="goCartBtn"><i class="fa fa-shopping-cart mr-1"></i> Add To Cart</button>
	                    
	                    <script type="text/javascript">
	                    
			                 // product/detail.jsp에서 Add to Cart 버튼을 클릭했을 때 sc_cart 테이블에 저장하기
			                	$("#goCartBtn").click(function() {
			                		$.ajax({
			                			url : "/Second/cartInsert.go",
			                			data : $("#goCart").serialize(),
			                			dataType : "text",
			                			success : function(res) {
			                				if (res > 0) {
			                					alert("장바구니 추가 완료");
			                				} else {
			                					alert("장바구니 추가 실패");
			                				}
			                			},
			                			error : function() {
			                				alert("데이터 통신 오류입니다...")
			                			}
			                		});
			                	});
	                    
	                    </script>
	                    
	                </div>
                </form>
                
                <div class="d-flex pt-2">
                    <p class="text-dark font-weight-medium mb-0 mr-2">Share on:</p>
                    <div class="d-inline-flex">
                        <a class="text-dark px-2" href="https://www.facebook.com/?locale=ko_KR">
                            <i class="fab fa-facebook-f"></i>
                        </a>
                        <a class="text-dark px-2" href="https://x.com/?lang=ko&mx=2">
                            <i class="fab fa-twitter"></i>
                        </a>
                        <a class="text-dark px-2" href="https://kr.linkedin.com/">
                            <i class="fab fa-linkedin-in"></i>
                        </a>
                        <a class="text-dark px-2" href="https://kr.pinterest.com/">
                            <i class="fab fa-pinterest"></i>
                        </a>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- 제품 설명, 사이즈 설명, 리뷰 -->
        <div class="row px-xl-5">
            <div class="col">
                <div class="nav nav-tabs justify-content-center border-secondary mb-4">
                    <a class="nav-item nav-link active" data-toggle="tab" href="#tab-pane-1">Description</a>
                    <a class="nav-item nav-link" data-toggle="tab" href="#tab-pane-2">Information</a>
                    <a class="nav-item nav-link" data-toggle="tab" href="#tab-pane-3">Reviews (${ reviewCount })</a>
                </div>

                <div class="tab-content">
                    <div class="tab-pane fade show active" id="tab-pane-1">
                        <h4 class="mb-3">Product Description</h4>
                        <br> <br>
                        
                        <div align="center">
                        <img class="w-50 h-50" src="<%= request.getContextPath() %>/resource/img/${ dto.getProduct_specInfo() }"
                            		alt="Image">
                        </div>
                        <!-- toogle 버튼 -->
                        <button type="button" class="btn btn-primary btn-lg btn-block" data-toggle="button" aria-pressed="false"
                            id="moreButton">
                            더보기
                        </button>
                        <!-- 숨겨진 글 -->
                        <p id="hiddenContent" style="display: none; margin-top: 10px;">${ dto.getProduct_specInfo() }</p>

                    </div>
                    <div class="tab-pane fade" id="tab-pane-2">
                        <h4 class="mb-3">Size Information</h4>
                        <p>Eos no lorem eirmod diam diam, eos elitr et gubergren diam sea. Consetetur vero aliquyam
                            invidunt duo dolores et duo sit. Vero diam ea vero et dolore rebum, dolor rebum eirmod
                            consetetur invidunt sed sed et, lorem duo et eos elitr, sadipscing kasd ipsum rebum diam.
                            Dolore diam stet rebum sed tempor kasd eirmod. Takimata kasd ipsum accusam sadipscing, eos
                            dolores sit no ut diam consetetur duo justo est, sit sanctus diam tempor aliquyam eirmod
                            nonumy rebum dolor accusam, ipsum kasd eos consetetur at sit rebum, diam kasd invidunt
                            tempor lorem, ipsum lorem elitr sanctus eirmod takimata dolor ea invidunt.</p>
                        <div class="row">
                            <div class="col-md-6">
                                <ul class="list-group list-group-flush">
                                    <li class="list-group-item px-0">
                                        Sit erat duo lorem duo ea consetetur, et eirmod takimata.
                                    </li>
                                    <li class="list-group-item px-0">
                                        Amet kasd gubergren sit sanctus et lorem eos sadipscing at.
                                    </li>
                                    <li class="list-group-item px-0">
                                        Duo amet accusam eirmod nonumy stet et et stet eirmod.
                                    </li>
                                    <li class="list-group-item px-0">
                                        Takimata ea clita labore amet ipsum erat justo voluptua. Nonumy.
                                    </li>
                                </ul>
                            </div>
                            <div class="col-md-6">
                                <ul class="list-group list-group-flush">
                                    <li class="list-group-item px-0">
                                        Sit erat duo lorem duo ea consetetur, et eirmod takimata.
                                    </li>
                                    <li class="list-group-item px-0">
                                        Amet kasd gubergren sit sanctus et lorem eos sadipscing at.
                                    </li>
                                    <li class="list-group-item px-0">
                                        Duo amet accusam eirmod nonumy stet et et stet eirmod.
                                    </li>
                                    <li class="list-group-item px-0">
                                        Takimata ea clita labore amet ipsum erat justo voluptua. Nonumy.
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                    
                    
                    <div class="tab-pane fade" id="tab-pane-3">
                        <div class="row">
                        
                        <!-- 해당 상품의 리뷰 가져오기 -->
                        <c:if test="${ !empty reviewDto }">
                        	<c:forEach items="${ reviewDto }" var="dto">
	                            <div class="col-md-6">
	                                <h4 class="mb-4">${ dto.getUser_id() } 님의 리뷰</h4>
	                                <!-- Modal 트리거 -->
	                                <a href="#" data-toggle="modal" data-target="#reviewDetailModal">
	                                <div class="media mb-4">
	                                    <img src="<%= request.getContextPath() %>/resource/img/${ dto.getReview_image() }"
	                                    	alt="Image" class="img-fluid mr-3 mt-1" style="width: 150px;">
	                                    <div class="media-body">
	                                        <h6>${ dto.getUser_id() }<small> - <i>${ dto.getReview_date() }</i></small></h6>
	                                        <div class="text-primary mb-2">
	                                        	${ dto.getReview_rank() } 점
	                                        	<!-- 미정 -->
	                                            <i class="fas fa-star"></i>
	                                            <i class="fas fa-star"></i>
	                                            <i class="fas fa-star"></i>
	                                            <i class="fas fa-star-half-alt"></i>
	                                            <i class="far fa-star"></i>
	                                        </div>
	                                        <p>${ dto.getReview_cont() }</p>
	                                    </div>
	                                </div>
	                                </a>
	                            </div>
                            </c:forEach>
						</c:if>

                            <!-- 페이지네이션(수정 必) -->
                            <div class="col-12 pb-1">
                                <nav aria-label="Page navigation">
                                  <ul class="pagination justify-content-center mb-3">
                                    <li class="page-item disabled">
                                      <a class="page-link" href="#" aria-label="Previous">
                                        <span aria-hidden="true">&laquo;</span>
                                        <span class="sr-only">Previous</span>
                                      </a>
                                    </li>
                                    <li class="page-item active"><a class="page-link" href="#">1</a></li>
                                    <li class="page-item"><a class="page-link" href="#">2</a></li>
                                    <li class="page-item"><a class="page-link" href="#">3</a></li>
                                    <li class="page-item">
                                      <a class="page-link" href="#" aria-label="Next">
                                        <span aria-hidden="true">&raquo;</span>
                                        <span class="sr-only">Next</span>
                                      </a>
                                    </li>
                                  </ul>
                                </nav>
                            </div>
                            
                        </div>
                    </div>
                </div>
            </div>
        </div>
        </c:if>
    </div>
    
    
    
    <!-- 상품 정보(상품 사진, 장바구니 버튼, 상품 설명 등) end -->


    <!-- 추천상품 로테이션 리스트 Start -->
    <div class="container-fluid py-5">
        <div class="text-center mb-4">
            <h2 class="section-title px-5"><span class="px-2">추천 상품</span></h2>
        </div>
        <div class="row px-xl-5">
            <div class="col">
                <div class="owl-carousel related-carousel">
                
               		<!-- 추천 상품 로테이션(미정) -->
               		<c:forEach items="${ productList }" var="dto">
               			<div class="col-lg-4 col-md-6 col-sm-12 pb-1">
		                    <div class="card product-item border-0 mb-4">
		                        <div class="card-header product-img position-relative overflow-hidden bg-transparent border p-0">
		                            <img class="img-fluid w-100" src="<%= request.getContextPath() %>/resource/img/${ dto.getProduct_image() }" alt="">
		                        </div>
		                        <div class="card-body border-left border-right text-center p-0 pt-4 pb-3">
		                            <h6 class="text-truncate mb-3">${ dto.getProduct_name() }</h6>
		                            <div class="d-flex justify-content-center">
		                                <h6>${ dto.getProduct_price() }</h6>
		                                <h6 class="text-muted ml-2"><del>${ dto.getProduct_price() }</del></h6>
		                            </div>
		                        </div>
		                        <div class="card-footer d-flex justify-content-between bg-light border">
		                            <a href="" class="btn btn-sm text-dark p-0"><i class="fas fa-eye text-primary mr-1"></i>View Detail</a>
		                            <a href="" class="btn btn-sm text-dark p-0"><i class="fas fa-shopping-cart text-primary mr-1"></i>Add To Cart</a>
		                        </div>
		                    </div>
	                    </div>
	            	</c:forEach>
	            	
                </div>
            </div>
        </div>
    </div>
    <!-- 추천상품 로테이션 리스트 End -->


    <!-- Back to Top -->
    <a href="#" class="btn btn-primary back-to-top"><i class="fa fa-angle-double-up"></i></a>


<jsp:include page="../modal/reviewDetailModal.jsp" />		<!-- 리뷰 클릭시 modal 팝업 -->
<jsp:include page="../include/footer.jsp" />
