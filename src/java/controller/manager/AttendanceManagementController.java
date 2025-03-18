package controller.manager;

import dao.AttendanceDAO;
import entity.Attendance;
import java.io.IOException;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "AttendanceManagementController", urlPatterns = {"/manager/attendance"})
public class AttendanceManagementController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        AttendanceDAO attendanceDAO = new AttendanceDAO();
        
        // Lấy tham số filter
        String startDateStr = request.getParameter("startDate");
        String endDateStr = request.getParameter("endDate");
        String statusStr = request.getParameter("status");
        String userName = request.getParameter("userName");
        
        // Xử lý ngày
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        Date startDate = null;
        Date endDate = null;
        try {
            if (startDateStr != null && !startDateStr.isEmpty()) {
                startDate = sdf.parse(startDateStr);
            }
            if (endDateStr != null && !endDateStr.isEmpty()) {
                endDate = sdf.parse(endDateStr);
                // Đặt giờ kết thúc là 23:59:59 để bao gồm cả ngày kết thúc
                endDate.setHours(23);
                endDate.setMinutes(59);
                endDate.setSeconds(59);
            }
        } catch (ParseException e) {
            e.printStackTrace();
        }
        
        // Xử lý trạng thái
        Boolean status = null;
        if (statusStr != null && !statusStr.isEmpty()) {
            status = Boolean.parseBoolean(statusStr);
        }
        
        // Phân trang
        int page = 1;
        int pageSize = 10; // Số bản ghi mỗi trang
        String pageStr = request.getParameter("page");
        if (pageStr != null && !pageStr.isEmpty()) {
            try {
                page = Integer.parseInt(pageStr);
                if (page < 1) page = 1;
            } catch (NumberFormatException ex) {
                page = 1;
            }
        }
        int offset = (page - 1) * pageSize;
        
        try {
            // Lấy tổng số bản ghi theo filter
            int totalRecords = attendanceDAO.getAttendanceCount(startDate, endDate, status, userName);
            int totalPages = (int) Math.ceil((double) totalRecords / pageSize);
            
            // Lấy danh sách điểm danh theo filter và phân trang
            List<Attendance> list = attendanceDAO.getAttendances(startDate, endDate, status, userName, offset, pageSize);
            
            // Lấy thông tin thống kê
            int todayAttendances = attendanceDAO.getTodayAttendanceCount();
            int uniqueUsers = attendanceDAO.getUniqueUserCount();
            
            // Đặt thuộc tính cho request
            request.setAttribute("attendanceList", list);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("currentPage", page);
            request.setAttribute("startDate", startDateStr);
            request.setAttribute("endDate", endDateStr);
            request.setAttribute("status", statusStr);
            request.setAttribute("userName", userName);
            request.setAttribute("totalAttendances", totalRecords);
            request.setAttribute("todayAttendances", todayAttendances);
            request.setAttribute("uniqueUsers", uniqueUsers);
            
            // Chuyển hướng đến trang JSP
            request.getRequestDispatcher("attendanceList.jsp").forward(request, response);
        } catch (SQLException ex) {
            ex.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi khi truy xuất dữ liệu điểm danh");
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
