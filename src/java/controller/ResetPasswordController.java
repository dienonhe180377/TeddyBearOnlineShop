/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.UserDAO;
import entity.User;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author ADMIN
 */
@WebServlet(name = "ResetPasswordController", urlPatterns = {"/reset-password"})
public class ResetPasswordController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Get the token from the URL parameters
        String token = request.getParameter("token");
        HttpSession session = request.getSession();
        String sessionToken = (String) session.getAttribute("resetToken");

        // Validate the token before showing the reset password page
        if (token == null || sessionToken == null || !token.equals(sessionToken)) {
            session.setAttribute("notificationErr", "Invalid or expired reset token.");
            response.sendRedirect("forgot-password");
            return;
        }
        // Forward to reset password JSP
        request.getRequestDispatcher("reset-password.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        // Validate the token again on form submission
        String token = request.getParameter("token");
        String sessionToken = (String) session.getAttribute("resetToken");
        if (token == null || sessionToken == null || !token.equals(sessionToken)) {
            session.setAttribute("notificationErr", "Invalid or expired reset token.");
            response.sendRedirect("forgot-password");
            return;
        }

        // Retrieve new password and confirmation from form
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        if (!newPassword.equals(confirmPassword)) {
            session.setAttribute("notificationErr", "Passwords do not match.");
            response.sendRedirect("reset-password?token=" + token);
            return;
        }

        // Retrieve the user stored during forgot password flow
        User user = (User) session.getAttribute("userForReset");
        if (user == null) {
            session.setAttribute("notificationErr", "User session expired, please try the forgot password process again.");
            response.sendRedirect("forgot-password");
            return;
        }

        // Update the password using the DAO
        UserDAO dao = new UserDAO();
        boolean updated = dao.updatePassword(user.getId(), newPassword);
        if (updated) {
            session.setAttribute("notification", "Password updated successfully. You can now log in.");
            // Clear the reset token and user info from session
            session.removeAttribute("resetToken");
            session.removeAttribute("userForReset");
            response.sendRedirect("login");
        } else {
            session.setAttribute("notificationErr", "Failed to update password. Please try again.");
            response.sendRedirect("reset-password?token=" + token);
        }
    }
}
