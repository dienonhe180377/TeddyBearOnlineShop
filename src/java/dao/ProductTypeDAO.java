/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import entity.Product;
import entity.ProductType;
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
public class ProductTypeDAO extends DBConnection {

    public ProductTypeDAO() {
    }
    
    //Update a type
    public int editType(int id, String name, boolean status) throws Exception {
        Connection conn = null;
        PreparedStatement pre = null;

        String sql = "update ProductType\n"
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

    //Add New ProductType
    public void addProductType(String name, boolean status) throws Exception {
        Connection conn = null;
        ResultSet rs = null;
        /* Result set returned by the sqlserver */
        PreparedStatement pre = null;
        /* Prepared statement for executing sql queries */
        String sql = "INSERT INTO [dbo].[ProductType] ([name], [status]) VALUES (?,?)";
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

    public ProductType getProductTypeById(int typeId) throws Exception {
        Connection conn = null;
        ResultSet rs = null;
        /* Result set returned by the sqlserver */
        PreparedStatement pre = null;
        /* Prepared statement for executing sql queries */
        String sql = "SELECT * FROM ProductType where id = " + typeId;
        try {
            ProductType type = new ProductType();
            conn = getConnection();
            pre = conn.prepareStatement(sql);
            rs = pre.executeQuery();
            if (rs.next()) {
                int id = rs.getInt("id");
                String name = rs.getString("name");
                boolean status = rs.getBoolean("status");
                type.setId(id);
                type.setName(name);
                type.setStatus(status);
            }
            return type;
        } catch (Exception e) {
            throw e;
        } finally {
            closeResultSet(rs);
            closePreparedStatement(pre);
            closeConnection(conn);
        }
    }

    public ProductType getById(int id) {
        String sql = "SELECT * FROM ProductType WHERE id = ?";
        try {
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, id);
            try (ResultSet rs = statement.executeQuery()) {
                if (rs.next()) {
                    ProductType productType = new ProductType();
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

    public List<ProductType> getAllActiveProductTypes() {
        List<ProductType> productTypes = new ArrayList<>();
        String sql = "SELECT * FROM ProductType where status = 1";
        try {
            PreparedStatement statement = connection.prepareStatement(sql);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                ProductType productType = new ProductType();
                productType.setId(rs.getInt("id"));
                productType.setName(rs.getString("name"));
                productType.setStatus(rs.getBoolean("status"));
                productTypes.add(productType);
            }
        } catch (SQLException ex) {
            System.out.println("Error retrieving product types: " + ex);
        }
        return productTypes;
    }

    public List<ProductType> getAllInactiveProductTypes() {
        List<ProductType> productTypes = new ArrayList<>();
        String sql = "SELECT * FROM ProductType where status = 0";
        try {
            PreparedStatement statement = connection.prepareStatement(sql);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                ProductType productType = new ProductType();
                productType.setId(rs.getInt("id"));
                productType.setName(rs.getString("name"));
                productType.setStatus(rs.getBoolean("status"));
                productTypes.add(productType);
            }
        } catch (SQLException ex) {
            System.out.println("Error retrieving product types: " + ex);
        }
        return productTypes;
    }

    public List<ProductType> getAllProductTypes() {
        List<ProductType> productTypes = new ArrayList<>();
        String sql = "SELECT * FROM ProductType";
        try {
            PreparedStatement statement = connection.prepareStatement(sql);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                ProductType productType = new ProductType();
                productType.setId(rs.getInt("id"));
                productType.setName(rs.getString("name"));
                productType.setStatus(rs.getBoolean("status"));
                productTypes.add(productType);
            }
        } catch (SQLException ex) {
            System.out.println("Error retrieving product types: " + ex);
        }
        return productTypes;
    }

    public List<ProductType> getAllProductTypesByText(String text) throws Exception {
        Connection conn = null;
        ResultSet rs = null;
        /* Result set returned by the sqlserver */
        PreparedStatement pre = null;
        /* Prepared statement for executing sql queries */
        ArrayList<ProductType> typeList = new ArrayList<>();
        String sql = "SELECT * FROM ProductType where name COLLATE Latin1_General_CI_AI like '%" + text + "%'";
        try {
            conn = getConnection();
            pre = conn.prepareStatement(sql);
            rs = pre.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("id");
                String name = rs.getString("name");
                boolean status = rs.getBoolean("status");
                typeList.add(new ProductType(id, name, status));
            }
            return typeList;
        } catch (Exception ex) {
            throw ex;
        } finally {
            closeResultSet(rs);
            closePreparedStatement(pre);
            closeConnection(conn);
        }
    }

    public boolean checkProductTypeExisted(String content) throws Exception {
        List<ProductType> typeExisted = getAllProductTypes();
        for (int i = 0; i < typeExisted.size(); i++) {
            String type = typeExisted.get(i).getName().toLowerCase().trim();
            content = content.toLowerCase().trim();
            if (type.equals(content)) {
                return true;
            }
        }
        return false;
    }

    public static void main(String[] args) {
        ProductTypeDAO productTypeDAO = new ProductTypeDAO();
        List<ProductType> productTypes = productTypeDAO.getAllProductTypes();
        System.out.println(productTypes.size());

    }
}
