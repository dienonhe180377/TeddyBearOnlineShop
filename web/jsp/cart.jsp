<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Giỏ hàng của bạn</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">
    <!-- Custom styles -->
    <link rel="stylesheet" type="text/css" href="${contextPath}/css/allProductBootstrap.css">
    <link rel="stylesheet" type="text/css" href="${contextPath}/css/allProduct.css">
    <link rel="stylesheet" type="text/css" href="${contextPath}/css/allProductResponsive.css">
    <style>
        :root {
            --primary-color: #3d5a80;
            --secondary-color: #ee6c4d;
            --light-color: #f8f9fa;
            --dark-color: #293241;
            --success-color: #52b788;
            --danger-color: #e63946;
        }
        
        body {
            font-family: 'Roboto', sans-serif;
            background-color: #f8f9fa;
            color: #333;
        }
        
        .cart-section {
            padding: 60px 0;
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.05);
            margin: 30px auto;
        }
        
        .section-heading {
            position: relative;
            margin-bottom: 30px;
            color: var(--primary-color);
            font-weight: 700;
        }
        
        .section-heading:after {
            content: '';
            display: block;
            width: 80px;
            height: 3px;
            background-color: var(--secondary-color);
            margin: 15px auto 0;
        }
        
        .cart-table {
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.03);
            margin-bottom: 30px;
        }
        
        .cart-table thead {
            background-color: var(--primary-color);
            color: white;
        }
        
        .cart-table th {
            font-weight: 500;
            text-transform: uppercase;
            font-size: 0.85rem;
            letter-spacing: 0.5px;
            padding: 15px;
            vertical-align: middle;
        }
        
        .cart-table td {
            vertical-align: middle;
            padding: 15px;
        }
        
        .cart-table img {
            max-width: 80px;
            height: auto;
            border-radius: 6px;
            box-shadow: 0 3px 6px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease;
        }
        
        .cart-table img:hover {
            transform: scale(1.1);
        }
        
        .product-name {
            font-weight: 500;
            color: var(--dark-color);
            margin-bottom: 5px;
        }
        
        .product-size {
            font-size: 0.85rem;
            color: #6c757d;
        }
        
        .product-price {
            font-weight: 600;
            color: var(--primary-color);
        }
        
        .total-price {
            font-weight: 700;
            color: var(--secondary-color);
            font-size: 1.1rem;
        }
        
        .quantity-control {
            display: flex;
            align-items: center;
            justify-content: center;
            border: 1px solid #dee2e6;
            border-radius: 30px;
            padding: 2px;
            width: fit-content;
            margin: 0 auto;
        }
        
        .quantity-btn {
            width: 30px;
            height: 30px;
            border-radius: 50%;
            border: none;
            background-color: #f8f9fa;
            color: #6c757d;
            font-size: 1rem;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            transition: all 0.2s;
        }
        
        .quantity-btn:hover {
            background-color: var(--primary-color);
            color: white;
        }
        
        .quantity-input {
            width: 40px;
            border: none;
            text-align: center;
            font-weight: 600;
            background: transparent;
        }
        
        .quantity-input:focus {
            outline: none;
        }
        
        .remove-btn {
            background-color: #f8d7da;
            color: var(--danger-color);
            border: none;
            border-radius: 50%;
            width: 36px;
            height: 36px;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: all 0.2s;
        }
        
        .remove-btn:hover {
            background-color: var(--danger-color);
            color: white;
        }
        
        .cart-footer {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: 20px;
            flex-wrap: wrap;
            gap: 15px;
        }
        
        .continue-shopping {
            background-color: var(--primary-color);
            color: white;
            border: none;
            border-radius: 30px;
            padding: 10px 25px;
            font-weight: 500;
            transition: all 0.3s;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }
        
        .continue-shopping:hover {
            background-color: var(--dark-color);
            transform: translateY(-2px);
        }
        
        .checkout-btn {
            background-color: var(--success-color);
            color: white;
            border: none;
            border-radius: 30px;
            padding: 12px 30px;
            font-weight: 500;
            transition: all 0.3s;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }
        
        .checkout-btn:hover {
            background-color: #3a9679;
            transform: translateY(-2px);
        }
        
        .checkout-btn:disabled {
            background-color: #adb5bd;
            cursor: not-allowed;
            transform: none;
        }
        
        .empty-cart {
            text-align: center;
            padding: 40px 20px;
        }
        
        .empty-cart-icon {
            font-size: 5rem;
            color: #dee2e6;
            margin-bottom: 20px;
        }
        
        .empty-cart-message {
            font-size: 1.2rem;
            color: #6c757d;
            margin-bottom: 30px;
        }
        
        .alert {
            border-radius: 8px;
            border: none;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
        }
        
        .alert-success {
            background-color: #d1e7dd;
            color: #0f5132;
        }
        
        .alert-danger {
            background-color: #f8d7da;
            color: #842029;
        }
        
        @media (max-width: 768px) {
            .cart-table {
                font-size: 0.9rem;
            }
            
            .cart-table th, .cart-table td {
                padding: 10px;
            }
            
            .section-heading {
                font-size: 1.5rem;
            }
            
            .cart-footer {
                flex-direction: column;
                align-items: stretch;
            }
            
            .continue-shopping, .checkout-btn {
                width: 100%;
                justify-content: center;
            }
        }
    </style>
</head>
<body>
    <jsp:include page="header.jsp" />
    
    <div class="container cart-section">
        <div class="row justify-content-center">
            <div class="col-lg-10">
                <h2 class="text-center section-heading">Giỏ hàng của bạn</h2>
                
                <!-- Notifications -->
                <c:if test="${not empty sessionScope.notification}">
                    <div class="alert alert-success alert-dismissible fade show mb-4" role="alert">
                        <i class="fas fa-check-circle me-2"></i> ${sessionScope.notification}
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                    <% session.removeAttribute("notification"); %>
                </c:if>
                
                <c:if test="${not empty sessionScope.notificationErr}">
                    <div class="alert alert-danger alert-dismissible fade show mb-4" role="alert">
                        <i class="fas fa-exclamation-circle me-2"></i> ${sessionScope.notificationErr}
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                    <% session.removeAttribute("notificationErr"); %>
                </c:if>
                
                <!-- Cart Content -->
                <c:choose>
                    <c:when test="${empty cart}">
                        <div class="empty-cart">
                            <div class="empty-cart-icon">
                                <i class="fas fa-shopping-cart"></i>
                            </div>
                            <h3 class="empty-cart-message">Giỏ hàng của bạn đang trống</h3>
                            <a href="${contextPath}/MenuController?service=productInformation" class="continue-shopping">
                                <i class="fas fa-arrow-left"></i> Tiếp tục mua sắm
                            </a>
                        </div>
                    </c:when>
                    
                    <c:otherwise>
                        <div class="table-responsive">
                            <table class="table cart-table">
                                <thead>
                                    <tr>
                                        <th width="5%">STT</th>
                                        <th width="15%">Ảnh</th>
                                        <th width="25%">Sản phẩm</th>
                                        <th width="10%">Kích cỡ</th>
                                        <th width="15%">Đơn giá</th>
                                        <th width="15%">Số lượng</th>
                                        <th width="15%">Tổng tiền</th>
                                        <th width="5%"></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="c" items="${cart}" varStatus="status">
                                        <tr>
                                            <td class="text-center">${status.index + 1}</td>
                                            <td class="text-center">
                                                <img src="${c.product.images[0].source}" alt="${c.product.name}" class="img-fluid">
                                            </td>
                                            <td>
                                                <div class="product-name">${c.product.name}</div>
                                            </td>
                                            <td class="text-center">
                                                <span class="product-size">${c.size.name}</span>
                                            </td>
                                            <td class="text-center">
                                                <span class="product-price"><fmt:formatNumber value="${c.size.price}" pattern="#,###" />đ</span>
                                            </td>
                                            <td>
                                                <form action="cart" method="post" class="quantity-form">
                                                    <input type="hidden" name="action" value="update">
                                                    <input type="hidden" name="index" value="${status.index}">
                                                    <div class="quantity-control">
                                                        <button type="button" class="quantity-btn minus-btn">
                                                            <i class="fas fa-minus"></i>
                                                        </button>
                                                        <input type="text" name="quantity" value="${c.quantity}" min="1" class="quantity-input" readonly>
                                                        <button type="button" class="quantity-btn plus-btn">
                                                            <i class="fas fa-plus"></i>
                                                        </button>
                                                    </div>
                                                </form>
                                            </td>
                                            <td class="text-center">
                                                <span class="total-price"><fmt:formatNumber value="${c.getTotalPrice()}" pattern="#,###" />đ</span>
                                            </td>
                                            <td>
                                                <form action="cart" method="post" onsubmit="return confirm('Bạn có chắc muốn xóa sản phẩm này khỏi giỏ hàng?');">
                                                    <input type="hidden" name="action" value="remove">
                                                    <input type="hidden" name="index" value="${status.index}">
                                                    <button type="submit" class="remove-btn" title="Xóa sản phẩm">
                                                        <i class="fas fa-trash-alt"></i>
                                                    </button>
                                                </form>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                        
                        <!-- Cart Summary -->
                        <div class="row mt-4">
                            <div class="col-md-6 offset-md-6">
                                <div class="card">
                                    <div class="card-body">
                                        <h5 class="card-title mb-3">Tổng giỏ hàng</h5>
                                        <div class="d-flex justify-content-between mb-2">
                                            <span>Tổng sản phẩm:</span>
                                            <span>${cartCount} sản phẩm</span>
                                        </div>
                                        <div class="d-flex justify-content-between mb-2">
                                            <span>Tạm tính:</span>
                                            <span class="fw-bold">
                                                <c:set var="total" value="0" />
                                                <c:forEach var="item" items="${cart}">
                                                    <c:set var="total" value="${total + item.getTotalPrice()}" />
                                                </c:forEach>
                                                <fmt:formatNumber value="${total}" pattern="#,###" />đ
                                            </span>
                                        </div>
                                        <hr>
                                        <div class="d-flex justify-content-between mb-3">
                                            <span class="fw-bold">Tổng cộng:</span>
                                            <span class="fw-bold fs-5 text-danger">
                                                <fmt:formatNumber value="${total}" pattern="#,###" />đ
                                            </span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Cart Footer -->
                        <div class="cart-footer">
                            <a href="${contextPath}/MenuController?service=productInformation" class="continue-shopping">
                                <i class="fas fa-arrow-left"></i> Tiếp tục mua sắm
                            </a>
                            
                            <c:if test="${cartCount > 0}">
                                <a href="${contextPath}/checkout" class="checkout-btn">
                                    Tiến hành thanh toán <i class="fas fa-arrow-right"></i>
                                </a>
                            </c:if>
                            
                            <c:if test="${cartCount eq 0}">
                                <button class="checkout-btn" disabled>
                                    Tiến hành thanh toán <i class="fas fa-arrow-right"></i>
                                </button>
                            </c:if>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
    
    <jsp:include page="footer.jsp" />
    
    <!-- Bootstrap Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    
    <script>
        document.addEventListener("DOMContentLoaded", function () {
            // Quantity control
            document.querySelectorAll(".quantity-form").forEach(function (form) {
                const minusBtn = form.querySelector(".minus-btn");
                const plusBtn = form.querySelector(".plus-btn");
                const qtyInput = form.querySelector('input[name="quantity"]');

                minusBtn.addEventListener("click", function () {
                    const currentVal = parseInt(qtyInput.value) || 1;
                    if (currentVal > 1) {
                        qtyInput.value = currentVal - 1;
                        form.submit();
                    }
                });

                plusBtn.addEventListener("click", function () {
                    const currentVal = parseInt(qtyInput.value) || 1;
                    qtyInput.value = currentVal + 1;
                    form.submit();
                });
            });
            
            // Auto-dismiss alerts after 5 seconds
            setTimeout(function() {
                const alerts = document.querySelectorAll('.alert');
                alerts.forEach(function(alert) {
                    const bsAlert = new bootstrap.Alert(alert);
                    bsAlert.close();
                });
            }, 5000);
        });
    </script>
</body>
</html>
