/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import entity.Category;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

/**
 *
 * @author OS
 */
public class CategoryDAO extends DBConnection{

    public CategoryDAO() {
    }
    
    public ArrayList<Category> getAllCategory() throws Exception{
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
               categoryList.add(new Category(id, name));
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
    
}
