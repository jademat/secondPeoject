<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>카테고리 목록</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resource/startbootstrap_admin_pages/css/style.css">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
    
    <!-- Bootstrap 5 CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- SweetAlert2 CDN -->
    <link href="https://cdn.jsdelivr.net/npm/sweetalert2@11.7.0/dist/sweetalert2.min.css" rel="stylesheet">
    
    <!-- SweetAlert2 JS -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.7.0/dist/sweetalert2.min.js"></script>

    <style>
        body {
            background-color: #f1f1f1;
            font-family: 'Arial', sans-serif;
        }
        .container {
            margin-top: 30px;
        }
        .table-wrapper {
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            background-color: #ffffff;
            border-radius: 8px;
            padding: 30px;
            border: 2px solid #4e73df;
        }
        table {
            width: 100%;
            border-collapse: collapse;
        }
        th, td {
            text-align: center;
            vertical-align: middle;
            padding: 15px;
        }
        th {
            background-color: #007bff;
            color: white;
            font-size: 1.1em;
        }
        td {
            background-color: #f9f9f9;
            font-size: 1em;
        }
        tr:nth-child(even) td {
            background-color: #f2f2f2;
        }
        .table-hover tbody tr:hover {
            background-color: #e9ecef;
        }
        .add-btn {
            margin-bottom: 20px;
            padding: 12px 25px;
            background-color: #28a745;
            color: white;
            border-radius: 6px;
            cursor: pointer;
            font-size: 1.1em;
            border: none;
        }
        .add-btn:hover {
            background-color: #218838;
        }
        .add-btn i {
            margin-right: 8px;
        }
        /* 스타일링 for action buttons */
        .action-btn {
            padding: 8px 16px;
            background-color: #007bff;
            color: white;
            border-radius: 6px;
            border: none;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        .action-btn:hover {
            background-color: #0056b3;
        }
        .action-btn:focus {
            outline: none;
        }
        .action-btn i {
            margin-right: 8px;
        }
    </style>
</head>
<body>

    <!-- 헤더 포함 -->
    <jsp:include page="/include/admin_header.jsp" />

    <!-- 네비게이션 바 포함 -->
    <jsp:include page="/include/admin_navbar.jsp" />

    <!-- 메인 콘텐츠 -->
    <div class="container">
        <h2 class="text-center mb-4 text-primary">카테고리 목록</h2>

        <div class="table-wrapper">
            <!-- 카테고리 추가 버튼 -->
            <div class="text-end mb-3">
                <button class="add-btn" onclick="window.location.href='<%= request.getContextPath() %>/category_input.go'">
                    <i class="fas fa-plus-circle"></i> 카테고리 추가
                </button>
            </div>

            <table class="table table-bordered table-hover">
                <thead>
				    <tr align="center">
				        <th style="background-color: #4e73df; color: white; font-size: 1.1em; border-radius: 6px;">카테고리 번호</th>
				        <th style="background-color: #4e73df; color: white; font-size: 1.1em; border-radius: 6px;">카테고리 코드</th>
				        <th style="background-color: #4e73df; color: white; font-size: 1.1em; border-radius: 6px;">카테고리 이름</th>
				    </tr>
				</thead>
                <tbody>
                    <c:set var="list" value="${categoryList}" />
                    <c:if test="${!empty list}">
                        <c:forEach items="${list}" var="category">
                            <tr>
                                <td>${category.getCategory_no()}</td>
                                <td>${category.getCategory_code()}</td>
                                <td>${category.getCategory_name()}</td>
                            </tr>
                        </c:forEach>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>

</body>
</html>
