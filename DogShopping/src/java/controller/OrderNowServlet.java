/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.OrderDAO;
import dal.OrderDetailDAO;
import dal.ProductDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import model.Cart;
import model.Order;
import model.OrdersDetails;
import model.Product;
import model.User;

/**
 *
 * @author Admin
 */
@WebServlet(name = "OrderNowServlet", urlPatterns = {"/order-now"})
public class OrderNowServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
//        try (PrintWriter out = response.getWriter()) {
//            /* TODO output your page here. You may use following sample code. */
//            out.println("<!DOCTYPE html>");
//            out.println("<html>");
//            out.println("<head>");
//            out.println("<title>Servlet OrderNowServlet</title>");
//            out.println("</head>");
//            out.println("<body>");
//            out.println("<h1>Servlet OrderNowServlet at " + request.getContextPath() + "</h1>");
//            out.println("</body>");
//            out.println("</html>");
//        }
        try (PrintWriter out = response.getWriter()) {
            SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
            Date date = new Date();

            User auth = (User) request.getSession().getAttribute("auth");

            if (auth != null) {
                String productId = request.getParameter("id");
                ProductDAO pdao = new ProductDAO();
                Product p = pdao.getSingleProduct(Integer.parseInt(productId));
                int productQuantity = Integer.parseInt(request.getParameter("quantity"));
                if (productQuantity <= 0) {
                    productQuantity = 1;
                }
                Order orderModel = new Order();
                orderModel.setTotalprice(productQuantity * p.getPrice() * (100 - p.getDiscount()) / 100);
                orderModel.setDate(formatter.format(date));
                orderModel.setUser(auth);

                OrderDAO orderDao = new OrderDAO();
                OrderDetailDAO oddao = new OrderDetailDAO();
                boolean result = orderDao.insertOrder(orderModel);
                if (result) {
                    ArrayList<Cart> cart_list = (ArrayList<Cart>) request.getSession().getAttribute("cart-list");
                    if (cart_list != null) {
                        for (Cart c : cart_list) {
                            if (c.getId() == Integer.parseInt(productId)) {
                                cart_list.remove(cart_list.indexOf(c));
                                break;
                            }
                        }
                    }

                    Order o1 = orderDao.getLastOrder();
                    OrdersDetails od = new OrdersDetails();
                    od.setOrder(o1);
                    od.setProduct(p);
                    od.setPrice(productQuantity * p.getPrice());
                    od.setQuantity(productQuantity);
                    oddao.insertOrderDetail(od);

                    response.sendRedirect("orders.jsp");
                } else {
                    out.println("order failed");
                }
            } else {
                response.sendRedirect("login.jsp");
            }

        } catch (IOException e) {
            System.out.println(e);
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
//        processRequest(request, response);
        try (PrintWriter out = response.getWriter()) {
            User auth = (User) request.getSession().getAttribute("auth");
            HttpSession session = request.getSession();
            if (auth != null) {
                String productId = request.getParameter("id");
                ProductDAO pdao = new ProductDAO();
                Product p = pdao.getSingleProduct(Integer.parseInt(productId));
                int productQuantity = Integer.parseInt(request.getParameter("quantity"));
                if (productQuantity <= 0) {
                    productQuantity = 1;
                }
                ArrayList<Cart> cart = new ArrayList<>();
                cart.add(new Cart(p.getId(), p.getName(), p.getDescription(), p.getCategory(), p.getPrice(), p.getDiscount(), p.getImage(), p.getStock(), productQuantity));
                session.setAttribute("cart", cart);
                response.sendRedirect("ordernow.jsp");
            } else {
                session.setAttribute("message", "You need to login first");
                response.sendRedirect("login.jsp");
            }

        } catch (IOException e) {
            System.out.println(e);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
//        processRequest(request, response);
        String address = request.getParameter("address");
        String note = request.getParameter("note");
        try (PrintWriter out = response.getWriter()) {
            SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
            Date date = new Date();
            ArrayList<Cart> cart = (ArrayList<Cart>) request.getSession().getAttribute("cart");
            User auth = (User) request.getSession().getAttribute("auth");
            if (auth != null) {
                if (cart != null) {
                    Order orderModel = new Order();
                    ProductDAO pdao = new ProductDAO();
                    orderModel.setTotalprice(pdao.getTotalCartPrice(cart));
                    orderModel.setAddress(address);
                    orderModel.setNote(note);
                    orderModel.setDate(formatter.format(date));
                    orderModel.setUser(auth);
                    OrderDAO oDao = new OrderDAO();
                    OrderDetailDAO oddao = new OrderDetailDAO();
                    boolean result = oDao.insertOrder(orderModel);
                    double totalCart = 0;
                    if (result) {
                        for (Cart c : cart) {
                            Product p = pdao.getSingleProduct(c.getId());
                            Order o1 = oDao.getLastOrder();
                            OrdersDetails od = new OrdersDetails();
                            totalCart = c.getQuantity() * p.getPrice() * (100 - p.getDiscount()) / 100;
                            od.setOrder(o1);
                            od.setProduct(p);
                            od.setPrice(totalCart);
                            od.setQuantity(c.getQuantity());
                            oddao.insertOrderDetail(od);
                            p.setStock(p.getStock() - c.getQuantity());
                            pdao.updateProduct(p);
                        }
                    }
                    cart.clear();
                    request.getSession().removeAttribute("cart1");
                    HttpSession session = request.getSession();
                    session.setAttribute("message", "Ordered successfully");
                    response.sendRedirect("orders.jsp");
                } else {
                    response.sendRedirect("cart.jsp");
                }
            } else {
                response.sendRedirect("login.jsp");
            }

        } catch (IOException e) {
            System.out.println(e);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
