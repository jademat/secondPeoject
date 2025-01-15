<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 해당 상품의 리뷰 리스트 -->

<div class="modal fade" id="reviewModal" tabindex="-1" aria-labelledby="reviewModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="reviewModalLabel">Review Details</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body" style="max-height: 500px; overflow-y: auto;">
                <img id="reviewImage" src="" alt="Image" class="img-fluid mr-3 mt-1" style="width: 400px;">
                <p><strong>Reviewer:</strong> <span id="reviewUser"></span></p>
                <p><strong>Title:</strong> <span id="reviewTitle"></span></p>
                <p><strong>Date:</strong> <span id="reviewDate"></span></p>
                <p><strong>Review:</strong> <span id="reviewContent"></span></p>
                <p><strong>Rating:</strong> <span id="reviewRating"></span></p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>

<script>
    // 모달이 열릴 때마다 데이터를 동적으로 설정
    $('#reviewModal').on('show.bs.modal', function (event) {
        var button = $(event.relatedTarget); // 버튼 클릭 이벤트
        var image = button.data('image');
        var user = button.data('user');
        var date = button.data('date');
        var content = button.data('content');
        var rating = button.data('rating');
		var title = button.data('title');
        // 모달에 데이터 설정
        $(this).find('#reviewImage').attr('src', '<%= request.getContextPath() %>/resource/img/' + image);
        $(this).find('#reviewUser').text(user);
        $(this).find('#reviewDate').text(date);
        $(this).find('#reviewContent').text(content);
        $(this).find('#reviewTitle').text(title);

        // 별점 처리
        var stars = '';
        for (var i = 1; i <= 5; i++) {
            if (i <= rating) {
                stars += '<i class="fas fa-star text-warning"></i>';
            } else {
                stars += '<i class="far fa-star text-muted"></i>';
            }
        }
        $(this).find('#reviewRating').html(stars);
    });
</script>