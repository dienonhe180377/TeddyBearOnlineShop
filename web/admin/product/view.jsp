<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>View Product</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-5">
        <div class="row mb-3">
            <div class="col">
                <h2>Product Details</h2>
            </div>
            <div class="col text-end">
                <a href="<c:url value='/product-manage?action=list'/>" class="btn btn-secondary">Back to List</a>
                <a href="<c:url value='/product-manage?action=edit&id=${product.id}'/>" class="btn btn-warning">Edit</a>
                <a href="<c:url value='/product-manage?action=delete&id=${product.id}'/>" class="btn btn-danger" onclick="return confirm('Are you sure you want to delete this product?')">Delete</a>
            </div>
        </div>
        
        <div class="card">
            <div class="card-body">
                <div class="row">
                    <div class="col-md-6">
                        <div id="productCarousel" class="carousel slide" data-bs-ride="carousel">
                            <div class="carousel-inner">
                                <c:forEach var="image" items="${product.images}" varStatus="loop">
                                    <div class="carousel-item ${loop.index == 0 ? 'active' : ''}">
                                        <img src="<c:url value='/${image.source}'/>" class="d-block w-100" alt="${product.name}">
                                    </div>
                                </c:forEach>
                            </div>
                            <c:if test="${product.images.size() > 1}">
                                <button class="carousel-control-prev" type="button" data-bs-target="#productCarousel" data-bs-slide="prev">
                                    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                                    <span class="visually-hidden">Previous</span>
                                </button>
                                 <button class="carousel-control-next" type="button" data-bs-target="#productCarousel" data-bs-slide="next">
                                    <span class="carousel-control-next-icon" aria-hidden="true"></span>
                                    <span class="visually-hidden">Next</span>
                                </button>
                            </c:if>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <h3>${product.name}</h3>
                        <p><strong>Category:</strong> ${product.category.name}</p>
                        <p><strong>Type:</strong> ${product.productType.name}</p>
                        
                        <h4 class="mt-4">Available Sizes</h4>
                        <table class="table table-sm">
                            <thead>
                                <tr>
                                    <th>Size</th>
                                    <th>Quantity</th>
                                    <th>Price</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="size" items="${product.sizes}">
                                    <tr>
                                        <td>${size.name}</td>
                                        <td>${size.quantity}</td>
                                        <td>$${size.price}</td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
                
                <div class="row mt-4">
                    <div class="col">
                        <h4>Description</h4>
                        <p>${product.description}</p>
                    </div>
                </div>
                
                <div class="row mt-4">
                    <div class="col-md-6">
                        <div class="card">
                            <div class="card-header">
                                <h5>Purchase Guide</h5>
                            </div>
                            <div class="card-body">
                                <p>${product.purchaseGuide}</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="card">
                            <div class="card-header">
                                <h5>Warranty Information</h5>
                            </div>
                            <div class="card-body">
                                <p>${product.warrantyInfo}</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>