/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author OS
 */
public class Product {

    private int id;
    private String name;
    private ArrayList<ProductImage> images;
    private ArrayList<Size> sizes;
    private ProductType productType;
    private Category category;
    private String description;
    private String purchaseGuide;
    private String warrantyInfo;
    private List<Comment> comments;

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getPurchaseGuide() {
        return purchaseGuide;
    }

    public void setPurchaseGuide(String purchaseGuide) {
        this.purchaseGuide = purchaseGuide;
    }

    public String getWarrantyInfo() {
        return warrantyInfo;
    }

    public void setWarrantyInfo(String warrantyInfo) {
        this.warrantyInfo = warrantyInfo;
    }

    public List<Comment> getComments() {
        return comments;
    }

    public void setComments(List<Comment> comments) {
        this.comments = comments;
    }

    public Product() {
    }

    public Product(int id, String name, ArrayList<ProductImage> images, ArrayList<Size> sizes, ProductType productType, Category category) {
        this.id = id;
        this.name = name;
        this.images = images;
        this.sizes = sizes;
        this.productType = productType;
        this.category = category;
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

    public ArrayList<ProductImage> getImages() {
        return images;
    }

    public void setImages(ArrayList<ProductImage> images) {
        this.images = images;
    }

    public ArrayList<Size> getSizes() {
        return sizes;
    }

    public void setSizes(ArrayList<Size> sizes) {
        this.sizes = sizes;
    }

    public ProductType getProductType() {
        return productType;
    }

    public void setProductType(ProductType productType) {
        this.productType = productType;
    }

    public Category getCategory() {
        return category;
    }

    public void setCategory(Category category) {
        this.category = category;
    }

}
