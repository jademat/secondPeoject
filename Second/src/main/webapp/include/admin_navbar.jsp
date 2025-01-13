<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- admin_navbar -->

<!-- Page Wrapper -->
<div id="wrapper">

    <!-- Sidebar -->
    <ul class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion" id="accordionSidebar">

        <!-- Sidebar - Brand -->
        <a class="sidebar-brand d-flex align-items-center justify-content-center" href="<%=request.getContextPath() %>/admin/admin_main.jsp">
            <div class="sidebar-brand-icon rotate-n-15">
                <i class="fas fa-laugh-wink"></i>
            </div>
            <div class="sidebar-brand-text mx-3">HHLB<sup>1</sup></div>
        </a>

        <!-- Divider -->
        <hr class="sidebar-divider my-0">

        <!-- Nav Item - Dashboard -->
        <li class="nav-item active">
            <a class="nav-link" href="<%=request.getContextPath() %>/admin/admin_main.jsp">
                <i class="fas fa-fw fa-tachometer-alt"></i>
                <span>관리자 홈</span></a>
        </li>

        <!-- Divider -->
        <hr class="sidebar-divider">

        <!-- Heading -->
        <div class="sidebar-heading">
        	상품관리
        </div>

        <!-- Nav Item - Product Management -->
        <li class="nav-item">
            <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseCategoryManagement"
                aria-expanded="true" aria-controls="collapseProductManagement">
                <i class="fas fa-fw fa-box"></i>
                <span>카테고리 관리</span>
            </a>
            <div id="collapseCategoryManagement" class="collapse" aria-labelledby="headingProductManagement" data-parent="#accordionSidebar">
                <div class="bg-white py-2 collapse-inner rounded">
                    <a class="collapse-item" href="<%=request.getContextPath() %>/category_input.go">카테고리 등록</a>
                    <a class="collapse-item" href="<%=request.getContextPath() %>/category_modify.go">카테고리 수정</a>
                    <a class="collapse-item" href="<%=request.getContextPath() %>/category_delete.go">카테고리 삭제</a>
                    <a class="collapse-item" href="<%=request.getContextPath() %>/category_list.go">카테고리 목록</a>
                </div>
            </div>
            
            <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseProductManagement"
                aria-expanded="true" aria-controls="collapseProductManagement">
                <i class="fas fa-fw fa-box"></i>
                <span>상품 관리</span>
            </a>
            <div id="collapseProductManagement" class="collapse" aria-labelledby="headingProductManagement" data-parent="#accordionSidebar">
                <div class="bg-white py-2 collapse-inner rounded">
                    <a class="collapse-item" href="product_input.jsp">상품 등록</a>
                    <a class="collapse-item" href="product_modify.jsp">상품 수정</a>
                    <a class="collapse-item" href="product_delete.jsp">상품 삭제</a>
                </div>
            </div>
            
        </li>

        <!-- Divider -->
        <hr class="sidebar-divider">


        <!-- Heading -->
        <div class="sidebar-heading">
            회원관리
        </div>

        <!-- Nav Item - Member Management -->
        <li class="nav-item">
            <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseMemberManagement"
                aria-expanded="true" aria-controls="collapseMemberManagement">
                <i class="fas fa-fw fa-users"></i>
                <span>회원 관리</span>
            </a>
            <div id="collapseMemberManagement" class="collapse" aria-labelledby="headingMemberManagement" data-parent="#accordionSidebar">
                <div class="bg-white py-2 collapse-inner rounded">
                    <a class="collapse-item" href="memberList.jsp">회원 목록</a>
                    <a class="collapse-item" href="memberModify.jsp">회원 정보 수정</a>
                </div>
            </div>
        </li>

        <!-- Divider -->
        <hr class="sidebar-divider">
        
        
        

        <!-- Heading -->
        <div class="sidebar-heading">
            매출관리
        </div>

        <!-- Nav Item - Sales Management -->
        <li class="nav-item">
            <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseSalesManagement"
                aria-expanded="true" aria-controls="collapseSalesManagement">
                <i class="fas fa-fw fa-chart-line"></i>
                <span>매출 관리</span>
            </a>
            <div id="collapseSalesManagement" class="collapse" aria-labelledby="headingSalesManagement" data-parent="#accordionSidebar">
                <div class="bg-white py-2 collapse-inner rounded">
                    <a class="collapse-item" href="Sales_day.jsp">일자별</a>
                    <a class="collapse-item" href="Sales_month.jsp">월별</a>
                </div>
            </div>
        </li>

        <!-- Divider -->
        <hr class="sidebar-divider d-none d-md-block">
    	
    	
    	<!-- Sidebar Toggler (Sidebar) -->
        <!-- <div class="text-center d-none d-md-inline">
            <button class="rounded-circle border-0" id="sidebarToggle"></button>
        </div> -->

        <!-- Sidebar Message -->
        <!-- <div class="sidebar-card d-none d-lg-flex">
            <img class="sidebar-card-illustration mb-2" src="img/undraw_rocket.svg" alt="...">
            <p class="text-center mb-2"><strong>SB Admin Pro</strong> is packed with premium features, components, and more!</p>
            <a class="btn btn-success btn-sm" href="https://startbootstrap.com/theme/sb-admin-pro">Upgrade to Pro!</a>
        </div> -->

    </ul>
    <!-- End of Sidebar -->
