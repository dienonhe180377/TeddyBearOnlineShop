<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Product Management</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body>
        <div class="container mt-5">
            <div class="row mb-3">
                <div class="col">
                    <h2>Product List</h2>
                </div>
                <div class="col text-end">
                    <a href="<c:url value='product-manage?action=new'/>" class="btn btn-primary">Add New Product</a>
                </div>
            </div>

            <table class="table table-striped table-hover">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Image</th>
                        <th>Name</th>
                        <th>Category</th>
                        <th>Type</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="product" items="${products}">
                        <tr>
                            <td>${product.id}</td>
                            <td>
                                <c:if test="${not empty product.images}">
                                    <img src="<c:url value='/${product.images[0].source}'/>" alt="${product.name}" width="50">
                                </c:if>
                            </td>
                            <td>${product.name}</td>
                            <td>${product.category.name}</td>
                            <td>${product.productType.name}</td>
                            <td>
                                <a href="<c:url value='/product-manage?action=view&id=${product.id}'/>" class="btn btn-info btn-sm">View</a>
                                <a href="<c:url value='/product-manage?action=edit&id=${product.id}'/>" class="btn btn-warning btn-sm">Edit</a>
                                <a href="<c:url value='/product-manage?action=delete&id=${product.id}'/>" class="btn btn-danger btn-sm" onclick="return confirm('Are you sure you want to delete this product?')">Delete</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>