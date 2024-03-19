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
import model.Product;
import model.SupplierProduct;

/**
 *
 * @author Admin
 */
public class SupplierProductDAO extends DBContext {

    public List<SupplierProduct> getSupplierProductBySid(int[] sid) {
        List<SupplierProduct> list = new ArrayList<>();
        SupplierDAO sdao = new SupplierDAO();
        ProductDAO pdao = new ProductDAO();
        try {
            String sql = "select * from suppliers_products where sid in (?)";
            PreparedStatement st = connection.prepareStatement(sql);
            String s = "";
            for (int i = 0; i < sid.length; i++) {
                s += i;
                if (i < sid.length - 1) {
                    s += ", ";
                }
            }
            st.setString(1, s);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                SupplierProduct p = new SupplierProduct();
                p.setSupplier(sdao.getSingleSupplier(rs.getInt("sid")));
                p.setProduct(pdao.getSingleProduct(rs.getInt("pid")));
                list.add(p);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }
    
    public List<Product> getProductsWithSupplierProductBySid(int[] sid) {
        SupplierProduct p = null;
        SupplierDAO sdao = new SupplierDAO();
        ProductDAO pdao = new ProductDAO();
        try {
            String sql = "select * from suppliers_products where sid in (?)";
            PreparedStatement st = connection.prepareStatement(sql);
            String s = "";
            for (int i = 0; i < sid.length; i++) {
                s += i;
                if (i < sid.length - 1) {
                    s += ", ";
                }
            }
            st.setString(1, s);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                p = new SupplierProduct();
                p.setSupplier(sdao.getSingleSupplier(rs.getInt("sid")));
                p.setProduct(pdao.getSingleProduct(rs.getInt("pid")));
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return p;
    }
}
