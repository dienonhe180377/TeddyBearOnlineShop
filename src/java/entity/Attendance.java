package entity;

import java.util.Date;

public class Attendance {

    private int id;
    private boolean status;
    private int userId;
    private Date updateTime;
    private String userName;
    public Attendance() {
    }

    // Constructor dùng khi thêm mới (id tự động)
    public Attendance(boolean status, int userId, Date updateTime) {
        this.status = status;
        this.userId = userId;
        this.updateTime = updateTime;
    }

    // Constructor đầy đủ
    public Attendance(int id, boolean status, int userId, Date updateTime) {
        this.id = id;
        this.status = status;
        this.userId = userId;
        this.updateTime = updateTime;
    }

    // Getters & Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public Date getUpdateTime() {
        return updateTime;
    }

    public void setUpdateTime(Date updateTime) {
        this.updateTime = updateTime;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }
}
