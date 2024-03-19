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
import model.Supplier;

/**
 *
 * @author Admin
 */
public class SupplierDAO extends DBContext {

    public Supplier getSingleSupplier(int id) {
        Supplier p = null;
        try {
            String sql = "select * from products where id=?";
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                p = new Supplier();
                p.setId(rs.getInt("id"));
                p.setName(rs.getString("name"));
                p.setAddress(rs.getString("address"));
                p.setEmail(rs.getString("email"));
                p.setPhone(rs.getString("phone"));
            }
        } catch (SQLException e) {
        }
        return p;
    }
    
    public List<Supplier> getAllSuppliers() {
        List<Supplier> list = new ArrayList<>();
        try {
            String sql = "select * from suppliers";
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Supplier p = new Supplier();
                p.setId(rs.getInt("id"));
                p.setName(rs.getString("name"));
                p.setAddress(rs.getString("address"));
                p.setEmail(rs.getString("email"));
                p.setPhone(rs.getString("phone"));
                list.add(p);
            }
        } catch (SQLException e) {
        }
        return list;
    }
}
