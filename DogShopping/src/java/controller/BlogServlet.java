/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.BlogDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Blog;

/**
 *
 * @author Admin
 */
@WebServlet(name = "BlogServlet", urlPatterns = {"/blog"})
public class BlogServlet extends HttpServlet {

//    private static final int BLOGS_PER_PAGE = 3;
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
//            out.println("<title>Servlet BlogServlet</title>");
//            out.println("</head>");
//            out.println("<body>");
//            out.println("<h1>Servlet BlogServlet at " + request.getContextPath() + "</h1>");
//            out.println("</body>");
//            out.println("</html>");
//        }

        String index_raw = request.getParameter("index");
        if (index_raw == null) {
            index_raw = "1";
        }
        int index = Integer.parseInt(index_raw);
        BlogDAO bdao = new BlogDAO();
        int count = bdao.getTotalBlogs();
        int endPage = count / 6;
        if (count % 6 != 0) {
            endPage++;
        }

        List<Blog> list = bdao.pagingBlogs(index);

        request.setAttribute("listB", list);
        request.setAttribute("endP", endPage);
        request.setAttribute("tag", index);
        request.getRequestDispatcher("blog.jsp").forward(request, response);
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
//        String pageStr = request.getParameter("page");
//        int page = pageStr == null ? 1 : Integer.parseInt(pageStr);
//        List<Blog> blogs = getBlogs((page - 1) * BLOGS_PER_PAGE, BLOGS_PER_PAGE);
//        HttpSession session = request.getSession();
//        session.setAttribute("blogs", blogs);
//        request.setAttribute("currentPage", page);
//        request.setAttribute("totalPages", Math.ceil(blogs.size() / BLOGS_PER_PAGE));
//        request.getRequestDispatcher("blog.jsp").forward(request, response);
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

//    private List<Blog> getBlogs(int start, int length) {
//        // Fetch the blogs from the database using the start and length parameters
//        List<Blog> blogs = new ArrayList<>();
//        blogs.add(new Blog("1 Blog", "This is the 1 blog content.", new Date()));
//        blogs.add(new Blog("2 Blog", "This is the 2 blog content.", new Date()));
//        blogs.add(new Blog("3 Blog", "This is the 3 blog content.", new Date()));
//        blogs.add(new Blog("4 Blog", "This is the 4 blog content.", new Date()));
//        blogs.add(new Blog("5 Blog", "This is the 5 blog content.", new Date()));
//        blogs.add(new Blog("6 Blog", "This is the 6 blog content.", new Date()));
//
//        if (start < 0 || length < 0 || start + length > blogs.size()) {
//            throw new IllegalArgumentException("Invalid start or length");
//        }
//        return blogs.subList(start, start + length);
//    }
}
