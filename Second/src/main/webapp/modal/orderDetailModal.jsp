<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="modal fade" id="orderDetailModal" data-backdrop="static"
	data-keyboard="false" tabindex="-1"
	aria-labelledby="orderDetailModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="orderDetailModalLabel">주문상세내역</h5>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<h3 id = "orderDate"></h3>
				<p id = "userId"></p>
				<p id = "userPhone"></p>
				<p id = "orderAddr"></p>
				<div>
				<table class="table table">
					<tr>
						<th>상품명</th>
						<td id = "productName"></td>
					</tr>
					<tr>
						<th>구매수량</th>
						<td></td>
					</tr>
					<tr>
						<th>총금액</th>
						<td id = "orderTotal"></td>
					</tr>
					<tr>
						<th>메모</th>
						<td id = "orderMemo"></td>
					</tr>
				</table>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-dismiss="modal">확인</button>

			</div>
		</div>
	</div>
</div>

<script>
    $('#orderDetailModal').on('show.bs.modal', function (event) {
        var button = $(event.relatedTarget); // 버튼 클릭 이벤트
        var date = button.data('date');
        var user = button.data('user');
        var phone = button.data('phone');
        var addr = button.data('addr');
        var name = button.data('name');
		var total = button.data('total');
		var memo = button.data('memo')
		var datesub = date.substring(0,10);
		
        $(this).find('#orderDate').text(datesub);
        $(this).find('#userId').text(user);
        $(this).find('#userPhone').text(phone);
        $(this).find('#orderAddr').text(addr);
        $(this).find('#productName').text(name);
        $(this).find('#orderTotal').text(total);
        $(this).find('#orderMemo').text(memo);
		
        if (!memo) {
            $(this).find('#orderMemo').text("작성한 메모가 없습니다.");
        } else {
            $(this).find('#orderMemo').text(memo);
        }
    });
</script>