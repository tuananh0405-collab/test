<%-- 
    Document   : aboutus
    Created on : Feb 4, 2024, 10:02:00 PM
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
        <title>About Us</title>
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Lato:ital,wght@0,100;0,400;1,700&family=Montserrat:wght@300&family=Mulish:wght@400;600&family=Open+Sans:ital,wght@0,300..800;1,300..800&family=Roboto:ital,wght@0,100;0,300;0,400;0,500;0,700;0,900;1,300;1,400;1,500;1,700;1,900&family=Rubik:ital,wght@0,300..900;1,300..900&display=swap" rel="stylesheet">
                <link rel="shortcut icon" href="./images/cropped-favicon.jpg" type="image/x-icon"  />


        <style type="text/css">
            *{
                font-family:"Rubik" ,sans-serif;
            }
            body {
                background-image: linear-gradient(to right, #f8f9fa, #e9ecef);
            }
            section .container {
                background-color: #ffffff;
                box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
                border-radius: 10px;
                padding: 30px;
            }
            .col-md-4 {
                padding: 20px;
                transition: all 0.3s ease-in-out;
            }
            .col-md-4:hover {
                transform: translateY(-5px);
                box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
            }
            .fa {
                color: #007bff;
            }
            .font-weight-normal {
                color: white;
                text-shadow: 2px 2px 4px black;
            }
            .text-muted {
                color: black;
                font-size: 18px;
                line-height: 1.5;
            }
            ul {
                list-style-type: none;
                padding: 0;
            }
            li {
                display: flex;
                align-items: center;
                margin-bottom: 10px;
            }
            img {
                width: 50px;
                height: 50px;
                border-radius: 50%;
            }
            .media-body {
                margin-left: 10px;
            }
            h5 {
                color: green;
                font-weight: bold;
            }



            /*test*/
            body {
                font-family: 'Roboto';
                font-size: 16px;
            }

            .aboutus-section {
                padding: 90px 0;
            }
            .aboutus-title {
                font-size: 30px;
                letter-spacing: 0;
                line-height: 32px;
                margin: 0 0 39px;
                padding: 0 0 11px;
                position: relative;
                text-transform: uppercase;
                color: #000;
            }
            .aboutus-title::after {
                background: #fdb801 none repeat scroll 0 0;
                bottom: 0;
                content: "";
                height: 2px;
                left: 0;
                position: absolute;
                width: 54px;
            }
            .aboutus-text {
                color: #606060;
                font-size: 13px;
                line-height: 22px;
                margin: 0 0 35px;
            }

            a:hover, a:active {
                color: #ffb901;
                text-decoration: none;
                outline: 0;
            }
            .aboutus-more {
                border: 1px solid #fdb801;
                border-radius: 25px;
                color: #fdb801;
                display: inline-block;
                font-size: 14px;
                font-weight: 700;
                letter-spacing: 0;
                padding: 7px 20px;
                text-transform: uppercase;
            }
            .aboutus-more:hover{
                cursor: pointer;
                background: yellow;
                color: white;
            }
            .feature .feature-box .iconset {
                /*background: #fff none repeat scroll 0 0;*/
                float: left;
                position: relative;
                width: 18%;
            }
            .feature .feature-box .iconset::after {
                background: #fdb801 none repeat scroll 0 0;
                content: "";
                height: 150%;
                left: 43%;
                position: absolute;
                top: 100%;
                width: 1px;
            }

            .feature .feature-box .feature-content h4 {
                color: #0f0f0f;
                font-size: 18px;
                letter-spacing: 0;
                line-height: 22px;
                margin: 0 0 5px;
            }


            .feature .feature-box .feature-content {
                float: left;
                padding-left: 28px;
                width: 78%;
            }
            .feature .feature-box .feature-content h4 {
                color: #0f0f0f;
                font-size: 18px;
                letter-spacing: 0;
                line-height: 22px;
                margin: 0 0 5px;
            }
            .feature .feature-box .feature-content p {
                color: #606060;
                font-size: 13px;
                line-height: 22px;
            }
            .icon {
                color : #f4b841;
                padding:0px;
                font-size:40px;
                border: 1px solid #fdb801;
                border-radius: 100px;
                color: #fdb801;
                font-size: 28px;
                height: 70px;
                line-height: 70px;
                text-align: center;
                width: 70px;
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
                        <li class="breadcrumb-item logo">About us</li>
                    </ol>
                </nav>
            </div>
        </div>

<!--        <div class="aboutContainer" >
            <div class="container ">
                <div class="aboutus-section">
                    <div class="container">
                        <div class="row">
                            <div class="col-md-3 col-sm-6 col-xs-12">
                                <div class="aboutus">
                                    <h1 class="aboutus-title  text-muted">About Us</h2>
                                        <p class="aboutus-text text-muted">Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in.</p>
                                        <p class="aboutus-text text-muted">This is Photoshop's version of Lorem Ipsum. Proin gravida nibh vel velit auctor aliquet. Aenean sollicitudin, lorem quis bibendum auctor, nisi elit consequat ipsum, nec sagittis sem</p>
                                        <a class="aboutus-more text-muted" href="#">read more</a>
                                </div>
                            </div>
                            <div class="col-md-3 col-sm-6 col-xs-12">
                                <div class="aboutus-banner">
                                    <img src="http://themeinnovation.com/demo2/html/build-up/img/home1/about1.jpg" alt="logi">
                                </div>
                            </div>
                            <div class="col-md-5 col-sm-6 col-xs-12">
                                <div class="feature">
                                    <div class="feature-box">
                                        <div class="clearfix">
                                            <div class="iconset">
                                                <i class="fa-solid fa-gear icon"></i>
                                            </div>
                                            <div class="feature-content">
                                                <h4 class="text-muted">Work with heart</h4>
                                                <p class="text-muted">Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in.</p>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="feature-box">
                                        <div class="clearfix">
                                            <div class="iconset">
                                                <i class="fa-solid fa-gear icon"></i>
                                            </div>
                                            <div class="feature-content">
                                                <h4 class="text-muted">Reliable services</h4>
                                                <p class="text-muted">Donec vitae sapien ut libero venenatis faucibu. Nullam quis ante. Etiam sit amet orci eget eros faucibus tincidunt</p>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="feature-box">
                                        <div class="clearfix">
                                            <div class="iconset">
                                                <i class="fa-solid fa-gear icon"></i>
                                            </div>
                                            <div class="feature-content">
                                                <h4 class="text-muted">Great support</h4>
                                                <p class="text-muted">Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in.</p>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>-->

<div class="aboutContainer" >
    <div class="container ">
        <div class="aboutus-section">
            <div class="container">
                <div class="row">
                    <div class="col-md-3 col-sm-6 col-xs-12">
                        <div class="aboutus">
                            <h1 class="aboutus-title  text-muted">About Us</h1>
                            <p class="aboutus-text text-muted">Welcome to our shop specializing in dogs! Whether you're looking for a loyal companion, a playful puppy, or a seasoned friend, we have the perfect match for you.</p>
                            <p class="aboutus-text text-muted">Discover a variety of breeds, each with its own unique charm and personality. Our mission is to help you find the ideal furry addition to your family.</p>
                            <a class="aboutus-more text-muted" href="blog">Read more</a>
                        </div>
                    </div>
                    <div class="col-md-3 col-sm-6 col-xs-12">
                        <div class="aboutus-banner">
<!--                            <img src=images/logo.jpg alt="Dogs" width="50px" height="50px">-->
                        </div>
                    </div>
                    <div class="col-md-5 col-sm-6 col-xs-12">
                        <div class="feature">
                            <div class="feature-box">
                                <div class="clearfix">
                                    <div class="iconset">
                                        <i class="fa-solid fa-dog icon"></i>
                                    </div>
                                    <div class="feature-content">
                                        <h4 class="text-muted">Quality Breeds</h4>
                                        <p class="text-muted">We source our dogs from reputable breeders who prioritize health, temperament, and breed standards. Rest assured, you'll find only the finest companions here.</p>
                                    </div>
                                </div>
                            </div>
                            <div class="feature-box">
                                <div class="clearfix">
                                    <div class="iconset">
                                        <i class="fa-solid fa-dog icon"></i>
                                    </div>
                                    <div class="feature-content">
                                        <h4 class="text-muted">Expert Care</h4>
                                        <p class="text-muted">Each dog in our shop receives the utmost care and attention. From early socialization to routine veterinary check-ups, we ensure they are happy, healthy, and ready to join your home.</p>
                                    </div>
                                </div>
                            </div>
                            <div class="feature-box">
                                <div class="clearfix">
                                    <div class="iconset">
                                        <i class="fa-solid fa-dog icon"></i>
                                    </div>
                                    <div class="feature-content">
                                        <h4 class="text-muted">Dedicated Support</h4>
                                        <p class="text-muted">Our team is here to guide you through the process of finding your perfect dog. Whether you have questions about breeds, care, or training, we're committed to providing you with exceptional support.</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
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
