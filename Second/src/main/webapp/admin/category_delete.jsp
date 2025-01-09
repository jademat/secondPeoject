<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>카테고리 삭제</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resource/startbootstrap_admin_pages/css/style.css">
   	<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script> <!-- jQuery 추가 -->
    <script>
        $(document).ready(function() {
            // 카테고리 번호 입력 시 해당 카테고리 이름을 동적으로 로드
            $("#category_no").on("input", function() {
                var categoryNo = $(this).val(); // 입력된 카테고리 번호 가져오기
                if (categoryNo) {
                    $.ajax({
                        url: "CategoryGetNameServlet",  // 카테고리 이름을 가져올 서블릿
                        type: "GET",
                        data: { category_no: categoryNo },
                        success: function(response) {
                            if (response) {
                                $("#category_name").val(response); // 카테고리 이름 표시
                                $("#category_name").prop("readonly", true); // 이름 수정 불가
                            } else {
                                $("#category_name").val(''); // 이름이 없으면 빈 값으로
                                $("#category_name").prop("readonly", false); // 입력 가능
                            }
                        },
                        error: function() {
                            alert("카테고리 조회에 실패했습니다.");
                        }
                    });
                } else {
                    $("#category_name").val(''); // 카테고리 번호가 비어있으면 이름을 초기화
                    $("#category_name").prop("readonly", false); // 이름 수정 가능
                }
            });
        });
    </script>

</head>
<body>

    <!-- 헤더 포함 -->
    <jsp:include page="/include/admin_header.jsp" />

    <!-- 네비게이션 바 포함 -->
    <jsp:include page="/include/admin_navbar.jsp" />

    <!-- 메인 콘텐츠 -->
    <div class="container">
    
    	<br> <br>
    	
        <h2 class="text-center mb-4">카테고리 삭제</h2>
        
        <br> <br>

        <form action="CategoryDeleteServlet" method="POST" class="category-form">
            <div class="form-group">
                <label for="category_no">삭제할 카테고리 번호:</label>
                <input type="number" id="category_no" name="category_no" required="required" class="form-control" min="1" />
            </div>
            
            <div class="form-group">
                <label for="category_name">카테고리 이름:</label>
                <input type="text" id="category_name" name="category_name" class="form-control" readonly />
            </div>

            <br>
            <div class="form-group">
                <input type="submit" value="카테고리 삭제" class="btn btn-danger" />
            </div>
        </form>
    </div>


</body>
</html>
