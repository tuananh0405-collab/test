<%-- 
    Document   : contactus
    Created on : Feb 4, 2024, 10:02:09 PM
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
    
ProductDAO pd = new ProductDAO();
    List<Product> products = pd.getAllProducts();
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
        <title>Contact Us</title>
                <link rel="shortcut icon" href="./images/cropped-favicon.jpg" type="image/x-icon"  />

        <style>
            body {
                font-family: Arial, sans-serif;
            }
            .container {
                width: 80%;
                margin: auto;
            }
            #map {
                height: 400px;
                width: 100%;
            }
            .btnSend:hover {
                animation: changeColor 0.3s ease-in;
                animation-fill-mode: forwards;
            }
            @keyframes changeColor {
                0% {
                    background: black;
                }
                100% {
                    background: red;
                }
            }
            .svg:hover{
                cursor: pointer;
                background: black;
                color: white;
            }
            .social:hover{
                cursor: pointer;
                color:  red;
            }
        </style>
    </head>
    <body>
        <%@include file="includes/navbar.jsp" %>

        <div class="row nav-history">
            <div class="col">
                <nav aria-label="breadcrumb" class="rounded-3 p-3">
                    <ol class="breadcrumb d-flex align-items-center justify-content-center pt-3">
                        <li class="breadcrumb-item logo"><a href="index.jsp">Home</a></li>
                        <li class="breadcrumb-item logo">Contact us</li>
                    </ol>
                </nav>
            </div>
        </div>

        <div class="container text-center">
            <div class="my-5">

                <p style="opacity:0.5">Please feel free to reach out to us at any time. We look forward to hearing from you!</p>

            </div>
            <div id="map" class="mb-5">
                <iframe src="https://maps.google.com/maps?q=21.0285,105.8542&z=15&output=embed" width="100%" height="450" style="border:0;" allowfullscreen="" loading="lazy"></iframe>
            </div>
            <div class="mt-10">
                <div class="row p-10 gap-2">
                    <div class="col-md-4 bg-gray-100 border py-5">
                        <div class="row gx-4 text-left">
                            <div class="col-2">
                                <div class="border border-1 rounded-circle border-dark p-1 text-center svg">
                                    <i class="fa-solid fa-phone"></i>
                                </div>
                            </div>
                            <div class="col-10">
                                <p>+0817 870 528</p>
                                <p>+0916 961 458</p>
                            </div>
                            <div class="col-2">
                                <div class="border border-1 rounded-circle border-dark p-1 text-center svg">
                                    <i class="fa-solid fa-earth-americas"></i>                                </div>
                            </div>
                            <div class="col-10">
                                <p>shoppingcart@gmail.com</p>
                                <p>flower.store</p>
                            </div>
                            <div class="col-2">
                                <div class="border border-1 rounded-circle border-dark p-1 text-center svg">
                                    <i class="fa-solid fa-location-dot"></i>
                                </div>
                            </div>
                            <div class="col-10">
                                <p>Address</p>
                                <p>FPT, Thạch Thất, Hà Nội</p>
                            </div>
                        </div>
                        <div class="mt-5">
                            <p class="text-2xl font-bold text-gray-500 mb-3">Follow us</p>
                            <div class="d-flex justify-content-center align-items-center gap-5 text-gray-500 pb-10" style="gap: 15px">
                                <div><i class="fa-brands fa-facebook social"></i></div>
                                <div> <i class="fa-brands fa-twitter social"></i></div>
                                <div> <i class="fa-brands fa-instagram social"></i></div>
                                <div> <i class="fa-brands fa-linkedin social"></i></div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-8 bg-gray-100 border py-5">
                        <div class="pt-5">
                            <form class="inline-block" style="max-width: 600px;">
                                <div class="mb-3 ">
                                    <p class="text-center font-bold " style="font-size: larger; font-weight: 600">Contact :</p>
                                </div>
                                <div class="mb-3">
                                    <input type="text" class="form-control" placeholder="Họ và tên">
                                    <input type="email" class="form-control mt-3" placeholder="Email">
                                </div>
                                <div class="mb-3">
                                    <input type="text" class="form-control" placeholder="Số điện thoại">
                                </div>
                                <div class="mb-3">
                                    <textarea class="form-control" rows="4" placeholder="Nội dung"></textarea>
                                </div>
                                <div class="mb-3">
                                    <button class="btn btn-primary btnSend" style="background: black;">Send</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>

        </div>
        
        <%@include file="includes/scroll.jsp" %>

        <%@include file="includes/foot.jsp" %>

        <%@include file="includes/footer.jsp" %>
    </body>
</html>
