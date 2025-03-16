/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

import java.util.ArrayList;
import java.util.List;

import java.util.ArrayList;
import java.util.List;

public class ProductCRUD {

    private int id;
    private String name;
    private int categoryId;
    private int typeId;
    private String description;
    private String purchaseGuide;
    private String warrantyInfo;

    // Navigation properties
    private Category category;
    private ProductTypeCRUD productType;
    private List<ProductImageCRUD> images;
    private List<SizeCRUD> sizes;

    public ProductCRUD() {
        this.images = new ArrayList<>();
        this.sizes = new ArrayList<>();
    }

    public ProductCRUD(int id, String name, int categoryId, int typeId, String description, String purchaseGuide,
            String warrantyInfo) {
        this.id = id;
        this.name = name;
        this.categoryId = categoryId;
        this.typeId = typeId;
        this.description = description;
        this.purchaseGuide = purchaseGuide;
        this.warrantyInfo = warrantyInfo;
        this.images = new ArrayList<>();
        this.sizes = new ArrayList<>();
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

    public int getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }

    public int getTypeId() {
        return typeId;
    }

    public void setTypeId(int typeId) {
        this.typeId = typeId;
    }

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

    public Category getCategory() {
        return category;
    }

    public void setCategory(Category category) {
        this.category = category;
    }

    public ProductTypeCRUD getProductType() {
        return productType;
    }

    public void setProductType(ProductTypeCRUD productType) {
        this.productType = productType;
    }

    public List<ProductImageCRUD> getImages() {
        return images;
    }

    public void setImages(List<ProductImageCRUD> images) {
        this.images = images;
    }

    public void addImage(ProductImageCRUD image) {
        this.images.add(image);
    }

    public List<SizeCRUD> getSizes() {
        return sizes;
    }

    public void setSizes(List<SizeCRUD> sizes) {
        this.sizes = sizes;
    }

    public void addSize(SizeCRUD size) {
        this.sizes.add(size);
    }

    @Override
    public String toString() {
        return "Product [id=" + id + ", name=" + name + ", categoryId=" + categoryId + ", typeId=" + typeId
                + ", description=" + description + ", purchaseGuide=" + purchaseGuide + ", warrantyInfo=" + warrantyInfo
                + "]";
    }
}
