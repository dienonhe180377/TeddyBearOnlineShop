package controller;

import dao.OrderDAO;
import entity.CartItem;
import entity.Order;
import entity.OrderDetail;

import entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {

    private final OrderDAO orderDAO = new OrderDAO();

    // doGet: Display the checkout page with user info and product details.
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        try {
            // Retrieve cart items for the current user.
            List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
            request.setAttribute("cartItems", cart);
            // checkout.jsp will use sessionScope.user for user info.
            request.getRequestDispatcher("jsp/checkout.jsp").forward(request, response);
        } catch (ServletException | IOException ex) {
            Logger.getLogger(CheckoutServlet.class.getName()).log(Level.SEVERE, null, ex);
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error loading checkout page.");
        }
    }

    // doPost: Process the checkout submission and create the order.
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            // Retrieve current cart items.
            List<CartItem> cartItems = (List<CartItem>) session.getAttribute("cart");

            if (cartItems == null || cartItems.isEmpty()) {
                session.setAttribute("notificationErr", "Your cart is empty, Please add to cart first!");
                response.sendRedirect(request.getContextPath() + "/cart");
                return;
            }

            // Calculate total cost and build order details.
            int totalCost = 0;
            List<OrderDetail> orderDetails = new ArrayList<>();
            for (CartItem item : cartItems) {
                int subtotal = item.getTotalPrice();
                totalCost += subtotal;
                OrderDetail detail = new OrderDetail();
                detail.setProductId(item.getProduct().getId());
                detail.setQuantity(item.getQuantity());
                orderDetails.add(detail);
            }

            // Create an Order object.
            Order order = new Order();
            order.setTotalCost(totalCost);
            order.setStatus(0); 
            order.setUserId(user.getId());
            order.setTotalCost(totalCost);
            orderDAO.createOrderWithDetails(order, orderDetails);
            session.removeAttribute("cart");
            session.setAttribute("cartCount", 0);

            response.sendRedirect(request.getContextPath() + "/jsp/order-confirmation.jsp");
        } catch (Exception ex) {
            Logger.getLogger(CheckoutServlet.class.getName()).log(Level.SEVERE, null, ex);
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Checkout failed.");
        }
    }
}
