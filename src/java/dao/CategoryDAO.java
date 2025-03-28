/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import entity.Category;
import entity.Product;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author OS
 */
public class CategoryDAO extends DBConnection {

    public CategoryDAO() {
    }
    
    //Get Active Category where product > 0
    public ArrayList<Category> getActiveCategoryHaveProduct() throws Exception{
        Connection conn = null;
        ResultSet rs = null;
        /* Result set returned by the sqlserver */
        PreparedStatement pre = null;
        /* Prepared statement for executing sql queries */
        ProductDAO productDAO = new ProductDAO();
        ArrayList<Category> categoryList = new ArrayList<>();
        String sql = "SELECT * FROM Category where [status] = 1";
        try {
            conn = getConnection();
            pre = conn.prepareStatement(sql);
            rs = pre.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("id");
                String name = rs.getString("name");
                boolean status = rs.getBoolean("status");
                ArrayList<Product> products = productDAO.getProductByCategory(id);
                if(products.isEmpty()){
                    continue;
                } else {
                    categoryList.add(new Category(id, name, status));
                }
            }
            return categoryList;
        } catch (Exception ex) {
            throw ex;
        } finally {
            closeResultSet(rs);
            closePreparedStatement(pre);
            closeConnection(conn);
        }
    }
    
    //Delete a category
    public int deleteCategory(int id) throws Exception{
        Connection conn = null;
        PreparedStatement pre = null;
        
        String sql = "delete from Category where id = ?";
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
    
    //Update a category
    public int editCategory(int id, String name, boolean status) throws Exception {
        Connection conn = null;
        PreparedStatement pre = null;

        String sql = "update Category\n"
                + "set status = ? , name = ?\n"
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
    
    //Get Category By Id
    public Category getCategoryById(int id) throws Exception {
        Connection conn = null;
        ResultSet rs = null;
        /* Result set returned by the sqlserver */
        PreparedStatement pre = null;
        /* Prepared statement for executing sql queries */
        Category category = null;
        String sql = "SELECT * FROM Category where id = " + id;
        try {
            conn = getConnection();
            pre = conn.prepareStatement(sql);
            rs = pre.executeQuery();
            while (rs.next()) {
                int iD = rs.getInt("id");
                String name = rs.getString("name");
                boolean status = rs.getBoolean("status");
                category = new Category(iD, name, status);
            }
            return category;
        } catch (Exception ex) {
            throw ex;
        } finally {
            closeResultSet(rs);
            closePreparedStatement(pre);
            closeConnection(conn);
        }
    }
    
    //Add New Category
    public void addCategory(String name , boolean status) throws Exception {
        Connection conn = null;
        ResultSet rs = null;
        /* Result set returned by the sqlserver */
        PreparedStatement pre = null;
        /* Prepared statement for executing sql queries */
        ArrayList<Category> categoryList = new ArrayList<>();
        String sql = "INSERT INTO [dbo].[Category] ([name], [status]) VALUES (?,?)";
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
    
    //Get All Category
    public ArrayList<Category> getAllCategory() throws Exception {
        Connection conn = null;
        ResultSet rs = null;
        /* Result set returned by the sqlserver */
        PreparedStatement pre = null;
        /* Prepared statement for executing sql queries */
        ArrayList<Category> categoryList = new ArrayList<>();
        String sql = "SELECT * FROM Category";
        try {
            conn = getConnection();
            pre = conn.prepareStatement(sql);
            rs = pre.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("id");
                String name = rs.getString("name");
                boolean status = rs.getBoolean("status");
                categoryList.add(new Category(id, name, status));
            }
            return categoryList;
        } catch (Exception ex) {
            throw ex;
        } finally {
            closeResultSet(rs);
            closePreparedStatement(pre);
            closeConnection(conn);
        }
    }
    
    //Get All Category By Text
    public ArrayList<Category> getAllCategoryByText(String text) throws Exception {
        Connection conn = null;
        ResultSet rs = null;
        /* Result set returned by the sqlserver */
        PreparedStatement pre = null;
        /* Prepared statement for executing sql queries */
        ArrayList<Category> categoryList = new ArrayList<>();
        String sql = "SELECT * FROM Category where name COLLATE Latin1_General_CI_AI like '%" + text + "%'";
        try {
            conn = getConnection();
            pre = conn.prepareStatement(sql);
            rs = pre.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("id");
                String name = rs.getString("name");
                boolean status = rs.getBoolean("status");
                categoryList.add(new Category(id, name, status));
            }
            return categoryList;
        } catch (Exception ex) {
            throw ex;
        } finally {
            closeResultSet(rs);
            closePreparedStatement(pre);
            closeConnection(conn);
        }
    }
    
    //Get all active category
    public ArrayList<Category> getAllInactiveCategory() throws Exception {
        Connection conn = null;
        ResultSet rs = null;
        /* Result set returned by the sqlserver */
        PreparedStatement pre = null;
        /* Prepared statement for executing sql queries */
        ArrayList<Category> categoryList = new ArrayList<>();
        String sql = "SELECT * FROM Category where [status] = 0";
        try {
            conn = getConnection();
            pre = conn.prepareStatement(sql);
            rs = pre.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("id");
                String name = rs.getString("name");
                boolean status = rs.getBoolean("status");
                categoryList.add(new Category(id, name, status));
            }
            return categoryList;
        } catch (Exception ex) {
            throw ex;
        } finally {
            closeResultSet(rs);
            closePreparedStatement(pre);
            closeConnection(conn);
        }
    }
    
    //Get all active category
    public ArrayList<Category> getAllActiveCategory() throws Exception {
        Connection conn = null;
        ResultSet rs = null;
        /* Result set returned by the sqlserver */
        PreparedStatement pre = null;
        /* Prepared statement for executing sql queries */
        ArrayList<Category> categoryList = new ArrayList<>();
        String sql = "SELECT * FROM Category where [status] = 1";
        try {
            conn = getConnection();
            pre = conn.prepareStatement(sql);
            rs = pre.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("id");
                String name = rs.getString("name");
                boolean status = rs.getBoolean("status");
                categoryList.add(new Category(id, name, status));
            }
            return categoryList;
        } catch (Exception ex) {
            throw ex;
        } finally {
            closeResultSet(rs);
            closePreparedStatement(pre);
            closeConnection(conn);
        }
    }

    //Get a category with id
    public Category getById(int id) {
        String sql = "SELECT * FROM Category WHERE id = ?";
        try {
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, id);
            try (ResultSet rs = statement.executeQuery()) {
                if (rs.next()) {
                    Category productType = new Category();
                    productType.setId(rs.getInt("id"));
                    productType.setName(rs.getString("Name"));
                    return productType;
                }
            }
        } catch (SQLException ex) {
            System.out.println("Error in product type dao " + ex);
        }
        return null;
    }

    
    public List<Category> getAllCategories() {
        List<Category> categories = new ArrayList<>();
        String sql = "SELECT * FROM Category";
        try {
            PreparedStatement statement = connection.prepareStatement(sql);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                Category category = new Category();
                category.setId(rs.getInt("id"));
                category.setName(rs.getString("name"));
                categories.add(category);
            }
        } catch (SQLException ex) {
            System.out.println("Error retrieving categories: " + ex);
        }
        return categories;
    }
    
    public boolean checkCategoryExisted(String content) throws Exception{
        ArrayList<Category> categoryExisted = getAllCategory();
        for (int i = 0; i < categoryExisted.size(); i++) {
            String category = categoryExisted.get(i).getName().toLowerCase().trim();
            content = content.toLowerCase().trim();
            if(category.equals(content)){
                return true;
            }
        }
        return false;
    }
    
    public static void main(String[] args) throws Exception {
        CategoryDAO categoryDAO = new CategoryDAO();
        List<Category> categoryList = categoryDAO.getActiveCategoryHaveProduct();
        for (int i = 0; i < categoryList.size(); i++) {
            System.out.println(categoryList.get(i));
        }
    }
}
