/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import entity.Comment;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CommentDAO extends DBConnection {

    private Connection conn;

    public CommentDAO() {
        this.conn = connection;
    }

    public boolean addComment(Comment comment) {
        String sql = "INSERT INTO Comment (product_id, user_id, content, status, created_at) VALUES (?, ?, ?, 'pending', GETDATE())";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, comment.getProductId());
            ps.setInt(2, comment.getUserId());
            ps.setString(3, comment.getContent());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<Comment> getCommentsByProductId(int productId) {
        List<Comment> comments = new ArrayList<>();
        String sql = "SELECT c.id, c.content, c.status, c.created_at, u.username "
                + "FROM Comment c JOIN [User] u ON c.user_id = u.id "
                + "WHERE c.product_id = ? AND c.status = 'pending' "
                + "ORDER BY c.created_at DESC";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, productId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Comment comment = new Comment();
                comment.setId(rs.getInt("id"));
                comment.setContent(rs.getString("content"));
                comment.setStatus(rs.getString("status"));
                comment.setCreatedAt(rs.getTimestamp("created_at"));
                comment.setUsername(rs.getString("username"));
                comments.add(comment);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return comments;
    }
}
