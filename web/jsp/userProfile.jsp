<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        <title>Profile Hub - Trang hồ sơ</title>
        <!-- Liên kết tới file CSS -->
        <link rel="stylesheet" href="${contextPath}/css/userProfile.css" />
    </head>
    <body>
        <jsp:include page="header.jsp"/>

        <!-- Container chính -->
        <div class="container">
            <div class="profile-card">
                <!-- Ảnh đại diện -->
                <img 
                    src="${contextPath}/images/usericon.jpg" 
                    alt="Avatar" 
                    class="avatar"
                    />
                <!-- Thông tin cơ bản -->
                <div class="profile-info">
                    <h2>Alex Johnson</h2>
                    <a href="mailto:alex.johnson@example.com">alex.johnson@example.com</a>
                </div>

                <!-- Tóm tắt tài khoản -->
                <div class="account-summary">
                    <h3>Account Summary</h3>
                    <p>Member since: January 2021</p>
                    <p>Last login: October 15, 2023</p>
                    <p>Subscription: Premium</p>
                </div>

                <!-- Nút thao tác -->
                <div class="actions">
                    <button class="btn">Edit Profile</button>
                    <button class="btn">Security Settings</button>
                </div>
            </div>
        </div>
        
        <jsp:include page="footer.jsp"/>
    </body>
</html>
