package dao;

import entity.Category;
import entity.ProductCRUD;
import entity.ProductImageCRUD;
import entity.ProductTypeCRUD;
import entity.SizeCRUD;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProductCRUDDAO extends DBConnection {

    public ProductCRUDDAO() {
    }

    // ======== PRODUCT METHODS ========
    public List<ProductCRUD> getAllProducts() throws Exception {
        List<ProductCRUD> products = new ArrayList<>();
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        String sql = "SELECT id, name, categoryId, typeId, description, purchase_guide, warranty_info FROM Product";

        try {
            conn = getConnection();
            stmt = conn.createStatement();
            rs = stmt.executeQuery(sql);

            while (rs.next()) {
                ProductCRUD product = new ProductCRUD();
                product.setId(rs.getInt("id"));
                product.setName(rs.getString("name"));
                product.setCategoryId(rs.getInt("categoryId"));
                product.setTypeId(rs.getInt("typeId"));
                product.setDescription(rs.getString("description"));
                product.setPurchaseGuide(rs.getString("purchase_guide"));
                product.setWarrantyInfo(rs.getString("warranty_info"));

                // Load related entities using the same connection
                product.setCategory(getCategoryById(conn, product.getCategoryId()));
                product.setProductType(getProductTypeById(conn, product.getTypeId()));

                // Note that we're using the same connection and not closing it in these methods
                product.setImages(getImagesByProductId(conn, product.getId()));
                product.setSizes(getSizesByProductId(conn, product.getId()));

                products.add(product);
            }
            return products;
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        } finally {
            // Close all resources properly
            if (rs != null) try {
                rs.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
            if (stmt != null) try {
                stmt.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
            if (conn != null) try {
                conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    public ProductCRUD getProductById(int id) throws Exception {
        ProductCRUD product = null;
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "SELECT id, name, categoryId, typeId, description, purchase_guide, warranty_info FROM Product WHERE id = ?";

        try {
            conn = getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, id);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                product = new ProductCRUD();
                product.setId(rs.getInt("id"));
                product.setName(rs.getString("name"));
                product.setCategoryId(rs.getInt("categoryId"));
                product.setTypeId(rs.getInt("typeId"));
                product.setDescription(rs.getString("description"));
                product.setPurchaseGuide(rs.getString("purchase_guide"));
                product.setWarrantyInfo(rs.getString("warranty_info"));

                // Load related entities using the same connection
                product.setCategory(getCategoryById(conn, product.getCategoryId()));
                product.setProductType(getProductTypeById(conn, product.getTypeId()));
                product.setImages(getImagesByProductId(conn, product.getId()));
                product.setSizes(getSizesByProductId(conn, product.getId()));
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        } finally {
            closeResources(rs, pstmt, conn);
        }

        return product;
    }

    public List<ProductCRUD> getProductsByCategoryId(int categoryId) throws Exception {
        List<ProductCRUD> products = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "SELECT id, name, categoryId, typeId, description, purchase_guide, warranty_info FROM Product WHERE categoryId = ?";

        try {
            conn = getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, categoryId);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                ProductCRUD product = new ProductCRUD();
                product.setId(rs.getInt("id"));
                product.setName(rs.getString("name"));
                product.setCategoryId(rs.getInt("categoryId"));
                product.setTypeId(rs.getInt("typeId"));
                product.setDescription(rs.getString("description"));
                product.setPurchaseGuide(rs.getString("purchase_guide"));
                product.setWarrantyInfo(rs.getString("warranty_info"));

                // Load related entities using the same connection
                product.setCategory(getCategoryById(conn, product.getCategoryId()));
                product.setProductType(getProductTypeById(conn, product.getTypeId()));
                product.setImages(getImagesByProductId(conn, product.getId()));
                product.setSizes(getSizesByProductId(conn, product.getId()));

                products.add(product);
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        } finally {
            closeResources(rs, pstmt, conn);
        }

        return products;
    }

    public ProductTypeCRUD getProductTypeById(Connection connection, int typeId) throws Exception {
        Connection conn = null;
        ResultSet rs = null;
        /* Result set returned by the sqlserver */
        PreparedStatement pre = null;
        /* Prepared statement for executing sql queries */
        String sql = "SELECT * FROM ProductType where id = " + typeId;
        try {
            ProductTypeCRUD type = new ProductTypeCRUD();
            conn = getConnection();
            pre = conn.prepareStatement(sql);
            rs = pre.executeQuery();
            if (rs.next()) {
                int id = rs.getInt("id");
                String name = rs.getString("name");
                type.setId(id);
                type.setName(name);
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

    public boolean insertProduct(ProductCRUD product) throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet generatedKeys = null;
        String sql = "INSERT INTO Product (name, categoryId, typeId, description, purchase_guide, warranty_info) VALUES (?, ?, ?, ?, ?, ?)";

        try {
            conn = getConnection();
            // Start transaction
            conn.setAutoCommit(false);

            pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);

            pstmt.setString(1, product.getName());
            pstmt.setInt(2, product.getCategoryId());
            pstmt.setInt(3, product.getTypeId());
            pstmt.setString(4, product.getDescription());
            pstmt.setString(5, product.getPurchaseGuide());
            pstmt.setString(6, product.getWarrantyInfo());

            int affectedRows = pstmt.executeUpdate();

            if (affectedRows > 0) {
                generatedKeys = pstmt.getGeneratedKeys();
                if (generatedKeys.next()) {
                    int productId = generatedKeys.getInt(1);
                    product.setId(productId);

                    // Insert related images
                    if (product.getImages() != null) {
                        for (ProductImageCRUD image : product.getImages()) {
                            image.setProductId(productId);
                            insertProductImage(conn, image);
                        }
                    }

                    // Insert related sizes
                    if (product.getSizes() != null) {
                        for (SizeCRUD size : product.getSizes()) {
                            size.setProductId(productId);
                            insertSize(conn, size);
                        }
                    }

                    conn.commit();
                    return true;
                }
            }

            conn.rollback();
            return false;
        } catch (SQLException e) {
            if (conn != null) {
                try {
                    conn.rollback();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            e.printStackTrace();
            throw e;
        } finally {
            if (conn != null) {
                try {
                    conn.setAutoCommit(true);
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            closeResources(generatedKeys, pstmt, conn);
        }
    }

    public boolean updateProduct(ProductCRUD product) throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "UPDATE Product SET name = ?, categoryId = ?, typeId = ?, description = ?, purchase_guide = ?, warranty_info = ? WHERE id = ?";

        try {
            conn = getConnection();
            // Start transaction
            conn.setAutoCommit(false);

            pstmt = conn.prepareStatement(sql);

            pstmt.setString(1, product.getName());
            pstmt.setInt(2, product.getCategoryId());
            pstmt.setInt(3, product.getTypeId());
            pstmt.setString(4, product.getDescription());
            pstmt.setString(5, product.getPurchaseGuide());
            pstmt.setString(6, product.getWarrantyInfo());
            pstmt.setInt(7, product.getId());

            int affectedRows = pstmt.executeUpdate();

            if (affectedRows > 0) {
                // Update related entities
                // Delete existing related entities and insert new ones
                deleteProductImagesByProductId(conn, product.getId());
                deleteSizesByProductId(conn, product.getId());

                // Insert new images
                if (product.getImages() != null) {
                    for (ProductImageCRUD image : product.getImages()) {
                        image.setProductId(product.getId());
                        insertProductImage(conn, image);
                    }
                }

                // Insert new sizes
                if (product.getSizes() != null) {
                    for (SizeCRUD size : product.getSizes()) {
                        size.setProductId(product.getId());
                        insertSize(conn, size);
                    }
                }

                conn.commit();
                return true;
            }

            conn.rollback();
            return false;
        } catch (SQLException e) {
            if (conn != null) {
                try {
                    conn.rollback();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            e.printStackTrace();
            throw e;
        } finally {
            if (conn != null) {
                try {
                    conn.setAutoCommit(true);
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            closeResources(null, pstmt, conn);
        }
    }

    public boolean deleteProduct(int id) throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            conn = getConnection();
            // Start transaction
            conn.setAutoCommit(false);

            deleteProductImagesByProductId(conn, id);
            deleteSizesByProductId(conn, id);

            // Then delete the product
            String sql = "DELETE FROM Product WHERE id = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, id);
            int affectedRows = pstmt.executeUpdate();

            if (affectedRows > 0) {
                conn.commit();
                return true;
            }

            conn.rollback();
            return false;
        } catch (SQLException e) {
            if (conn != null) {
                try {
                    conn.rollback();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            e.printStackTrace();
            throw e;
        } finally {
            if (conn != null) {
                try {
                    conn.setAutoCommit(true);
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            closeResources(null, pstmt, conn);
        }
    }

    // ======== CATEGORY METHODS ========
    public List<Category> getAllCategories() throws Exception {
        List<Category> categories = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        String sql = "SELECT * FROM Category";

        try {
            conn = getConnection();
            stmt = conn.prepareStatement(sql);
            rs = stmt.executeQuery();

            while (rs.next()) {
                Category category = new Category();
                category.setId(rs.getInt("id"));
                category.setName(rs.getString("name"));
                categories.add(category);
            }
        } catch (SQLException ex) {
            System.out.println("Error retrieving categories: " + ex);
            throw ex;
        } finally {
            closeResources(rs, stmt, conn);
        }

        return categories;
    }

    public Category getCategoryById(int id) throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        Category category = null;
        String sql = "SELECT id, name FROM Category WHERE id = ?";

        try {
            conn = getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, id);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                category = new Category();
                category.setId(rs.getInt("id"));
                category.setName(rs.getString("name"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw e;
        } finally {
            closeResources(rs, pstmt, conn);
        }

        return category;
    }

    // Method for internal use with existing connection
    private Category getCategoryById(Connection conn, int id) throws Exception {
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        Category category = null;
        String sql = "SELECT id, name FROM Category WHERE id = ?";

        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, id);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                category = new Category();
                category.setId(rs.getInt("id"));
                category.setName(rs.getString("name"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw e;
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (pstmt != null) {
                pstmt.close();
            }
            // Don't close the connection here as it's passed in
        }

        return category;
    }

    public boolean insertCategory(Category category) throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet generatedKeys = null;
        String sql = "INSERT INTO Category (name) VALUES (?)";

        try {
            conn = getConnection();
            pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);

            pstmt.setString(1, category.getName());
            int affectedRows = pstmt.executeUpdate();

            if (affectedRows > 0) {
                generatedKeys = pstmt.getGeneratedKeys();
                if (generatedKeys.next()) {
                    category.setId(generatedKeys.getInt(1));
                    return true;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw e;
        } finally {
            closeResources(generatedKeys, pstmt, conn);
        }

        return false;
    }

    // Fix for getSizesByProductId method
    public List<SizeCRUD> getSizesByProductId(Connection conn, int productId) throws Exception {
        List<SizeCRUD> sizes = new ArrayList<>();
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "SELECT id, name, quantity, price, productId FROM Size WHERE productId = ?";

        try {
            // Don't create a new connection, use the one passed in
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, productId);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                SizeCRUD size = new SizeCRUD();
                size.setId(rs.getInt("id"));
                size.setName(rs.getString("name"));
                size.setQuantity(rs.getInt("quantity"));
                size.setPrice(rs.getInt("price"));
                size.setProductId(rs.getInt("productId"));
                sizes.add(size);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw e;
        } finally {
            // Close resources but NOT the connection
            if (rs != null) try {
                rs.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
            if (pstmt != null) try {
                pstmt.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
            // Do NOT close the connection here as it's passed in and needed elsewhere
        }

        return sizes;
    }

// Fix for getImagesByProductId method
    public List<ProductImageCRUD> getImagesByProductId(Connection conn, int productId) throws Exception {
        List<ProductImageCRUD> images = new ArrayList<>();
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "SELECT id, source, productId FROM ProductImage WHERE productId = ?";

        try {
            // Don't create a new connection, use the one passed in
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, productId);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                ProductImageCRUD image = new ProductImageCRUD();
                image.setId(rs.getInt("id"));
                image.setSource(rs.getString("source"));
                image.setProductId(rs.getInt("productId"));
                images.add(image);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw e;
        } finally {
            // Close resources but NOT the connection
            if (rs != null) try {
                rs.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
            if (pstmt != null) try {
                pstmt.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
            // Do NOT close the connection here as it's passed in and needed elsewhere
        }

        return images;
    }

// Fix for insertSize method
    public boolean insertSize(Connection conn, SizeCRUD size) throws Exception {
        PreparedStatement pstmt = null;
        ResultSet generatedKeys = null;
        String sql = "INSERT INTO Size (name, quantity, price, productId) VALUES (?, ?, ?, ?)";

        try {
            // Use the connection that was passed in
            pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            pstmt.setString(1, size.getName());
            pstmt.setInt(2, size.getQuantity());
            pstmt.setInt(3, size.getPrice());
            pstmt.setInt(4, size.getProductId());
            int affectedRows = pstmt.executeUpdate();

            if (affectedRows > 0) {
                generatedKeys = pstmt.getGeneratedKeys();
                if (generatedKeys.next()) {
                    size.setId(generatedKeys.getInt(1));
                }
                return true;
            }
            return false;
        } catch (SQLException e) {
            e.printStackTrace();
            throw e;
        } finally {
            // Close resources but NOT the connection
            if (generatedKeys != null) try {
                generatedKeys.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
            if (pstmt != null) try {
                pstmt.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
            // Do NOT close the connection here
        }
    }

// Fix for insertProductImage method
    public boolean insertProductImage(Connection conn, ProductImageCRUD image) throws Exception {
        PreparedStatement pstmt = null;
        ResultSet generatedKeys = null;
        String sql = "INSERT INTO ProductImage (source, productId) VALUES (?, ?)";

        try {
            // Use the connection that was passed in
            pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            pstmt.setString(1, image.getSource());
            pstmt.setInt(2, image.getProductId());
            int affectedRows = pstmt.executeUpdate();

            if (affectedRows > 0) {
                generatedKeys = pstmt.getGeneratedKeys();
                if (generatedKeys.next()) {
                    image.setId(generatedKeys.getInt(1));
                }
                return true;
            }
            return false;
        } catch (SQLException e) {
            e.printStackTrace();
            throw e;
        } finally {
            // Close resources but NOT the connection
            if (generatedKeys != null) try {
                generatedKeys.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
            if (pstmt != null) try {
                pstmt.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
            // Do NOT close the connection here
        }
    }

// Fix for deleteSizesByProductId method
    public boolean deleteSizesByProductId(Connection conn, int productId) throws Exception {
        PreparedStatement pstmt = null;
        String sql = "DELETE FROM Size WHERE productId = ?";

        try {
            // Use the connection that was passed in
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, productId);
            pstmt.executeUpdate();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            throw e;
        } finally {
            // Close prepared statement but NOT the connection
            if (pstmt != null) try {
                pstmt.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
            // Do NOT close the connection here
        }
    }

// Fix for deleteProductImage method
    public boolean deleteProductImage(Connection conn, int id) throws Exception {
        PreparedStatement pstmt = null;
        String sql = "DELETE FROM ProductImage WHERE id = ?";

        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, id);
            int affectedRows = pstmt.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            throw e;
        } finally {
            if (pstmt != null) try {
                pstmt.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    public boolean deleteProductImagesByProductId(Connection conn, int productId) throws Exception {
        PreparedStatement pstmt = null;
        String sql = "DELETE FROM ProductImage WHERE productId = ?";

        try {
            // Use the connection that was passed in
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, productId);
            pstmt.executeUpdate();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            throw e;
        } finally {
            // Close prepared statement but NOT the connection
            if (pstmt != null) try {
                pstmt.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
            // Do NOT close the connection here
        }
    }

    public List<ProductTypeCRUD> getAllProductTypes() throws Exception {
        List<ProductTypeCRUD> productTypes = new ArrayList<>();
        String sql = "SELECT * FROM ProductType";
        try {
            Connection conn = null;
            PreparedStatement stmt = null;
            ResultSet rs = null;
            conn = getConnection();
            PreparedStatement statement = conn.prepareStatement(sql);
            rs = statement.executeQuery();
            while (rs.next()) {
                ProductTypeCRUD productType = new ProductTypeCRUD();
                productType.setId(rs.getInt("id"));
                productType.setName(rs.getString("name"));
                productTypes.add(productType);
            }
        } catch (SQLException ex) {
            System.out.println("Error retrieving product types: " + ex);
        } finally {
            closeConnection(connection);
        }
        return productTypes;
    }
    // Fix for closeResources method

    private void closeResources(ResultSet rs, Statement stmt, Connection conn) throws Exception {
        try {
            if (rs != null) {
                rs.close();
            }
            if (stmt != null) {
                stmt.close();
            }
            if (conn != null) {
                conn.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw e;
        }
    }
}
