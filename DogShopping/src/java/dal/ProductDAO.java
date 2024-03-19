/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import model.Cart;
import model.Product;

/**
 *
 * @author Admin
 */
public class ProductDAO extends DBContext {

    public List<Product> getAllProducts() {
        List<Product> list = new ArrayList<>();
        String sql = "select * from products";
        SupplierDAO sdao = new SupplierDAO();
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Product p = new Product();
                p.setId(rs.getInt("id"));
                p.setName(rs.getString("name"));
                p.setDescription(rs.getString("description"));
                p.setCategory(rs.getString("category"));
                p.setPrice(rs.getDouble("price"));
                p.setDiscount(rs.getInt("discount"));
                p.setImage(rs.getString("image"));
                p.setStock(rs.getInt("stock"));
                list.add(p);
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return list;
    }

    public Product getSingleProduct(int id) {
        Product p = null;
        SupplierDAO sdao = new SupplierDAO();
        try {
            String sql = "select * from products where id=?";
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                p = new Product();
                p.setId(rs.getInt("id"));
                p.setName(rs.getString("name"));
                p.setDescription(rs.getString("description"));
                p.setCategory(rs.getString("category"));
                p.setPrice(rs.getDouble("price"));
                p.setDiscount(rs.getInt("discount"));
                p.setImage(rs.getString("image"));
                p.setStock(rs.getInt("stock"));
            }
        } catch (SQLException e) {
        }
        return p;
    }

    public double getTotalCartPrice(ArrayList<Cart> cartList) {
        double sum = 0;
        try {
            if (!cartList.isEmpty()) {
                for (Cart item : cartList) {
                    String sql = "select price, discount from products where id=?";
                    PreparedStatement st = connection.prepareStatement(sql);
                    st.setInt(1, item.getId());
                    ResultSet rs = st.executeQuery();
                    while (rs.next()) {
                        sum += rs.getDouble("price") * item.getQuantity() * (100 - rs.getInt("discount")) / 100;
                    }
                }
            }

        } catch (SQLException e) {
            System.out.println(e);
        }
        return sum;
    }

    public List<String> getCategories() {
        List<String> list = new ArrayList<>();
        try {
            String sql = "select distinct category from products";
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                list.add(rs.getString("category"));
            }
        } catch (SQLException e) {
        }
        return list;
    }

    public int getTotalCategories() {
        String sql = "SELECT COUNT(DISTINCT category) FROM products;";
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

    public int getTotalProducts() {
        String sql = "select count(*) from products";
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

    public List<Cart> getCartProducts(ArrayList<Cart> cartList) {
        List<Cart> book = new ArrayList<>();
        String sql = "select * from products where id=?";
        SupplierDAO sdao = new SupplierDAO();
        try {
            if (!cartList.isEmpty()) {
                for (Cart item : cartList) {
                    PreparedStatement st = connection.prepareStatement(sql);
                    st.setInt(1, item.getId());
                    ResultSet rs = st.executeQuery();
                    while (rs.next()) {
                        Cart row = new Cart();
                        row.setId(rs.getInt("id"));
                        row.setName(rs.getString("name"));
                        row.setDescription(rs.getString("description"));
                        row.setCategory(rs.getString("category"));
                        row.setPrice(rs.getDouble("price") * item.getQuantity());
                        row.setDiscount(rs.getInt("discount"));
                        row.setImage(rs.getString("image"));
                        row.setStock(rs.getInt("stock"));
                        row.setQuantity(item.getQuantity());
                        book.add(row);
                    }

                }
            }

        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return book;
    }

    public List<Product> pagingProducts(int index) {
        List<Product> list = new ArrayList<>();
        SupplierDAO sdao = new SupplierDAO();
        String sql = "select * from products\n"
                + "order by id\n"
                + "offset ? rows fetch next 6 rows only;";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, (index - 1) * 6);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                list.add(new Product(rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("description"),
                        rs.getString("category"),
                        rs.getDouble("price"),
                        rs.getInt("discount"),
                        rs.getString("image"),
                        rs.getInt("stock")
                ));
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return list;
    }

    public List<Product> getProductsByName(String name, int index) {
        List<Product> list = new ArrayList<>();
        SupplierDAO sdao = new SupplierDAO();
        String sql = "select * from products\n"
                + "where name like ?\n"
                + "order by id\n"
                + "offset ? rows fetch next 6 rows only;";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, "%" + name + "%");
            st.setInt(2, (index - 1) * 6);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                list.add(new Product(rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("description"),
                        rs.getString("category"),
                        rs.getDouble("price"),
                        rs.getInt("discount"),
                        rs.getString("image"),
                        rs.getInt("stock")
                ));
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return list;
    }

    public int getTotalProductsByName(String name) {
        String sql = "select count(*) from products where name like ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, "%" + name + "%");
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return 0;
    }

    public List<Product> getProductsByCategory(String name, int index) {
        List<Product> list = new ArrayList<>();
        SupplierDAO sdao = new SupplierDAO();
        String sql = "select * from products\n"
                + "where category like ?\n"
                + "order by id\n"
                + "offset ? rows fetch next 6 rows only;";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, "%" + name + "%");
            st.setInt(2, (index - 1) * 6);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                list.add(new Product(rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("description"),
                        rs.getString("category"),
                        rs.getDouble("price"),
                        rs.getInt("discount"),
                        rs.getString("image"),
                        rs.getInt("stock")
                ));
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return list;
    }

    public int getTotalProductsByCategory(String category) {
        String sql = "select count(*) from products where category like ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, "%" + category + "%");
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return 0;
    }

    public List<Product> getProductsByPrice(double from, double to, int index) {
        if (from > to || to == 0) {
            return null;
        }
        List<Product> list = new ArrayList<>();
        SupplierDAO sdao = new SupplierDAO();
        String sql = "select * from products\n"
                + "where price*(100-discount)/100 between ? and ?\n"
                + "order by id\n"
                + "offset ? rows fetch next 6 rows only;";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setDouble(1, from);
            st.setDouble(2, to);
            st.setInt(3, (index - 1) * 6);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                list.add(new Product(rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("description"),
                        rs.getString("category"),
                        rs.getDouble("price"),
                        rs.getInt("discount"),
                        rs.getString("image"),
                        rs.getInt("stock")
                ));
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return list;
    }

    public int getTotalProductsByPrice(double from, double to) {
        String sql = "select count(*) from products where price*(100-discount)/100 between ? and ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setDouble(1, from);
            st.setDouble(2, to);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return 0;
    }

    public List<Product> FilterInc(int index) {
        List<Product> list = new ArrayList<>();
        String sql = "select * from products\n"
                + "order by price * (100-discount)/100 asc\n"
                + "offset ? rows fetch next 6 rows only;";
        SupplierDAO sdao = new SupplierDAO();
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, (index - 1) * 6);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Product p = new Product();
                p.setId(rs.getInt("id"));
                p.setName(rs.getString("name"));
                p.setDescription(rs.getString("description"));
                p.setCategory(rs.getString("category"));
                p.setPrice(rs.getDouble("price"));
                p.setDiscount(rs.getInt("discount"));
                p.setImage(rs.getString("image"));
                p.setStock(rs.getInt("stock"));
                list.add(p);
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return list;
    }

    public List<Product> FilterDec(int index) {
        List<Product> list = new ArrayList<>();
        String sql = "select * from products\n"
                + "order by price * (100-discount)/100 desc\n"
                + "offset ? rows fetch next 6 rows only;";
        SupplierDAO sdao = new SupplierDAO();
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, (index - 1) * 6);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Product p = new Product();
                p.setId(rs.getInt("id"));
                p.setName(rs.getString("name"));
                p.setDescription(rs.getString("description"));
                p.setCategory(rs.getString("category"));
                p.setPrice(rs.getDouble("price"));
                p.setDiscount(rs.getInt("discount"));
                p.setImage(rs.getString("image"));
                p.setStock(rs.getInt("stock"));
                list.add(p);
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return list;
    }

    public List<Product> FilterAlphabet(int index) {
        List<Product> list = new ArrayList<>();
        String sql = "select * from products\n"
                + "order by name asc\n"
                + "offset ? rows fetch next 6 rows only;";
        SupplierDAO sdao = new SupplierDAO();
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, (index - 1) * 6);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Product p = new Product();
                p.setId(rs.getInt("id"));
                p.setName(rs.getString("name"));
                p.setDescription(rs.getString("description"));
                p.setCategory(rs.getString("category"));
                p.setPrice(rs.getDouble("price"));
                p.setDiscount(rs.getInt("discount"));
                p.setImage(rs.getString("image"));
                p.setStock(rs.getInt("stock"));
                list.add(p);
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return list;
    }

    public List<Product> get4Products() {
        List<Product> list = new ArrayList<>();
        String sql = "select top 4 * from products order by price desc";
        SupplierDAO sdao = new SupplierDAO();
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Product p = new Product();
                p.setId(rs.getInt("id"));
                p.setName(rs.getString("name"));
                p.setDescription(rs.getString("description"));
                p.setCategory(rs.getString("category"));
                p.setPrice(rs.getDouble("price"));
                p.setDiscount(rs.getInt("discount"));
                p.setImage(rs.getString("image"));
                p.setStock(rs.getInt("stock"));
                list.add(p);
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return list;
    }

    public void addProduct(Product product) {
        try {
            String sql = "INSERT INTO products (name, description, category, price, discount, image, stock) values(?,?,?,?,?,?,?)";
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, product.getName());
            st.setString(2, product.getDescription());
            st.setString(3, product.getCategory());
            st.setDouble(4, product.getPrice());
            st.setInt(5, product.getDiscount());
            st.setString(6, product.getImage());
            st.setInt(7, product.getStock());
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public void updateProduct(Product product) {
        String sql = "update products set name=?, description=?, category=?, price=?, discount=?, image=?, stock=? where id=?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, product.getName());
            st.setString(2, product.getDescription());
            st.setString(3, product.getCategory());
            st.setDouble(4, product.getPrice());
            st.setInt(5, product.getStock());
            st.setString(6, product.getImage());
            st.setInt(7, product.getStock());
            st.setInt(8, product.getId());
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public void delete(int id) {
        String sql = "delete from products where id=?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public List<Product> get3ProductsByCategory(String name, int id) {
        List<Product> list = new ArrayList<>();
        String sql = "select top 3 * from products\n"
                + "where category like ? and id <> ?\n";
        SupplierDAO sdao = new SupplierDAO();
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, "%" + name + "%");
            st.setInt(2, id);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                list.add(new Product(rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("description"),
                        rs.getString("category"),
                        rs.getDouble("price"),
                        rs.getInt("discount"),
                        rs.getString("image"),
                        rs.getInt("stock")
                ));
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return list;
    }

    public int getTotalProductsWithCategory(String name) {
        String sql = "select count(*) from products\n"
                + "where category like ?\n";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, "%" + name + "%");
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return 0;
    }

    public Map<String, Integer> getDataProductsCategories() {
        Map<String, Integer> data = new HashMap<>();
        List<String> list = getCategories();
        for (String x : list) {
            int count = getTotalProductsWithCategory(x);
            data.put(x, count);
        }
        return data;
    }

    public Map<String, Integer> getTop5MostBoughtProducts() {
        Map<String, Integer> data = new HashMap<>();
        String sql = "select top 5 o.pid, p.name, sum(o.quantity) as total from orders_details o\n"
                + "join products p on o.pid = p.id\n"
                + "group by o.pid, p.name\n"
                + "order by sum(o.quantity) desc;";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                data.put(rs.getString("name"), rs.getInt("total"));
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return data;
    }
}
