/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

/**
 *
 * @author HP
 */
public class SizeCRUD {
     private int id;
    private String name;
    private int quantity;
    private int price;
    private int productId;
    
    public SizeCRUD() {}
    
    public SizeCRUD(int id, String name, int quantity, int price, int productId) {
        this.id = id;
        this.name = name;
        this.quantity = quantity;
        this.price = price;
        this.productId = productId;
    }
    
    public int getId() {
        return id;
    }
    
    public void setId(int id) {
        this.id = id;
    }
    
    public String getName() {
        return name;
    }
    
    public void setName(String name) {
        this.name = name;
    }
    
    public int getQuantity() {
        return quantity;
    }
    
    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
    
    public int getPrice() {
        return price;
    }
    
    public void setPrice(int price) {
        this.price = price;
    }
    
    public int getProductId() {
        return productId;
    }
    
    public void setProductId(int productId) {
        this.productId = productId;
    }
    
    @Override
    public String toString() {
        return "Size [id=" + id + ", name=" + name + ", quantity=" + quantity + ", price=" + price + ", productId="
                + productId + "]";
    }
}
