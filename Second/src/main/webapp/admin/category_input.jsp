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

    <!-- SweetAlert2 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/sweetalert2@11.7.0/dist/sweetalert2.min.css" rel="stylesheet">

    <!-- SweetAlert2 JS -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.7.0/dist/sweetalert2.min.js"></script>

    <style>
        /* 카드 테두리 색상 변경 */
        .product-card {
            border: 2px solid #4e73df !important;
            border-radius: 8px;
            padding: 20px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            margin-bottom: 30px;
        }

        .btn-custom {
            margin-top: 20px;
            padding: 10px 20px;
        }

        /* 라벨 스타일 */
        .form-group label {
            font-weight: bold;
            color: #4e73df; /* 카테고리 이름, 카테고리 코드, 성별 라벨 텍스트 색상 */
            margin-bottom: 10px;  /* 라벨과 입력 필드 간의 마진 */
            display: block;  /* 라벨을 블록 요소로 설정하여 아래와의 간격을 증가 */
        }

        /* 입력 필드 스타일 */
        .form-control {
            border-color: #4e73df; /* 입력창 테두리 색상 */
            color: #4e73df; /* 입력창 글자색 */
            margin-bottom: 15px; /* 입력 필드 간의 마진 */
        }

        .form-control:focus {
            border-color: #4e73df;
            box-shadow: 0 0 0 0.2rem rgba(78, 115, 223, 0.25);
        }

        .button-container {
            display: flex;
            justify-content: center;
            margin-top: 20px;
        }

        /* 카테고리 등록 제목 색상 */
        h2 {
            color: #4e73df; /* 진한 파란색 */
        }

        /* 남성/여성 라벨 색상 회색으로 돌리기 */
        .form-check-label {
            color: #6c757d !important; /* 회색으로 변경 (강제로 적용) */
            margin-right: 10px;  /* 성별 라벨들 간의 마진 추가 */
        }

        /* 버튼 색상 */
        .btn-primary {
            background-color: #4e73df;
            border-color: #4e73df;
        }

        .btn-primary:hover {
            background-color: #2e59d9; /* 버튼 Hover 시 색상 */
            border-color: #2e59d9;
        }

        /* sub 태그 색상 강제 변경 */
        .form-text sub {
            color: black; /* sub 태그 글자 색상 적용 */
        }

    </style>
</head>
<body>

    <!-- 헤더 포함 -->
    <jsp:include page="/include/admin_header.jsp" />

    <!-- 네비게이션 바 포함 -->
    <jsp:include page="/include/admin_navbar.jsp" />

    <!-- 메인 콘텐츠 -->
    <div class="container mt-5">
    
        <h2 class="text-center mb-4">카테고리 등록</h2>

        <!-- 카드로 감싼 폼 -->
        <div class="card product-card">
            <div class="card-body">
                <form id="categoryForm" action="<%=request.getContextPath() %>/category_input_ok.go" method="POST" class="category-form">
                    <!-- 카테고리 이름 입력 -->
                    <div class="form-group">
                        <label for="category_name">카테고리 이름:</label>
                        <input type="text" id="category_name" name="category_name" class="form-control" required="required" />
                        <sub id="categoryHelp" class="form-text text-muted">* 예: 상의, 하의, 아우터 등</sub>
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
                        <sub id="categoryCodeHelp" class="form-text text-muted">* 카테고리 이름과 성별에 따라 자동 생성된 코드가 표시됩니다.</sub>
                    </div>

                    <!-- 버튼을 감싼 div로 중앙 정렬 -->
                    <div class="button-container">
                        <!-- 이 버튼은 제출을 위한 버튼 -->
                        <button type="button" class="btn btn-primary btn-custom" onclick="validateAndSubmitForm()">카테고리 추가</button>
                    </div>
                </form>
            </div>
        </div>

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

        // 성별 선택 체크 및 폼 제출
        function validateAndSubmitForm() {
            const categoryName = document.getElementById('category_name').value.trim();
            const maleChecked = document.getElementById('male').checked;
            const femaleChecked = document.getElementById('female').checked;

            // 카테고리 이름이 비어 있으면 경고
            if (!categoryName) {
                Swal.fire({
                    title: '카테고리 이름을 입력하세요.',
                    icon: 'warning',
                    confirmButtonText: '확인'
                });
                return;
            }

            // 성별이 선택되지 않으면 경고
            if (!maleChecked && !femaleChecked) {
                Swal.fire({
                    title: '성별을 선택해주세요.',
                    icon: 'warning',
                    confirmButtonText: '확인'
                });
                return;
            }

            // 유효성 검사 통과 시 폼 제출
            document.getElementById('categoryForm').submit();
        }

        // 카테고리 이름이나 성별 선택 시 카테고리 코드 자동 생성
        document.getElementById('category_name').addEventListener('input', generateCategoryCode);
        document.getElementById('male').addEventListener('change', generateCategoryCode);
        document.getElementById('female').addEventListener('change', generateCategoryCode);
    </script>

</body>
</html>
