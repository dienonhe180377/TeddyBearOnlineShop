<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Gấu Bông Cặp Đôi BearHug - Thỏ Bunny & Daisy</title>
        <style>
            :root {
                --primary: #00BCD4;
                --secondary: #FF6B8B;
                --light-gray: #f5f5f5;
                --dark-gray: #333;
                --white: #fff;
            }

            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
                font-family: 'Roboto', sans-serif;
            }

            body {
                background-color: var(--white);
                color: var(--dark-gray);
                line-height: 1.6;
            }

            .container {
                max-width: 1200px;
                margin: 0 auto;
                padding: 0 15px;
            }

            header {
                background-color: var(--white);
                box-shadow: 0 2px 5px rgba(0,0,0,0.1);
                position: sticky;
                top: 0;
                z-index: 100;
            }

            .logo {
                max-width: 200px;
                padding: 10px 0;
            }

            .services {
                display: flex;
                justify-content: space-between;
                padding: 20px 0;
                flex-wrap: wrap;
            }

            .service-item {
                display: flex;
                flex-direction: column;
                align-items: center;
                width: 18%;
                text-align: center;
            }

            .service-item img {
                width: 60px;
                height: 60px;
                margin-bottom: 10px;
            }

            .service-item p {
                font-weight: bold;
                font-size: 14px;
            }

            .product-main {
                display: flex;
                gap: 30px;
                margin: 30px 0;
                flex-wrap: wrap;
            }

            .product-gallery {
                flex: 1;
                min-width: 300px;
            }

            .main-image {
                width: 100%;
                margin-bottom: 15px;
                border-radius: 5px;
            }
            .main_images img {
                width: 100%;
            }

            .thumbnail-container {
                display: flex;
                gap: 10px;
                flex-wrap: wrap;
            }

            .thumbnail {
                width: 80px;
                height: 80px;
                object-fit: cover;
                border-radius: 5px;
                cursor: pointer;
            }

            .product-info {
                flex: 1;
                min-width: 300px;
            }

            .product-title {
                font-size: 24px;
                margin-bottom: 20px;
                color: var(--dark-gray);
            }

            .price-table {
                width: 100%;
                border-collapse: collapse;
                margin-bottom: 20px;
            }

            .price-table th, .price-table td {
                padding: 10px;
                border: 1px solid #ddd;
                text-align: center;
            }

            .price-table th {
                background-color: var(--light-gray);
            }

            .price {
                font-size: 24px;
                color: var(--secondary);
                margin-bottom: 20px;
                font-weight: bold;
            }

            .size-options {
                margin-bottom: 20px;
            }

            .size-btn {
                background-color: var(--secondary);
                color: var(--white);
                border: none;
                padding: 5px 15px;
                border-radius: 3px;
                cursor: pointer;
                margin-right: 5px;
                margin-bottom: 5px;
            }

            .active-size {
                background-color: #689f82;
                color: white;
                border-color: #689f82;
            }

            .buy-buttons {
                display: flex;
                flex-direction: column;
                gap: 15px;
                margin-bottom: 20px;
            }

            .buy-now, .quick-order {
                padding: 12px;
                border: none;
                border-radius: 5px;
                font-weight: bold;
                cursor: pointer;
                font-size: 16px;
                text-align: center;
            }

            .buy-now {
                background-color: var(--secondary);
                color: var(--white);
            }

            .quick-order {
                background-color: var(--primary);
                color: var(--white);
            }

            .phone-input {
                display: flex;
                gap: 10px;
                margin-bottom: 20px;
            }

            .phone-input input {
                flex: 1;
                padding: 10px;
                border: 1px solid #ddd;
                border-radius: 5px;
            }

            .phone-input button {
                background-color: var(--secondary);
                color: var(--white);
                border: none;
                padding: 0 15px;
                border-radius: 5px;
                cursor: pointer;
            }

            .benefits {
                display: grid;
                grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
                gap: 15px;
                margin-bottom: 20px;
            }

            .benefit-item {
                display: flex;
                align-items: center;
                gap: 10px;
            }

            .store-info {
                margin-bottom: 20px;
            }

            .store-info h3 {
                color: var(--secondary);
                margin-bottom: 10px;
            }

            .address-list {
                list-style: none;
            }

            .address-item {
                margin-bottom: 5px;
                display: flex;
                align-items: flex-start;
                gap: 10px;
            }

            .address-item i {
                color: var(--primary);
                margin-top: 5px;
            }

            .tabs {
                margin-top: 40px;
                border-bottom: 1px solid #ddd;
            }

            .tab-buttons {
                display: flex;
                gap: 20px;
            }

            .tab-btn {
                padding: 10px 20px;
                background: none;
                border: none;
                border-bottom: 3px solid transparent;
                cursor: pointer;
                font-weight: bold;
            }

            .tab-btn.active {
                border-bottom: 3px solid var(--primary);
                color: var(--primary);
            }

            .tab-content {
                padding: 20px 0;
            }

            .product-details p {
                margin-bottom: 10px;
            }
            /* Pop-up styles */
            .popup {
                display: none;
                position: fixed;
                z-index: 999;
                left: 0;
                top: 0;
                width: 100%;
                height: 100%;
                background-color: rgba(0,0,0,0.5);
                overflow: auto;
            }

            .popup-content {
                background-color: var(--white);
                margin: 15% auto;
                padding: 20px;
                border: 1px solid #888;
                width: 300px;
                border-radius: 5px;
                position: relative;
            }

            .close {
                position: absolute;
                right: 10px;
                top: 10px;
                font-size: 28px;
                font-weight: bold;
                cursor: pointer;
            }

            .popup select {
                width: 100%;
                padding: 10px;
                margin: 15px 0;
                border: 1px solid #ddd;
                border-radius: 5px;
            }

            .popup button {
                width: 100%;
                padding: 10px;
                background-color: var(--secondary);
                color: var(--white);
                border: none;
                border-radius: 5px;
                cursor: pointer;
            }

            .thumbnail {
                width: 80px;
                height: 80px;
                cursor: pointer;
                border: 2px solid transparent;
                transition: 0.3s;
            }

            .thumbnail:hover, .active-thumbnail {
                border: 2px solid red;
                transform: scale(1.1);
            }

            .comments-section {
                background: #f8f9fa;
                padding: 20px;
                border-radius: 8px;
                max-width: 700px;
                margin: auto;
            }

            .comments-title {
                font-size: 20px;
                font-weight: bold;
                color: #333;
                margin-bottom: 15px;
            }

            .no-comments {
                text-align: center;
                color: #777;
                font-style: italic;
            }

            .comments-list {
                margin-bottom: 20px;
            }

            .comment-item {
                background: #fff;
                padding: 12px;
                margin-bottom: 10px;
                border-radius: 5px;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            }

            .comment-header {
                display: flex;
                justify-content: space-between;
                font-size: 14px;
                font-weight: bold;
                color: #555;
            }

            .comment-content {
                margin-top: 8px;
                font-size: 15px;
                color: #333;
            }

            .comment-form {
                margin-top: 20px;
            }

            .comment-input {
                width: 100%;
                height: 80px;
                border-radius: 5px;
                border: 1px solid #ddd;
                padding: 10px;
                font-size: 14px;
            }

            .comment-submit {
                margin-top: 10px;
                width: 100%;
                background: #007bff;
                color: white;
                border: none;
                padding: 8px;
                border-radius: 5px;
                cursor: pointer;
                font-size: 15px;
            }

            .comment-submit:hover {
                background: #0056b3;
            }

            .buy-buttons-flex {
                display: flex;
                gap: 10px;
                flex-direction: row;
            }

            @media (max-width: 768px) {
                .service-item {
                    width: 33%;
                    margin-bottom: 20px;
                }

                .product-main {
                    flex-direction: column;
                }

                .product-gallery, .product-info {
                    width: 100%;
                }
            }
        </style>
    </head>
    <body>
        <jsp:include page="header.jsp" /> 
        <header>
            <div class="container">
                <img src="/api/placeholder/200/60" alt="Gấu Bông Online" class="logo">
            </div>
        </header>

        <main class="container" style="margin-top: 150px;">
            <section class="services">
                <div class="service-item">
                    <img src="https://gaubongonline.vn/wp-content/uploads/2017/08/Asset-2.png" alt="Giao hàng" />
                    <p>GIAO HÀNG TẬN NHÀ</p>
                </div>
                <div class="service-item">
                    <img src="https://gaubongonline.vn/wp-content/uploads/2017/08/Asset-3.png" alt="Bọc quà" />
                    <p>BỌC QUÀ GIÁ RẺ</p>
                </div>
                <div class="service-item">
                    <img src="https://gaubongonline.vn/wp-content/uploads/2017/08/Asset-4.png" alt="Tặng thiệp" />
                    <p>TẶNG THIỆP MIỄN PHÍ</p>
                </div>
                <div class="service-item">
                    <img src="https://gaubongonline.vn/wp-content/uploads/2017/08/Asset-5.png" alt="Giặt gấu bông" />
                    <p>GIẶT GẤU BÔNG</p>
                </div>
                <div class="service-item">
                    <img src="https://gaubongonline.vn/wp-content/uploads/2017/08/Asset-1.png" alt="Nén nhỏ gấu" />
                    <p>NÉN NHỎ GẤU</p>
                </div>
            </section>

            <section class="product-main">
                <div class="product-gallery">
                    <div class="main_images">
                        <img id="mainImage" src="${contextPath}/${thumbnail}" alt="${product.name}">
                    </div>
                    <div class="thumbnail-container">
                        <a href="javascript:void(0);" onclick="changeImage('${contextPath}/${thumbnail}', this)">
                            <img src="${contextPath}/${thumbnail}" alt="${product.name}" class="thumbnail active-thumbnail">
                        </a>
                        <c:forEach var="image" items="${product.images}">
                            <a href="javascript:void(0);" onclick="changeImage('${contextPath}/${image.source}', this)">
                                <img src="${contextPath}/${image.source}" alt="${product.name}" class="thumbnail">
                            </a>
                        </c:forEach> 
                    </div>
                </div>

                <div class="product-info">
                    <h1 class="product-title">${product.name}</h1>

                    <table class="price-table">
                        <thead>
                            <tr>
                                <th>Kích thước</th>
                                <th>Giá bán</th>
                                <th>Trạng thái</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="size" items="${product.sizes}">
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
                            </c:forEach> 
                        </tbody>
                    </table>

                    <div class="price" id="selectedPrice">${product.sizes[0].price}đ</div>

                    <div class="size-options">
                        <c:forEach var="size" items="${product.sizes}" varStatus="loop">
                            <button  onclick="selectSize('${size.price}', this)" class="size-btn ${loop.first ? 'active-size' : ''}">${size.name}</button>
                        </c:forEach>
                    </div>

                    <div class="buy-buttons buy-buttons-flex">
                        <button id="buyButton" class="buy-now">THÊM VÀO GIỎ HÀNG</button>
                        <button id="buyButton2" class="quick-order">MUA NGAY</button>
                    </div>
                    <div class="benefits">
                        <div class="benefit-item">
                            <span>✓</span>
                            <p>100% bông trắng tinh khiết</p>
                        </div>
                        <div class="benefit-item">
                            <span>✓</span>
                            <p>100% ảnh chụp tại shop</p>
                        </div>
                        <div class="benefit-item">
                            <span>✓</span>
                            <p>Bảo hành đường chỉ trọn đời</p>
                        </div>
                        <div class="benefit-item">
                            <span>✓</span>
                            <p>Bảo hành Bông gấu 6 tháng</p>
                        </div>
                        <div class="benefit-item">
                            <span>✓</span>
                            <p>Miễn phí Gói quà</p>
                        </div>
                        <div class="benefit-item">
                            <span>✓</span>
                            <p>Miễn phí Tặng thiệp</p>
                        </div>
                        <div class="benefit-item">
                            <span>✓</span>
                            <p>Miễn phí Nén chân không gấu</p>
                        </div>
                    </div>

                    <div class="store-info">
                        <h3>HÀ NỘI | 8:30 - 23:00</h3>
                        <ul class="address-list">
                            <li class="address-item">
                                <i>📍</i>
                                <p>275 Bạch Mai, Hai Bà Trưng, Hà Nội - 0979896616</p>
                            </li>
                        </ul>
                    </div>
                </div>
            </section>

            <section class="tabs">
                <div class="tab-buttons">
                    <button class="tab-btn active" data-tab="product-info">THÔNG TIN SẢN PHẨM</button>
                    <button class="tab-btn" data-tab="purchase-guide">HƯỚNG DẪN MUA HÀNG</button>
                    <button class="tab-btn" data-tab="warranty">BẢO HÀNH</button>
                    <button class="tab-btn" data-tab="comments">BÌNH LUẬN</button>
                </div>

                <div class="tab-content">
                    <div class="tab-pane active" id="product-info">
                        <div class="product-details">
                            ${product.description}
                        </div>
                    </div>

                    <div class="tab-pane" id="purchase-guide">
                        <div class="product-details">
                            ${product.purchaseGuide}
                        </div>
                    </div>

                    <div class="tab-pane" id="warranty">
                        <div class="product-details">
                            ${product.warrantyInfo}
                        </div>
                    </div>
                    <div class="tab-pane" id="comments">


                        <div class="comments-section">
                            <h3 class="comments-title">💬 Bình luận về sản phẩm</h3>

                            <div class="comments-list">
                                <c:if test="${empty product.comments}">
                                    <p class="no-comments">Chưa có bình luận nào. Hãy là người đầu tiên bình luận!</p>
                                </c:if>

                                <c:forEach var="comment" items="${product.comments}">
                                    <div class="comment-item">
                                        <div class="comment-header">
                                            <span class="comment-username">🧑 ${comment.username}</span>
                                            <span class="comment-date">${comment.createdAt}</span>
                                        </div>
                                        <p class="comment-content">${comment.content}</p>
                                    </div>
                                </c:forEach>
                            </div>

                            <div class="comment-form">
                                <h4>✍️ Viết bình luận</h4>
                                <form action="CommentController" method="post">
                                    <input type="hidden" name="productId" value="${product.id}">
                                    <textarea name="content" class="comment-input" placeholder="Nhập bình luận của bạn..." required></textarea>
                                    <button type="submit" class="comment-submit">Gửi</button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </section>

            <style>
                .tab-buttons {
                    display: flex;
                    gap: 10px;
                    margin-bottom: 15px;
                }

                .tab-btn {
                    padding: 10px 20px;
                    border: none;
                    cursor: pointer;
                    transition: 0.3s;
                }

                .tab-btn.active {
                    background: var(--secondary);
                    color: white;
                }

                .tab-pane {
                    display: none;
                }

                .tab-pane.active {
                    display: block;
                }
            </style>

            <script>
                document.addEventListener("DOMContentLoaded", function () {
                    const buttons = document.querySelectorAll(".tab-btn");
                    const contents = document.querySelectorAll(".tab-pane");

                    buttons.forEach(button => {
                        button.addEventListener("click", function () {

                            buttons.forEach(btn => btn.classList.remove("active"));
                            this.classList.add("active");

                            contents.forEach(content => content.classList.remove("active"));

                            const targetId = this.getAttribute("data-tab");
                            document.getElementById(targetId).classList.add("active");
                        });
                    });
                });
            </script>

            <div id="sizePopup" class="popup">
                <div class="popup-content">
                    <span class="close">&times;</span>
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
                    <span class="close">&times;</span>
                    <h2>Chọn kích cỡ sản phẩm</h2>
                    <select id="productSize2" name="size">
                        <c:forEach var="size" items="${product.sizes}">
                            <option value="${size.name}">${size.name}</option>
                        </c:forEach> 
                    </select>
                    <button id="buyNow">Mua Ngay</button>
                </div>
            </div>
        </main>
        <script>
            function selectSize(price, element) {
                document.getElementById("selectedPrice").textContent = price + "đ";
                document.querySelectorAll(".size-btn").forEach(btn => btn.classList.remove("active-size"));
                element.classList.add("active-size");
            }
        </script>

        <script>
            function changeImage(imageSrc, element) {
                document.getElementById("mainImage").src = imageSrc;
                document.querySelectorAll(".thumbnail").forEach(img => img.classList.remove("active-thumbnail"));
                element.querySelector("img").classList.add("active-thumbnail");
            }
        </script>

        <script>

            // Get elements
            var buyButton = document.getElementById("buyButton");
            var buyButton2 = document.getElementById("buyButton2");
            var sizePopup = document.getElementById("sizePopup");
            var sizePopup2 = document.getElementById("sizePopup2");
            var closeButtons = document.getElementsByClassName("close");
            var addToCart = document.getElementById("addToCart");
            var buyNow = document.getElementById("buyNow");

            // Show popup when clicking "Add to Cart" button
            buyButton.onclick = function () {
                sizePopup.style.display = "block";
            }

            // Show popup when clicking "Buy Now" button
            buyButton2.onclick = function () {
                sizePopup2.style.display = "block";
            }

            // Close popups when clicking on X
            for (var i = 0; i < closeButtons.length; i++) {
                closeButtons[i].onclick = function () {
                    sizePopup.style.display = "none";
                    sizePopup2.style.display = "none";
                }
            }

            // Close popups when clicking outside
            window.onclick = function (event) {
                if (event.target == sizePopup) {
                    sizePopup.style.display = "none";
                } else if (event.target == sizePopup2) {
                    sizePopup2.style.display = "none";
                }
            }

            // Tab functionality
            var tabButtons = document.getElementsByClassName("tab-btn");
            for (var i = 0; i < tabButtons.length; i++) {
                tabButtons[i].addEventListener("click", function () {
                    // Remove active class from all buttons
                    for (var j = 0; j < tabButtons.length; j++) {
                        tabButtons[j].classList.remove("active");
                    }
                    // Add active class to clicked button
                    this.classList.add("active");
                });
            }
        </script>
        <footer style="margin-top: 151px;">
            <jsp:include page="../jsp/footer.jsp" /> 
        </footer>

