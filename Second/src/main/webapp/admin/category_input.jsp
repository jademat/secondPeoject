<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, com.hhlb.model.CategoryDAO" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>카테고리 등록</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resource/startbootstrap_admin_pages/css/style.css">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
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

        <form action="<%=request.getContextPath() %>/category_input_ok.go" method="POST" class="category-form">
            <!-- 카테고리 이름 입력 -->
            <div class="form-group">
                <label for="category_name">카테고리 이름:</label>
                <input type="text" id="category_name" name="category_name" class="form-control" required="required" />
                <small id="categoryHelp" class="form-text text-muted">예: 상의, 하의, 아우터 등</small>
            </div>

            <!-- 성별 선택 -->
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
                <div class="form-text text-danger" id="genderError" style="display: none;">성별을 선택해주세요.</div>
            </div>

            <!-- 카테고리 코드 표시 -->
            <div class="form-group">
                <label for="category_code">카테고리 코드:</label>
                <input type="text" id="category_code" name="category_code" class="form-control" readonly />
                <small id="categoryCodeHelp" class="form-text text-muted">카테고리 이름과 성별에 따라 자동 생성된 코드가 표시됩니다.</small>
            </div>

            <br>
            <div class="form-group">
                <input type="submit" value="카테고리 추가" class="btn btn-primary" />
            </div>
        </form>
    </div>

    <%
        // DB에서 카테고리 코드 목록을 가져오기
        CategoryDAO dao = CategoryDAO.getInstance();
        List<String> existingCategoryCodes = dao.getCategoryCodes();

        // List를 JSON 형식으로 변환
        StringBuilder json = new StringBuilder("[");
        for (int i = 0; i < existingCategoryCodes.size(); i++) {
            json.append("\"").append(existingCategoryCodes.get(i)).append("\"");
            if (i < existingCategoryCodes.size() - 1) {
                json.append(",");
            }
        }
        json.append("]");
    %>

    <script>
        // JSP에서 전달한 카테고리 코드 목록을 JavaScript로 전달
        const existingCategoryCodes = <%= json.toString() %>;

        // 카테고리 이름과 성별을 기반으로 카테고리 코드 자동 생성
        function generateCategoryCode() {
            const categoryName = document.getElementById('category_name').value.trim();
            const maleChecked = document.getElementById('male').checked;
            const femaleChecked = document.getElementById('female').checked;

            let baseCode = '';
            if (maleChecked) {
                baseCode = 'e100';  // 남성 카테고리 코드 시작
            } else if (femaleChecked) {
                baseCode = 'e200';  // 여성 카테고리 코드 시작
            }

            // 카테고리 이름에 따른 번호 추가 (예: 상의 -> e1001)
            let categoryCode = '';
            if (categoryName) {
                const categorySuffix = getCategorySuffix(categoryName);
                if (categorySuffix) {
                    categoryCode = baseCode + categorySuffix;
                }
            }

            // 중복되지 않는 새로운 카테고리 코드 찾기
            let newCategoryCode = getNextCategoryCode(baseCode);

            // 자동 생성된 코드 업데이트
            document.getElementById('category_code').value = newCategoryCode;
        }

        // 카테고리 이름에 맞는 번호 반환 (예: 상의 -> 1, 하의 -> 2, 아우터 -> 3)
        function getCategorySuffix(categoryName) {
            if (categoryName.includes('상의')) {
                return '1';
            } else if (categoryName.includes('하의')) {
                return '2';
            } else if (categoryName.includes('아우터')) {
                return '3';
            } else {
                return '';
            }
        }

        // 가장 큰 카테고리 번호를 찾아서 그 다음 번호를 반환
        function getNextCategoryCode(baseCode) {
            let maxCodeNumber = 0;

            // 기존 코드 목록에서 가장 큰 번호를 찾음
            existingCategoryCodes.forEach(function (existingCode) {
                if (existingCode.startsWith(baseCode)) {
                    const codeNumber = parseInt(existingCode.replace(baseCode, ''), 10);
                    if (codeNumber > maxCodeNumber) {
                        maxCodeNumber = codeNumber;
                    }
                }
            });

            // 새 카테고리 코드 번호는 가장 큰 번호 + 1
            return baseCode + (maxCodeNumber + 1);
        }

        // 성별 선택 체크
        document.querySelector('form').addEventListener('submit', function (event) {
            const maleChecked = document.getElementById('male').checked;
            const femaleChecked = document.getElementById('female').checked;

            if (!maleChecked && !femaleChecked) {
                event.preventDefault();  // 폼 전송을 막음
                document.getElementById('genderError').style.display = 'block';
            } else {
                document.getElementById('genderError').style.display = 'none';
                generateCategoryCode();  // 카테고리 코드 자동 생성
            }
        });

        // 카테고리 이름이나 성별 선택 시 카테고리 코드 자동 생성
        document.getElementById('category_name').addEventListener('input', generateCategoryCode);
        document.getElementById('male').addEventListener('change', generateCategoryCode);
        document.getElementById('female').addEventListener('change', generateCategoryCode);
    </script>

</body>
</html>
