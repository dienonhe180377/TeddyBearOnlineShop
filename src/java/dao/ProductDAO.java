/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import entity.Category;
import entity.Product;
import entity.ProductImage;
import entity.ProductType;
import entity.Size;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.DecimalFormat;
import java.text.DecimalFormatSymbols;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Locale;

/**
 *
 * @author OS
 */
public class ProductDAO extends DBConnection {
    
    private CategoryDAO categoryDAO = new CategoryDAO();
    private ProductTypeDAO productTypeDAO = new ProductTypeDAO();

    public ProductDAO() {
    }
    
    public ArrayList<ProductImage> getProductImages(int productId) throws Exception{
        Connection conn = null;
        ResultSet rs = null;
        /* Result set returned by the sqlserver */
        PreparedStatement pre = null;
        ArrayList<ProductImage> images = new ArrayList<>();
        String sql = "select * from ProductImage where productId = " + productId;
        try {
            conn = getConnection();
            pre = conn.prepareStatement(sql);
            rs = pre.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("id");
                String source = rs.getString("source");
                images.add(new ProductImage(id, source));
            }
            return images;
        } catch (Exception ex) {
            throw ex;
        } finally {
            closeResultSet(rs);
            closePreparedStatement(pre);
            closeConnection(conn);
        }
    }
    
    public ArrayList<Size> getProductSizes(int productId) throws Exception{
        Connection conn = null;
        ResultSet rs = null;
        /* Result set returned by the sqlserver */
        PreparedStatement pre = null;
        ArrayList<Size> sizes = new ArrayList<>();
        String sql = "select * from Size where productId = " + productId;
        try {
            conn = getConnection();
            pre = conn.prepareStatement(sql);
            rs = pre.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("id");
                String name = rs.getString("name");
                int quantity = rs.getInt("quantity");
                int priceNumber = rs.getInt("price");
                DecimalFormatSymbols symbols = new DecimalFormatSymbols(Locale.getDefault());
                symbols.setGroupingSeparator('.');
                DecimalFormat decimalFormat = new DecimalFormat("#,###", symbols);
                String price = decimalFormat.format(priceNumber);
                sizes.add(new Size(id, name, quantity, price));
            }
            return sizes;
        } catch (Exception ex) {
            throw ex;
        } finally {
            closeResultSet(rs);
            closePreparedStatement(pre);
            closeConnection(conn);
        }
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
                ArrayList<ProductImage> images = getProductImages(id);
                ArrayList<Size> sizes = getProductSizes(id);
                int categoryId = rs.getInt("categoryId");
                int typeId = rs.getInt("typeId");
                Category category = categoryDAO.getById(categoryId);
                ProductType type = productTypeDAO.getProductTypeById(typeId);
                productList.add(new Product(id, name, images, sizes, type, category));
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
    
    public Product getProductById(int productId) throws Exception {
        Connection conn = null;
        ResultSet rs = null;
        /* Result set returned by the sqlserver */
        PreparedStatement pre = null;
        /* Prepared statement for executing sql queries */
        Product product = null;
        String sql = "SELECT * FROM Product where id = " + productId;
        try {
            conn = getConnection();
            pre = conn.prepareStatement(sql);
            rs = pre.executeQuery();
            if (rs.next()) {
                int id = rs.getInt("id");
                String name = rs.getString("name");
                ArrayList<ProductImage> images = getProductImages(id);
                ArrayList<Size> sizes = getProductSizes(id);
                int categoryId = rs.getInt("categoryId");
                int typeId = rs.getInt("typeId");
                Category category = categoryDAO.getById(categoryId);
                ProductType type = productTypeDAO.getProductTypeById(typeId);
                product = new Product(id, name, images, sizes, type, category);
            }
            return product;
        } catch (Exception e) {
            throw e;
        } finally {
            closeResultSet(rs);
            closePreparedStatement(pre);
            closeConnection(conn);
        }
    }

    public ArrayList<Product> getProductByCategory(int categoryID) throws Exception {
        Connection conn = null;
        ResultSet rs = null;
        /* Result set returned by the sqlserver */
        PreparedStatement pre = null;
        /* Prepared statement for executing sql queries */
        ArrayList<Product> productList = new ArrayList<>();
        String sql = "SELECT * FROM Product where categoryId = " + categoryID;
        try {
            conn = getConnection();
            pre = conn.prepareStatement(sql);
            rs = pre.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("id");
                String name = rs.getString("name");
                ArrayList<ProductImage> images = getProductImages(id);
                ArrayList<Size> sizes = getProductSizes(id);
                int categoryId = rs.getInt("categoryId");
                int typeId = rs.getInt("typeId");
                Category category = categoryDAO.getById(categoryId);
                ProductType type = productTypeDAO.getProductTypeById(typeId);
                productList.add(new Product(id, name, images, sizes, type, category));
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

    public ArrayList<Product> getProductByType(int typeID) throws Exception {
        Connection conn = null;
        ResultSet rs = null;
        /* Result set returned by the sqlserver */
        PreparedStatement pre = null;
        /* Prepared statement for executing sql queries */
        ArrayList<Product> productList = new ArrayList<>();
        String sql = "SELECT * FROM Product where typeId = " + typeID;
        try {
            conn = getConnection();
            pre = conn.prepareStatement(sql);
            rs = pre.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("id");
                String name = rs.getString("name");
                ArrayList<ProductImage> images = getProductImages(id);
                ArrayList<Size> sizes = getProductSizes(id);
                int categoryId = rs.getInt("categoryId");
                int typeId = rs.getInt("typeId");
                Category category = categoryDAO.getById(categoryId);
                ProductType type = productTypeDAO.getProductTypeById(typeId);
                productList.add(new Product(id, name, images, sizes, type, category));
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
                ArrayList<ProductImage> images = getProductImages(id);
                ArrayList<Size> sizes = getProductSizes(id);
                int categoryId = rs.getInt("categoryId");
                int typeId = rs.getInt("typeId");
                Category category = categoryDAO.getById(categoryId);
                ProductType type = productTypeDAO.getProductTypeById(typeId);
                productList.add(new Product(id, name, images, sizes, type, category));
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

    
     public List<Product> getProductsWithParam(String searchParam, Integer categoryId, Integer typeId, Integer minPrice, Integer maxPrice) {
        List<Product> products = new ArrayList<>();
        List<Object> list = new ArrayList<>();
        ProductTypeDAO productTypeDAO = new ProductTypeDAO();
        CategoryDAO categoryDAO = new CategoryDAO();
        try {
            StringBuilder query = new StringBuilder("SELECT * from Product WHERE 1=1");

            if (searchParam != null && !searchParam.trim().isEmpty()) {
                query.append(" AND Name LIKE ? ");
                list.add("%" + searchParam + "%");
            }
            if (categoryId != null) {
                query.append(" AND categoryId = ? ");
                list.add(categoryId);
            }
            if (typeId != null) {
                query.append(" AND typeId = ? ");
                list.add(typeId);
            }
            if (minPrice != null) {
                query.append(" AND price >= ? ");
                list.add(minPrice);
            }
            if (maxPrice != null) {
                query.append(" AND price <= ? ");
                list.add(maxPrice);
            }

            query.append(" ORDER BY id DESC");
            PreparedStatement preparedStatement = connection.prepareStatement(query.toString());
            mapParams(preparedStatement, list);
            try (ResultSet rs = preparedStatement.executeQuery()) {
                while (rs.next()) {
                    Product product = new Product();
                    product.setId(rs.getInt("id"));
                    product.setName(rs.getString("name"));
                    product.setImage(rs.getString("image"));
                    product.setDescription(rs.getString("description"));
                    product.setQuantity(rs.getInt("quantity"));
                    product.setPrice(rs.getString("price"));
                    ProductType productType = productTypeDAO.getById(rs.getInt("typeId"));
                    Category category = categoryDAO.getById(rs.getInt("categoryId"));
                    product.setCategory(category);
                    product.setProductType(productType);
                    products.add(product);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return products;
    }

    public void addProduct(Product product) {
        String sql = "INSERT INTO Product (name, image, description, quantity, price, categoryId, typeId) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try {
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, product.getName());
            statement.setString(2, product.getImage());
            statement.setString(3, product.getDescription());
            statement.setInt(4, product.getQuantity());
            statement.setString(5, product.getPrice());
            statement.setInt(6, product.getCategory().getId());
            statement.setInt(7, product.getProductType().getId());
            statement.executeUpdate();
        } catch (SQLException ex) {
            System.out.println("Error adding product: " + ex);
        }
    }

    public Product getById(int id) {
        String sql = "SELECT * FROM Product WHERE id = ?";
        try {
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, id);
            ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                Product product = new Product();
                product.setId(rs.getInt("id"));
                product.setName(rs.getString("name"));
                product.setImage(rs.getString("image"));
                product.setDescription(rs.getString("description"));
                product.setQuantity(rs.getInt("quantity"));
                product.setPrice(rs.getString("price"));
                product.setCategory(new CategoryDAO().getById(rs.getInt("categoryId")));
                product.setProductType(new ProductTypeDAO().getById(rs.getInt("typeId")));
                return product;
            }
        } catch (SQLException ex) {
            System.out.println("Error fetching product: " + ex);
        }
        return null;
    }

    public void mapParams(PreparedStatement ps, List<Object> args) throws SQLException {
        int i = 1;
        for (Object arg : args) {
            if (arg instanceof Date) {
                ps.setTimestamp(i++, new Timestamp(((Date) arg).getTime()));
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

    public List<Product> Paging(List<Product> products, int page, int pageSize) {
        int fromIndex = (page - 1) * pageSize;
        int toIndex = Math.min(fromIndex + pageSize, products.size());

        if (fromIndex > toIndex) {
            // Handle the case where fromIndex is greater than toIndex
            fromIndex = toIndex;
        }

        return products.subList(fromIndex, toIndex);
    }
    
}