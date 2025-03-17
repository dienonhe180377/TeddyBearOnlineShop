package dao;

import entity.Category;
import entity.Product;
import entity.ProductImage;
import entity.ProductType;
import entity.Size;
import entity.User;
import entity.UserRole;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDAO extends DBConnection {

    //Add an user
    public void addUser(String name, String email, String password, String phone, String location, int role) throws Exception {
        Connection conn = null;
        ResultSet rs = null;
        /* Result set returned by the sqlserver */
        PreparedStatement pre = null;
        /* Prepared statement for executing sql queries */
        String sql = "insert into [User](userName,email,phoneNumber,location,roleId,password)\n"
                + "values(?,?,?,?,?,?)";
        try {
            conn = getConnection();
            pre = conn.prepareStatement(sql);
            pre.setString(1, name);
            pre.setString(2, email);
            pre.setString(3, phone);
            pre.setString(4, location);
            pre.setInt(5, role);
            pre.setString(6, password);
            pre.executeUpdate();
        } catch (Exception ex) {
            throw ex;
        } finally {
            closeResultSet(rs);
            closePreparedStatement(pre);
            closeConnection(conn);
        }
    }

    public User getUserById(int userId) throws Exception {
        Connection conn = null;
        ResultSet rs = null;
        /* Result set returned by the sqlserver */
        PreparedStatement pre = null;
        /* Prepared statement for executing sql queries */
        String sql = "select * from [User] where id = " + userId;
        try {
            conn = getConnection();
            pre = conn.prepareStatement(sql);
            rs = pre.executeQuery();
            if (rs.next()) {
                int id = rs.getInt("id");
                String userName = rs.getString("userName");
                String profilePic = rs.getString("profilePic");
                String email = rs.getString("email");
                String phoneNumber = rs.getString("phoneNumber");
                String location = rs.getString("location");
                Date createdDate = rs.getDate("createdDate");
                UserRole role = getRoleByUserID(id);
                return new User(id, userName, profilePic, email, phoneNumber, location, createdDate, role);
            }
        } catch (Exception ex) {
            throw ex;
        } finally {
            closeResultSet(rs);
            closePreparedStatement(pre);
            closeConnection(conn);
        }
        return null;
    }

    public void updateUserAvatar(int userId, String avatarPath) throws SQLException {
        Connection conn = null;
        PreparedStatement pre = null;
        String sql = "UPDATE [User] SET profilePic = ? WHERE Id = ?";

        try {
            conn = getConnection();
            pre = conn.prepareStatement(sql);
            pre.setString(1, avatarPath);
            pre.setInt(2, userId);
            pre.executeUpdate();
        } catch (SQLException ex) {
            throw ex;
        }
    }

    //Get users by roleId
    public ArrayList<User> getUserByFilter(String roleId, String usernameFilter, String emailFilter, String phoneFilter) throws Exception {
        int addedFilter = 0;
        Connection conn = null;
        ResultSet rs = null;
        /* Result set returned by the sqlserver */
        PreparedStatement pre = null;
        /* Prepared statement for executing sql queries */
        ArrayList<User> users = new ArrayList<>();
        String sql = "select * from [User]";

        if (!roleId.equals("")) {
            int role = Integer.parseInt(roleId);
            if (addedFilter < 1) {
                sql += " where roleId = " + role;
                addedFilter++;
            } else {
                sql += " and roleId = " + role;
            }
        }
        if (!usernameFilter.equals("")) {
            if (addedFilter < 1) {
                String newLine = " where userName like N'%" + usernameFilter + "%'";
                sql += newLine;
                addedFilter++;
            } else {
                String newLine = " and userName like N'%" + usernameFilter + "%'";
                sql += newLine;
            }
        }
        if (!emailFilter.equals("")) {
            if (addedFilter < 1) {
                sql += " where email like N'%" + emailFilter + "%'";
                addedFilter++;
            } else {
                sql += " and email like N'%" + emailFilter + "%'";
            }
        }
        if (!phoneFilter.equals("")) {
            if (addedFilter < 1) {
                sql += " where phoneNumber like N'%" + phoneFilter + "%'";
                addedFilter++;
            } else {
                sql += " and phoneNumber like N'%" + phoneFilter + "%'";
            }
        }

        try {
            conn = getConnection();
            pre = conn.prepareStatement(sql);
            rs = pre.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("id");
                String userName = rs.getString("userName");
                String profilePic = rs.getString("profilePic");
                String email = rs.getString("email");
                String phoneNumber = rs.getString("phoneNumber");
                String location = rs.getString("location");
                Date createdDate = rs.getDate("createdDate");
                UserRole role = getRoleByUserID(id);
                users.add(new User(id, userName, profilePic, email, phoneNumber, location, createdDate, role));
            }
            return users;
        } catch (Exception ex) {
            throw ex;
        } finally {
            closeResultSet(rs);
            closePreparedStatement(pre);
            closeConnection(conn);
        }
    }
    
    //Get all active user role
    public ArrayList<UserRole> getAllUserRole() throws Exception {
        Connection conn = null;
        ResultSet rs = null;
        /* Result set returned by the sqlserver */
        PreparedStatement pre = null;
        /* Prepared statement for executing sql queries */
        ArrayList<UserRole> roles = new ArrayList<>();
        String sql = "select * from [UserRole]";
        try {
            conn = getConnection();
            pre = conn.prepareStatement(sql);
            rs = pre.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("id");
                String roleName = rs.getString("roleName");
                boolean status = rs.getBoolean("status");
                roles.add(new UserRole(id, roleName, status));
            }
            return roles;
        } catch (Exception ex) {
            throw ex;
        } finally {
            closeResultSet(rs);
            closePreparedStatement(pre);
            closeConnection(conn);
        }
    }
    
    //Get all active user role
    public ArrayList<UserRole> getAllUserRoleByText(String text) throws Exception {
        Connection conn = null;
        ResultSet rs = null;
        /* Result set returned by the sqlserver */
        PreparedStatement pre = null;
        /* Prepared statement for executing sql queries */
        ArrayList<UserRole> roles = new ArrayList<>();
        String sql = "select * from [UserRole] where roleName like '%" + text + "%'";
        try {
            conn = getConnection();
            pre = conn.prepareStatement(sql);
            rs = pre.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("id");
                String roleName = rs.getString("roleName");
                boolean status = rs.getBoolean("status");
                roles.add(new UserRole(id, roleName, status));
            }
            return roles;
        } catch (Exception ex) {
            throw ex;
        } finally {
            closeResultSet(rs);
            closePreparedStatement(pre);
            closeConnection(conn);
        }
    }

    //Get all active user role
    public ArrayList<UserRole> getAllActiveUserRole() throws Exception {
        Connection conn = null;
        ResultSet rs = null;
        /* Result set returned by the sqlserver */
        PreparedStatement pre = null;
        /* Prepared statement for executing sql queries */
        ArrayList<UserRole> roles = new ArrayList<>();
        String sql = "select * from [UserRole] where status = 1";
        try {
            conn = getConnection();
            pre = conn.prepareStatement(sql);
            rs = pre.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("id");
                String roleName = rs.getString("roleName");
                boolean status = rs.getBoolean("status");
                roles.add(new UserRole(id, roleName, status));
            }
            return roles;
        } catch (Exception ex) {
            throw ex;
        } finally {
            closeResultSet(rs);
            closePreparedStatement(pre);
            closeConnection(conn);
        }
    }
    
    //Get all active user role
    public ArrayList<UserRole> getAllInactiveUserRole() throws Exception {
        Connection conn = null;
        ResultSet rs = null;
        /* Result set returned by the sqlserver */
        PreparedStatement pre = null;
        /* Prepared statement for executing sql queries */
        ArrayList<UserRole> roles = new ArrayList<>();
        String sql = "select * from [UserRole] where status = 0";
        try {
            conn = getConnection();
            pre = conn.prepareStatement(sql);
            rs = pre.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("id");
                String roleName = rs.getString("roleName");
                boolean status = rs.getBoolean("status");
                roles.add(new UserRole(id, roleName, status));
            }
            return roles;
        } catch (Exception ex) {
            throw ex;
        } finally {
            closeResultSet(rs);
            closePreparedStatement(pre);
            closeConnection(conn);
        }
    }

    //Get all users
    public ArrayList<User> getAllUser() throws Exception {
        Connection conn = null;
        ResultSet rs = null;
        /* Result set returned by the sqlserver */
        PreparedStatement pre = null;
        /* Prepared statement for executing sql queries */
        ArrayList<User> users = new ArrayList<>();
        String sql = "select * from [User]";
        try {
            conn = getConnection();
            pre = conn.prepareStatement(sql);
            rs = pre.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("id");
                String userName = rs.getString("userName");
                String profilePic = rs.getString("profilePic");
                String email = rs.getString("email");
                String phoneNumber = rs.getString("phoneNumber");
                String location = rs.getString("location");
                Date createdDate = rs.getDate("createdDate");
                UserRole role = getRoleByUserID(id);
                users.add(new User(id, userName, profilePic, email, phoneNumber, location, createdDate, role));
            }
            return users;
        } catch (Exception ex) {
            throw ex;
        } finally {
            closeResultSet(rs);
            closePreparedStatement(pre);
            closeConnection(conn);
        }
    }

    //Change current user information
    public void changeUserInformation(String currentUsername, String username, String email, String phoneNumber, String location) throws Exception {
        Connection conn = null;
        ResultSet rs = null;
        /* Result set returned by the sqlserver */
        PreparedStatement pre = null;
        /* Prepared statement for executing sql queries */
        String sql = "UPDATE [User]\n"
                + "SET userName = ? , email = ?, phoneNumber = ?, location = ?\n"
                + "WHERE userName = ?;";
        try {
            conn = getConnection();
            pre = conn.prepareStatement(sql);
            pre.setString(1, username);
            pre.setString(2, email);
            pre.setString(3, phoneNumber);
            pre.setString(4, location);
            pre.setString(5, currentUsername);
            pre.executeUpdate();
        } catch (Exception ex) {
            throw ex;
        } finally {
            closeResultSet(rs);
            closePreparedStatement(pre);
            closeConnection(conn);
        }
    }

    // This method retrieves the UserRole associated with a given user ID.
    public UserRole getRoleByUserID(int userId) {
        UserRole role = null;
        String sql = "SELECT r.id, r.roleName "
                + "FROM [User] u "
                + "JOIN UserRole r ON u.roleId = r.id "
                + "WHERE u.id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                role = new UserRole();
                role.setId(rs.getInt("id"));
                role.setUserRole(rs.getString("roleName"));
            }
        } catch (SQLException e) {
            System.err.println(e);
        }
        return role;
    }

    // The checkLogin method that uses getRoleByUserID
    public User checkLogin(String email, String password) {
        User user = null;
        String sql = "SELECT id, username, profilePic, email, phoneNumber, location, createdDate "
                + "FROM [User] "
                + "WHERE email = ? AND password = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, email);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                user = new User();
                user.setId(rs.getInt("id"));
                user.setUserName(rs.getString("username"));
                user.setProfilePic(rs.getString("profilePic"));
                user.setEmail(rs.getString("email"));
                user.setPhoneNumber(rs.getString("phoneNumber"));
                user.setLocation(rs.getString("location"));
                user.setCreatedDate(rs.getDate("createdDate"));

                // Call the helper method to get the role based on the user id.
                UserRole role = getRoleByUserID(user.getId());
                user.setRole(role);
            }
        } catch (SQLException e) {
            System.err.println(e);
        }
        return user;
    }

    public boolean registerUser(String username, String email, String password, String phone, String location) {
        // Adjust the SQL statement and column names if your table schema differs.
        String sql = "INSERT INTO [User] (username, email, password, roleId, phoneNumber, location) VALUES (?, ?, ?, ?, ? ,?)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, username);
            ps.setString(2, email);
            ps.setString(3, password);
            ps.setInt(4, 2);
            ps.setString(5, phone);
            ps.setString(6, location);
            int affectedRows = ps.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException e) {
            System.err.println(e);
        }
        return false;
    }

    public boolean isUsernameExist(String username) {
        String sql = "SELECT id FROM [User] WHERE userName = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return true;
            }
        } catch (SQLException e) {
            System.err.println(e);
        }
        return false;
    }

    // Check if an email already exists
    public boolean isEmailExist(String email) {
        String sql = "SELECT id FROM [User] WHERE email = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return true;
            }
        } catch (SQLException e) {
            System.err.println(e);
        }
        return false;
    }

    public boolean isPhoneNumberExist(String phoneNumber) {
        String sql = "SELECT id FROM [User] WHERE phoneNumber = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, phoneNumber);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return true;
            }
        } catch (SQLException e) {
            System.err.println(e);
        }
        return false;
    }

    public boolean changePassword(int userId, String oldPassword, String newPassword) {
        String sql = "UPDATE [User] SET password = ? WHERE id = ? AND password = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, newPassword);
            ps.setInt(2, userId);
            ps.setString(3, oldPassword);  // This check ensures the old password is correct.
            int rows = ps.executeUpdate();
            return rows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public static void main(String[] args) throws Exception {
        UserDAO userDAO = new UserDAO();
        List<UserRole> roles = userDAO.getAllUserRoleByText("a");
        for (int i = 0; i < roles.size(); i++) {
            System.out.println(roles.get(i));
        }
    }
}
