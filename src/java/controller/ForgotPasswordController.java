package controller;

import dao.UserDAO;
import entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.UUID;
import javax.mail.MessagingException;
import utility.EmailUtility;

@WebServlet(name = "ForgotPasswordController", urlPatterns = {"/forgot-password"})
public class ForgotPasswordController extends HttpServlet {

    private final String host = "smtp.gmail.com";
    private final String port = "587";
    private final String mailFrom = "teddybearonlineshop6@gmail.com";
    private final String mailPassword = "012345678930042004123045607890quang1"; 

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Forward to forgot password JSP
        request.getRequestDispatcher("forgotPassword.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Retrieve the email entered by the user
        String email = request.getParameter("email");
        HttpSession session = request.getSession();
        UserDAO dao = new UserDAO();

        // Check if the email exists in the database
        User user = dao.getByEmail(email);
        if (user != null) {
            // Generate a secure reset token (in production, store this in your DB with an expiration)
            String resetToken = UUID.randomUUID().toString();
            session.setAttribute("resetToken", resetToken);
            session.setAttribute("userForReset", user);

            // Create the reset link (adjust the URL to match your domain and context)
            String resetLink = request.getRequestURL().toString().replace("forgot-password", "reset-password")
                    + "?token=" + resetToken;
            
            // Build the email content (HTML format)
            String subject = "Password Reset Request";
            String message = "<h3>Password Reset Request</h3>"
                    + "<p>Dear " + user.getUserName() + ",</p>"
                    + "<p>To reset your password, please click the link below:</p>"
                    + "<a href=\"" + resetLink + "\">Reset Password</a>"
                    + "<br><p>If you did not request a password reset, please ignore this email.</p>";

            // Send the email using the EmailUtility
            try {
                EmailUtility.sendEmail(host, port, mailFrom, mailPassword, email, subject, message);
                session.setAttribute("notification", "A password reset link has been sent to your email.");
            } catch (MessagingException e) {
                session.setAttribute("notificationErr", "Error in sending email. Please try again.");
            }
        } else {
            session.setAttribute("notificationErr", "Email not found. Please check and try again.");
        }
        // Forward back to the forgot password page to display notifications
        request.getRequestDispatcher("forgotPassword.jsp").forward(request, response);
    }
}