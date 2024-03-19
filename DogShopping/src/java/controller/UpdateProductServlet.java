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
@WebServlet(name = "UpdateProductServlet", urlPatterns = {"/update-product"})
public class UpdateProductServlet extends HttpServlet {

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
            out.println("<title>Servlet UpdateProductServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UpdateProductServlet at " + request.getContextPath() + "</h1>");
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
        try {
            id = Integer.parseInt(id_raw);
            Product c = pdao.getSingleProduct(id);
            if (c != null) {
                request.setAttribute("product", c);
                request.getRequestDispatcher("updateproduct.jsp").forward(request, response);
            } else {
                request.setAttribute("msg", "Not found!");
                request.getRequestDispatcher("updateproduct.jsp").forward(request, response);
            }
            
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
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        String category = request.getParameter("category");
        String price_raw = request.getParameter("price");
        String discount_raw = request.getParameter("discount");
        String stock_raw = request.getParameter("stock");
        String image = request.getParameter("image");
        String supplier_id_raw = request.getParameter("supplier_id");
        double price;
        int id, stock, discount, supplier_id;
        ProductDAO pdao = new ProductDAO();
        SupplierDAO sdao = new SupplierDAO();
        try {
            price = Double.parseDouble(price_raw);
            id = Integer.parseInt(id_raw);
            stock = Integer.parseInt(stock_raw);
            discount = Integer.parseInt(discount_raw);
            supplier_id = Integer.parseInt(supplier_id_raw);
            Product p = new Product(id, name, description, category, price, discount, image, stock);
            pdao.updateProduct(p);
            HttpSession session = request.getSession();
            session.setAttribute("message", "Product was updated successfully");
            response.sendRedirect("show-products");
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
