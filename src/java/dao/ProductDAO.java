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
import java.util.ArrayList;

/**
 *
 * @author OS
 */
public class ProductDAO extends DBConnection {

    public ProductDAO() {
    }

    public ArrayList<Product> getAllProduct() throws Exception {
        Connection conn = null;
        ResultSet rs = null;
        /* Result set returned by the sqlserver */
        PreparedStatement pre = null;
        /* Prepared statement for executing sql queries */
        ArrayList<Product> productList = new ArrayList<>();
        String sql = "SELECT * FROM Product";
        try {
            conn = getConnection();
            pre = conn.prepareStatement(sql);
            rs = pre.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("id");
                String name = rs.getString("name");
                String image = rs.getString("image");
                int quantity = rs.getInt("quantity");
                int price = rs.getInt("price");
                int categoryId = rs.getInt("categoryId");
                int typeId = rs.getInt("typeId");
                productList.add(new Product(id, name, image, quantity, price, categoryId, typeId));
            }
            return productList;
        } catch (Exception ex) {
            throw ex;
        } finally {
            closeResultSet(rs);
            closePreparedStatement(pre);
            closeConnection(conn);
        }
    }

    public ArrayList<Product> getProductByCategory(int categoryId) throws Exception {
        Connection conn = null;
        ResultSet rs = null;
        /* Result set returned by the sqlserver */
        PreparedStatement pre = null;
        /* Prepared statement for executing sql queries */
        ArrayList<Product> productList = new ArrayList<>();
        String sql = "SELECT * FROM Product where categoryId = " + categoryId;
        try {
            conn = getConnection();
            pre = conn.prepareStatement(sql);
            rs = pre.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("id");
                String name = rs.getString("name");
                String image = rs.getString("image");
                int quantity = rs.getInt("quantity");
                int price = rs.getInt("price");
                int category = rs.getInt("categoryId");
                int typeId = rs.getInt("typeId");
                productList.add(new Product(id, name, image, quantity, price, category, typeId));
            }
            return productList;
        } catch (Exception e) {
            throw e;
        } finally {
            closeResultSet(rs);
            closePreparedStatement(pre);
            closeConnection(conn);
        }
    }

    public ArrayList<Product> getProductByType(int typeId) throws Exception {
        Connection conn = null;
        ResultSet rs = null;
        /* Result set returned by the sqlserver */
        PreparedStatement pre = null;
        /* Prepared statement for executing sql queries */
        ArrayList<Product> productList = new ArrayList<>();
        String sql = "SELECT * FROM Product where typeId = " + typeId;
        try {
            conn = getConnection();
            pre = conn.prepareStatement(sql);
            rs = pre.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("id");
                String name = rs.getString("name");
                String image = rs.getString("image");
                int quantity = rs.getInt("quantity");
                int price = rs.getInt("price");
                int category = rs.getInt("categoryId");
                int typeID = rs.getInt("typeId");
                productList.add(new Product(id, name, image, quantity, price, category, typeID));
            }
            return productList;
        } catch (Exception e) {
            throw e;
        } finally {
            closeResultSet(rs);
            closePreparedStatement(pre);
            closeConnection(conn);
        }
    }

    public ArrayList<Product> getProductByText(String text) throws Exception {
        Connection conn = null;
        ResultSet rs = null;
        /* Result set returned by the sqlserver */
        PreparedStatement pre = null;
        /* Prepared statement for executing sql queries */
        ArrayList<Product> productList = new ArrayList<>();
        String sql = "select p.*from Product p "
                + "inner join Category c on p.categoryId = c.id "
                + "inner join ProductType pt on pt.id = p.typeId "
                + "where p.name COLLATE Latin1_General_CI_AI like '%" + text + "%' "
                + "OR c.name COLLATE Latin1_General_CI_AI like '%" + text + "%'  "
                + "OR pt.name COLLATE Latin1_General_CI_AI like '%" + text + "%'";
        try {
            conn = getConnection();
            pre = conn.prepareStatement(sql);
            rs = pre.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("id");
                String name = rs.getString("name");
                String image = rs.getString("image");
                int quantity = rs.getInt("quantity");
                int price = rs.getInt("price");
                int category = rs.getInt("categoryId");
                int typeID = rs.getInt("typeId");
                productList.add(new Product(id, name, image, quantity, price, category, typeID));
            }
            return productList;
        } catch (Exception e) {
            throw e;
        } finally {
            closeResultSet(rs);
            closePreparedStatement(pre);
            closeConnection(conn);
        }

    }

    public static void main(String[] args) throws Exception {
        ProductDAO productDAO = new ProductDAO();
        ArrayList<Product> productList = productDAO.getProductByText("om");
        for (int i = 0; i < productList.size(); i++) {
            System.out.println(productList.get(i).getName());
        }
    }
}
