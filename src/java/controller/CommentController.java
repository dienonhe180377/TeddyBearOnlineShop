/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.CommentDAO;
import entity.Comment;
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
 * @author HP
 */
@WebServlet(name = "CommentController", urlPatterns = {"/CommentController"})
public class CommentController extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private CommentDAO commentDAO;

    public void init() {
        commentDAO = new CommentDAO();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        int userId = user.getId();
        int productId = Integer.parseInt(request.getParameter("productId"));
        String content = request.getParameter("content");

        Comment comment = new Comment();
        comment.setProductId(productId);
        comment.setUserId(userId);
        comment.setContent(content);
        comment.setStatus("approved");

        if (commentDAO.addComment(comment)) {
            response.sendRedirect("MenuController?service=productView&productId=" + productId + "&success=1");
        } else {
            response.sendRedirect("MenuController?service=productView&productId=" + productId + "&success=0");
        }
    }
}
