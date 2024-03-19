/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.CommentDAO;
import dal.ProductDAO;
import dal.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.Date;
import java.util.List;
import model.Comment;
import model.Product;
import model.User;

/**
 *
 * @author Admin
 */
@WebServlet(name = "ProductDetailServlet", urlPatterns = {"/product-detail"})
public class ProductDetailServlet extends HttpServlet {

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
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ProductDetailServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ProductDetailServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
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
        String id_raw = request.getParameter("id");
        int id;
        ProductDAO pdao = new ProductDAO();
        CommentDAO cdao = new CommentDAO();
        try {
            id = Integer.parseInt(id_raw);
            Product product = pdao.getSingleProduct(id);
            List<Product> list = pdao.get3ProductsByCategory(product.getCategory(), product.getId());
            List<Comment> cmts = cdao.getCommentsByPid(id);
            request.setAttribute("product", product);
            request.setAttribute("list", list);
            request.setAttribute("cmts", cmts);
            request.getRequestDispatcher("productdetail.jsp").forward(request, response);
        } catch (NumberFormatException e) {
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
        String id_raw = request.getParameter("id");
        String comment = request.getParameter("comment");
        String uid_raw = request.getParameter("uid");
        if (uid_raw == null || uid_raw.trim().equals("")) {
            request.setAttribute("error", "You need to login first!");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
        int id, uid;
        ProductDAO pdao = new ProductDAO();
        CommentDAO cdao = new CommentDAO();
        UserDAO udao = new UserDAO();
        try {
            if (id_raw != null && !id_raw.trim().equals("")) {
                id = Integer.parseInt(id_raw);
            } else {
                throw new NumberFormatException("Invalid product id");
            }
            if (uid_raw != null && !uid_raw.trim().equals("")) {
                uid = Integer.parseInt(uid_raw);
            } else {
                throw new NumberFormatException("Invalid user id");
            }
            Product product = pdao.getSingleProduct(id);
            User user = udao.getUserById(uid);
            if (comment != null && !comment.trim().equals("")) {
                cdao.addProduct(new Comment(user, product, comment, new java.sql.Date(System.currentTimeMillis())));
            }
            List<Product> list = pdao.get3ProductsByCategory(product.getCategory(), product.getId());
            List<Comment> cmts = cdao.getCommentsByPid(id);
            request.setAttribute("product", product);
            request.setAttribute("list", list);
            request.setAttribute("cmts", cmts);
            request.getRequestDispatcher("productdetail.jsp").forward(request, response);
        } catch (NumberFormatException e) {
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
