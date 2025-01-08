<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>카테고리 등록</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.css">
    <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.js"></script>
</head>
<body>

    <!-- 헤더 포함 -->
    <jsp:include page="/include/admin_header.jsp" />

    <!-- 네비게이션 바 포함 -->
    <jsp:include page="/include/admin_navbar.jsp" />

    <!-- 메인 콘텐츠 -->
    <div class="container">
    
    	<br> <br>
    	
        <h2 class="text-center mb-4">카테고리 등록</h2>

		<br> <br>

        <form action="CategoryInsertServlet" method="POST" class="category-form">
            <div class="form-group">
                <label for="category_name">카테고리 이름:</label>
                <input type="text" id="category_name" name="category_name" class="form-control" required="required" />
            </div>

            <div class="form-group">
                <label for="category_gender">성별:</label>
                <div class="form-check">
                    <input type="radio" id="male" name="category_gender" value="남성" class="form-check-input" required="required">
                    <label class="form-check-label" for="male">남성</label>
                </div>
                <div class="form-check">
                    <input type="radio" id="female" name="category_gender" value="여성" class="form-check-input" required="required">
                    <label class="form-check-label" for="female">여성</label>
                </div>
            </div>

            <br>
            <div class="form-group">
                <input type="submit" value="카테고리 추가" class="btn btn-primary" />
            </div>
        </form>
    </div>


</body>
</html>
