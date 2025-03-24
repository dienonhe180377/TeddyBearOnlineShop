<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Orders Management</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
        <link rel="stylesheet" href="${contextPath}/css/style.css">
    </head>
    <body>
        <div class="wrap">
            <c:if test="${user.role.id == 1 or user.role.id == 3}">
                <jsp:include page="./header.jsp" />
            </c:if>
            <c:if test="${user.role.id != 1 or user.role.id != 3}">
                <jsp:include page="../gui/header.jsp" />
                <jsp:include page="../gui/sidebar.jsp"/>
            </c:if>

            <div class="main" style="margin-top: 126px;">
                <c:if test="${not empty sessionScope.notification}">
                    <div class="alert alert-success alert-dismissible fade show" role="alert" style="text-align: center">
                        ${sessionScope.notification}
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                    <c:remove var="notification" scope="session" />
                </c:if>

                <c:if test="${not empty sessionScope.notificationErr}">
                    <div class="alert alert-danger alert-dismissible fade show" role="alert" style="text-align: center">
                        ${sessionScope.notificationErr}
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                    <c:remove var="notificationErr" scope="session" />
                </c:if>

                <div class="container mt-4">
                    <div class="row">
                        <div class="col-md-12">
                            <h2>Orders Management</h2>

                            <!-- Search form -->
                            <div class="card mb-4">
                                <div class="card-body">
                                    <form action="${contextPath}/orders" method="get" class="form-inline">
                                        <div class="form-group mb-2">
                                            <label for="search" class="sr-only">Search</label>
                                            <input type="text" class="form-control" id="search" name="search" 
                                                   placeholder="Search by product name or order ID" value="${search}">
                                        </div>
                                        <button type="submit" class="btn btn-primary mb-2 ml-2">Search</button>
                                    </form>
                                </div>
                            </div>

                            <!-- Add New Order button for Seller and Marketing -->
                            <c:if test="${userRole eq 'seller' || userRole eq 'marketing'}">
                                <div class="mb-3">
                                    <a href="${contextPath}/new-order" class="btn btn-success">Add New Order</a>
                                </div>
                            </c:if>

                            <!-- Orders table -->
                            <div class="card">
                                <div class="card-body">
                                    <c:choose>
                                        <c:when test="${empty orders}">
                                            <div class="alert alert-info">No orders found.</div>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="table-responsive">
                                                <table class="table table-bordered table-hover">
                                                    <thead class="thead-dark">
                                                        <tr>
                                                            <th>Order ID</th>
                                                            <th>Date</th>
                                                            <th>Customer</th>
                                                            <th>Total Cost</th>
                                                            <th>Status</th>
                                                            <th>Actions</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <c:forEach var="order" items="${orders}">
                                                            <tr>
                                                                <td>${order.id}</td>
                                                                <td><fmt:formatDate value="${order.orderDate}" pattern="yyyy-MM-dd HH:mm" /></td>
                                                                <td>${order.user.userName}</td>
                                                                <td><fmt:formatNumber value="${order.totalCost}" type="currency" currencySymbol="₫" maxFractionDigits="0"/></td>
                                                                <td>
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
                                                                </td>
                                                                <td>
                                                                    <a href="${contextPath}/order-detail?id=${order.id}" class="btn btn-sm btn-info">View</a>

                                                                    <!-- Cancel button for pending orders -->
                                                                    <c:if test="${order.status == 0 && (userRole eq 'manager' || userRole eq 'seller' || userRole eq 'customer')}">
                                                                        <form style="display:inline;" action="${contextPath}/orders" method="post" 
                                                                              onsubmit="return confirm('Are you sure you want to cancel this order?')">
                                                                            <input type="hidden" name="action" value="cancel-order">
                                                                            <input type="hidden" name="orderId" value="${order.id}">
                                                                            <button type="submit" class="btn btn-sm btn-danger">Cancel</button>
                                                                        </form>
                                                                    </c:if>
                                                                </td>
                                                            </tr>
                                                        </c:forEach>
                                                    </tbody>
                                                </table>
                                            </div>

                                            <!-- Pagination -->
                                            <nav aria-label="Page navigation">
                                                <ul class="pagination justify-content-center">
                                                    <c:if test="${currentPage > 1}">
                                                        <li class="page-item">
                                                            <a class="page-link" href="${contextPath}/orders?page=${currentPage - 1}&search=${search}" aria-label="Previous">
                                                                <span aria-hidden="true">&laquo;</span>
                                                            </a>
                                                        </li>
                                                    </c:if>

                                                    <c:forEach begin="1" end="${totalPages}" var="i">
                                                        <li class="page-item ${currentPage == i ? 'active' : ''}">
                                                            <a class="page-link" href="${contextPath}/orders?page=${i}&search=${search}">${i}</a>
                                                        </li>
                                                    </c:forEach>

                                                    <c:if test="${currentPage < totalPages}">
                                                        <li class="page-item">
                                                            <a class="page-link" href="${contextPath}/orders?page=${currentPage + 1}&search=${search}" aria-label="Next">
                                                                <span aria-hidden="true">&raquo;</span>
                                                            </a>
                                                        </li>
                                                    </c:if>
                                                </ul>
                                            </nav>
                                        </c:otherwise>
                                    </c:choose>
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
    </body>
</html>
