<%-- 
    Document   : ordernow
    Created on : Feb 20, 2024, 11:06:16 PM
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
    
    ArrayList<Cart> cart = (ArrayList<Cart>) session.getAttribute("cart");
    List<Cart> cartProduct = null;
    if (cart != null) {
            ProductDAO pDao = new ProductDAO();
            cartProduct = pDao.getCartProducts(cart);
            double total = pDao.getTotalCartPrice(cart);
            request.setAttribute("total", total);
            request.setAttribute("cart", cart);
    }
    
    ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");
    if (cart_list != null) {
        request.setAttribute("cart_list", cart_list);
    }
    
    ProductDAO pd = new ProductDAO();
    List<String> categories = pd.getCategories();
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Order Now</title>
                <link rel="shortcut icon" href="./images/cropped-favicon.jpg" type="image/x-icon"  />

        <%@include file="includes/head.jsp" %>
    </head>
    <body>
        <%@include file="includes/navbar.jsp" %>
        
        <div class="row nav-history">
            <div class="col">
                <nav aria-label="breadcrumb" class="rounded-3 p-3">
                    <ol class="breadcrumb d-flex align-items-center justify-content-center pt-3">
                        <li class="breadcrumb-item"><a href="index.jsp">Home</a></li>
                        <li class="breadcrumb-item"><a href="product-pagination">Product</a></li>
                        <li class="breadcrumb-item">Order now</li>
                    </ol>
                </nav>
            </div>
        </div>

        <div class="container" style="margin-top: 70px">
            <h1 class="text-center" style="color: blue; margin: 20px 0">Checkout</h1>
            <form action="order-now" method="post">
                <div class="row">
                    <div class="col-md-6">
                        <h2>Billing Address</h2>
                        <div class="form-group">
                            <label for="name">Name</label>
                            <input type="text" class="form-control" id="name" name="name" value="<%= auth.getName()%>" readonly>
                        </div>
                        <div class="form-group">
                            <label for="email">Email</label>
                            <input type="email" class="form-control" id="email" name="email" value="<%= auth.getEmail()%>" readonly>
                        </div>
                        <div class="form-group">
                            <label for="address">Address</label>
                            <input type="text" class="form-control" id="address" name="address" required>
                        </div>
                        <div class="form-group">
                            <label for="note">Note</label>
                            <input type="text" class="form-control" id="note" name="note" required>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <h2>Order Summary</h2>
                        <table class="table">
                            <thead>
                                <tr>
                                    <th>Product</th>
                                    <th>Price</th>
                                    <th>Quantity</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                if (cart != null) {
                                    for (Cart c : cartProduct) {
                                %>
                                <tr>
                                    <td><%=c.getName()%></td>
                                    <td><fmt:formatNumber pattern="##.##" value="<%= c.getPrice() * (100-c.getDiscount()) / 100 %>"/></td>
                                    <td>
                                        <form action="order-now" method="post" class="form-inline">
                                            <input type="hidden" name="id" value="<%= c.getId()%>" class="form-input">
                                            <div class="form-group d-flex justify-content-between">
                                                <a class="btn btn-sm btn-decre" href="quantity?action=dec&id=<%=c.getId()%>"><i class="fas fa-minus-square"></i></a>
                                                <input type="text" name="quantity" class="form-control"  value="<%=c.getQuantity()%>" readonly> 
                                                <a class="btn bnt-sm btn-incre" href="quantity?action=inc&id=<%=c.getId()%>"><i class="fas fa-plus-square"></i></a> 
                                            </div>
                                        </form>
                                    </td>
                                </tr>

                                <%
				}}%>
                            </tbody>
                            <tfoot>
                                <tr>
                                    <th colspan="2">Total price</th>
                                    <td>$ <fmt:formatNumber pattern="##.##" value="${(total>0)?total:0}"/></td>
                                </tr>
                            </tfoot>
                        </table>
                    </div>
                </div>
                <div class="text-center">
                    <button type="submit" class="btn btn-primary">Buy</button>
                </div>
            </form>
        </div>

        <%@include file="includes/foot.jsp" %>

        <%@include file="includes/footer.jsp" %>
    </body>
</html>
