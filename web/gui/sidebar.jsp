<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<style>
    /* Sidebar Styles */
    .sidebar-container {
        position: fixed;
        top: 0;
        left: 0;
        height: 100%;
        z-index: 1000;
        transition: all 0.3s ease;
        display: flex;
    }

    .sidebar {
        margin-top: 70px;
        width: 110px;
        height: 100%;
        background-color: #f1f1f1;
        position: relative;
        overflow-x: hidden;
        padding-top: 20px;
        border-right: 1px solid #e0e0e0;
        transition: all 0.3s ease;
    }

    .sidebar-menu {
        list-style-type: none;
        padding: 0;
        margin: 0;
    }

    .menu-item {
        padding: 15px 0;
        text-align: center;
        cursor: pointer;
    }

    .menu-icon {
        display: block;
        margin: 0 auto;
        width: 40px;
        height: 40px;
        background-color: #f45642;
        border-radius: 50%;
        color: white;
        text-align: center;
        line-height: 40px;
        font-size: 20px;
        margin-bottom: 5px;
    }

    .content-panel {
        width: 250px;
        background-color: white;
        height: 100%;
        padding: 90px 20px 20px 20px;
        box-shadow: 2px 0 5px rgba(0, 0, 0, 0.1);
        transition: all 0.3s ease;
        overflow-y: auto;
    }

    .menu-list {
        list-style-type: none;
        padding: 0;
        margin: 0;
    }

    .menu-list li {
        padding: 15px 20px;
        border-radius: 8px;
        margin-bottom: 5px;
        cursor: pointer;
    }

    .menu-list li.active {
        background-color: #e0e0e0;
    }

    .menu-list li:hover {
        background-color: #f5f5f5;
    }

    .check-icon {
        color: #f45642;
        margin-right: 15px;
    }

    h3 {
        margin-top: 0;
        padding-bottom: 15px;
        border-bottom: 1px solid #e0e0e0;
    }

    /* Toggle Button */
    .sidebar-toggle {
        position: fixed;
        top: 70px;
        left: 0px;
        background-color: #f45642;
        color: white;
        border: none;
        border-radius: 0 5px 5px 0;
        padding: 8px 12px;
        cursor: pointer;
        z-index: 1001;
        transition: all 0.3s ease;
    }

    /* Collapsed State */
    .sidebar-collapsed {
        transform: translateX(-360px); /* Move entire sidebar off-screen */
    }

    .sidebar-collapsed .sidebar-toggle {
        transform: translateX(360px); /* Move toggle button to edge of screen */
    }

    /* Menu items with links */
    .menu-list li a {
        text-decoration: none;
        color: inherit;
        display: block;
    }
</style>

<c:set var="user" value="${sessionScope.user}" />
<c:set var="userRole" value="${user.role.userRole.toLowerCase()}" />

<div id="sidebarContainer" class="sidebar-container">
    <div class="sidebar">
        <ul class="sidebar-menu">
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
                    <li><a href="${pageContext.request.contextPath}/admin/dashboard"><span class="check-icon">✓</span> Thống kê </a></li>
                    <li><a href="${pageContext.request.contextPath}/admin/users"><span class="check-icon">✓</span> Quản lý người dùng</a></li>
                    <li><a href="${pageContext.request.contextPath}/admin/sales"><span class="check-icon">✓</span> Quản lý Settings</a></li>
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