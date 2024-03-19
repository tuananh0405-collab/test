<%-- 
    Document   : deleteproduct
    Created on : Feb 19, 2024, 3:48:41 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.*" %>
<%@page import="dal.*" %>
<%@page import="java.util.List" %>
<%@page import="java.util.ArrayList" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
    User auth = (User) request.getSession().getAttribute("auth");
    if (auth!=null) {
        request.setAttribute("auth", auth);
    }
    
ProductDAO pdao = new ProductDAO();
List<Product> list = pdao.getAllProducts();
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <%@include file="includes/head.jsp" %>
        <script type="text/javascript">
            function doDelete(id) {
                if (confirm("Are you sure to delete product with id = " + id)) {
                    window.location = "delete-product?id=" + id;
                }
            }
        </script>
        <%
            String message = (String) request.getSession().getAttribute("message");
            if (message!=null && message!="") {
        %>

        <script type="text/javascript">
            window.onload = function () {
                var message = '<%=message%>';
                if (message !== null && message !== '') {
                    alert(message, 3000);
                }
            };
        </script>
        <script src="includes/alert.js"></script>

        <%
            }
            request.getSession().removeAttribute("message");
        %>
    </head>
    <body>
        <div class="card-header my-3 d-flex align-items-center justify-content-between">
            <a href="#"><h5>Dashboard</h5></a>
            <a class="nav-link" href="logout">Log out</a>
        </div>
        <div class="row">
            <%@include file="includes/asideadmin.jsp" %>

            <main role="main" class="col-md-9 ml-sm-auto col-lg-10 px-4">
                <table class="table table-light">
                    <thead>
                        <tr>
                            <th scope="col">Product ID</th>
                            <th scope="col">Product Name</th>
                            <th scope="col">Image</th>
                            <th scope="col">Price</th>
                            <th scope="col">Stock</th>
                            <th scope="col">Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${list}" var="o">
                            <tr>
                                <td>${o.id}</td>
                                <td>${o.name}</td>
                                <td><img src="images/${o.image}" alt="${o.name}" style="height: 120px; width: 200px;"/></td>
                                <td>${o.price}</td>
                                <td>${o.stock}</td>
                                <td><a href="#" onclick="doDelete('${o.id}')">Delete</a></td>
                            </tr> 
                        </c:forEach>
                    </tbody>
                </table>
                <div style="text-align: center;" class="clearfix">
                    <div class="hint-text">Showing <b>${requestScope.tag}</b> out of <b>${requestScope.endP}</b> entries</div>
                    <ul class="pagination" style="display: flex; align-items: center; justify-content: center;">
                        <c:if test="${requestScope.tag>1}">
                            <li class="page-item">
                                <a href="delete-products?index=${requestScope.tag-1}" class="page-link" aria-label="Go to previous page">Previous</a>
                            </li>
                        </c:if>
                        <c:forEach begin="1" end="${requestScope.endP}" var="i">
                            <li class="page-item ${requestScope.tag == i?"active":""}">
                                <a href="delete-products?index=${i}" class="page-link">${i}</a>
                            </li> 
                        </c:forEach>
                        <c:if test="${requestScope.tag < requestScope.endP}">
                            <li class="page-item">
                                <a href="delete-products?index=${requestScope.tag+1}" class="page-link" aria-label="Go to next page">Next</a>
                            </li>
                        </c:if>
                    </ul>
                </div>
            </main>
        </div>

        <%@include file="includes/footer.jsp" %>
    </body>
</html>
