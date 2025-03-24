package controller;

import dao.OrderDAO;
import dao.ProductDAO;
import dao.UserDAO;
import entity.User;
import entity.Product;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "NewOrderController", urlPatterns = {"/new-order"})
public class NewOrderController extends HttpServlet {
    private final UserDAO userDAO = new UserDAO();
    private final ProductDAO productDAO = new ProductDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("user");
            
            if (user == null) {
                session.setAttribute("notificationErr", "Please login first!");
                response.sendRedirect(request.getContextPath() + "/login");
                return;
            }
            
            String role = user.getRole().getUserRole().toLowerCase();
            if (!"seller".equals(role) && !"marketing".equals(role)) {
                session.setAttribute("notificationErr", "Access Denied!");
                response.sendRedirect(request.getContextPath() + "/orders");
                return;
            }
            
            // Get list of customers and products for the dropdowns
            List<User> customers = userDAO.getAllCustomers();
            List<Product> products = productDAO.getAllProduct();
            
            request.setAttribute("customers", customers);
            request.setAttribute("products", products);
            
            request.getRequestDispatcher("jsp/new-order.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "An error occurred: " + e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }
}
