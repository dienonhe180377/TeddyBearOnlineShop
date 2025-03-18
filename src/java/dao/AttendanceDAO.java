package dao;

import entity.Attendance;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class AttendanceDAO extends DBConnection {

    // Lấy danh sách điểm danh theo filter và phân trang
    public List<Attendance> getAttendances(Date startDate, Date endDate, Boolean status, String userName, int offset, int pageSize) throws SQLException {
        List<Attendance> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT a.id, a.status, a.userId, a.updateTime, u.userName "
                + "FROM Attendance a JOIN [User] u ON u.id = a.userId WHERE 1=1 ");
        
        List<Object> params = new ArrayList<>();
        
        if (startDate != null) {
            sql.append("AND a.updateTime >= ? ");
            params.add(new java.sql.Timestamp(startDate.getTime()));
        }
        
        if (endDate != null) {
            sql.append("AND a.updateTime <= ? ");
            params.add(new java.sql.Timestamp(endDate.getTime()));
        }
        
        if (status != null) {
            sql.append("AND a.status = ? ");
            params.add(status);
        }
        
        if (userName != null && !userName.trim().isEmpty()) {
            sql.append("AND u.userName LIKE ? ");
            params.add("%" + userName.trim() + "%");
        }
        
        sql.append("ORDER BY a.updateTime DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");
        params.add(offset);
        params.add(pageSize);

        try (Connection conn = getConnection(); 
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {
            
            for (int i = 0; i < params.size(); i++) {
                setParameter(ps, i + 1, params.get(i));
            }

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    int id = rs.getInt("id");
                    boolean statusValue = rs.getBoolean("status");
                    int userId = rs.getInt("userId");
                    Date updateTime = rs.getTimestamp("updateTime");
                    Attendance attendance = new Attendance(id, statusValue, userId, updateTime);
                    attendance.setUserName(rs.getString("userName"));
                    list.add(attendance);
                }
            }
        }
        return list;
    }

    // Đếm số bản ghi điểm danh theo filter (để phân trang)
    public int getAttendanceCount(Date startDate, Date endDate, Boolean status, String userName) throws SQLException {
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) AS total FROM Attendance a "
                + "JOIN [User] u ON u.id = a.userId WHERE 1=1 ");
        
        List<Object> params = new ArrayList<>();
        
        if (startDate != null) {
            sql.append("AND a.updateTime >= ? ");
            params.add(new java.sql.Timestamp(startDate.getTime()));
        }
        
        if (endDate != null) {
            sql.append("AND a.updateTime <= ? ");
            params.add(new java.sql.Timestamp(endDate.getTime()));
        }
        
        if (status != null) {
            sql.append("AND a.status = ? ");
            params.add(status);
        }
        
        if (userName != null && !userName.trim().isEmpty()) {
            sql.append("AND u.userName LIKE ? ");
            params.add("%" + userName.trim() + "%");
        }

        try (Connection conn = getConnection(); 
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {
            
            for (int i = 0; i < params.size(); i++) {
                setParameter(ps, i + 1, params.get(i));
            }
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("total");
                }
            }
        }
        return 0;
    }
    
    // Phương thức hỗ trợ để thiết lập tham số cho PreparedStatement
    private void setParameter(PreparedStatement ps, int index, Object value) throws SQLException {
        if (value instanceof String) {
            ps.setString(index, (String) value);
        } else if (value instanceof Integer) {
            ps.setInt(index, (Integer) value);
        } else if (value instanceof Boolean) {
            ps.setBoolean(index, (Boolean) value);
        } else if (value instanceof java.sql.Timestamp) {
            ps.setTimestamp(index, (java.sql.Timestamp) value);
        } else if (value instanceof Date) {
            ps.setTimestamp(index, new java.sql.Timestamp(((Date) value).getTime()));
        }
    }

    // Phương thức getAllAttendances cũ (nếu cần)
    public List<Attendance> getAllAttendances() throws SQLException {
        return getAttendances(null, null, null, null, 0, Integer.MAX_VALUE);
    }

    // Thêm một điểm danh mới
    public int addAttendance(Attendance attendance) throws SQLException {
        String sql = "INSERT INTO Attendance (status, userId, updateTime) VALUES (?, ?, ?)";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setBoolean(1, attendance.isStatus());
            ps.setInt(2, attendance.getUserId());
            ps.setTimestamp(3, new java.sql.Timestamp(attendance.getUpdateTime().getTime()));
            return ps.executeUpdate();
        }
    }

    public boolean hasAttendedToday(int userId) throws SQLException {
        String sql = "SELECT COUNT(*) AS total FROM Attendance "
                + "WHERE userId = ? AND CONVERT(date, updateTime) = CONVERT(date, GETDATE())";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("total") > 0;
                }
            }
        }
        return false;
    }
    
    // Lấy số lượng điểm danh hôm nay
    public int getTodayAttendanceCount() throws SQLException {
        String sql = "SELECT COUNT(*) AS total FROM Attendance "
                + "WHERE CONVERT(date, updateTime) = CONVERT(date, GETDATE())";
        try (Connection conn = getConnection(); 
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt("total");
            }
        }
        return 0;
    }
    
    // Lấy số lượng người dùng duy nhất đã điểm danh
    public int getUniqueUserCount() throws SQLException {
        String sql = "SELECT COUNT(DISTINCT userId) AS total FROM Attendance";
        try (Connection conn = getConnection(); 
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt("total");
            }
        }
        return 0;
    }
}
