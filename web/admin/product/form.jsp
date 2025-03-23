<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${product != null ? 'Edit' : 'Add'} Product</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body style="margin-top: 115px;">
    
    <jsp:include page="../../gui/header.jsp" />
    <jsp:include page="../../gui/sidebar.jsp" />
    
    <div class="container mt-5">
        <div class="row mb-3">
            <div class="col">
                <h2>${product != null ? 'Edit' : 'Add'} Product</h2>
            </div>
            <div class="col text-end">
                <a href="<c:url value='/product-manage??action=list'/>" class="btn btn-secondary">Back to List</a>
            </div>
        </div>
        
        <div class="card">
            <div class="card-body">
                <form action="<c:url value='/product-manage?action=${product != null ? "update" : "create"}'/>" method="post" enctype="multipart/form-data">
                    <c:if test="${product != null}">
                        <input type="hidden" name="id" value="${product.id}">
                    </c:if>
                    
                    <div class="row mb-3">
                        <div class="col-md-6">
                            <label for="name" class="form-label">Product Name</label>
                            <input type="text" class="form-control" id="name" name="name" value="${product != null ? product.name : ''}" maxlength="25" required>
                        </div>
                        <div class="col-md-3">
                            <label for="categoryId" class="form-label">Category</label>
                            <select class="form-select" id="categoryId" name="categoryId" required>
                                <option value="">Select Category</option>
                                <c:forEach var="category" items="${categories}">
                                    <option value="${category.id}" ${product != null && product.categoryId == category.id ? 'selected' : ''}>${category.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="col-md-3">
                            <label for="typeId" class="form-label">Product Type</label>
                            <select class="form-select" id="typeId" name="typeId" required>
                                <option value="">Select Type</option>
                                <c:forEach var="type" items="${productTypes}">
                                    <option value="${type.id}" ${product != null && product.typeId == type.id ? 'selected' : ''}>${type.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                    
                    <div class="mb-3">
                        <label for="description" class="form-label">Description</label>
                        <textarea class="form-control" id="description" name="description" rows="4">${product != null ? product.description : ''}</textarea>
                    </div>
                    
                    <div class="row mb-3">
                        <div class="col-md-6">
                            <label for="purchaseGuide" class="form-label">Purchase Guide</label>
                            <textarea class="form-control" id="purchaseGuide" name="purchaseGuide" rows="3">${product != null ? product.purchaseGuide : ''}</textarea>
                        </div>
                        <div class="col-md-6">
                            <label for="warrantyInfo" class="form-label">Warranty Information</label>
                            <textarea class="form-control" id="warrantyInfo" name="warrantyInfo" rows="3">${product != null ? product.warrantyInfo : ''}</textarea>
                        </div>
                    </div>
                    
                    <div class="mb-3">
                        <label for="productImage" class="form-label">Product Images</label>
                        <input type="file" class="form-control" id="productImage" name="productImage" multiple>
                        <small class="text-muted">You can select multiple images</small>
                    </div>
                    
                    <c:if test="${product != null && not empty product.images}">
                        <div class="mb-3">
                            <label class="form-label">Current Images</label>
                            <div class="row">
                                <c:forEach var="image" items="${product.images}">
                                    <div class="col-md-2 mb-2">
                                        <img src="<c:url value='/${image.source}'/>" class="img-thumbnail" alt="Product Image">
                                    </div>
                                </c:forEach>
                            </div>
                            <small class="text-muted">Uploading new images will replace the current ones</small>
                        </div>
                    </c:if>
                    
                    <h4 class="mt-4">Product Sizes</h4>
                    <div id="sizeContainer">
                        <c:if test="${product != null && not empty product.sizes}">
                            <c:forEach var="size" items="${product.sizes}" varStatus="loop">
                                <div class="row mb-2 size-row">
                                    <input type="hidden" name="sizeId" value="${size.id}">
                                    <div class="col-md-4">
                                        <input type="text" class="form-control" name="sizeName" placeholder="Size Name" value="${size.name}" required>
                                    </div>
                                    <div class="col-md-3">
                                        <input type="number" class="form-control" name="quantity" placeholder="Quantity" value="${size.quantity}" required>
                                    </div>
                                    <div class="col-md-3">
                                        <input type="number" class="form-control" name="price" placeholder="Price" value="${size.price}" required>
                                    </div>
                                    <div class="col-md-2">
                                        <button type="button" class="btn btn-danger remove-size">Remove</button>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:if>
                        <c:if test="${product == null || empty product.sizes}">
                            <div class="row mb-2 size-row">
                                <div class="col-md-4">
                                    <input type="text" class="form-control" name="sizeName" placeholder="Size Name" required>
                                </div>
                                <div class="col-md-3">
                                    <input type="number" class="form-control" name="quantity" placeholder="Quantity" required>
                                </div>
                                <div class="col-md-3">
                                    <input type="number" class="form-control" name="price" placeholder="Price" required>
                                </div>
                                <div class="col-md-2">
                                    <button type="button" class="btn btn-danger remove-size">Remove</button>
                                </div>
                            </div>
                        </c:if>
                    </div>
                    
                    <button type="button" class="btn btn-info mb-3" id="addSize">Add Size</button>
                    
                    <div class="text-end">
                        <button type="submit" class="btn btn-primary">${product != null ? 'Update' : 'Create'} Product</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Add JavaScript for dynamic size fields
        document.addEventListener('DOMContentLoaded', function() {
            const sizeContainer = document.getElementById('sizeContainer');
            const addSizeBtn = document.getElementById('addSize');
            
            // Add new size row
            addSizeBtn.addEventListener('click', function() {
                const newRow = document.createElement('div');
                newRow.className = 'row mb-2 size-row';
                newRow.innerHTML = `
                    <div class="col-md-4">
                        <input type="text" class="form-control" name="sizeName" placeholder="Size Name" required>
                    </div>
                    <div class="col-md-3">
                        <input type="number" class="form-control" name="quantity" placeholder="Quantity" required>
                    </div>
                    <div class="col-md-3">
                        <input type="number" class="form-control" name="price" placeholder="Price" required>
                    </div>
                    <div class="col-md-2">
                        <button type="button" class="btn btn-danger remove-size">Remove</button>
                    </div>
                `;
                sizeContainer.appendChild(newRow);
                
                // Add event listener to the new remove button
                newRow.querySelector('.remove-size').addEventListener('click', function() {
                    sizeContainer.removeChild(newRow);
                });
            });
            
            // Add event listeners to existing remove buttons
            document.querySelectorAll('.remove-size').forEach(button => {
                button.addEventListener('click', function() {
                    const row = this.closest('.size-row');
                    sizeContainer.removeChild(row);
                });
            });
        });
    </script>
</body>
</html>
