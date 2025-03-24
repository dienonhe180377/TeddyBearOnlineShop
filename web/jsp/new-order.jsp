<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Create New Order</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
        <link rel="stylesheet" href="${contextPath}/css/style.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.13/css/select2.min.css">
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
                                    <h3>Create New Order</h3>
                                    <a href="${contextPath}/orders" class="btn btn-light btn-sm float-right">Back to Orders</a>
                                </div>
                                <div class="card-body">
                                    <form id="newOrderForm" action="${contextPath}/orders" method="post">
                                        <input type="hidden" name="action" value="create-order">

                                        <div class="row">
                                            <!-- Customer Section -->
                                            <div class="col-md-6">
                                                <h5>Customer Information</h5>
                                                <div class="form-group">
                                                    <label for="customerId">Select Customer</label>
                                                    <select class="form-control customer-select" id="customerId" name="customerId" required>
                                                        <option value="">-- Select a Customer --</option>
                                                        <c:forEach var="customer" items="${customers}">
                                                            <option value="${customer.id}">${customer.userName} - ${customer.email}</option>
                                                        </c:forEach>
                                                    </select>
                                                </div>

                                                <div class="form-group">
                                                    <label for="address">Shipping Address</label>
                                                    <textarea class="form-control" id="address" name="address" rows="3" 
                                                              placeholder="Enter shipping address"></textarea>
                                                    <small class="form-text text-muted">Leave blank to use customer's default address.</small>
                                                </div>
                                            </div>

                                            <!-- Order Items Section -->
                                            <div class="col-md-6">
                                                <h5>Order Items</h5>
                                                <div id="orderItems">
                                                    <div class="order-item mb-3 border p-3">
                                                        <div class="form-group">
                                                            <div class="form-group">
                                                                <label>Select Product</label>
                                                                <select class="form-control product-select" name="productId" required>
                                                                    <option value="">-- Select a Product --</option>
                                                                    <c:forEach var="product" items="${products}">
                                                                        <option value="${product.id}">${product.name}</option>
                                                                    </c:forEach>
                                                                </select>
                                                            </div>

                                                            <div class="form-group">
                                                                <label>Select Size</label>
                                                                <select class="form-control size-select" name="sizeId" required disabled>
                                                                    <option value="">-- Select Size --</option>
                                                                </select>
                                                            </div>

                                                        </div>

                                                        <div class="form-group">
                                                            <label>Quantity</label>
                                                            <input type="number" class="form-control quantity-input" name="quantity" 
                                                                   min="1" value="1" required>
                                                        </div>
                                                    </div>
                                                </div>

                                                <button type="button" class="btn btn-secondary" id="addItemButton">
                                                    <i class="fa fa-plus"></i> Add More Items
                                                </button>
                                            </div>
                                        </div>

                                        <hr>

                                        <div class="row">
                                            <div class="col-md-12">
                                                <div class="d-flex justify-content-between">
                                                    <h5>Order Summary</h5>
                                                    <h5>Total: ₫ <span id="totalAmount">0</span></h5>
                                                </div>
                                                <button type="submit" class="btn btn-success btn-lg mt-3">Create Order</button>
                                            </div>
                                        </div>
                                    </form>
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

        <script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.13/js/select2.min.js"></script>

        <script>
            $(document).ready(function () {
                // Initialize Select2
                $('.customer-select, .product-select').select2();

                // Product selection changes - load appropriate sizes
                $(document).on('change', '.product-select', function () {
                    const productId = $(this).val();
                    const sizeSelect = $(this).closest('.order-item').find('.size-select');

                    // Clear existing options
                    sizeSelect.empty().append('<option value="">-- Select Size --</option>');

                    if (productId) {
                        // Load sizes for this product via AJAX
                        $.ajax({
                            url: '${contextPath}/api/product-sizes',
                            data: {productId: productId},
                            dataType: 'json',
                            success: function (sizes) {
                                // Add size options
                                if (sizes && sizes.length > 0) {
                                    for (var i = 0; i < sizes.length; i++) {
                                        var size = sizes[i];
                                        // Clean the price - remove non-digits first
                                        var cleanPrice = size.price;
                                        // Manual string cleaning instead of regex
                                        if (typeof cleanPrice === 'string') {
                                            cleanPrice = '';
                                            for (var j = 0; j < size.price.length; j++) {
                                                var char = size.price.charAt(j);
                                                if (char >= '0' && char <= '9') {
                                                    cleanPrice += char;
                                                }
                                            }
                                        }

                                        // Build option with standard string concatenation
                                        var option = document.createElement('option');
                                        option.value = size.id;
                                        option.setAttribute('data-price', cleanPrice);
                                        option.setAttribute('data-available', size.quantity);
                                        option.textContent = size.name + ' - ₫' + size.price + ' (' + size.quantity + ' available)';

                                        // Add to select
                                        sizeSelect.append(option);
                                    }
                                    sizeSelect.prop('disabled', false);
                                } else {
                                    sizeSelect.append('<option value="">No sizes available</option>');
                                }
                                // Initialize select2 for the new dropdown
                                sizeSelect.select2();
                                updateTotalAmount();
                            },
                            error: function () {
                                alert('Error loading product sizes');
                            }
                        });
                    } else {
                        sizeSelect.prop('disabled', true);
                        updateTotalAmount();
                    }
                });

                // Update total when size or quantity changes
                $(document).on('change', '.size-select, .quantity-input', function () {
                    updateTotalAmount();
                });

                // Function to update total amount
                function updateTotalAmount() {
                    let total = 0;
                    $('.order-item').each(function () {
                        const sizeSelect = $(this).find('.size-select');
                        const selectedOption = sizeSelect.find('option:selected');
                        const quantity = parseInt($(this).find('.quantity-input').val()) || 0;
                        if (selectedOption.val()) {
                            const price = parseInt(selectedOption.data('price')) || 0;
                            total += price * quantity;
                        }
                    });
                    $('#totalAmount').text(total.toLocaleString('vi-VN'));
                }

                // Form validation before submission
                $('#newOrderForm').submit(function (event) {
                    // Check if at least one product is selected
                    const hasProducts = $('.product-select').toArray().some(select => $(select).val());
                    if (!hasProducts) {
                        alert('Please add at least one product to the order.');
                        event.preventDefault();
                        return false;
                    }

                    // Check for duplicate product-size combinations
                    const productSizeCombos = [];
                    let hasDuplicates = false;
                    
                    $('.order-item').each(function() {
                        const productId = $(this).find('.product-select').val();
                        const sizeId = $(this).find('.size-select').val();
                        
                        // Skip empty selections
                        if (!productId || !sizeId) return;
                        
                        // Create a composite key
                        const combo = productId + '-' + sizeId;
                        
                        // Check if this combo already exists
                        if (productSizeCombos.includes(combo)) {
                            hasDuplicates = true;
                            return false; // Break the each loop
                        }
                        
                        productSizeCombos.push(combo);
                    });
                    
                    if (hasDuplicates) {
                        alert('You have selected the same product with the same size multiple times. Please adjust the quantity instead.');
                        event.preventDefault();
                        return false;
                    }

                    return true;
                });

                // Add Item button
                $('#addItemButton').click(function () {
                    const newItem = `
                  <div class="order-item mb-3 border p-3">
                      <button type="button" class="btn btn-sm btn-danger float-right remove-item">
                          <i class="fa fa-times"></i> Remove
                      </button>
                      <div class="form-group">
                          <label>Select Product</label>
                          <select class="form-control product-select" name="productId" required>
                              <option value="">-- Select a Product --</option>
            <c:forEach var="product" items="${products}">
                                  <option value="${product.id}">${product.name}</option>
            </c:forEach>
                          </select>
                      </div>
                      <div class="form-group">
                          <label>Select Size</label>
                          <select class="form-control size-select" name="sizeId" required disabled>
                              <option value="">-- Select Size --</option>
                          </select>
                      </div>
                      <div class="form-group">
                          <label>Quantity</label>
                          <input type="number" class="form-control quantity-input" name="quantity" 
                                 min="1" value="1" required>
                      </div>
                  </div>
                `;
                    $('#orderItems').append(newItem);

                    // Initialize the new selects with Select2
                    $('#orderItems .order-item:last-child .product-select').select2();

                    // Add remove functionality
                    $('.remove-item').off('click').on('click', function () {
                        $(this).closest('.order-item').remove();
                        updateTotalAmount();
                    });
                });
            });
        </script>

    </body>
</html>
