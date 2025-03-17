/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

/**
 *
 * @author OS
 */
public class ProductType {
    private int id;
    private String name;
    private boolean status;
    
    public ProductType() {
    }

    public ProductType(int id, String name) {
        this.id = id;
        this.name = name;
    }

    public ProductType(int id, String name, boolean status) {
        this.id = id;
        this.name = name;
        this.status = status;
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

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "ProductType{" + "id=" + id + ", name=" + name + ", status=" + status + '}';
    }

    
}
