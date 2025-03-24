<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Order Details #${order.id}</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
    <link rel="stylesheet" href="${contextPath}/css/style.css">
</head>
<body>
    <div class="wrap">
        <jsp:include page="header.jsp" />

        <div class="container" style="margin-top: 160px; min-height: 500px;">
            <div class="row justify-content-center">
                <div class="col-md-10">
                    <div class="card">
                        <div class="card-header bg-primary text-white">
                            <h4 class="mb-0">Order #${order.id} Details</h4>
                            <a href="${contextPath}/guest-order" class="btn btn-light btn-sm float-right">Track Another Order</a>
                        </div>
                        <div class="card-body">
                            <div class="row mb-4">
                                <div class="col-md-6">
                                    <h5>Order Information</h5>
                                    <p><strong>Order Date:</strong> <fmt:formatDate value="${order.orderDate}" pattern="yyyy-MM-dd HH:mm" /></p>
                                    <c:if test="${order.arrivedAt != null}">
                                        <p><strong>Shipping Date:</strong> <fmt:formatDate value="${order.arrivedAt}" pattern="yyyy-MM-dd HH:mm" /></p>
                                    </c:if>
                                    <p><strong>Status:</strong> 
                                        <c:choose>
                                            <c:when test="${order.status == 0}">
                                                <span class="badge badge-warning">Pending</span>
                                            </c:when>
                                            <c:when test="${order.status == 1}">
                                                <span class="badge badge-info">Shipping</span>
                                            </c:when>
                                            <c:when test="${order.status == 2}">
                                                <span class="badge badge-success">Delivered</span>
                                            </c:when>
                                            <c:when test="${order.status == 3}">
                                                <span class="badge badge-danger">Cancelled</span>
                                            </c:when>
                                        </c:choose>
                                    </p>
                                </div>
                                <div class="col-md-6">
                                    <h5>Shipping Information</h5>
                                    <p><strong>Customer:</strong> ${order.user.userName}</p>
                                    <p><strong>Shipping Address:</strong> ${order.address != null ? order.address : order.user.location}</p>
                                </div>
                            </div>
                            
                            <h5>Ordered Products</h5>
                            <div class="table-responsive">
                                <table class="table table-bordered table-striped">
                                    <thead>
                                        <tr>
                                            <th>Product</th>
                                            <th>Image</th>
                                            <th>Price</th>
                                            <th>Quantity</th>
                                            <th>Subtotal</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="detail" items="${order.details}">
                                            <tr>
                                                <td>${detail.product.name}</td>
                                                <td>
                                                    <c:if test="${not empty detail.product.images}">
                                                        <img src="${detail.product.images[0].source}" alt="${detail.product.name}" 
                                                             style="max-width: 50px; max-height: 50px;">
                                                    </c:if>
                                                </td>
                                                <td><fmt:formatNumber value="${detail.product.sizes[0].price}" type="currency" currencySymbol="₫" maxFractionDigits="0"/></td>
                                                <td>${detail.quantity}</td>
                                                <td><fmt:formatNumber value="${detail.product.sizes[0].price * detail.quantity}" type="currency" currencySymbol="₫" maxFractionDigits="0"/></td>
                                            </tr>
                                        </c:forEach>
                                        <tr>
                                            <td colspan="4" class="text-right"><strong>Total:</strong></td>
                                            <td><fmt:formatNumber value="${order.totalCost}" type="currency" currencySymbol="₫" maxFractionDigits="0"/></td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <footer>
            <jsp:include page="footer.jsp" />
        </footer>
    </div>
    
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
</body>
</html>
