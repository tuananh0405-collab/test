/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.ProductDAO;
import dal.SupplierDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Product;

/**
 *
 * @author Admin
 */
@WebServlet(name = "AddProductServlet", urlPatterns = {"/add-product"})
public class AddProductServlet extends HttpServlet {

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
//            out.println("<title>Servlet AddProductServlet</title>");  
//            out.println("</head>");
//            out.println("<body>");
//            out.println("<h1>Servlet AddProductServlet at " + request.getContextPath () + "</h1>");
//            out.println("</body>");
//            out.println("</html>");
//        }
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        String category = request.getParameter("category");
        String price_raw = request.getParameter("price");
        String discount_raw = request.getParameter("discount");
        String image = request.getParameter("image");
        String stock_raw = request.getParameter("stock");
        double price;
        int stock, discount, supplier_id;
        ProductDAO pdao = new ProductDAO();
        SupplierDAO sdao = new SupplierDAO();
        try {
            price = Double.parseDouble(price_raw);
            discount = Integer.parseInt(discount_raw);
            stock = Integer.parseInt(stock_raw);
            Product p = new Product();
            p.setName(name);
            p.setDescription(description);
            p.setCategory(category);
            p.setPrice(price);
            p.setDiscount(discount);
            p.setStock(stock);
            p.setImage(image);
            pdao.addProduct(p);
            HttpSession session = request.getSession();
            String message = (String) request.getSession().getAttribute("message");
            session.removeAttribute(message);
            session.setAttribute("message", "Product was added successfully");
            response.sendRedirect("show-products");
        } catch (NumberFormatException e) {
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
        processRequest(request, response);
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
        processRequest(request, response);
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
