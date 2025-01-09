<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<jsp:include page="../include/header.jsp" />


<div class="container">
    <div class="input-form-backgroud row">
      <div class="input-form col-md-12 mx-auto">
        <h4 class="mb-3">주문서</h4>

        <form class="validation-form" novalidate>
          <div class="row">
            <div class="col-md-6 mb-3">
              <label for="name">이름</label>
              <input type="text" class="form-control" id="name" placeholder="" value="DB이름" required>
            </div>
            
            <div class="col-md-6 mb-3">
              <label for="nickname">연락처</label>
              <input type="text" class="form-control" id="nickname" placeholder="" value="DB연락처" required>
            </div>
          </div>
    
          <!-- Cart Start -->
        <div class="container-fluid pt-5">
            <div class="row px-xl-5">
                <div class="col-lg-8 table-responsive mb-5">
                    <table class="table table-bordered text-center mb-0">
                        <thead class="bg-secondary text-dark">
                            <tr>
                                <th>Products</th>
                                <th>Price</th>
                                <th>Quantity</th>
                                <th>Total</th>
                            </tr>
                        </thead>
                        <tbody class="align-middle">
                            <tr>
                                <td class="align-middle"><img src="img/product-1.jpg" alt="" style="width: 50px;"> Colorful Stylish Shirt</td>
                                <td class="align-middle">$150</td>
                                <td class="align-middle">1</td>
                                <td class="align-middle">$150</td>
                                
                            </tr>
                            <tr>
                                <td class="align-middle"><img src="img/product-2.jpg" alt="" style="width: 50px;"> Colorful Stylish Shirt</td>
                                <td class="align-middle">$150</td>
                                <td class="align-middle">1</td>
                                <td class="align-middle">$150</td>
                            </tr>
                            <tr>
                                <td class="align-middle"><img src="img/product-3.jpg" alt="" style="width: 50px;"> Colorful Stylish Shirt</td>
                                <td class="align-middle">$150</td>
                                <td class="align-middle">1</td> 
                                <td class="align-middle">$150</td>
                            </tr>
                            <tr>
                                <td class="align-middle"><img src="img/product-4.jpg" alt="" style="width: 50px;"> Colorful Stylish Shirt</td>
                                <td class="align-middle">$150</td>
                                <td class="align-middle">1</td>
                                <td class="align-middle">$150</td>
                            </tr>
                            <tr>
                                <td class="align-middle"><img src="img/product-5.jpg" alt="" style="width: 50px;"> Colorful Stylish Shirt</td>
                                <td class="align-middle">$150</td>
                                <td class="align-middle">1</td>
                                <td class="align-middle">$150</td>
                            </tr>
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
                                <h5 class="font-weight-bold">상품 개수</h5>
                                <h5 class="font-weight-bold">DB 개수</h5>
                            </div>
                        </div>

                        <div class="card-footer border-secondary bg-transparent">
                            <div class="d-flex justify-content-between mt-2">
                                <h5 class="font-weight-bold">Total</h5>
                                <h5 class="font-weight-bold">$160</h5>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Cart End -->

        <div class="mb-3">
            <label for="id">주소 입력</label>
            <div class="d-flex align-items-center">
                <input type="text" class="form-control mr-5" id="id" placeholder="" value="DB주소" required>
                <button type="button" class="btn btn-primary" style="width: 120px;" data-toggle="modal" data-target="#cartAddrModal" data-whatever="@getbootstrap">상세 주소</button>
            </div>
            <div class="invalid-feedback">
                주소를 입력해주세요.
            </div>
        </div>
        <br>

          <label for="id">결제 수단</label>
            <br>
            <div class="d-flex justify-content-start" style="gap: 20px; overflow-x: auto; flex-wrap: nowrap;">
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
          <br> <br> <br>

          <div class="mb-3">
            <label for="id">구매금액</label>
            <div class="mb-4">상품금액&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;~~원</div>
            <div class="mb-4">배송비&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;배송비 무료</div>  
          </div>
          <br>

          <div class="mb-3">
            <label for="id">총 구매금액</label>
            <div class="mb-4">총 상품금액&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;~~원</div>
          </div>

          <div class="jumbotron">
            <h1 class="display-4">주 문 확 정</h1>
            <p class="lead">This is a simple hero unit, a simple jumbotron-style component for calling extra attention to featured content or information.</p>
            <hr class="my-4">
            <p>It uses utility classes for typography and spacing to space content out within the larger container.</p>
            <a class="btn btn-primary btn-lg" href="#" role="button" type="submit">주문확정</a>
            <img class="rounded mx-auto d-block" src="img/payments.png" alt="">
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
