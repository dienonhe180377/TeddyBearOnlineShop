<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/sidebar.css"/>

<c:set var="user" value="${sessionScope.user}" />
<c:set var="userRole" value="${user.role.userRole.toLowerCase()}" />

<div id="sidebarContainer" class="sidebar-container">
    <div class="sidebar">
        <ul class="sidebar-menu" style="margin-top: 32px;">
            <li class="menu-item"><div class="menu-icon"><i class="fas fa-th"></i></div></li>
            <li class="menu-item"><div class="menu-icon" style="background-color: transparent; color: #666;"><i class="fas fa-chart-line"></i></div></li>
            <li class="menu-item"><div class="menu-icon" style="background-color: transparent; color: #666;"><i class="fas fa-users"></i></div></li>
            <li class="menu-item"><div class="menu-icon" style="background-color: transparent; color: #666;"><i class="fas fa-calendar"></i></div></li>
        </ul>
    </div>

    <div class="content-panel">
        <h3>Sales Data</h3>

        <c:choose>
            <c:when test="${userRole == 'admin'}">
                <ul class="menu-list">
                    <li><a href="${pageContext.request.contextPath}/admin/dashboard"><i class="fa-solid fa-chart-line" style="color: #e15b5b;"></i> Thống kê </a></li>
                    <li><a href="${pageContext.request.contextPath}/UserController?service=getAllUser"><i class="fa-solid fa-user" style="color: #d96d6d;"></i> Quản lý người dùng</a></li>
                    <li><a href="${pageContext.request.contextPath}/admin/sales"><i class="fa-solid fa-gears" style="color: #dd6e6e;"></i> Quản lý Settings</a></li>
                </ul>
            </c:when>
            <c:when test="${userRole == 'manager'}">
                <ul class="menu-list">
                    <li><a href="${pageContext.request.contextPath}/manager/sales"><span class="check-icon">✓</span> Quản lý khách hàng</a></li>
                    <li><a href="${pageContext.request.contextPath}/manager/product-details"><span class="check-icon">✓</span> Quản lý sản phẩm</a></li>
                    <li><a href="${pageContext.request.contextPath}/manager/sales-report"><span class="check-icon">✓</span> Quản lý đơn hàng</a></li>
                    <li><a href="${pageContext.request.contextPath}/manager/employee-performance"><span class="check-icon">✓</span> Nhân viên</a></li>
                    <li><a href="${pageContext.request.contextPath}/admin/dashboard"><span class="check-icon">✓</span> Thống kê </a></li>
                </ul>
            </c:when>
            <c:when test="${userRole == 'seller' || userRole == 'sale'}">
                <ul class="menu-list">
                    <li><a href="${pageContext.request.contextPath}/seller/sales"><span class="check-icon">✓</span> Quản lý đơn hàng</a></li>
                    <li><a href="${pageContext.request.contextPath}/seller/product-details"><span class="check-icon">✓</span> Quản lý sản phẩm</a></li>
                    <li><a href="${pageContext.request.contextPath}/seller/sales-report"><span class="check-icon">✓</span> Thống kê</a></li>
                    <li><a href="${pageContext.request.contextPath}/seller/product-b"><span class="check-icon">✓</span> Product B</a></li>
                    <li class="active"><a href="${pageContext.request.contextPath}/seller/product-a"><span class="check-icon">✓</span> Product A</a></li>
                    <li><a href="${pageContext.request.contextPath}/seller/product-c"><span class="check-icon">✓</span> Product C</a></li>
                    <li><a href="${pageContext.request.contextPath}/seller/product-d"><span class="check-icon">✓</span> Product D</a></li>
                    <li><a href="${pageContext.request.contextPath}/seller/employee-a"><span class="check-icon">✓</span> Product details: employee A</a></li>
                    <li><a href="${pageContext.request.contextPath}/seller/employee-b"><span class="check-icon">✓</span> Product details: employee B</a></li>
                </ul>
            </c:when>
            <c:when test="${userRole == 'customer'}">
                <ul class="menu-list">
                    <li><a href="${pageContext.request.contextPath}/catalog"><span class="check-icon">✓</span> Product Catalog</a></li>
                    <li><a href="${pageContext.request.contextPath}/orders"><span class="check-icon">✓</span> My Orders</a></li>
                    <li><a href="${pageContext.request.contextPath}/cart"><span class="check-icon">✓</span> Shopping Cart</a></li>
                    <li><a href="${pageContext.request.contextPath}/account"><span class="check-icon">✓</span> Account Settings</a></li>
                    <li><a href="${pageContext.request.contextPath}/wishlist"><span class="check-icon">✓</span> Wishlist</a></li>
                </ul>
            </c:when>
            <c:otherwise>
                <ul class="menu-list">
                    <li><a href="${pageContext.request.contextPath}/products"><span class="check-icon">✓</span> Products</a></li>
                    <li><a href="${pageContext.request.contextPath}/categories"><span class="check-icon">✓</span> Categories</a></li>
                    <li><a href="${pageContext.request.contextPath}/special-offers"><span class="check-icon">✓</span> Special Offers</a></li>
                    <li><a href="${pageContext.request.contextPath}/about"><span class="check-icon">✓</span> About Us</a></li>
                    <li><a href="${pageContext.request.contextPath}/contact"><span class="check-icon">✓</span> Contact</a></li>
                </ul>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<!-- Toggle Button outside the container so it doesn't move with the sidebar -->
<button id="sidebarToggle" class="sidebar-toggle" title="Toggle Sidebar">
    <i class="fas fa-chevron-left"></i>
</button>

<script>
    document.addEventListener('DOMContentLoaded', function () {
        const sidebarContainer = document.getElementById('sidebarContainer');
        const sidebarToggle = document.getElementById('sidebarToggle');
        const toggleIcon = sidebarToggle.querySelector('i');

        if (localStorage.getItem('sidebarState') === 'collapsed') {
            sidebarContainer.classList.add('sidebar-collapsed');
            toggleIcon.classList.remove('fa-chevron-left');
            toggleIcon.classList.add('fa-chevron-right');
        }

        sidebarToggle.addEventListener('click', function () {
            if (sidebarContainer.classList.contains('sidebar-collapsed')) {
                sidebarContainer.classList.remove('sidebar-collapsed');
                toggleIcon.classList.remove('fa-chevron-right');
                toggleIcon.classList.add('fa-chevron-left');
                localStorage.setItem('sidebarState', 'expanded');

            } else {
                sidebarContainer.classList.add('sidebar-collapsed');
                toggleIcon.classList.remove('fa-chevron-left');
                toggleIcon.classList.add('fa-chevron-right');
                localStorage.setItem('sidebarState', 'collapsed');
            }
        });

        const menuItems = document.querySelectorAll('.menu-list li');
        menuItems.forEach(item => {
            item.addEventListener('click', function () {
                if (!this.querySelector('a') || this.querySelector('a').getAttribute('href') === '#') {
                    menuItems.forEach(i => i.classList.remove('active'));

                    this.classList.add('active');
                }
            });
        });
    });
</script>