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
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.nio.file.Paths;

/**
 *
 * @author Admin
 */
@WebServlet(name = "UpdateAvatarController", urlPatterns = {"/updateAvatar"})
@MultipartConfig
public class UpdateAvatarController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet UpdateAvatarController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UpdateAvatarController at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");
        if (user == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            response.getWriter().write("{\"status\":\"error\",\"message\":\"Bạn cần đăng nhập để thực hiện thao tác này.\"}");
            return;
        }

        Part avatarPart = request.getPart("avatar");
        String fileName = Paths.get(avatarPart.getSubmittedFileName()).getFileName().toString();

        String uploadDir = getServletContext().getRealPath("/images");

        File uploadDirFile = new File(uploadDir);
        if (!uploadDirFile.exists()) {
            uploadDirFile.mkdirs(); 
        }

        String avatarFilePath = uploadDir + File.separator + fileName;
        avatarPart.write(avatarFilePath);

        UserDAO userDAO = new UserDAO();
        try {
            userDAO.updateUserAvatar(user.getId(), "images/" + fileName);

            user.setProfilePic("images/" + fileName);
            request.getSession().setAttribute("user", user);

            response.setContentType("application/json");
            response.getWriter().write("{\"status\":\"success\",\"avatarPath\":\"/images/" + fileName + "\"}");
        } catch (Exception e) {
            // Trả về thông báo lỗi nếu có vấn đề
            response.setContentType("application/json");
            response.getWriter().write("{\"status\":\"error\",\"message\":\"Không thể cập nhật ảnh đại diện.\"}");
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
