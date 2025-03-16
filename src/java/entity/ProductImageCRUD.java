/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

/**
 *
 * @author HP
 */
public class ProductImageCRUD {
    private int id;
    private String source;
    private int productId;
    
    public ProductImageCRUD() {}
    
    public ProductImageCRUD(int id, String source, int productId) {
        this.id = id;
        this.source = source;
        this.productId = productId;
    }
    
    public int getId() {
        return id;
    }
    
    public void setId(int id) {
        this.id = id;
    }
    
    public String getSource() {
        return source;
    }
    
    public void setSource(String source) {
        this.source = source;
    }
    
    public int getProductId() {
        return productId;
    }
    
    public void setProductId(int productId) {
        this.productId = productId;
    }
    
    @Override
    public String toString() {
        return "ProductImage [id=" + id + ", source=" + source + ", productId=" + productId + "]";
    }
}
