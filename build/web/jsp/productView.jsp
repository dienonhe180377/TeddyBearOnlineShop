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
                    <img src="${contextPath}/${thumbnail}" alt="Gấu Bông Teddy Socola">
                </div>

                <!-- Thông tin sản phẩm (bên phải) -->
                <div class="product-details">
                    <h1 class="product-title">${product.name}</h1>

                    <table class="size-status-table">
                        <thead>
                            <tr>
                                <th>Kích thước</th>
                                <th>Giá bán</th>
                                <th>Trạng thái</th>
                            </tr>
                        </thead>
                        <c:forEach var="size" items="${product.sizes}">
                            <tbody>
                                <tr>
                                    <td>${size.name}</td>
                                    <td>${size.price}đ</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${size.quantity < 1}">
                                                Hết Hàng
                                            </c:when>
                                            <c:otherwise>
                                                Còn Hàng
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                </tr>
                            </tbody>
                        </c:forEach>

                    </table>

                    <div class="product-price">${product.sizes[0].price}đ </div>

                    <div class="product-actions">
                        <button id="buyButton" class="btn btn-buy">Thêm vào giỏ hàng</button>
                        <button id="buyButton2" class="btn btn-quick-order">Mua ngay</button>
                    </div>


                    <p class="note">
                        HÀ NỘI: 8:30 - 23:00 <br>
                        275 Bạch Mai, Hai Bà Trưng, Hà Nội - 0979896616
                    </p>
                </div>
                <!-- Pop-up chọn size -->
                <form action="" method="get">
                    <div id="sizePopup" class="popup">
                        <div class="popup-content">
                            <span class="close" id="closePopup">&times;</span>
                            <h2>Chọn kích cỡ sản phẩm</h2>
                            <select id="productSize" name="size">
                                <c:forEach var="size" items="${product.sizes}">
                                    <option value="${size.name}">${size.name}</option>
                                </c:forEach>
                            </select>
                            <button id="addToCart">Thêm vào giỏ hàng</button>
                        </div>
                    </div>
                    <div id="sizePopup2" class="popup">
                        <div class="popup-content">
                            <span class="close" id="closePopup">&times;</span>
                            <h2>Chọn kích cỡ sản phẩm</h2>
                            <select id="productSize" name="size">
                                <c:forEach var="size" items="${product.sizes}">
                                    <option value="${size.name}">${size.name}</option>
                                </c:forEach>
                            </select>
                            <button id="addToCart">Mua Ngay</button>
                        </div>
                    </div>
                </form>
            </div>
            <div class="small-images">
                <ul>
                    <c:forEach var="image" items="${product.images}">
                        <li>
                            <a href="${contextPath}/MenuController?service=productView&thumbnail=${image.id}&productId=${product.id}"><img src="${contextPath}/${image.source}" alt="Gấu Bông Teddy Socola"></a>
                        </li>
                    </c:forEach>
                </ul>
            </div>
        </div>

        <footer style="margin-top: 151px;">
            <jsp:include page="footer.jsp" />
        </footer>
    </body>
    <script>
// Lấy các phần tử
        var buyButton = document.getElementById("buyButton");
        var buyButton2 = document.getElementById("buyButton2");
        var sizePopup = document.getElementById("sizePopup");
        var sizePopup2 = document.getElementById("sizePopup2");
        var closePopup = document.getElementById("closePopup");
        var addToCart = document.getElementById("addToCart");

// Khi bấm vào nút Mua hàng, hiển thị pop-up
        buyButton.onclick = function () {
            sizePopup.style.display = "block";
        }

        buyButton2.onclick = function () {
            sizePopup2.style.display = "block";
        }

// Khi bấm vào nút đóng pop-up
        closePopup.onclick = function () {
            sizePopup.style.display = "none";
            sizePopup2.style.display = "none";
        }

// Khi bấm ra ngoài pop-up, đóng pop-up
        window.onclick = function (event) {
            if (event.target == sizePopup) {
                sizePopup.style.display = "none";
            } else if (event.target == sizePopup2) {
                sizePopup2.style.display = "none";
            }
        }

    </script>
</html>
