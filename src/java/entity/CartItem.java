/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

public class CartItem {

    private Product product;
    private Size size;
    private int quantity;

    public CartItem(Product product, Size size, int quantity) {
        this.product = product;
        this.size = size;
        this.quantity = quantity;
    }

    // Getters & Setters
    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    public Size getSize() {
        return size;
    }

    public void setSize(Size size) {
        this.size = size;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public int getTotalPrice() {
        String cleanedPrice = size.getPrice().replace(".", "");
        return quantity * Integer.parseInt(cleanedPrice);
    }
}
