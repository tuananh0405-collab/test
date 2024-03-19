<%-- 
    Document   : cart.jsp
    Created on : Jan 20, 2024, 3:16:12 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.*" %>
<%@page import="dal.*" %>
<%@page import="java.util.List" %>
<%@page import="java.util.ArrayList" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%    
    User auth = (User) request.getSession().getAttribute("auth");
    if (auth!=null) {
        request.setAttribute("auth", auth);
    }
    
    ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");
    List<Cart> cartProduct = null;
    if (cart_list != null) {
            ProductDAO pDao = new ProductDAO();
            cartProduct = pDao.getCartProducts(cart_list);
            double total = pDao.getTotalCartPrice(cart_list);
            request.setAttribute("total", total);
            request.setAttribute("cart_list", cart_list);
    }
    
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="includes/head.jsp" %>
        <title>Cart</title>
        <link rel="shortcut icon" href="./images/cropped-favicon.jpg" type="image/x-icon"  />

        <style type="text/css">
            .table tbody td {
                vertical-align: middle;
            }

            .btn-incre, .btn-decre {
                box-shadow: none;
                font-size: 25px;
            }
        </style>
        <%
            String message = (String) request.getSession().getAttribute("message");
            if (message!=null && message!="") {
        %>
        <script type="text/javascript">
            window.onload = function () {
                var message = '<%=message%>';
                if (message !== null && message !== '') {
                    alert(message, 2000);
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
        <%@include file="includes/navbar.jsp" %>

        <div class="row nav-history">
            <div class="col">
                <nav aria-label="breadcrumb" class="rounded-3 p-3">
                    <ol class="breadcrumb d-flex align-items-center justify-content-center pt-2">
                        <li class="breadcrumb-item logo"><a href="index.jsp" style="text-decoration: none">Home</a></li>
                        <li class="breadcrumb-item logo">Cart</li>
                    </ol>
                </nav>
            </div>
        </div>

        <div class="container my-3" style="margin-top: 200px">
            <div class="d-flex py-3">
                <h3>Total Price: $ <fmt:formatNumber pattern="##.##" value="${(total>0)?total:0}"/></h3>
                <a class="mx-3 btn btn-primary" href="check-out">Check Out</a>
            </div>
            <table class="table table-light">
                <thead>
                    <tr>
                        <th scope="col">Name</th>
                        <th scope="col">Category</th>
                        <th scope="col">Price</th>
                        <th scope="col">Image</th>
                        <th scope="col">Action</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                    if (cart_list != null) {
                        for (Cart c : cartProduct) {
                    %>
                    <tr>
                        <td><%=c.getName()%></td>
                        <td><%=c.getCategory()%></td>
                        <td><fmt:formatNumber pattern="##.##" value="<%= c.getPrice() * (100-c.getDiscount()) / 100 %>"/></td>
                        <td><img src="images/<%= c.getImage() %>" alt="<%= c.getImage() %>" style="height: 180px; width: 300px;"/></td>
                        <td><a href="order-now?quantity=1&id=<%=c.getId() %>" class="btn btn-sm btn-primary">Buy now</a></td>
                        <td><a href="remove-from-cart?id=<%=c.getId() %>" class="btn btn-sm btn-danger">Remove</a></td>
                    </tr>

                    <%
				}}%>
                </tbody>
            </table>
        </div>
        <%@include file="includes/foot.jsp" %>     

        <%@include file="includes/footer.jsp" %>
    </body>
</html>
