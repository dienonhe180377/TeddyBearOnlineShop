package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

// DashboardDAO extends your existing DBConnection (which should provide getConnection(), etc.)
public class DashboardDAO extends DBConnection {

    // Summary statistic methods
    public int getTotalProducts() throws SQLException {
        String sql = "SELECT COUNT(*) AS totalProducts FROM Product";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt("totalProducts");
            }
        }
        return 0;
    }
    
    public int getTotalOrders() throws SQLException {
        String sql = "SELECT COUNT(*) AS totalOrders FROM [Order]";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()){
            if(rs.next()){
                return rs.getInt("totalOrders");
            }
        }
        return 0;
    }
    
    public int getTotalRevenue() throws SQLException {
        String sql = "SELECT ISNULL(SUM(totalCost),0) AS totalRevenue FROM [Order]";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()){
            if(rs.next()){
                return rs.getInt("totalRevenue");
            }
        }
        return 0;
    }
    
    public int getTotalUsers() throws SQLException {
        String sql = "SELECT COUNT(*) AS totalUsers FROM [User]";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()){
            if(rs.next()){
                return rs.getInt("totalUsers");
            }
        }
        return 0;
    }
    
    public int getTotalBlogs() throws SQLException {
        String sql = "SELECT COUNT(*) AS totalBlogs FROM Blog";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()){
            if(rs.next()){
                return rs.getInt("totalBlogs");
            }
        }
        return 0;
    }
    
    // Chart 1: Products by Category
    public List<CategoryStat> getProductCountByCategory() throws SQLException {
        List<CategoryStat> list = new ArrayList<>();
        String sql = "SELECT c.name AS categoryName, COUNT(p.id) AS productCount " +
                     "FROM Category c LEFT JOIN Product p ON c.id = p.categoryId " +
                     "GROUP BY c.name";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()){
            while(rs.next()){
                String categoryName = rs.getString("categoryName");
                int productCount = rs.getInt("productCount");
                list.add(new CategoryStat(categoryName, productCount));
            }
        }
        return list;
    }
    
    // Chart 2: Revenue Trend by Month
    public List<RevenueTrend> getRevenueTrend() throws SQLException {
        List<RevenueTrend> list = new ArrayList<>();
        // Note: The FORMAT function is available in SQL Server 2012+. Adjust if necessary.
        String sql = "SELECT FORMAT(orderDate, 'yyyy-MM') AS month, SUM(totalCost) AS revenue " +
                     "FROM [Order] " +
                     "GROUP BY FORMAT(orderDate, 'yyyy-MM') " +
                     "ORDER BY month";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()){
            while(rs.next()){
                String month = rs.getString("month");
                int revenue = rs.getInt("revenue");
                list.add(new RevenueTrend(month, revenue));
            }
        }
        return list;
    }
    
    // Chart 3: User Role Distribution
    public List<RoleStat> getUserRoleDistribution() throws SQLException {
        List<RoleStat> list = new ArrayList<>();
        String sql = "SELECT ur.roleName, COUNT(u.id) AS userCount " +
                     "FROM [User] u JOIN UserRole ur ON u.roleId = ur.id " +
                     "GROUP BY ur.roleName";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()){
            while(rs.next()){
                String roleName = rs.getString("roleName");
                int userCount = rs.getInt("userCount");
                list.add(new RoleStat(roleName, userCount));
            }
        }
        return list;
    }
    
    // Inner classes to hold chart data
    public static class CategoryStat {
        private String categoryName;
        private int productCount;
        public CategoryStat(String categoryName, int productCount) {
            this.categoryName = categoryName;
            this.productCount = productCount;
        }
        public String getCategoryName() { return categoryName; }
        public int getProductCount() { return productCount; }
    }
    
    public static class RevenueTrend {
        private String month;
        private int revenue;
        public RevenueTrend(String month, int revenue) {
            this.month = month;
            this.revenue = revenue;
        }
        public String getMonth() { return month; }
        public int getRevenue() { return revenue; }
    }
    
    public static class RoleStat {
        private String roleName;
        private int userCount;
        public RoleStat(String roleName, int userCount) {
            this.roleName = roleName;
            this.userCount = userCount;
        }
        public String getRoleName() { return roleName; }
        public int getUserCount() { return userCount; }
    }
}
