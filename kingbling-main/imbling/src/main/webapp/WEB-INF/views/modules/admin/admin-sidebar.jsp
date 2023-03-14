<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

            <!-- Sidebar -->
        <ul class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion" id="accordionSidebar">

            <!-- Sidebar - Brand -->
            <a class="sidebar-brand d-flex align-items-center justify-content-center" href="/home">
                <div class="sidebar-brand-icon rotate-n-15">
                    <img class="img-profile rounded-circle"
                                    src="/resources/dist/img/skyblue-gem.png" width="50px">
                </div>
                <div class="sidebar-brand-text mx-3" >임블링</div>
            </a>

            <!-- Divider -->
            <hr class="sidebar-divider my-0">

            <!-- Nav Item - Dashboard -->
            <li class="nav-item active">
                <a class="nav-link" href="/admin-home">
                    <i class="fas fa-light fa-house-user"></i>
                    <span>관리자 홈</span></a>
            </li>

            <!-- Divider -->
            <hr class="sidebar-divider" />

            <!-- Nav Item - Pages Collapse Menu -->
            <li class="nav-item">
                <a class="nav-link collapsed" href="/member/userlist">
                    <i class="fas fa-person-simple"></i>
                    <span>회원 관리</span>
                </a>
            </li>
            

            <!-- Nav Item - Utilities Collapse Menu -->
            <li class="nav-item">
                <a class="nav-link collapsed" href="/admin/detail">
                    <i class="fas fa-plus"></i>
                    <span>상품 등록</span>
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link collapsed" href="/admin/list">
                    <i class="fas fa-list"></i>
                    <span>상품 목록</span>
                </a>
            </li>

            <!-- Nav Item - Pages Collapse Menu -->
            <li class="nav-item">
                <a class="nav-link collapsed" href="/admin/order-list">
                    <i class="fas fa-shopping-basket"></i>
                    <span>주문 내역</span>
                </a>
            </li>
            
            <li class="nav-item">
                <a class="nav-link collapsed" href="/board/event">
                    <i class="fas fa-chalkboard"></i>
                    <span>게시판 관리</span>
                </a>
            </li>
            
            <li class="nav-item">
                <a class="nav-link collapsed" href="/board/adminreviewList">
                    <i class="fas fa-chalkboard"></i>
                    <span>리뷰 관리</span>
                </a>
            </li>

            <!-- Divider -->
            <hr class="sidebar-divider d-none d-md-block">

            <!-- Sidebar Toggler (Sidebar) -->
            <div class="text-center d-none d-md-inline">
                <button class="rounded-circle border-0" id="sidebarToggle"></button>
            </div>

        </ul>
        <!-- End of Sidebar -->