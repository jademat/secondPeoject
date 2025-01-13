(function ($) {
    "use strict";
    
    // Dropdown on mouse hover
    $(document).ready(function () {
        function toggleNavbarMethod() {
            if ($(window).width() > 992) {
                $('.navbar .dropdown').on('mouseover', function () {
                    $('.dropdown-toggle', this).trigger('click');
                }).on('mouseout', function () {
                    $('.dropdown-toggle', this).trigger('click').blur();
                });
            } else {
                $('.navbar .dropdown').off('mouseover').off('mouseout');
            }
        }
        toggleNavbarMethod();
        $(window).resize(toggleNavbarMethod);
    });
    
    
    // Back to top button
    $(window).scroll(function () {
        if ($(this).scrollTop() > 100) {
            $('.back-to-top').fadeIn('slow');
        } else {
            $('.back-to-top').fadeOut('slow');
        }
    });
    $('.back-to-top').click(function () {
        $('html, body').animate({scrollTop: 0}, 1500, 'easeInOutExpo');
        return false;
    });


    // Vendor carousel
    $('.vendor-carousel').owlCarousel({
        loop: true,
        margin: 29,
        nav: false,
        autoplay: true,
        smartSpeed: 1000,
        responsive: {
            0:{
                items:2
            },
            576:{
                items:3
            },
            768:{
                items:4
            },
            992:{
                items:5
            },
            1200:{
                items:6
            }
        }
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


    // Product Quantity
    $('.quantity button').on('click', function () {
        var button = $(this);
        var oldValue = button.parent().parent().find('input').val();
        if (button.hasClass('btn-plus')) {
            var newVal = parseFloat(oldValue) + 1;
        } else {
            if (oldValue > 0) {
                var newVal = parseFloat(oldValue) - 1;
            } else {
                newVal = 0;
            }
        }
        button.parent().parent().find('input').val(newVal);
    });


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
	
	
	/* // product/cart.jsp 장바구니 리스트에서 X(deleteBtn) 클릭 시 삭제되는 코드
	$(document).ready(function() {
        // 삭제 버튼 클릭 이벤트
        $('.deleteBtn').click(function() {

            // AJAX 요청
            $.ajax({
                url: '/Second/cartDelete.go', // 요청 URL
                method: 'POST',              // 요청 방식
                data: { cart_no: cartNo },   // 전송 데이터
                success: function(response) {
                    alert("상품이 장바구니에서 삭제되었습니다."); // 성공 메시지
                    location.reload(); // 페이지 새로고침
                },
                error: function() {
                    alert("상품 삭제에 실패했습니다. 다시 시도해 주세요."); // 오류 메시지
                }
            });
        });
    });*/
    
})(jQuery);

