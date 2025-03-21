/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

/**
 *
 * @author ADMIN
 */
public class UserRole {
    private int id;
    private String name;
    private boolean status;

    public UserRole() {
    }

    
    public UserRole(int id, String userRole) {
        this.id = id;
        this.name = userRole;
    }

    public UserRole(int id, String userRole, boolean status) {
        this.id = id;
        this.name = userRole;
        this.status = status;
    }

    public int getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUserRole() {
        return name;
    }

    public void setUserRole(String userRole) {
        this.name = userRole;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }
    
    

    @Override
    public String toString() {
        return "UserRole{" + "id=" + id + ", userRole=" + name + ", status=" + status + '}';
    }
    
}
