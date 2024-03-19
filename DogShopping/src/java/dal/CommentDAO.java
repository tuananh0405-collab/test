/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Comment;

/**
 *
 * @author Admin
 */
public class CommentDAO extends DBContext {

    public List<Comment> getCommentsByPid(int id) {
        List<Comment> list = new ArrayList<>();
        String sql = "select * from comments where pid=? order by dateComment desc";
        UserDAO udao = new UserDAO();
        ProductDAO pdao = new ProductDAO();
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Comment p = new Comment();
                p.setUser(udao.getUserById(rs.getInt("uid")));
                p.setProduct(pdao.getSingleProduct(rs.getInt("pid")));
                p.setComment(rs.getString("comment"));
                p.setDateComment(rs.getDate("dateComment"));
                list.add(p);
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return list;
    }

    public void addProduct(Comment comment) {
        try {
            String sql = "INSERT INTO comments (uid, pid, comment, dateComment) values(?,?,?,?)";
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, comment.getUser().getId());
            st.setInt(2, comment.getProduct().getId());
            st.setString(3, comment.getComment());
            st.setDate(4, comment.getDateComment());
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }
}
