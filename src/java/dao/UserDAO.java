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

    //Get all Customer
    public ArrayList<User> getAllCustomer() throws Exception {
        Connection conn = null;
        ResultSet rs = null;
        /* Result set returned by the sqlserver */
        PreparedStatement pre = null;
        /* Prepared statement for executing sql queries */
        ArrayList<User> users = new ArrayList<>();
        String sql = "select * from [User] where roleId = 1";
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

    //Delete a role
    public int deleteUserRole(int id) throws Exception {
        Connection conn = null;
        PreparedStatement pre = null;

        String sql = "delete from UserRole where id = ?";
        try {
            conn = getConnection();
            pre = conn.prepareStatement(sql);
            pre.setInt(1, id);
            int successCheck = pre.executeUpdate();
            return successCheck;
        } catch (Exception e) {
            throw e;
        } finally {
            closeConnection(conn);
            closePreparedStatement(pre);
        }
    }

    //Get User By Role
    public List<User> getUsersByRole(int roleId) throws Exception {
        Connection conn = null;
        ResultSet rs = null;
        /* Result set returned by the sqlserver */
        PreparedStatement pre = null;
        /* Prepared statement for executing sql queries */
        List<User> users = new ArrayList<>();
        String sql = "select * from [User] where roleId = " + roleId;
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
        } catch (Exception e) {
            throw e;
        } finally {
            closeResultSet(rs);
            closePreparedStatement(pre);
            closeConnection(conn);
        }
    }

    //Update a role
    public int editUserRole(int id, String name, boolean status) throws Exception {
        Connection conn = null;
        PreparedStatement pre = null;

        String sql = "update UserRole\n"
                + "set status = ? , roleName = ?\n"
                + "where id = ?";

        try {
            conn = getConnection();
            pre = conn.prepareStatement(sql);
            pre.setBoolean(1, status);
            pre.setString(2, name);
            pre.setInt(3, id);
            int success = pre.executeUpdate();
            return success;
        } catch (Exception e) {
            throw e;
        } finally {
            closeConnection(conn);
            closePreparedStatement(pre);
        }
    }

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

    public void updateUserAvatar(int userId, String avatarPath) throws SQLException, Exception {
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
        } finally {
            closeConnection(conn);
            closePreparedStatement(pre);
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

    //Get Role By Id
    public UserRole getRoleById(int id) throws Exception {
        Connection conn = null;
        ResultSet rs = null;
        /* Result set returned by the sqlserver */
        PreparedStatement pre = null;
        /* Prepared statement for executing sql queries */
        UserRole role = null;
        String sql = "SELECT * FROM UserRole where id = " + id;
        try {
            conn = getConnection();
            pre = conn.prepareStatement(sql);
            rs = pre.executeQuery();
            while (rs.next()) {
                int iD = rs.getInt("id");
                String name = rs.getString("roleName");
                boolean status = rs.getBoolean("status");
                role = new UserRole(iD, name, status);
            }
            return role;
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

    //Add New UserRole
    public void addUserRole(String name, boolean status) throws Exception {
        Connection conn = null;
        ResultSet rs = null;
        /* Result set returned by the sqlserver */
        PreparedStatement pre = null;
        /* Prepared statement for executing sql queries */
        String sql = "INSERT INTO [dbo].[UserRole] ([roleName], [status]) VALUES (?,?)";
        try {
            conn = getConnection();
            pre = conn.prepareStatement(sql);
            pre.setString(1, name);
            pre.setBoolean(2, status);
            pre.executeUpdate();
        } catch (Exception ex) {
            throw ex;
        } finally {
            closeResultSet(rs);
            closePreparedStatement(pre);
            closeConnection(conn);
        }
    }

    //Check duplicated user role
    public boolean checkRoleExisted(String content) throws Exception {
        List<UserRole> roleExisted = getAllUserRole();
        for (int i = 0; i < roleExisted.size(); i++) {
            String role = roleExisted.get(i).getName().toLowerCase().trim();
            content = content.toLowerCase().trim();
            if (role.equals(content)) {
                return true;
            }
        }
        return false;
    }

    public List<User> getAllUsersWithParam(String searchParam, Integer role) throws Exception {
        List<User> users = new ArrayList<>();
        List<Object> list = new ArrayList<>();
        StringBuilder query = new StringBuilder("select * from [User] u where (roleId = 3 or roleId = 2)");

        PreparedStatement preparedStatement;
        if (searchParam != null && !searchParam.trim().isEmpty()) {
            query.append(" AND (u.userName LIKE ? OR u.email LIKE ? OR u.phoneNumber LIKE ? ) ");
            String searchPattern = "%" + searchParam.trim() + "%";
            list.add(searchPattern);  // For fullName
            list.add(searchPattern);  // For email
            list.add(searchPattern);  // For account
        }

        if (role != null) {
            query.append(" AND u.roleId = ? ");
            list.add(role);
        }

        query.append(" ORDER BY u.id DESC ");
        preparedStatement = connection.prepareStatement(query.toString());

        // Map the parameters
        mapParams(preparedStatement, list);
        try (ResultSet rs = preparedStatement.executeQuery()) {

            while (rs.next()) {
                int id = rs.getInt("id");
                String userName = rs.getString("userName");
                String profilePic = rs.getString("profilePic");
                String email = rs.getString("email");
                String phoneNumber = rs.getString("phoneNumber");
                String location = rs.getString("location");
                Date createdDate = rs.getDate("createdDate");
                UserRole roles = getRoleByUserID(id);
                users.add(new User(id, userName, profilePic, email, phoneNumber, location, createdDate, roles));
            }
            return users;
        } catch (Exception ex) {
            throw ex;
        }
    }
// In your UserDAO class

    public void updateUser(int userId, String userName, String email, String phone, String location, int role) throws Exception {
        Connection conn = null;
        PreparedStatement pre = null;
        String sql = "UPDATE [User] SET userName = ?, email = ?, phoneNumber = ?, location = ?, roleId = ? WHERE id = ?";
        try {
            conn = getConnection();
            pre = conn.prepareStatement(sql);
            pre.setString(1, userName);
            pre.setString(2, email);
            pre.setString(3, phone);
            pre.setString(4, location);
            pre.setInt(5, role);
            pre.setInt(6, userId);
            pre.executeUpdate();
        } catch (Exception ex) {
            throw ex;
        }
    }

    public void mapParams(PreparedStatement ps, List<Object> args) throws SQLException {
        int i = 1;
        for (Object arg : args) {
            if (arg instanceof java.util.Date) {
                ps.setTimestamp(i++, new Timestamp(((java.util.Date) arg).getTime()));
            } else if (arg instanceof Integer) {
                ps.setInt(i++, (Integer) arg);
            } else if (arg instanceof Long) {
                ps.setLong(i++, (Long) arg);
            } else if (arg instanceof Double) {
                ps.setDouble(i++, (Double) arg);
            } else if (arg instanceof Float) {
                ps.setFloat(i++, (Float) arg);
            } else {
                ps.setString(i++, (String) arg);
            }

        }
    }

    public List<User> Paging(List<User> users, int page, int pageSize) {
        int fromIndex = (page - 1) * pageSize;
        int toIndex = Math.min(fromIndex + pageSize, users.size());

        if (fromIndex > toIndex) {
            // Handle the case where fromIndex is greater than toIndex
            fromIndex = toIndex;
        }

        return users.subList(fromIndex, toIndex);
    }

    /**
     * Gets all users with customer role
     *
     * @return List<User> List of customers
     * @throws Exception if a database error occurs
     */
    public List<User> getAllCustomers() throws Exception {
        Connection conn = null;
        ResultSet rs = null;
        PreparedStatement pre = null;
        List<User> customers = new ArrayList<>();

        // Find users with roleId = 2 (customer role)
        String sql = "SELECT * FROM [User] WHERE roleId = 1";
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

                // Get the user role object using existing helper method
                UserRole role = getRoleByUserID(id);

                customers.add(new User(id, userName, profilePic, email, phoneNumber, location, createdDate, role));
            }
            return customers;
        } catch (Exception ex) {
            throw ex;
        } finally {
            closeResultSet(rs);
            closePreparedStatement(pre);
            closeConnection(conn);
        }
    }

    public static void main(String[] args) throws Exception {
        UserDAO userDAO = new UserDAO();
        List<User> roles = userDAO.getAllUser();
        System.out.println(roles);
    }

}
