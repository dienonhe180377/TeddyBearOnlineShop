<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Order Details</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
    <link rel="stylesheet" href="${contextPath}/css/style.css">
</head>
<body>
    <div class="wrap">
        <jsp:include page="../gui/header.jsp" />
        <jsp:include page="../gui/sidebar.jsp"/>

        <div class="main" style="margin-top: 126px;">
            <div class="container mt-4">
                <div class="row">
                    <div class="col-md-12">
                        <div class="card">
                            <div class="card-header bg-primary text-white">
                                <h3>Order #${order.id} Details</h3>
                                <a href="${contextPath}/orders" class="btn btn-light btn-sm float-right">Back to Orders</a>
                            </div>
                            <div class="card-body">
                                <div class="row mb-4">
                                    <div class="col-md-6">
                                        <h5>Customer Information</h5>
                                        <p><strong>Name:</strong> ${order.user.userName}</p>
                                        <p><strong>Email:</strong> ${order.user.email}</p>
                                        <p><strong>Phone:</strong> ${order.user.phoneNumber}</p>
                                        <p><strong>Shipping Address:</strong> ${order.address != null ? order.address : order.user.location}</p>
                                    </div>
                                    <div class="col-md-6">
                                        <h5>Order Information</h5>
                                        <p><strong>Order Date:</strong> <fmt:formatDate value="${order.orderDate}" pattern="yyyy-MM-dd HH:mm" /></p>
                                        <p><strong>Shipping Date:</strong> 
                                            <c:if test="${order.arrivedAt != null}">
                                                <fmt:formatDate value="${order.arrivedAt}" pattern="yyyy-MM-dd HH:mm" />
                                            </c:if>
                                            <c:if test="${order.arrivedAt == null}">
                                                Not shipped yet
                                            </c:if>
                                        </p>
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
                                        
                                        <!-- Status update buttons for managers and sellers -->
                                        <c:if test="${(userRole eq 'manager' || userRole eq 'seller') && order.status != 3}">
                                            <div class="mt-3">
                                                <c:if test="${order.status == 0}">
                                                    <form action="${contextPath}/orders" method="post" style="display:inline;">
                                                        <input type="hidden" name="action" value="update-status">
                                                        <input type="hidden" name="orderId" value="${order.id}">
                                                        <input type="hidden" name="statusAction" value="accept">
                                                        <button type="submit" class="btn btn-success btn-sm">Accept Order</button>
                                                    </form>
                                                    
                                                    <form action="${contextPath}/orders" method="post" style="display:inline;" 
                                                          onsubmit="return confirm('Are you sure you want to cancel this order?')">
                                                        <input type="hidden" name="action" value="cancel-order">
                                                        <input type="hidden" name="orderId" value="${order.id}">
                                                        <button type="submit" class="btn btn-danger btn-sm">Cancel Order</button>
                                                    </form>
                                                </c:if>
                                                
                                                <c:if test="${order.status == 1}">
                                                    <form action="${contextPath}/orders" method="post">
                                                        <input type="hidden" name="action" value="update-status">
                                                        <input type="hidden" name="orderId" value="${order.id}">
                                                        <input type="hidden" name="statusAction" value="deliver">
                                                        <button type="submit" class="btn btn-primary btn-sm">Mark as Delivered</button>
                                                    </form>
                                                </c:if>
                                            </div>
                                        </c:if>
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
                                                    <td><a href="${contextPath}/MenuController?service=productView&productId=${detail.product.id}">${detail.product.name}</a></td>
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
                                
                                <!-- Order Timeline -->
                                <div class="mt-4">
                                    <h5>Order Timeline</h5>
                                    <div class="timeline">
                                        <div class="timeline-item">
                                            <div class="timeline-marker bg-success"></div>
                                            <div class="timeline-content">
                                                <h6 class="mb-0">Order Placed</h6>
                                                <p class="text-muted"><small><fmt:formatDate value="${order.orderDate}" pattern="yyyy-MM-dd HH:mm" /></small></p>
                                            </div>
                                        </div>
                                        
                                        <c:choose>
                                            <c:when test="${order.status >= 1}">
                                                <div class="timeline-item">
                                                    <div class="timeline-marker bg-info"></div>
                                                    <div class="timeline-content">
                                                        <h6 class="mb-0">Order Accepted</h6>
                                                        <p class="text-muted"><small>Processing for shipment</small></p>
                                                    </div>
                                                </div>
                                            </c:when>
                                            <c:when test="${order.status == 3}">
                                                <div class="timeline-item">
                                                    <div class="timeline-marker bg-danger"></div>
                                                    <div class="timeline-content">
                                                        <h6 class="mb-0">Order Cancelled</h6>
                                                    </div>
                                                </div>
                                            </c:when>
                                        </c:choose>
                                        
                                        <c:if test="${order.status >= 2}">
                                            <div class="timeline-item">
                                                <div class="timeline-marker bg-success"></div>
                                                <div class="timeline-content">
                                                    <h6 class="mb-0">Order Delivered</h6>
                                                    <p class="text-muted">
                                                        <small>
                                                            <c:if test="${order.arrivedAt != null}">
                                                                <fmt:formatDate value="${order.arrivedAt}" pattern="yyyy-MM-dd HH:mm" />
                                                            </c:if>
                                                        </small>
                                                    </p>
                                                </div>
                                            </div>
                                        </c:if>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
            <footer style="margin-top: 143px;">
                <jsp:include page="../gui/footer.jsp" />
            </footer>
        </div>
    </div>
    
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
    
    <style>
        /* Timeline CSS */
        .timeline {
            position: relative;
            padding: 1rem;
            margin: 0 auto;
        }
        .timeline::before {
            content: '';
            position: absolute;
            height: 100%;
            border: 1px solid #e9ecef;
            right: 40px;
            top: 0;
        }
        .timeline-item {
            position: relative;
            margin: 1.5rem 3rem 1.5rem 0;
            clear: both;
        }
        .timeline-marker {
            position: absolute;
            right: -43px;
            border-radius: 50%;
            width: 15px;
            height: 15px;
            line-height: 15px;
            text-align: center;
            z-index: 1;
        }
        .timeline-content {
            position: relative;
            padding: 0 1rem;
            text-align: right;
        }
    </style>
</body>
</html>
