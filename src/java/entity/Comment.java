/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

import java.util.Date;

public class Comment {
    private int id;
    private int productId;
    private int userId;
    private String content;
    private String status;
    private Date createdAt;
    private String username; // Để hiển thị tên người dùng khi lấy dữ liệu

    public Comment() {}

    public Comment(int id, int productId, int userId, String content, String status, Date createdAt, String username) {
        this.id = id;
        this.productId = productId;
        this.userId = userId;
        this.content = content;
        this.status = status;
        this.createdAt = createdAt;
        this.username = username;
    }

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getProductId() { return productId; }
    public void setProductId(int productId) { this.productId = productId; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public Date getCreatedAt() { return createdAt; }
    public void setCreatedAt(Date createdAt) { this.createdAt = createdAt; }

    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }
}
