<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<jsp:include page="../include/header.jsp" />

	<c:set var="list" value="${ CartList }"/>
	<c:set var="totalPrice" value="${ TotalPrice }"/>

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
                    		<form action="<%= request.getContextPath() %>/cartDelete.go">
                    		     <input type="hidden" name="no" value="${dto.getCart_no() }">
                    		     <input type="hidden" name=user_id value="${ user_id }">
	                        <tr>
	                            <td class="align-middle">
	                            		<img src="<%= request.getContextPath() %>/resource/img/${ dto.getProduct_image() }" 
	                            				alt="" style="width: 50px;">${ dto.getProduct_name() }</td>
	                            <td class="align-middle">${ dto.getProduct_price() }</td>
	                            <td class="align-middle">${ dto.getProduct_qty() }</td>
	                            <td class="align-middle"><span id="total-price">${dto.getProduct_price() * dto.getProduct_qty() }</span></td>
	                            <!-- 삭제 버튼 -->
	                            <td class="align-middle">
	                            		<button type="submit" class="btn btn-sm btn-primary" id="deleteBtn">
	                	            		<i class="fa fa-times"></i></button>
	                            </td>
	                        </tr>
	                    </form>
                        </c:forEach>
                        
                    </tbody>
                </table>
            </div>
            
            <!-- 장바구니 결제버튼 -->
            <form action="<%= request.getContextPath() %>/cart_receipt.go">
            <input type="hidden" name="user_id" value="${ user_id }">
            
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
                        <button class="btn btn-block btn-primary my-3 py-3" type="submit">결제하기</button>
                    </div>
                </div>
            </div>
            </form>
        </div>
    </div>
    <!-- Cart End -->
    

<jsp:include page="../modal/reviewModal.jsp" />
<jsp:include page="../include/footer.jsp" />
