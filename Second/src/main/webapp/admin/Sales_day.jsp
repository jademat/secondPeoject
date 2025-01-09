<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>매출 관리 - 일자별</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resource/startbootstrap_admin_pages/css/style.css">
   	<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>
</head>
<body>

    <!-- 헤더 포함 -->
    <jsp:include page="/include/admin_header.jsp" />

    <!-- 네비게이션 바 포함 -->
    <jsp:include page="/include/admin_navbar.jsp" />

    <!-- 메인 콘텐츠 -->
    <div class="container">
        <h2>매출 관리 - 일자별</h2>

        <form action="SalesDayServlet" method="GET">
            <div class="form-group">
                <label for="datePicker">날짜 선택:</label>
                <input type="text" id="datePicker" name="date" class="form-control" required="required">
            </div>

            <br>
            <div class="form-group">
                <input type="submit" value="매출 조회" class="btn btn-primary">
            </div>
        </form>

        <!-- 선택한 날짜에 대한 매출 정보 출력 (추후 구현) -->
        <div id="salesDetails">
            <!-- 매출 세부 정보가 여기에 표시됩니다. -->
        </div>
    </div>

    <!-- 푸터 포함 -->
    <jsp:include page="/include/admin_footer.jsp" />

    <!-- 스크립트 -->
    <script>
        $(document).ready(function() {
            // jQuery UI Datepicker 활성화
            $("#datePicker").datepicker({
                dateFormat: "yy-mm-dd", // 날짜 형식 설정
                showButtonPanel: true, // 버튼 패널 표시
                changeMonth: true, // 월 변경 가능
                changeYear: true, // 연도 변경 가능
                yearRange: "2020:2030" // 선택 가능한 연도 범위
            });
        });
    </script>

</body>
</html>
