<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	
<%
	request.setAttribute("pageTitle", "Order Form");
%>	
	
<jsp:include page="../include/header.jsp" />

	<c:set var="userdto" value="${ UserInfo }"/>
	<c:set var="list" value="${ CartList }"/>
	<c:set var="totalPrice" value="${ TotalPrice }"/>


<div class="container">
    <div class="input-form-backgroud row">
      <div class="input-form col-md-12 mx-auto">
        <h4 class="mb-3">주문서</h4>

		<!-- 폼 태그 시작 -->
        <form class="validation-form" action="<%= request.getContextPath() %>/insertOrder.go">
        <input type="hidden" name="user_id" value="${ user_id }">
        <input type="hidden" name="totalPrice" value="${ totalPrice }">
        
        
          <div class="row">
            <div class="col-md-6 mb-3">
              <label for="name">이름</label>
              <input type="text" class="form-control" id="name" placeholder="" value="${ userdto.getUser_name() }" required>
            </div>
            
            <div class="col-md-6 mb-3">
              <label for="nickname">연락처</label>
              <input type="text" class="form-control" id="nickname" placeholder="" value="${ userdto.getUser_phone() }" required>
            </div>
          </div>
    
          <!-- Cart Start -->
	        <div class="container-fluid pt-5">
	        <div class="row px-xl-5">
	            <div class="col-lg-8 table-responsive mb-5">
	                <table class="table table-bordered text-center mb-0">
	                    <thead class="bg-secondary text-dark">
	                        <tr>
	                            <th>상품명</th>
	                            <th>가격</th>
	                            <th>수량</th>
	                            <th>합계</th>
	                        </tr>
	                    </thead>
	                    <tbody class="align-middle">
	                    
	                    	<c:forEach items="${ list }" var="dto">
		                        <tr>
		                            <td class="align-middle">
		                            		<img src="<%= request.getContextPath() %>/resource/img/${ dto.getProduct_image() }" 
		                            				alt="" style="width: 50px;">${ dto.getProduct_name() }</td>
		                            <td class="align-middle">${ dto.getProduct_price() }</td>
		                            <td class="align-middle">${ dto.getProduct_qty() }</td>
		                            <td class="align-middle"><span id="total-price">${dto.getProduct_price() * dto.getProduct_qty() }</span></td>
		                        </tr>
	                        </c:forEach>
	                        
	                    </tbody>
	                </table>
	            </div>
	            
	            <!-- 장바구니 결제버튼 -->
	            <div class="col-lg-4">
	                <div class="card border-secondary mb-5">
	                    <div class="card-header bg-secondary border-0">
	                        <h4 class="font-weight-semi-bold m-0">금액</h4>
	                    </div>
	                    <div class="card-body">
		                        <div class="d-flex justify-content-between mb-3 pt-1">
		                            <h6 class="font-weight-medium">상품 금액</h6>
		                            <h6 class="font-weight-medium"><span id="total-amount" >${ totalPrice }</span> 원</h6>
		                        </div>
	                        <div class="d-flex justify-content-between">
	                            <h6 class="font-weight-medium">배송료</h6>
	                            <h6 class="font-weight-medium">3000</h6>
	                        </div>
	                    </div>
	                    <div class="card-footer border-secondary bg-transparent">
	                        <div class="d-flex justify-content-between mt-2">
	                            <h5 class="font-weight-bold">Total</h5>
	                            <h5 class="font-weight-bold">${ totalPrice + 3000 } 원</h5>
	                        </div>
	                    </div>
	                </div>
	            </div>
	        </div>
	    </div>
        <!-- Cart End -->

        <div class="mb-3">
            <label for="id">주소</label>
            <div class="d-flex align-items-center">
                <input type="text" class="form-control mr-5" id="id" name = "addr" placeholder="" value="${ userdto.getUser_addr() }" required >
            </div>
            <div class="invalid-feedback">
                주소를 입력해주세요.
            </div>
        </div>
        <br>
        
        <div>
          <label for="id">배송 메세지</label>
        </div>
        <div>
          <textarea class="form-control" id="message-text" name="memo"></textarea>
        </div>
        <br> <br> <br>

          <label for="id">결제 수단</label>
            <br>
            <div class="d-flex justify-content-start" style="gap: 20px; overflow-x: auto; flex-wrap: nowrap;">
                <button type="button" name="selectedCard" value="MASTER" class="btn p-0">
                    <div class="card" style="width: 18rem;">
                        <img src="img/VISA.png" class="card-img-top" alt="...">
                        <div class="card-body">
                            <p class="card-text">VISA사의 카드로 결제혜택 - 5% 적립 및 무이자 할부</p>
                        </div>
                    </div>
                </button>

                <a href="">
                    <div class="card" style="width: 18rem;">
                        <img src="img/VISA.png" class="card-img-top" alt="...">
                        <div class="card-body">
                            <p class="card-text">VISA사의 카드로 결제혜택 - 5% 적립 및 무이자 할부</p>
                        </div>
                    </div>
                </a>

                <a href="">
                    <div class="card" style="width: 18rem;">
                        <img src="img/VISA.png" class="card-img-top" alt="...">
                        <div class="card-body">
                            <p class="card-text">VISA사의 카드로 결제혜택 - 5% 적립 및 무이자 할부</p>
                        </div>
                    </div>
                </a>

                <a href="">
                    <div class="card" style="width: 18rem;">
                        <img src="img/VISA.png" class="card-img-top" alt="...">
                        <div class="card-body">
                            <p class="card-text">VISA사의 카드로 결제혜택 - 5% 적립 및 무이자 할부</p>
                        </div>
                    </div>
                </a>
            </div>
            <br> <br>

          <div class="mb-3">
            <label for="id">선택된 결제 수단</label>
            <input type="text" class="form-control" id="id" placeholder="" value="위에서 선택한 카드 명칭" required>
          </div>
          <br>

          <div class="mb-3">
            <label for="id">구매금액</label>
            <div class="mb-4">상품금액&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ${ totalPrice } 원</div>
            <div class="mb-4">배송비&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;3000 원</div>  
          </div>

          <div class="mb-3">
            <label for="id">총 구매금액</label>
            <div class="mb-4">총 상품금액&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${ totalPrice + 3000 } 원</div>
          </div>

          <div class="jumbotron">
            <h1 class="display-4">주 문 확 정</h1>
            <p class="lead">This is a simple hero unit, a simple jumbotron-style component for calling extra attention to featured content or information.</p>
            <hr class="my-4">
            <p>It uses utility classes for typography and spacing to space content out within the larger container.</p>
            <input type="submit" class="btn btn-block btn-primary my-3 py-3" value="주문완료" >
            <img class="rounded mx-auto d-block" src="../resource/img/payments.png" alt="">
          </div>
          
          <hr class="mb-4">
          <div class="custom-control custom-checkbox">
            <input type="checkbox" class="custom-control-input" id="aggrement" required>
            <label class="custom-control-label" for="aggrement">개인정보 수집 및 이용에 동의합니다.</label>
          </div>
        </form>
      </div>
    </div>
    <footer class="my-3 text-center text-small">
      <p class="mb-1">&copy; 2021 YD</p>
    </footer>
    </div>

    <!-- Products Start -->
    <div class="container-fluid py-5">
        <div class="text-center mb-4">
            <h2 class="section-title px-5"><span class="px-2">다른 상품 알아보기</span></h2>
        </div>
        <div class="row px-xl-5">
            <div class="col">
                <div class="owl-carousel related-carousel">
                    <div class="card product-item border-0">
                        <div
                            class="card-header product-img position-relative overflow-hidden bg-transparent border p-0">
                            <img class="img-fluid w-100" src="img/product-1.jpg" alt="">
                        </div>
                        <div class="card-body border-left border-right text-center p-0 pt-4 pb-3">
                            <h6 class="text-truncate mb-3">Colorful Stylish Shirt</h6>
                            <div class="d-flex justify-content-center">
                                <h6>$123.00</h6>
                                <h6 class="text-muted ml-2"><del>$123.00</del></h6>
                            </div>
                        </div>
                        <div class="card-footer d-flex justify-content-between bg-light border">
                            <a href="" class="btn btn-sm text-dark p-0"><i class="fas fa-eye text-primary mr-1"></i>View
                                Detail</a>
                            <a href="" class="btn btn-sm text-dark p-0"><i
                                    class="fas fa-shopping-cart text-primary mr-1"></i>Add To Cart</a>
                        </div>
                    </div>
                    <div class="card product-item border-0">
                        <div
                            class="card-header product-img position-relative overflow-hidden bg-transparent border p-0">
                            <img class="img-fluid w-100" src="img/product-2.jpg" alt="">
                        </div>
                        <div class="card-body border-left border-right text-center p-0 pt-4 pb-3">
                            <h6 class="text-truncate mb-3">Colorful Stylish Shirt</h6>
                            <div class="d-flex justify-content-center">
                                <h6>$123.00</h6>
                                <h6 class="text-muted ml-2"><del>$123.00</del></h6>
                            </div>
                        </div>
                        <div class="card-footer d-flex justify-content-between bg-light border">
                            <a href="" class="btn btn-sm text-dark p-0"><i class="fas fa-eye text-primary mr-1"></i>View
                                Detail</a>
                            <a href="" class="btn btn-sm text-dark p-0"><i
                                    class="fas fa-shopping-cart text-primary mr-1"></i>Add To Cart</a>


                        </div>
                    </div>
                    <div class="card product-item border-0">
                        <div
                            class="card-header product-img position-relative overflow-hidden bg-transparent border p-0">
                            <img class="img-fluid w-100" src="img/product-3.jpg" alt="">
                        </div>
                        <div class="card-body border-left border-right text-center p-0 pt-4 pb-3">
                            <h6 class="text-truncate mb-3">Colorful Stylish Shirt</h6>
                            <div class="d-flex justify-content-center">
                                <h6>$123.00</h6>
                                <h6 class="text-muted ml-2"><del>$123.00</del></h6>
                            </div>
                        </div>
                        <div class="card-footer d-flex justify-content-between bg-light border">
                            <a href="" class="btn btn-sm text-dark p-0"><i class="fas fa-eye text-primary mr-1"></i>View
                                Detail</a>
                            <a href="" class="btn btn-sm text-dark p-0"><i
                                    class="fas fa-shopping-cart text-primary mr-1"></i>Add To Cart</a>
                        </div>
                    </div>
                    <div class="card product-item border-0">
                        <div
                            class="card-header product-img position-relative overflow-hidden bg-transparent border p-0">
                            <img class="img-fluid w-100" src="img/product-4.jpg" alt="">
                        </div>
                        <div class="card-body border-left border-right text-center p-0 pt-4 pb-3">
                            <h6 class="text-truncate mb-3">Colorful Stylish Shirt</h6>
                            <div class="d-flex justify-content-center">
                                <h6>$123.00</h6>
                                <h6 class="text-muted ml-2"><del>$123.00</del></h6>
                            </div>
                        </div>
                        <div class="card-footer d-flex justify-content-between bg-light border">
                            <a href="" class="btn btn-sm text-dark p-0"><i class="fas fa-eye text-primary mr-1"></i>View
                                Detail</a>
                            <a href="" class="btn btn-sm text-dark p-0"><i
                                    class="fas fa-shopping-cart text-primary mr-1"></i>Add To Cart</a>
                        </div>
                    </div>
                    <div class="card product-item border-0">
                        <div
                            class="card-header product-img position-relative overflow-hidden bg-transparent border p-0">
                            <img class="img-fluid w-100" src="img/product-5.jpg" alt="">
                        </div>
                        <div class="card-body border-left border-right text-center p-0 pt-4 pb-3">
                            <h6 class="text-truncate mb-3">Colorful Stylish Shirt</h6>
                            <div class="d-flex justify-content-center">
                                <h6>$123.00</h6>
                                <h6 class="text-muted ml-2"><del>$123.00</del></h6>
                            </div>
                        </div>
                        <div class="card-footer d-flex justify-content-between bg-light border">
                            <a href="" class="btn btn-sm text-dark p-0"><i class="fas fa-eye text-primary mr-1"></i>View
                                Detail</a>
                            <a href="" class="btn btn-sm text-dark p-0"><i
                                    class="fas fa-shopping-cart text-primary mr-1"></i>Add To Cart</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Products End -->

	<!-- 유효성 검사 -->
    <script>
	    window.addEventListener('load', () => {
	      const forms = document.getElementsByClassName('validation-form');
	    
	      Array.prototype.filter.call(forms, (form) => {
	        form.addEventListener('submit', function (event) {
	          if (form.checkValidity() === false) {
	            event.preventDefault();
	            event.stopPropagation();
	          }
	    
	          form.classList.add('was-validated');
	        }, false);
	      });
	    }, false);
    </script>
    
<jsp:include page="../modal/cartAddrModal.jsp" />
<jsp:include page="../include/footer.jsp" />
