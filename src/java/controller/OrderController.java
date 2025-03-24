package controller;

import dao.OrderDAO;
import dao.ProductDAO;
import entity.Order;
import entity.OrderDetail;
import entity.Product;
import entity.Size;
import entity.User;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.Date;

@WebServlet(name = "OrderController", urlPatterns = {"/orders", "/order-detail", "/guest-order"})
public class OrderController extends HttpServlet {

    private final OrderDAO orderDAO = new OrderDAO();
    private final ProductDAO productDAO = new ProductDAO();  // You'll need to implement this

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String servletPath = request.getServletPath();

        try {
            // Handling request to view order as a guest
            if ("/guest-order".equals(servletPath)) {
                handleGuestOrderView(request, response);
                return;
            }

            // For all other paths, require authentication
            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("user");
            if (user == null) {
                session.setAttribute("notificationErr", "Please login first!");
                response.sendRedirect(request.getContextPath() + "/login");
                return;
            }

            // Determine what to show based on URL and user role
            if ("/orders".equals(servletPath)) {
                showOrdersList(request, response, user);
            } else if ("/order-detail".equals(servletPath)) {
                showOrderDetail(request, response, user);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "An error occurred: " + e.getMessage());
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        try {
            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("user");

            // Guest order lookup doesn't need authentication
            if ("guest-lookup".equals(action)) {
                String orderIdStr = request.getParameter("orderId");
                if (orderIdStr != null && !orderIdStr.isEmpty()) {
                    int orderId = Integer.parseInt(orderIdStr);
                    handleGuestOrderLookup(request, response, orderId);
                } else {
                    request.setAttribute("error", "Please enter a valid order ID");
                    request.getRequestDispatcher("jsp/guest-order-lookup.jsp").forward(request, response);
                }
                return;
            }

            // For other actions, require authentication
            if (user == null) {
                session.setAttribute("notificationErr", "Please login first!");
                response.sendRedirect(request.getContextPath() + "/login");
                return;
            }

            // Handle different actions
            if ("create-order".equals(action)) {
                if ("seller".equalsIgnoreCase(user.getRole().getUserRole())
                        || "marketing".equalsIgnoreCase(user.getRole().getUserRole())) {
                    createNewOrder(request, response, user);
                } else {
                    session.setAttribute("notificationErr", "You don't have permission to create orders!");
                    response.sendRedirect(request.getContextPath() + "orders");
                }
            } else if ("update-status".equals(action)) {
                updateOrderStatus(request, response, user);
            } else if ("cancel-order".equals(action)) {
                cancelOrder(request, response, user);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "An error occurred: " + e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }

    private void showOrdersList(HttpServletRequest request, HttpServletResponse response, User user)
            throws Exception {
        String search = request.getParameter("search");
        int page = 1;
        int pageSize = 10;

        if (request.getParameter("page") != null) {
            page = Integer.parseInt(request.getParameter("page"));
        }

        String role = user.getRole().getUserRole().toLowerCase();
        List<Order> orders;
        int totalOrders;

        // Different view based on user role
        if ("manager".equals(role) || "seller".equals(role) || "marketing".equals(role)) {
            // Managers, sellers and marketing can see all orders
            orders = orderDAO.getOrdersWithSearch(search, (page - 1) * pageSize, pageSize);
            totalOrders = orderDAO.countAllOrdersWithSearch(search);
        } else {
            // Customer can only see their own orders
            orders = orderDAO.getOrdersByUserSearch(user.getId(), search, (page - 1) * pageSize, pageSize);
            totalOrders = orderDAO.countOrdersByUserSearch(user.getId(), search);
        }

        int totalPages = (totalOrders + pageSize - 1) / pageSize;

        request.setAttribute("orders", orders);
        request.setAttribute("search", search);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("userRole", role);

        request.getRequestDispatcher("jsp/orders.jsp").forward(request, response);
    }

    private void showOrderDetail(HttpServletRequest request, HttpServletResponse response, User user)
            throws Exception {
        String orderIdParam = request.getParameter("id");
        if (orderIdParam == null || orderIdParam.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/orders");
            return;
        }

        int orderId = Integer.parseInt(orderIdParam);
        Order order = orderDAO.getOrderById(orderId);

        if (order == null) {
            request.setAttribute("error", "Order not found");
            request.getRequestDispatcher("/error.jsp").forward(request, response);
            return;
        }

        // Security check: Customers can only view their own orders
        String role = user.getRole().getUserRole().toLowerCase();
        if ("customer".equals(role) && order.getUserId() != user.getId()) {
            request.setAttribute("error", "You don't have permission to view this order");
            request.getRequestDispatcher("/error.jsp").forward(request, response);
            return;
        }

        List<OrderDetail> orderDetails = orderDAO.getOrderDetails(orderId);
        order.setDetails(orderDetails);

        request.setAttribute("order", order);
        request.setAttribute("userRole", role);

        request.getRequestDispatcher("jsp/order-detail.jsp").forward(request, response);
    }

    private void handleGuestOrderView(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        String orderIdParam = request.getParameter("id");

        if (orderIdParam != null && !orderIdParam.isEmpty()) {
            int orderId = Integer.parseInt(orderIdParam);
            handleGuestOrderLookup(request, response, orderId);
        } else {
            // Show the guest lookup form
            request.getRequestDispatcher("jsp/guest-order-lookup.jsp").forward(request, response);
        }
    }

    private void handleGuestOrderLookup(HttpServletRequest request, HttpServletResponse response, int orderId)
            throws Exception {
        Order order = orderDAO.getOrderById(orderId);

        if (order == null) {
            request.setAttribute("error", "Order not found. Please check the order number and try again.");
            request.getRequestDispatcher("jsp/guest-order-lookup.jsp").forward(request, response);
            return;
        }

        List<OrderDetail> orderDetails = orderDAO.getOrderDetails(orderId);
        order.setDetails(orderDetails);

        request.setAttribute("order", order);
        request.getRequestDispatcher("jsp/guest-order-detail.jsp").forward(request, response);
    }

    private void updateOrderStatus(HttpServletRequest request, HttpServletResponse response, User user)
            throws Exception {
        String role = user.getRole().getUserRole().toLowerCase();

        // Only managers and sellers can update order status
        if (!("manager".equals(role) || "seller".equals(role))) {
            request.setAttribute("error", "You don't have permission to update order status");
            request.getRequestDispatcher("/error.jsp").forward(request, response);
            return;
        }

        int orderId = Integer.parseInt(request.getParameter("orderId"));
        String statusAction = request.getParameter("statusAction");

        if ("accept".equals(statusAction)) {
            orderDAO.acceptOrder(orderId);
        } else if ("deliver".equals(statusAction)) {
            orderDAO.markDelivered(orderId);
        }

        // Redirect back to order detail
        response.sendRedirect(request.getContextPath() + "/order-detail?id=" + orderId);
    }

    private void cancelOrder(HttpServletRequest request, HttpServletResponse response, User user)
            throws Exception {
        int orderId = Integer.parseInt(request.getParameter("orderId"));
        Order order = orderDAO.getOrderById(orderId);

        if (order == null) {
            request.setAttribute("error", "Order not found");
            request.getRequestDispatcher("/error.jsp").forward(request, response);
            return;
        }

        String role = user.getRole().getUserRole().toLowerCase();

        // Verify permissions: Manager, seller, or the order owner can cancel
        boolean canCancel = "manager".equals(role) || "seller".equals(role)
                || (order.getUserId() == user.getId() && order.getStatus() == 0);

        if (!canCancel) {
            request.setAttribute("error", "You don't have permission to cancel this order");
            request.getRequestDispatcher("/error.jsp").forward(request, response);
            return;
        }

        orderDAO.cancelOrder(orderId);

        // Redirect back to appropriate page
        if ("customer".equals(role)) {
            response.sendRedirect(request.getContextPath() + "/orders");
        } else {
            response.sendRedirect(request.getContextPath() + "/order-detail?id=" + orderId);
        }
    }

    private void createNewOrder(HttpServletRequest request, HttpServletResponse response, User user)
            throws Exception {
        int customerId = Integer.parseInt(request.getParameter("customerId"));

        // Create new order
        Order order = new Order();
        order.setUserId(customerId);
        order.setStatus(0); // Pending
        order.setOrderDate(new Date());
        order.setAddress(request.getParameter("address"));

        // Parse order details from the form
        String[] productIds = request.getParameterValues("productId");
        String[] sizeIds = request.getParameterValues("sizeId");  // Get selected sizes
        String[] quantities = request.getParameterValues("quantity");

        List<OrderDetail> details = new ArrayList<>();
        int totalCost = 0;

        for (int i = 0; i < productIds.length; i++) {
            if (productIds[i] == null || productIds[i].isEmpty()) {
                continue;
            }

            int productId = Integer.parseInt(productIds[i]);
            int sizeId = Integer.parseInt(sizeIds[i]);
            int quantity = Integer.parseInt(quantities[i]);

            // Get product and size information
            Product product = productDAO.getProductById(productId);
            if (product == null) {
                continue;
            }

            // Find the selected size
            Size selectedSize = null;
            for (Size size : product.getSizes()) {
                if (size.getId() == sizeId) {
                    selectedSize = size;
                    break;
                }
            }

            if (selectedSize == null) {
                continue;
            }

            // Clean the price string - remove any non-digit characters
            String priceStr = selectedSize.getPrice().replaceAll("[^0-9]", "");
            int price = Integer.parseInt(priceStr);

            totalCost += price * quantity;

            OrderDetail detail = new OrderDetail();
            detail.setProductId(productId);
            detail.setQuantity(quantity);
            detail.setProduct(product);
            details.add(detail);

            // Update stock (reduce quantity)
            orderDAO.updateSizeStock(sizeId, quantity);
        }

        order.setTotalCost(totalCost);

        // Create the order with details
        orderDAO.createOrderWithDetails(order, details);

        HttpSession session = request.getSession();
        session.setAttribute("notification", "Order created successfully!");
        response.sendRedirect(request.getContextPath() + "/orders");
    }
}
