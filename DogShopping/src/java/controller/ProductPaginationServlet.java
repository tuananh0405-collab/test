/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.ProductDAO;
import dal.SupplierDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Product;
import model.Supplier;

/**
 *
 * @author Admin
 */
@WebServlet(name = "ProductPaginationServlet", urlPatterns = {"/product-pagination"})
public class ProductPaginationServlet extends HttpServlet {

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
//            out.println("<!DOCTYPE html>");
//            out.println("<html>");
//            out.println("<head>");
//            out.println("<title>Servlet ProductPaginationServlet</title>");  
//            out.println("</head>");
//            out.println("<body>");
//            out.println("<h1>Servlet ProductPaginationServlet at " + request.getContextPath () + "</h1>");
//            out.println("</body>");
//            out.println("</html>");
//        }
        SupplierDAO sdao = new SupplierDAO();
        String index_raw = request.getParameter("index");
        String category = request.getParameter("category");
        String name = request.getParameter("name");
        String selectedChoice = request.getParameter("choice-item");
        String items_raw = request.getParameter("items");
        String from_raw = request.getParameter("from");
        String to_raw = request.getParameter("to");
        String[] supplierids = request.getParameterValues("supplier");
        request.removeAttribute("category");
        request.removeAttribute("name");
        request.removeAttribute("choice-item");
        request.removeAttribute("items");
        request.removeAttribute("from");
        request.removeAttribute("to");
        if (index_raw == null) {
            index_raw = "1";
        }
        if (items_raw == null) {
            items_raw = "3";
        }
        int index = Integer.parseInt(index_raw);
        int items = Integer.parseInt(items_raw);
        ProductDAO pdao = new ProductDAO();

        List<Product> list = null;
        int count = 0;

        if (name != null && !name.isEmpty()) {
            request.setAttribute("name", name);
            list = pdao.getProductsByName(name, index);
            count = pdao.getTotalProductsByName(name);
        } else if (category != null && !category.isEmpty()) {
            request.setAttribute("category", category);
            list = pdao.getProductsByCategory(category, index);
            count = pdao.getTotalProductsByCategory(category);
        } else if (selectedChoice != null && !selectedChoice.isEmpty()) {
            switch (selectedChoice) {
                case "Increasing" -> {
                    count = pdao.getTotalProducts();
                    list = pdao.FilterInc(index);
                }
                case "Decreasing" -> {
                    count = pdao.getTotalProducts();
                    list = pdao.FilterDec(index);
                }
                case "Alphabet" -> {
                    count = pdao.getTotalProducts();
                    list = pdao.FilterAlphabet(index);
                }
                default -> {
                    count = pdao.getTotalProducts();
                    list = pdao.pagingProducts(index);
                }
            }
            request.setAttribute("choice-item", selectedChoice);
        } else if ((from_raw != null && !from_raw.isEmpty()) && (to_raw == null || to_raw.isEmpty())) {
            to_raw = "9999";
            try {
                double from = Double.parseDouble(from_raw);
                double to = Double.parseDouble(to_raw);
                count = pdao.getTotalProductsByPrice(from, to);
                list = pdao.getProductsByPrice(from, to, index);
                request.setAttribute("from", from);
            } catch (NumberFormatException e) {
                System.out.println(e);
            }
        } else if ((from_raw == null || from_raw.isEmpty()) && (to_raw != null && !to_raw.isEmpty())) {
            from_raw = "0";
            try {
                double from = Double.parseDouble(from_raw);
                double to = Double.parseDouble(to_raw);
                count = pdao.getTotalProductsByPrice(from, to);
                list = pdao.getProductsByPrice(from, to, index);
                request.setAttribute("to", to);
            } catch (NumberFormatException e) {
                System.out.println(e);
            }
        } else if ((from_raw != null && !from_raw.isEmpty()) && (to_raw != null && !to_raw.isEmpty())) {
            try {
                double from = Double.parseDouble(from_raw);
                double to = Double.parseDouble(to_raw);
                count = pdao.getTotalProductsByPrice(from, to);
                list = pdao.getProductsByPrice(from, to, index);
                request.setAttribute("from", from);
                request.setAttribute("to", to);
            } catch (NumberFormatException e) {
                System.out.println(e);
            }
        } else if (supplierids != null) {
            
        } else {
            list = pdao.pagingProducts(index);
            count = pdao.getTotalProducts();
        }

        int endPage = count / 6;
        if (count % 6 != 0) {
            endPage++;
        }

        List<Supplier> suppliers = sdao.getAllSuppliers();
        request.setAttribute("suppliers", suppliers);
        request.setAttribute("items", items);
        request.setAttribute("list", list);
        request.setAttribute("endP", endPage);
        request.setAttribute("tag", index);
        request.getRequestDispatcher("product.jsp").forward(request, response);
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
