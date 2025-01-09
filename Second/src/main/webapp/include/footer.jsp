<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

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
                        <a class="text-dark mb-2" href="index.html"><i class="fa fa-angle-right mr-2"></i>Home</a>
                        <a class="text-dark mb-2" href="shop.html"><i class="fa fa-angle-right mr-2"></i>Our Shop</a>
                        
                        <a class="text-dark mb-2" href="cart.html"><i class="fa fa-angle-right mr-2"></i>Shopping Cart</a>
                        <a class="text-dark mb-2" href=""><i class="fa fa-angle-right mr-2"></i>Board</a>
                        <a class="text-dark" href=""><i class="fa fa-angle-right mr-2"></i>Review</a>
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

<!-- 개인정보 처리 방침 모달 -->
<div class="modal fade" id="privacyPolicyModal" tabindex="-1" role="dialog" aria-labelledby="privacyPolicyModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="privacyPolicyModalLabel">개인정보 처리 방침</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <!-- 개인정보 처리 방침 내용 -->
                <p>주식회사 HHLB(이하 "회사"라 합니다.)는 회사가 운영하는 HHLB스토어 ("www.HHLB.com"이하 "서비스"라 합니다.)와 오프라인 매장을 이용하는 정보주체의 개인정보 및 권리 보호를 위해 「개인정보 보호법」 및 관계 법령이 정한 바를 준수하여 안전하게 관리하고 있습니다.
                    정보주체의 개인정보를 보호하고 이와 관련한 고충을 신속하고 원활하게 처리할 수 있도록 다음과 같이 개인정보 처리방침을 수립·공개합니다.
                    
                    1. 개인정보의 처리 목적 및 수집 항목
                    정보주체는 회원가입을 하지 않아도 상품 검색 및 구매 등 서비스를 이용할 수 있습니다.
                    적립금, 쿠폰 등 회원제 서비스의 다양한 혜택과 정보주체의 관심, 흥미, 기호 등을 분석한 추천 서비스를 이용하기 위해 회원 가입을 할 경우 회사는 서비스 제공을 위해 필요한 최소한의 개인정보를 수집합니다.
                    회사는 다음과 같이 개인정보를 수집∙이용하고 있습니다. 개인정보가 필요한 시점에 최소한의 정보만을 수집하며 법적 근거와 사전 동의를 받은 범위 내에서만 이용합니다.
                    
                    2. 개인정보의 제3자 제공
                    회사는 다음의 하나에 해당되는 경우 개인정보를 제3자에게 제공합니다.
                    
                    1.정보주체의 동의를 받은 경우
                    2.법률에 특별한 규정이 있거나 법령상 의무를 준수하기 위하여 불가피한 경우
                    3.명백히 정보주체 또는 제3자의 급박한 생명, 신체, 재산의 이익을 위하여 필요하다고 인정되는 경우
                    4.개인정보처리자의 정당한 이익을 달성하기 위하여 필요한 경우로서 명백하게 정보주체의 권리보다 우선하는 경우
                    5.정부 관계부처가 합동으로 발표한 「긴급상황 시 개인정보 처리 및 보호수칙」에 따라 재난, 감염병, 급박한 생명·신체 위험을 초래하는 사건·사고, 급박한 재산 손실 등의 긴급상황이 발생하는 경우 정보주체의 동의 없이 관계 기관에 개인정보를 제공할 수 있습니다. 자세한 사항은 여기*를 눌러 확인하시기 바랍니다.
                    6.수집 목적과 합리적으로 관련된 범위 내에서 정보주체의 개인정보 제공이 예측 가능하고, 정보주체의 이익을 부당하게 침해하지 않으며, 안전성 확보에 필요한 조치를 한 경우
                    
                    
                    3. 추가적인 이용ㆍ제공의 판단 기준
                    회사는 정보주체에게 동의 받거나 법적 근거 범위 내에서만 개인정보를 이용 및 제공합니다. 다만, 개인정보 보호법 제15조 제3항 또는 제17조 제4항에 따라 정보주체의 동의 없이 개인정보를 추가적으로 이용ㆍ제공할 수 있습니다.
                    
                    회사는 정보주체의 동의 없이 개인정보를 이용ㆍ제공하려는 경우 다음과 같은 사항을 고려하며, 이 경우에도 최소한의 개인정보만을 이용ㆍ제공합니다.
                    
                    1. 당초 수집 목적과 관련성이 있는지 여부
                    2. 개인정보를 수집한 정황 또는 처리 관행에 비추어 볼 때 개인정보의 추가적인 이용 또는 제공에 대한 예측 가능성이 있는지 여부
                    3. 정보주체의 이익을 부당하게 침해 하는지 여부
                    4. 가명처리 또는 암호화 등 안전성 확보에 필요한 조치를 하였는지 여부
                    
                    개인정보의 추가적인 이용ㆍ제공이 지속적으로 발생하는 경우에는 위 사항에 대한 판단기준을 공개하고, 준수하고 있는지 여부를 점검하겠습니다.
                    
                    4. 개인정보의 처리 위탁
                    회사는 위탁 계약 체결 시 「개인정보 보호법」 제26조에 따라 위탁업무 수행목적 외 개인정보 처리금지, 기술적·관리적 보호조치, 재위탁 제한, 수탁자에 대한 관리·감독, 손해배상책임 등에 관한 사항을 계약서 등 문서에 명시하고, 수탁자가 개인정보를 안전하게 처리하는지를 감독하고 있습니다.
                    
                    수탁자가 회사의 개인정보 처리업무를 재위탁하는 경우 회사의 동의를 받고 있습니다. 위탁업무의 내용이나 수탁자가 변경될 경우 개인정보처리방침을 통해 공개하겠습니다.
                    개인정보 처리방침을 변경하는 경우 회사는 홈페이지를 통해 공지하고, 정보주체가 언제든지 변경된 사항을 쉽게 알아볼 수 있도록 조치하겠습니다.
                    <br>
                    - 개인정보 처리방침 고지일자 : 2024년 10월 21일<br>
                    - 개인정보 처리방침 시행일자 : 2024년 10월 23일
                </p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
            </div>
        </div>
    </div>
</div>
            </div>
            <div class="col-md-6 px-xl-0 text-center text-md-right">
                <img class="img-fluid" src="img/payments.png" alt="">
            </div>
        </div>
    </div>
    
</div>
<!-- Footer End -->




</body>
</html>