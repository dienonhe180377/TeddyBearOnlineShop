<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Customer Detail</title>
        <link rel="stylesheet" href="${contextPath}/css/customerDetail.css">
    </head>
    <body style="margin-top: 115px;">
         
        <jsp:include page="../gui/header.jsp" />
        <jsp:include page="../gui/sidebar.jsp" />
        
        <div class="container">
            <h2>Thông tin khách hàng</h2>
            <form id="customerForm">
                <label for="username">Tên đăng nhập:</label>
                <input type="text" id="username" name="username" placeholder="Nhập tên đăng nhập" required>

                <label for="email">Email:</label>
                <input type="email" id="email" name="email" placeholder="Nhập email" required>

                <label for="phone">Số điện thoại:</label>
                <input type="tel" id="phone" name="phone" placeholder="Nhập số điện thoại" required>

                <label for="location">Địa chỉ:</label>
                <input type="text" id="location" name="location" placeholder="Nhập địa chỉ" required>

                <div class="buttons">
                    <button type="button" id="saveButton">Lưu Cài Đặt</button>
                    <button type="button" id="cancelButton">Hủy</button>
                    <button type="button" id="transactionHistoryButton" style="background-color: #FF008B;">Lịch Sử Giao Dịch</button>
                </div>
            </form>
        </div>

        <script>

            document.getElementById('saveButton').addEventListener('click', function () {
                const username = document.getElementById('username').value;
                const email = document.getElementById('email').value;
                const phone = document.getElementById('phone').value;
                const location = document.getElementById('location').value;

                // Validate inputs
                if (username && email && phone && location) {
                    alert('Cài đặt đã được lưu!');
                } else {
                    alert('Vui lòng điền đầy đủ thông tin!');
                }
            });

            document.getElementById('cancelButton').addEventListener('click', function () {
                // Clear all input fields
                document.getElementById('customerForm').reset();
            });

            document.getElementById('transactionHistoryButton').addEventListener('click', function () {
                alert('Chức năng Lịch Sử Giao Dịch đang được phát triển!');
            });

        </script>
    </body>
</html>
