package controller.admin;

import dao.DashboardDAO;
import dao.DashboardDAO.CategoryStat;
import dao.DashboardDAO.RevenueTrend;
import dao.DashboardDAO.RoleStat;
import entity.User;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "AdminDashboardController", urlPatterns = {"/admin/dashboard"})
public class AdminDashboardController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        // Check for login and admin role
        if (user == null) {
            session.setAttribute("notificationErr", "Please login first!");
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        } else if (!user.getRole().getUserRole().equalsIgnoreCase("admin")) {
            session.setAttribute("notificationErr", "Access Denied!");
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        DashboardDAO dashboardDAO = new DashboardDAO();
        try {
            int totalProducts = dashboardDAO.getTotalProducts();
            int totalOrders = dashboardDAO.getTotalOrders();
            int totalRevenue = dashboardDAO.getTotalRevenue();
            int totalUsers = dashboardDAO.getTotalUsers();
            int totalBlogs = dashboardDAO.getTotalBlogs();
            
            List<CategoryStat> categoryStats = dashboardDAO.getProductCountByCategory();
            List<RevenueTrend> revenueTrend = dashboardDAO.getRevenueTrend();
            List<RoleStat> roleStats = dashboardDAO.getUserRoleDistribution();
            
            // Set attributes for the JSP
            request.setAttribute("totalProducts", totalProducts);
            request.setAttribute("totalOrders", totalOrders);
            request.setAttribute("totalRevenue", totalRevenue);
            request.setAttribute("totalUsers", totalUsers);
            request.setAttribute("totalBlogs", totalBlogs);
            request.setAttribute("categoryStats", categoryStats);
            request.setAttribute("revenueTrend", revenueTrend);
            request.setAttribute("roleStats", roleStats);
            
            request.getRequestDispatcher("/admin/dashboard.jsp").forward(request, response);
        } catch (SQLException ex) {
            ex.printStackTrace();
            request.setAttribute("errorMessage", "Error retrieving dashboard data.");
            request.getRequestDispatcher("/admin/error.jsp").forward(request, response);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
