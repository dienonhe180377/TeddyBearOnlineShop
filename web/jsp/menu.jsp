<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>

    <head>
        <title>Product Browsing</title>
        <link rel="stylesheet" href="../css/menu.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css">
    </head>

    <body>
        <div>
            <h1 class="category-title">Gấu bông cỡ lớn</h1>
            <div class="container swiper">
                <div class="card-wrapper">
                    <ul class="card-list swiper-wrapper">
                        <c:forEach var="product" items="">
                            <li class="card-item swiper-slide">
                                <a href="MenuController?service=productInformation" class="card-link" name="productDetail">
                                    <img src="" alt="Card Image" class="card-image">
                                    <p class="badge">Designer</p>
                                    <h2 class="card-title">Lorem ipsum dolor, sit amet consectetur adipisicing elit.</h2>
                                    <button class="fa-solid fa-arrow-right card-button"></button>
                                </a>
                            </li>   
                        </c:forEach>
                    </ul>
                    <div class="swiper-pagination"></div>
                    <div class="swiper-button-prev"></div>
                    <div class="swiper-button-next"></div>
                </div>
            </div>

            <div class="view-all-button-container">
                <button class="view-all-button">Xem tất cả</button>
            </div>

        </div>

        <!-- Linking SwiperJS script -->
        <script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>
        <script src="../js/menu.js"></script>
    </body>

</html>