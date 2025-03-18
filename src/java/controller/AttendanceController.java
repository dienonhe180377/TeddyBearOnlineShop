/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.AttendanceDAO;
import entity.Attendance;
import entity.User;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import java.util.Date;

/**
 *
 * @author ADMIN
 */
@WebServlet(name = "AttendanceController", urlPatterns = {"/seller/attendance"})
public class AttendanceController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        AttendanceDAO attendanceDAO = new AttendanceDAO();
        boolean attended = false;
        try {
            attended = attendanceDAO.hasAttendedToday(user.getId());
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        request.setAttribute("attended", attended);
        request.getRequestDispatcher("attendance.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        AttendanceDAO attendanceDAO = new AttendanceDAO();
        try {
            if (attendanceDAO.hasAttendedToday(user.getId())) {
                session.setAttribute("attendanceMessage", "Hôm nay bạn đã điểm danh rồi!");
                response.sendRedirect(request.getContextPath() + "/seller/attendance");
                return;
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error checking attendance");
            return;
        }
        
        // Nếu chưa điểm danh, thêm mới bản ghi điểm danh
        boolean status = true; // Có mặt
        int userId = user.getId();
        Date updateTime = new Date();
        Attendance attendance = new Attendance(status, userId, updateTime);
        try {
            attendanceDAO.addAttendance(attendance);
            session.setAttribute("attendanceMessage", "Điểm danh thành công!");
            response.sendRedirect(request.getContextPath() + "/seller/attendance");
        } catch (SQLException ex) {
            ex.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error adding attendance record");
        }
    }
}
