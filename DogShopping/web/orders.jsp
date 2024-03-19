<%-- 
    Document   : orders
    Created on : Jan 20, 2024, 3:16:25 PM
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
    List<Order> orders = null;
    if (auth!=null) {
        request.setAttribute("auth", auth);
        OrderDAO odao = new OrderDAO();
        orders = odao.userOrders(auth.getId());
    } else {
        response.sendRedirect("login.jsp");
    }
    
    ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");
    if (cart_list != null) {
        request.setAttribute("cart_list", cart_list);
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="includes/head.jsp" %>
        <title>Order </title>
                <link rel="shortcut icon" href="./images/cropped-favicon.jpg" type="image/x-icon"  />

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
                    <ol class="breadcrumb d-flex align-items-center justify-content-center pt-3">
                        <li class="breadcrumb-item logo"><a href="index.jsp">Home</a></li>
                        <li class="breadcrumb-item logo">Orders</li>
                    </ol>
                </nav>
            </div>
        </div>
        <div class="container">
            <!--<div class="card-header my-3">All orders</div>-->
            <table class="table table-light">
                <thead>
                    <tr>
                        <th scope="col">STT</th>
                        <th scope="col">Date</th>
                        <th scope="col">Total Price</th>
                        <th scope="col">Details</th>
                        <th scope="col">Cancel</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        if (orders!=null) {
                    %>
                    <c:forEach items="<%= orders %>" var="o">
                        <tr>
                            <td>${o.getOid()}</td>
                            <td>${o.getDate()}</td>
                            <td><fmt:formatNumber pattern="##.##" value="${o.getTotalprice()}"/></td>
                            <td><a href="order-detail?id=${o.getOid()}">Details</a></td>
                            <td><a class="btn btn-sm btn-danger" href="cancel-order?id=${o.getOid()}">Cancel</a></td>
                        </tr> 
                    </c:forEach>
                    <%
                        }
                    %>
                </tbody>
            </table>
        </div>

        <%@include file="includes/foot.jsp" %>

        <%@include file="includes/footer.jsp" %>
    </body>
</html>
