<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Gấu Bông Teddy Socola</title>
        <!-- Kết nối đến file CSS -->
        <link rel="stylesheet" href="${contextPath}/css/productView.css">
    </head>
    <body>
        <jsp:include page="header.jsp" />
        <div style="margin-top: 150px;">
            <div class="product-container">
                <!-- Hình ảnh sản phẩm (bên trái) -->
                <div class="product-image">
                    <!-- Thay link ảnh của bạn vào src bên dưới -->
                    <img src="https://via.placeholder.com/500x600?text=HINH+GAU+BONG" alt="Gấu Bông Teddy Socola">

                </div>

                <!-- Thông tin sản phẩm (bên phải) -->
                <div class="product-details">
                    <h1 class="product-title">Gấu Bông Teddy Socola</h1>

                    <table class="size-status-table">
                        <thead>
                            <tr>
                                <th>Kích thước</th>
                                <th>Giá bán</th>
                                <th>Trạng thái</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>80cm</td>
                                <td>425.000đ</td>
                                <td>Còn hàng</td>
                            </tr>
                            <tr>
                                <td>1m</td>
                                <td>550.000đ</td>
                                <td>Còn hàng</td>
                            </tr>
                            <tr>
                                <td>1m2</td>
                                <td>650.000đ</td>
                                <td>Còn hàng</td>
                            </tr>
                            <tr>
                                <td>1m4</td>
                                <td>750.000đ</td>
                                <td>Còn hàng</td>
                            </tr>
                        </tbody>
                    </table>

                    <div class="product-price">425.000đ (cho size 80cm)</div>

                    <div class="product-actions">
                        <button class="btn btn-buy">Mua hàng</button>
                        <button class="btn btn-quick-order">Đặt hàng nhanh</button>
                    </div>

                    <ul class="product-info-list">
                        <li>100% bông trắng tinh khiết</li>
                        <li>Bảo hành đường chỉ 6 tháng</li>
                        <li>Miễn phí gấu áo</li>
                        <li>Miễn phí gói quà</li>
                        <li>100% ảnh chụp thật shop</li>
                        <li>Hóa đơn bán hàng đổi gấu 6 tháng</li>
                        <li>Miễn phí tặng thiệp</li>
                    </ul>

                    <p class="note">
                        HÀ NỘI: 8:30 - 23:00 <br>
                        (Bạn có thể thêm thông tin liên hệ, địa chỉ cửa hàng ở đây)
                    </p>
                </div>
            </div>
            <div class="small-images">
                <ul>
                    <li>
                        <img src="https://gaubongonline.vn/wp-content/uploads/2024/05/Chuot-capybara-than-tai-2.jpg" alt="Gấu Bông Teddy Socola">
                    </li>
                    <li>
                        <img src="https://gaubongonline.vn/wp-content/uploads/2024/05/Chuot-capybara-than-tai-2.jpg" alt="Gấu Bông Teddy Socola">
                    </li>
                    <li>
                        <img src="https://gaubongonline.vn/wp-content/uploads/2024/05/Chuot-capybara-than-tai-2.jpg" alt="Gấu Bông Teddy Socola">
                    </li>
                    <li>
                        <img src="https://gaubongonline.vn/wp-content/uploads/2024/05/Chuot-capybara-than-tai-2.jpg" alt="Gấu Bông Teddy Socola">
                    </li>
                    <li>
                        <img src="https://gaubongonline.vn/wp-content/uploads/2024/05/Chuot-capybara-than-tai-2.jpg" alt="Gấu Bông Teddy Socola">
                    </li>
                    <li>
                        <img src="https://gaubongonline.vn/wp-content/uploads/2024/05/Chuot-capybara-than-tai-2.jpg" alt="Gấu Bông Teddy Socola">
                    </li>
                </ul>

            </div>
        </div>


    </body>
</html>
