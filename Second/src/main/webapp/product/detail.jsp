<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	request.setAttribute("pageTitle", "Detail");
%>	

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
                        <h4 class="mb-3">${ dto.getProduct_spec() }</h4>
                        <br> <br>
                        
                        <!-- toogle 버튼 -->
                        <button type="button" class="btn btn-primary btn-lg btn-block" data-toggle="button" aria-pressed="false"
                            id="moreButton">
                            더보기
                        </button>
                        
                        <!-- 숨겨진 글 -->
                        <div align="center">
                        <img id="hiddenContent" style="display: none;" class="w-50 h-50" 
                        		src="<%= request.getContextPath() %>/resource/img/${ dto.getProduct_specInfo() }" alt="Image">
                        </div>
                        <!-- <p id="hiddenContent" style="display: none; margin-top: 10px;">${ dto.getProduct_specInfo() }</p> -->

                    </div>
                    <div class="tab-pane fade" id="tab-pane-2">
                        <h4 class="mb-3">Information</h4>
                        <p>결제수단 - 무통장 입금(현금결제) - 카드결제 - 에스크로(실시간계좌이체) - 휴대폰결제
                        <br>
							무통장 입금(현금결제)시 입금자명과 입금 금액이 다를경우 자동으로 입금확인이 되지 않습니다.
						<br>
							위의 경우 꼭 게시판이나 전화로 정확한 입금 정보를 알려주시기 바랍니다.</p>
                        <div class="row">
                            <div class="col-md-6">
                                <ul class="list-group list-group-flush">
                                    <li class="list-group-item px-0">
                                        ▶ 교환배송비
                                        <br>
										- 우체국 착불 이용시 6,000원 - 그 외 이용시 선불 결제 후 3,000원
                                    </li>
                                    <li class="list-group-item px-0">
                                        ▶ 전체반품
                                        <br>
										- 우체국 착불 이용시 6,000원 - 그 외 이용시 선불 결제 후 3,000원
                                    </li>
                                    <li class="list-group-item px-0">
                                        ▶ 부분반품
                                        <br>
										- 반품상품 제외 후 남은 상품금액 5만원 이상 or 처음에 배송비를 결제하거나 무료쿠폰을 적용한 경우 우체국 착불 이용시 3,000원
                                    </li>
                                    <li class="list-group-item px-0">
                                        ▶ 제주도 및 도서, 산간지역 추가 배송비 무료
                                    </li>
                                </ul>
                            </div>
                            <div class="col-md-6">
                                <ul class="list-group list-group-flush">
                                    <li class="list-group-item px-0">
                                        ▶ 상품 불량 or 오배송
                                        <br>
										- 우체국 착불 이용시 무상 - 그 외 이용시 선불 결제 - 상품 검수 시 불량으로 간주가 어려울 경우 배송비 발생
                                    </li>
                                    <li class="list-group-item px-0">
                                        ▶반품주소지
                                        <br>
										 - 우체국 착불 이용시 서울시 마포구 신촌
                                    </li>
                                    <li class="list-group-item px-0">
                                        ★ 택배비 입금시에는 "주문자성함+주문자휴대폰번호뒷4자리" 작성하여 입금 부탁드립니다. ex) 홍길동4389
                                        <br>
										★ 동봉하실 경우 분실시 고객님께 이중부담될 수 있습니다.
                                        
                                    </li>
                                    <li class="list-group-item px-0">
                                        상품의 가치가 훼손된 경우 (외부착용, 세탁, 향수, 오염, 착용 후 손상 등), 상품의 초도 불량을 확인하기 어려울 경우 반품/교환 불가
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                    
                    
                    <!-- 리뷰 이벤트 -->
                    <div class="tab-pane fade" id="tab-pane-3">
                        <div class="row">
							<c:if test="${ !empty reviewDto }">
						    <c:forEach items="${ reviewDto }" var="dto" varStatus="status">
						        <div class="col-md-6">
						            <h4 class="mb-4">${ dto.getUser_id() } 님의 리뷰</h4>
						            <!-- Modal 트리거 -->
						            <a href="#" data-toggle="modal" data-target="#reviewDetailModal${status.index}">
						                <div class="media mb-4">
						                    <img src="<%= request.getContextPath() %>/resource/img/${ dto.getReview_image() }"
						                         alt="Image" class="img-fluid mr-3 mt-1" style="width: 150px;">
						                    <div class="media-body">
						                        <h6>${ dto.getUser_id() }<small> - <i>${ dto.getReview_date() }</i></small></h6>
						                        <div class="text-primary mb-2">
						                            <!-- 별 찍는 for문 -->
						                            <c:forEach var="i" begin="1" end="5">
						                                <c:choose>
						                                    <c:when test="${dto.review_rank >= i}">
						                                        <i class="fas fa-star text-warning"></i> <!-- 금색 별 -->
						                                    </c:when>
						                                    <c:otherwise>
						                                        <i class="far fa-star text-muted"></i> <!-- 회색 별 -->
						                                    </c:otherwise>
						                                </c:choose>
						                            </c:forEach>
						                        </div>
						                        <p>${ dto.getReview_cont() }</p>
						                    </div>
						                </div>
						            </a>
						        </div>
						
						        <!-- Modal(index 를 받아와서 개별 생성) -->
						        <div class="modal fade" id="reviewDetailModal${status.index}" tabindex="-1" aria-labelledby="reviewDetailModalLabel${status.index}"
						             aria-hidden="true">
						            <div class="modal-dialog modal-lg">
						                <div class="modal-content">
						                    <div class="modal-header">
						                        <h5 class="modal-title" id="reviewDetailModalLabel${status.index}">Review Details</h5>
						                        <button type="button" class="btn-close" data-dismiss="modal"
						                                aria-label="Close"></button>
						                    </div>
						                    <div class="modal-body" style="max-height: 500px; overflow-y: auto;">
						                        <img src="<%= request.getContextPath() %>/resource/img/${ dto.getReview_image() }"
						                             alt="Image" class="img-fluid mr-3 mt-1" style="width: 400px;">
						                        <p><strong>Reviewer :</strong> ${ dto.getUser_id() }</p>
						                        <p><strong>Title :</strong> ${ dto.getReview_title() }</p>
						                        <p><strong>Date :</strong> ${ dto.getReview_date() }</p>
						                        <p><strong>Review :</strong> ${ dto.getReview_cont() }</p>
						                        <p><strong>Rating:</strong> 
						                            <c:forEach var="i" begin="1" end="5">
						                                <c:choose>
						                                    <c:when test="${dto.review_rank >= i}">
						                                        <i class="fas fa-star text-warning"></i> <!-- 금색 별 -->
						                                    </c:when>
						                                    <c:otherwise>
						                                        <i class="far fa-star text-muted"></i> <!-- 회색 별 -->
						                                    </c:otherwise>
						                                </c:choose>
						                            </c:forEach>
						                        </p>
						                    </div>
						                    <div class="modal-footer">
						                        <button type="button" class="btn btn-secondary"
						                                data-dismiss="modal">Close</button>
						                    </div>
						                </div>
						            </div>
						        </div>
						    </c:forEach>
						</c:if>

                            <!-- review 페이지네이션 시작 -->
		                    <div class="container">
								<ul class="pagination justify-content-center mb-3">
								
									<!-- 처음으로 -->
									<c:if test="${page > block }">
										<li class="page-item">
											<a class="page-link" href="user_product_view.go?pnum=${ pnum }&page=1">◀◀</a>
										</li>
										<li class="page-item">
											<a class="page-link" href="user_product_view.go?pnum=${ pnum }&page=${startBlock - 1 }">◀</a>
										</li>
									</c:if>
									
									<!-- 페이지 글 번호 -->
									<c:forEach begin="${startBlock }" end="${endBlock }" var="i">
										<c:if test="${i == page}">
											<li class="page-item active"><a class="page-link"
												href="user_product_view.go?pnum=${ pnum }&page=${ i }">${ i }</a></li>
										</c:if>
										<c:if test="${i != page}">
											<li class="page-item"><a class="page-link"
												href="user_product_view.go?pnum=${ pnum }&page=${ i }">${ i }</a></li>
										</c:if>
									</c:forEach>
									
									<!-- 마지막으로 -->
									<c:if test="${endBlock < allPage}">
									<li class="page-item">
										<a class="page-link" href="user_product_view.go?pnum=${ pnum }&page=${endBlock + 1 }">▶</a>
									</li>
									<li class="page-item">
										<a class="page-link" href="user_product_view.go?pnum=${ pnum }&page=${ allPage }">▶▶</a>
									</li>
									</c:if>
								</ul>
							</div>
							<!-- review 페이지네이션 끝 -->
                            
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
	                    <div class="card product-item border-0">
	                        <div class="card-header product-img position-relative overflow-hidden bg-transparent border p-0">
	                            <img class="img-fluid w-100" src="<%= request.getContextPath() %>/resource/img/${ dto.getProduct_image() }" 
	                            		alt="">
	                        </div>
	                        <div class="card-body border-left border-right text-center p-0 pt-4 pb-3">
	                            <h6 class="text-truncate mb-3">${ dto.getProduct_name() }</h6>
	                            <div class="d-flex justify-content-center">
	                                <h6>${ dto.getProduct_price() }</h6>
	                                <h6 class="text-muted ml-2"><del>${ dto.getProduct_price() }</del></h6>
	                            </div>
	                        </div>
	                        <div class="card-footer d-flex justify-content-between bg-light border">
	                            <a href="<%= request.getContextPath() %>/user_product_view.go?pnum=${ dto.getProduct_no() }"
	                            		 class="btn btn-sm text-dark p-0"><i class="fas fa-eye text-primary mr-1"></i>View Detail</a>
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
    
    <script>

		// product/detail.jsp에서 더보기 버튼 클릭 시 이벤트 핸들러
	    $(document).ready(function () {
	        $('#moreButton').click(function () {
	            const hiddenContent = $('#hiddenContent');
	            const button = $(this);
	 
	            // 숨겨진 내용 표시/숨기기
	            if (hiddenContent.is(':hidden')) {
	                hiddenContent.slideDown(); // 슬라이드 다운 효과로 표시
	                button.text('숨기기'); // 버튼 텍스트 변경
	                hiddenContent.after(button); // 버튼을 숨겨진 내용 아래로 이동
	            } else {
	                hiddenContent.slideUp(); // 슬라이드 업 효과로 숨김
	                button.text('더보기'); // 버튼 텍스트 변경
	            }
	        });
	    });
		
		
	 	// Related carousel
	    $('.related-carousel').owlCarousel({
	        loop: true,
	        margin: 29,
	        nav: false,
	        autoplay: true,
	        smartSpeed: 1000,
	        responsive: {
	            0:{
	                items:1
	            },
	            576:{
	                items:2
	            },
	            768:{
	                items:3
	            },
	            992:{
	                items:4
	            }
	        }
	    });
    
	</script>

<script src="../resource/js/main.js"></script>
<jsp:include page="../include/footer.jsp" />
