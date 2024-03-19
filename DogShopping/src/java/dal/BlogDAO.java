/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Blog;

/**
 *
 * @author Admin
 */
public class BlogDAO extends DBContext {

    public int getTotalBlogs() {
        String sql = "select count(*) from Blog";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return 0;
    }

    public List<Blog> pagingBlogs(int index) {
        List<Blog> list = new ArrayList<>();
        String sql = "select * from Blog\n"
                + "order by id\n"
                + "offset ? rows fetch next 6 rows only;";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, (index - 1) * 6);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                list.add(new Blog(rs.getInt("id"),
                        rs.getString("title"),
                        rs.getString("image"),
                        rs.getString("content"),
                        rs.getDate("lastUpdated")));
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return list;
    }
    
    public Blog getBlogById(int id) {
        Blog p = null;
        try {
            String sql = "select * from Blog where id=?";
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                p = new Blog();
                p.setId(rs.getInt("id"));
                p.setTitle(rs.getString("title"));
                p.setImage(rs.getString("image"));
                p.setContent(rs.getString("content"));
                p.setLastUpdated(rs.getDate("lastUpdated"));
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return p;
    }
}
