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
public class ProductDAO extends DBConnection{

    public ProductDAO() {
    }
    
    public ArrayList<Product> getAllProduct() throws Exception{
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
}
