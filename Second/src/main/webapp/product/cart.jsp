<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<jsp:include page="../include/header.jsp" />

	<c:set var="list" value="${ CartList }"/>

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
                            <th>삭제</th>
                        </tr>
                    </thead>
                    <tbody class="align-middle">
                    
                    	<c:forEach items="${ list }" var="dto">
	                        <tr>
	                            <td class="align-middle">
	                            		<img src="<%= request.getContextPath() %>/resource/img/${ dto.getProduct_image() }" 
	                            				alt="" style="width: 50px;">${ dto.getProduct_name() }</td>
	                            <td class="align-middle">${ dto.getProduct_price() }</td>
	                            <td class="align-middle">
	                                <div class="input-group quantity mx-auto" style="width: 100px;">
	                                    <div class="input-group-btn">
	                                        <button class="btn btn-sm btn-primary btn-minus" >
	                                        <i class="fa fa-minus"></i>
	                                        </button>
	                                    </div>
	                                    <input type="text" class="form-control form-control-sm bg-secondary text-center" value="1" id="quantity-input">
	                                    <div class="input-group-btn">
	                                        <button class="btn btn-sm btn-primary btn-plus">
	                                            <i class="fa fa-plus"></i>
	                                        </button>
	                                    </div>
	                                </div>
	                            </td>
	                            <td class="align-middle"><span id="total-price">${dto.getProduct_price()}</span></td>
	                            <!-- 삭제 버튼 -->
	                            <td class="align-middle">
	                            	<form action="<%= request.getContextPath() %>/cartDelete.go?no=${ dto.getCart_no() }">
	                            		<button class="btn btn-sm btn-primary" id="deleteBtn">
	                	            		<i class="fa fa-times"></i></button>
	                            	</form>
	                            </td>
	                        </tr>
	                        
	                        <!-- 수량 버튼 클릭 시 이벤트 처리 -->
	                        <script>
							    // 기본 가격 설정
							    var productPrice = ${dto.getProduct_price()}; // 상품 가격
							
							    // 수량 증가 버튼 클릭 이벤트
							    document.querySelector('.btn-plus').addEventListener('click', function() {
							        var input = document.getElementById('quantity-input');
							        var currentValue = parseInt(input.value);
							        input.value = currentValue + 1;
							
							        updateTotalPrice(input.value);  // 총 가격 업데이트
							    });
							
							    // 수량 감소 버튼 클릭 이벤트
							    document.querySelector('.btn-minus').addEventListener('click', function() {
							        var input = document.getElementById('quantity-input');
							        var currentValue = parseInt(input.value);
							
							        if (currentValue > 1) {  // 최소 수량을 1로 설정
							            input.value = currentValue - 1;
							            updateTotalPrice(input.value);  // 총 가격 업데이트
							        }
							    });
							
							    // 총 가격 업데이트 함수
							    function updateTotalPrice(quantity) {
							        var totalPrice = productPrice * quantity;
							        
							        // AJAX로 서버와 연동해 값 갱신 가능
							        $.ajax({
							            url: '/update-price',
							            method: 'POST',
							            data: { quantity: quantity },
							            success: function(response) {
							                $('#total-price').text(response.totalPrice);
							            }
							        });
							
							        // 클라이언트 측 실시간 가격 업데이트
							        document.getElementById('total-price').textContent = totalPrice.toLocaleString();
							    }
							</script>
	                        
                        </c:forEach>
                        
                    </tbody>
                </table>
            </div>
            <div class="col-lg-4">
                
                <div class="card border-secondary mb-5">
                    <div class="card-header bg-secondary border-0">
                        <h4 class="font-weight-semi-bold m-0">Cart Summary</h4>
                    </div>
                    <div class="card-body">
                        <div class="d-flex justify-content-between mb-3 pt-1">
                            <h6 class="font-weight-medium">Subtotal</h6>
                            <h6 class="font-weight-medium">$150</h6>
                        </div>
                        <div class="d-flex justify-content-between">
                            <h6 class="font-weight-medium">Shipping</h6>
                            <h6 class="font-weight-medium">$10</h6>
                        </div>
                    </div>
                    <div class="card-footer border-secondary bg-transparent">
                        <div class="d-flex justify-content-between mt-2">
                            <h5 class="font-weight-bold">Total</h5>
                            <h5 class="font-weight-bold">$160</h5>
                        </div>
                        <button class="btn btn-block btn-primary my-3 py-3">결제하기</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Cart End -->
    

<jsp:include page="../modal/reviewModal.jsp" />
<jsp:include page="../include/footer.jsp" />
