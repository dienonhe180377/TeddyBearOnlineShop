/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.manager;

import dao.UserDAO;
import entity.User;
import entity.UserRole;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author OS
 */
@WebServlet(name = "UserManagementController", urlPatterns = {"/manager/user-management"})
public class UserManagementController extends HttpServlet {
    
    UserDAO udao = new UserDAO();
    
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
            } else if (!user.getRole().getUserRole().equalsIgnoreCase("manager")) {
                session.setAttribute("notificationErr", "Access Denied!");
                response.sendRedirect(request.getContextPath() + "/login");
                return;
            }
            String searchParam = request.getParameter("search");
            String roleParam = request.getParameter("role");
            String pageParam = request.getParameter("page");
            UserDAO userDAO = new UserDAO();
            int page = 1; // Default to the first page
            int pageSize = 6; // Set the desired page size
            if (pageParam != null && !pageParam.isEmpty()) {
                page = Integer.parseInt(pageParam);
            }
            Integer role = null;
            if (roleParam != null && !roleParam.isEmpty()) {
                role = Integer.valueOf(roleParam);
            }
            
            List<User> users = userDAO.getAllUsersWithParam(searchParam, role);
            List<User> pagingUser = userDAO.Paging(users, page, pageSize);
            request.setAttribute("users", pagingUser);
            request.setAttribute("title", "Quản lý nhân viên");
            request.setAttribute("search", searchParam);
            request.setAttribute("totalPages", users.size() % pageSize == 0 ? (users.size() / pageSize) : (users.size() / pageSize + 1));
            request.setAttribute("currentPage", page);
            
            request.getRequestDispatcher("user-management.jsp").forward(request, response);
        } catch (Exception ex) {
            Logger.getLogger(UserManagementController.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        String action = request.getParameter("action");
        
        try {
            if (action != null && action.equals("add")) {
                // ===== ADD USER =====
                String userName = request.getParameter("userName");
                String email = request.getParameter("email");
                String password = request.getParameter("password");
                String phone = request.getParameter("phone");
                String location = request.getParameter("location");
                String roleParam = request.getParameter("role");
                int role = Integer.parseInt(roleParam);

                // Server-side validations
                boolean hasError = false;
                StringBuilder errorMsg = new StringBuilder();

                // Check if email or phone already exists
                if (udao.isEmailExist(email)) {
                    hasError = true;
                    errorMsg.append("Email already exists. ");
                }
                if (udao.isPhoneNumberExist(phone)) {
                    hasError = true;
                    errorMsg.append("Phone number already exists. ");
                }
                // Validate email format
                if (!email.matches("^[\\w-\\.]+@([\\w-]+\\.)+[\\w-]{2,4}$")) {
                    hasError = true;
                    errorMsg.append("Invalid email format. ");
                }
                // Validate phone: must be 10 digits and start with 0
                if (!phone.matches("^0\\d{9}$")) {
                    hasError = true;
                    errorMsg.append("Phone number must be 10 digits and start with 0. ");
                }
                // Validate password: at least 6 characters, one uppercase, one special character
                if (password == null || password.length() < 6
                        || !password.matches(".*[A-Z].*")
                        || !password.matches(".*[^a-zA-Z0-9].*")) {
                    hasError = true;
                    errorMsg.append("Password must be at least 6 characters long, contain an uppercase letter and a special character. ");
                }
                
                if (hasError) {
                    request.setAttribute("error", errorMsg.toString());
                    request.getRequestDispatcher("user-management.jsp").forward(request, response);
                    return;
                }

                // All validations passed; add user
                udao.addUser(userName, email, password, phone, location, role);
                session.setAttribute("notification", "User added successfully.");
                response.sendRedirect(request.getContextPath() + "/manager/user-management");
                
            } else if (action != null && action.equals("edit")) {
                // ===== EDIT USER =====
                String userIdParam = request.getParameter("userId");
                int userId = Integer.parseInt(userIdParam);
                String userName = request.getParameter("userName");
                String email = request.getParameter("email");
                String phone = request.getParameter("phone");
                String location = request.getParameter("location");
                String roleParam = request.getParameter("role");
                int role = Integer.parseInt(roleParam);

                // Retrieve existing user details for comparison
                User existingUser = udao.getUserById(userId);
                if (existingUser == null) {
                    request.setAttribute("error", "User not found.");
                    request.getRequestDispatcher("user-management.jsp").forward(request, response);
                    return;
                }
                
                boolean hasError = false;
                StringBuilder errorMsg = new StringBuilder();

                // If the email has changed, check if the new email already exists
                if (!existingUser.getEmail().equalsIgnoreCase(email) && udao.isEmailExist(email)) {
                    hasError = true;
                    errorMsg.append("Email already exists. ");
                }
                // If the phone has changed, check if the new phone number already exists
                if (!existingUser.getPhoneNumber().equals(phone) && udao.isPhoneNumberExist(phone)) {
                    hasError = true;
                    errorMsg.append("Phone number already exists. ");
                }
                // Validate email format
                if (!email.matches("^[\\w-\\.]+@([\\w-]+\\.)+[\\w-]{2,4}$")) {
                    hasError = true;
                    errorMsg.append("Invalid email format. ");
                }
                // Validate phone: must be 10 digits and start with 0
                if (!phone.matches("^0\\d{9}$")) {
                    hasError = true;
                    errorMsg.append("Phone number must be 10 digits and start with 0. ");
                }
                
                if (hasError) {
                    request.setAttribute("error", errorMsg.toString());
                    request.getRequestDispatcher("user-management.jsp").forward(request, response);
                    return;
                }

                // Update user information
                udao.updateUser(userId, userName, email, phone, location, role);
                
                session.setAttribute("notification", "User updated successfully.");
                response.sendRedirect(request.getContextPath() + "/manager/user-management");
            } else {
                // If no valid action is provided, simply redirect back
                response.sendRedirect(request.getContextPath() + "/manager/user-management");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "An error occurred: " + e.getMessage());
            request.getRequestDispatcher("user-management.jsp").forward(request, response);
        }
    }
    
}
