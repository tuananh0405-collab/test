<%-- 
    Document   : index
    Created on : Jan 20, 2024, 3:01:44 PM
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
    List<Product> products4 = pd.get4Products();
    ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");
    if (cart_list != null) {
            request.setAttribute("cart_list", cart_list);
    }
    
    int index = 1;
    List<Product> list = pd.pagingProducts(index);
    int count = pd.getTotalProducts();
    int endPage = count / 6;
    if (count % 6 != 0) {
        endPage++;
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="includes/head.jsp" %>
        <title>Dog Shop</title>
        <!--<link rel="icon" type="image/x-icon" href="./images/favicon.png">-->
        <link rel="shortcut icon" href="./images/cropped-favicon.jpg" type="image/x-icon"  />
        <style type="text/css">
            .carousel-item {
                height: 500px;
            }

            .carousel-item img {
                height: 100%;
                object-fit: cover;
            }

            .round-image {
                position: relative;
                width: 200px;
                height: 200px;
                margin: 10px;
            }

            .round-image img {
                border-radius: 50%;
                width: 100%;
                height: 100%;
                object-fit: cover;
            }

            /*            .caption {
                            position: absolute;
                            bottom: 10px;
                            left: 0;
                            width: 100%;
            
                            text-align: center;
                            color: #fff;
            
                            transform: translateY(0);
                        }
            
                        .caption h5 {
                            font-size: 18px;
                            font-weight: bold;
                            margin-bottom: 5px;
                        }
            
                        .caption p {
                            font-size: 16px;
                        }*/

            .round-image::before {
                content: '';
                background: rgba(0,0,0,0.5);
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
            }

            .card {
                transition: all 0.3s ease-in-out;
            }

            .card:hover {
                transform: translateY(-5px);
                box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2);
            }

            .discount-badge {
                position: absolute;
                height: 20px;
                width: 45px;
                top: 5px;
                right: 5px;
                background: red;
                color: white;
                border-radius: 3px;

                display: flex;
                align-items: center;
                justify-content: center;
            }

            .price-box {
                display: flex;
                justify-content: flex-end;
            }

            .card-img-top:hover {
                cursor: pointer;
            }

            .col-md-4-1 {
                padding: 20px;
                transition: all 0.3s ease-in-out;
            }
            .col-md-4-1:hover {
                transform: translateY(-5px);
                box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
            }

            /*caro*/
            .header-carousel {
                position: relative;
            }

            .header-carousel .owl-nav .owl-prev {
                position: absolute;
                width: 70px;
                height: 70px;
                top: 50%;
                left: 20px;
                transform: translateY(-50%);
                border-radius: 50%;
                background: var(--bs-primary);
                color: var(--bs-white);
                font-size: 30px;
                display: flex;
                align-items: center;
                justify-content: center;
                transition: 0.5s;
            }

            .header-carousel .owl-nav .owl-next {
                position: absolute;
                width: 70px;
                height: 70px;
                top: 50%;
                right: 20px;
                transform: translateY(-50%);
                border-radius: 50%;
                background: var(--bs-primary);
                color: var(--bs-white);
                font-size: 30px;
                display: flex;
                align-items: center;
                justify-content: center;
                transition: 0.5s;
            }

            .header-carousel .owl-nav .owl-prev,
            .header-carousel .owl-nav .owl-next {
                transition: 0.5s;
            }

            .header-carousel .owl-nav .owl-prev:hover,
            .header-carousel .owl-nav .owl-next:hover {
                box-shadow: inset 150px 0 0 0 var(--bs-light) !important;
                color: var(--bs-primary) !important;
            }

            @media (max-width: 576px) {
                .header-carousel .owl-nav .owl-prev,
                .header-carousel .owl-nav .owl-next {
                    top: 630px;
                    transition: 0.5s;
                }

                .header-carousel .header-carousel-item .carousel-caption .carousel-caption-content {
                    width: 95% !important;
                }

            }

            .header-carousel .header-carousel-item,
            .header-carousel .header-carousel-item img {
                position: relative;
                width: 100%;
                height: 700px;
                margin-top: 95px;
                display: block;
                object-fit: cover;
                transition: 0.5s;

            }

            @media (max-width: 992px) {
                .header-carousel .header-carousel-item,
                .header-carousel .header-carousel-item img {
                    margin-top: 0;
                    transition: 0.5s;
                }

            }

            @media (min-width: 992px) {
                .header-carousel .owl-nav .owl-prev,
                .header-carousel .owl-nav .owl-next {
                    margin-top: 50px;
                }
            }

            .carousel-caption {
                width: 100%;
                height: 100%;
                position: absolute;
                top: 0;
                left: 0;
                padding: 100px 0;
                display: flex;
                align-items: center;
                justify-content: center;
                background: rgba(0, 0, 0, .5);
            }

            .header-carousel .header-carousel-item .carousel-caption .carousel-caption-content {
                position: relative;
                width: 75%;

            }
            .custom-button {
                background-color: #007bff; /* Primary color */
                opacity: 0.8;
                color: #fff; /* White text color */
                border-radius: 50px; /* Rounded shape */
                padding: 0.75rem 1.25rem; /* Padding */
                display: inline-block; /* Display as inline-block */
                text-decoration: none; /* Remove default link underline */
            }

            .custom-button:hover {
                opacity: 1;
                background-color: #0056b3; /* Darker shade of primary color on hover */
                color: #fff; /* Maintain text color on hover */
            }


            :root {
                --prime-color: #588a87;
                --hover-color: #b6c6be;
            }

            .card-feature {
                width: 280px;
                height: 280px;
                background: #F6FFFF;
                border-radius: 30px;
                position: relative;
                transition: 0.5s ease-in-out;
                overflow: hidden;
            }

            .profile-pic {
                position: absolute;
                width: 100%;
                height: 100%;
                top: 0;
                left: 0;
                border-radius: 30px;
                z-index: 1;
                border: 2px solid white;
                overflow: hidden;
                transition: 0.5s ease-in-out 0.3s;
            }

            .profile-pic img {
                width: 100%;
                height: 100%;
                object-fit: cover;
                position: relative;
                top: 0;
                transition: 0.5s ease-in-out;
            }

            .card-feature:hover .profile-pic {
                width: 100px;
                height: 100px;
                top: 10px;
                left: 10px;
                border-radius: 50%;
                border: 5px solid var(--prime-color);
                box-shadow: 0 0 10px #1115;
                transition: 0.5s ease-in-out;
                z-index: 3;
            }

            .card-feature:hover .profile-pic img {
                transform: scale(1.6);
                top: 20px;
                transition: 0.5s ease-in-out 0.5s;

            }

            .details {
                position: absolute;
                left: 4px;
                right: 4px;
                bottom: 4px;

                z-index: 2;
                top: 80%;
                background: var(--prime-color);
                color: white;
                border-radius: 25px;
                box-shadow: inset 5px 5px 10px #1114, 0px 80px 2px var(--prime-color);
                transition: 0.3s ease-in-out 0.2s;
                overflow: hidden;
            }


            .card-feature:hover .details {
                top: 20%;
                border-radius: 80px 25px 25px 25px;
                transition: 0.5s ease-in-out 0.2s;
            }

            .content {
                position: absolute;
                top: -300px;
                left: 20px;
                opacity: 0;
                transition: 0.5s ease-in-out 0s;
                overflow: hidden;
            }

            .card-feature:hover .content {
                top: 10px;
                opacity: 1;
                transition: 0.5s ease-in-out 0.5s,
                    opacity 0.5s ease-in-out 1s;
            }

            .content h2 {
                margin-left: 100px;
                font-size: 1.5rem;
                font-weight: bold;
            }

            .content .tag {
                margin-left: 100px;
                font-size: 0.6rem;
                letter-spacing: 2px;
                font-weight: 200;
            }

            .content .about {
                font-size: 0.8rem;
                margin-top: 40px;
                width: 80%;
                overflow-y: hidden;
            }

            .buttons {
                position: absolute;
                bottom: 12px;
                width: 100%;
                padding: 0 20px;
                display: flex;
                justify-content: space-between;
                align-items: center;
            }

            .buttons .social {
                display: flex;
                gap: 15px;
            }

            .buttons .social i {
                color: white;
                cursor: pointer;
            }


            .buttons .social i:hover {
                color: var(--hover-color);
            }

            .buttons .link {
                text-decoration: none;
                color: var(--prime-color);
                background: white;
                padding: 7px 10px;
                border-radius: 20px;
                font-size: .9rem;
            }

            .buttons .link:hover {
                background: var(--hover-color);

            }
        </style>
        <script type="text/javascript">
            function doImage(id) {
                window.location = "product-detail?id=" + id;
            }
        </script>
        <c:if test="${requestScope.tag != null}">
            <script>
                window.onload = function () {
                    var element = document.getElementById('name');
                    var rect = element.getBoundingClientRect();
                    var scrollTop = window.pageYOffset || document.documentElement.scrollTop;
                    window.scrollTo(0, rect.top + scrollTop - 110);
                };
            </script>
        </c:if>
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
        <%@include file="includes/navbar.jsp" %>

        <div id="carouselExampleIndicators" class="carousel slide mt-3" data-ride="carousel">
            <ol class="carousel-indicators">
                <li data-target="#carouselExampleIndicators" data-slide-to="0" class="active"></li>
                <li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
                <li data-target="#carouselExampleIndicators" data-slide-to="2"></li>
            </ol>
            <div class="carousel-inner header-carousel owl-carousel">
                <div class="carousel-item active ">
                    <img class="d-block w-100" src="./images/bg1.jpg" alt="First slide">
                    <div class="carousel-caption d-none d-md-block">
                        <div class="carousel-caption-content p-3">
                            <h5 class="text-white text-uppercase fw-bold mb-4" style="letter-spacing: 3px;">Dog Grooming Salon</h5>
                            <h1 class="display-1 text-capitalize text-white mb-4">Dog's Perfect Pampering Place</h1>
                            <p class="mb-5 fs-5">Treat your furry friend to a day of luxury at our grooming salon. Our expert groomers will ensure your dog looks and feels their best. Book an appointment today!</p>

                            <a class="custom-button" href="product-pagination">Explore now</a>
                        </div>
                    </div>
                </div>
                <div class="carousel-item  ">
                    <img class="d-block w-100" src="./images/bg2.jpg" alt="First slide">
                    <div class="carousel-caption d-none d-md-block">
                        <div class="carousel-caption-content p-3">
                            <h5 class="text-white text-uppercase fw-bold mb-4" style="letter-spacing: 3px;">Dog Training Academy</h5>
                            <h1 class="display-1 text-capitalize text-white mb-4">Unleash Your Dog's Potential</h1>
                            <p class="mb-5 fs-5">Empower your furry companion with the skills they need to thrive. Our expert trainers provide personalized training programs tailored to your dog's needs.</p>

                            <a class="custom-button" href="product-pagination">Explore now</a>
                        </div>
                    </div>
                </div>
                <div class="carousel-item  ">
                    <img class="d-block w-100" src="./images/bg3.jpg" alt="First slide">
                    <div class="carousel-caption d-none d-md-block">
                        <div class="carousel-caption-content p-3">
                            <h5 class="text-white text-uppercase fw-bold mb-4" style="letter-spacing: 3px;">Pet Supplies Emporium</h5>
                            <h1 class="display-1 text-capitalize text-white mb-4">Everything Your Pet Desires</h1>
                            <p class="mb-5 fs-5">From premium food to stylish accessories, we have everything your pet needs for a happy and healthy life. Discover the best products for your beloved companion today!</p>

                            <a class="custom-button" href="product-pagination">Explore now</a>
                        </div>
                    </div>
                </div>
            </div>
            <a class="carousel-control-prev" href="#carouselExampleIndicators" role="button" data-slide="prev">
                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                <span class="sr-only">Previous</span>
            </a>
            <a class="carousel-control-next" href="#carouselExampleIndicators" role="button" data-slide="next">
                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                <span class="sr-only">Next</span>
            </a>
        </div>

        <div class="container">



            <div class="section-title"><h2 class="text-center mb-5 subhead">Featured Products</h2></div>
            <div class="row">
                <!--                
                <c:forEach var="c" items="<%= products4%>">
                    <div class="col-md-3 col-6 mb-4">
                        <div class="card h-100">
                            <img src="images/${c.getImage()}" class="card-img-top" alt="${c.getName()}" onclick="doImage('${c.getId()}')">
                            <div class="card-body">
                                <h5 class="card-title">${c.getName()}</h5>
                                <p class="card-text">${c.getPrice()}</p>
                            </div>
                        </div>
                    </div>
                
                
                </c:forEach>
                -->
                <c:forEach var="c" items="<%= products4%>">
                    <div class="card-feature col-md-3 col-6 mb-4">
                        <div class="card h-100">
                            <div class="profile-pic">
                                <img src="images/${c.getImage()}" " alt="${c.getName()}" class="card-img-top" onclick="doImage('${c.getId()}')">
                            </div>

                            <div class="details">
                                <div class="content">
                                    <h2>${c.getCategory()}</h2>
                                    <p class="tag">${c.getName()}</p>
                                    <p class="about">${c.getDescription()} </p>
                                </div>

                                <div class="buttons">
                                    <div class="social">
                                        ${c.getName()}
                                    </div>
                                    <a href="#" class="link" onclick="doImage('${c.getId()}')">See more</a>
                                </div>

                            </div></div>

                    </div></c:forEach>
                </div>






                <div class="section-title"> <h2 class="text-center subhead">Total products</h2></div>
                <div class="d-flex align-items-center justify-content-center">
                    <form action="search-name" class="mb-3">
                    <c:set var="name" value="${requestScope.name}"/>                   
                    <input type="text" id="name" name="name" placeholder=${name != null ? name : "Search your favorite flowers:" } style="border-radius:20px; width: 300px"/>
                    <button type="submit" value="search" class="btn btn-outline-primary rounded-pill">
                        <i class="fa-solid fa-magnifying-glass"></i>
                    </button>
                </form> 
            </div>
            <!--            <h2 class="text-center">Total products</h2>
                        <div class="d-flex align-items-center justify-content-center">
                            <form action="search-name">
                                <label for="id">Search product by name: </label>
                                <input type="text" id="name" name="name" placeholder="${requestScope.name}"/>
                                <input type="submit" value="search"/>
            <c:set var="name" value="${requestScope.name}"/>
        </form>
    </div>-->
            <div class="row">
                <c:choose>
                    <c:when test="${requestScope.list!=null}">
                        <c:forEach var="c" items="${requestScope.list}">
                            <div class="col-md-4 pb-3">
                                <div class="card w-100" style="width: 18rem; position: relative;">
                                    <!--<image class="card-img-top" src="images/${c.getImage()}" alt="${c.getImage()}" style="height: 250px; width: auto;" onclick="doImage('${c.getId()}')"/>-->
                                    <div class="image-container" style="height: 250px; width: auto; position: relative;">
                                        <img class="card-img-top" src="images/${c.getImage()}" alt="${c.getImage()}"/>
                                        <button class="view-detail border-0 "  onclick="doImage('${c.getId()}')">View Detail</button>
                                    </div>
                                    <style type="text/css">
                                        .image-container {
                                            overflow: hidden;
                                        }
                                        .card-img-top {
                                            transition: transform 0.3s ease-in-out;
                                        }
                                        .view-detail {
                                            position: absolute;
                                            top: 50%;
                                            left: 50%;
                                            transform: translate(-50%, -50%);
                                            opacity: 0;
                                            transition: opacity 0.3s ease-in-out;
                                            background-color: lightgreen;
                                            color: white;
                                            padding: 10px 20px;
                                            border-radius: 10px;
                                            cursor: pointer;
                                        }
                                        .image-container:hover .card-img-top {
                                            transform: scale(1.1);
                                        }
                                        .image-container:hover .view-detail {
                                            opacity: 1;
                                        }
                                    </style>
                                    <div class="discount-badge">-${c.getDiscount()}%</div>
                                    <div class="card-body">
                                        <h5 class="card-title">${c.getName()}</h5>
                                        <div class="price-box" style="display: flex; align-items: center; justify-content: space-between;">
                                            <p style="font-weight: bold;">Price:</p> 
                                            <p style="text-decoration: line-through; color: gray">$${c.getPrice()}</p>
                                            <p>$<fmt:formatNumber value="${c.getPrice()*(100-c.getDiscount())/100}" type="number" maxFractionDigits="2"/></p>
                                        </div>
                                        <div class="description">${c.getDescription()}</div>
                                        <h6 class="category">Category: <a href="product-pagination?category=${c.getCategory()}">${c.getCategory()}</a></h6>
                                        <div class="mt-3 d-flex justify-content-between">
                                            <a href="add-to-cart?id=${c.getId()}" class="btn btn-danger">Add to cart</a>
                                            <a href="order-now?quantity=1&id=${c.getId()}" class="btn btn-primary">Buy now</a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="c" items="<%= list%>">
                            <div class="col-md-4 pb-3">
                                <div class="card w-100" style="width: 18rem; position: relative;">
                                    <!--<image class="card-img-top" src="images/${c.getImage()}" alt="${c.getImage()}" style="height: 250px; width: auto;" onclick="doImage('${c.getId()}')"/>-->

                                    <div class="image-container" style="height: 250px; width: auto; position: relative;">
                                        <img class="card-img-top" src="images/${c.getImage()}" alt="${c.getImage()}"/>
                                        <button class="view-detail"  onclick="doImage('${c.getId()}')">View Detail</button>
                                    </div>
                                    <style type="text/css">
                                        .image-container {
                                            overflow: hidden;
                                        }
                                        .card-img-top {
                                            transition: transform 0.3s ease-in-out;
                                        }
                                        .view-detail {
                                            position: absolute;
                                            top: 50%;
                                            left: 50%;
                                            transform: translate(-50%, -50%);
                                            opacity: 0;
                                            transition: opacity 0.3s ease-in-out;
                                            background-color: lightgreen;
                                            color: white;
                                            padding: 10px 20px;
                                            border-radius: 10px;
                                            cursor: pointer;
                                        }
                                        .image-container:hover .card-img-top {
                                            transform: scale(1.1);
                                        }
                                        .image-container:hover .view-detail {
                                            opacity: 1;
                                        }
                                    </style>

                                    <div class="discount-badge">-${c.getDiscount()}%</div>
                                    <div class="card-body">
                                        <h5 class="card-title">${c.getName()}</h5>
                                        <div class="price-box" style="display: flex; align-items: center; justify-content: space-between;">
                                            <p style="font-weight: bold;">Price:</p> 
                                            <p style="text-decoration: line-through; color: gray">$${c.getPrice()}</p>
                                            <p>$<fmt:formatNumber value="${c.getPrice()*(100-c.getDiscount())/100}" type="number" maxFractionDigits="2"/></p>
                                        </div>
                                        <div class="description">${c.getDescription()}</div>
                                        <h6 class="category">Category: <a href="product-pagination?category=${c.getCategory()}">${c.getCategory()}</a></h6>
                                        <div class="mt-3 d-flex justify-content-between">
                                            <a href="add-to-cart?id=${c.getId()}" class="btn btn-danger">Add to cart</a>
                                            <a href="order-now?quantity=1&id=${c.getId()}" class="btn btn-primary">Buy now</a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </div>
            <div style="text-align: center;" class="clearfix">
                <c:choose>
                    <c:when test="${requestScope.name!=null}">
                        <div class="hint-text">Showing <b>${requestScope.tag}</b> out of <b>${requestScope.endP}</b> entries</div>
                        <ul class="pagination" style="display: flex; align-items: center; justify-content: center;">
                            <c:if test="${requestScope.tag>1}">
                                <li class="page-item">
                                    <a href="search-name?index=${requestScope.tag-1}&name=${name}" class="page-link" aria-label="Go to previous page">Previous</a>
                                </li>
                            </c:if>
                            <c:forEach begin="1" end="${requestScope.endP}" var="i">
                                <li class="page-item ${requestScope.tag == i?"active":""}">
                                    <a href="search-name?index=${i}&name=${name}" class="page-link">${i}</a>
                                </li> 
                            </c:forEach>
                            <c:if test="${requestScope.tag < requestScope.endP}">
                                <li class="page-item">
                                    <a href="search-name?index=${requestScope.tag+1}&name=${name}" class="page-link" aria-label="Go to next page">Next</a>
                                </li>
                            </c:if>
                        </ul>
                    </c:when>
                    <c:otherwise>
                        <c:set var="index" value="<%= index%>"/>
                        <c:choose>
                            <c:when test="${requestScope.tag!=null && requestScope.endP!=null}">
                                <div class="hint-text">Showing <b>${requestScope.tag}</b> out of <b>${requestScope.endP}</b> entries</div>
                                <ul class="pagination" style="display: flex; align-items: center; justify-content: center;">
                                    <c:if test="${requestScope.tag>1}">
                                        <li class="page-item">
                                            <a href="search-name?index=${requestScope.tag-1}&name=${name}" class="page-link" aria-label="Go to previous page">Previous</a>
                                        </li>
                                    </c:if>
                                    <c:forEach begin="1" end="${requestScope.endP}" var="i">
                                        <li class="page-item ${requestScope.tag == i?"active":""}">
                                            <a href="search-name?index=${i}&name=${name}" class="page-link">${i}</a>
                                        </li> 
                                    </c:forEach>
                                    <c:if test="${requestScope.tag < requestScope.endP}">
                                        <li class="page-item">
                                            <a href="search-name?index=${requestScope.tag+1}&name=${name}" class="page-link" aria-label="Go to next page">Next</a>
                                        </li>
                                    </c:if>
                                </ul>
                            </c:when>
                            <c:otherwise>
                                <div class="hint-text">Showing <b><%= index%></b> out of <b><%= endPage%></b> entries</div>
                                <ul class="pagination" style="display: flex; align-items: center; justify-content: center;">
                                    <c:if test="<%= (index>1)%>">
                                        <li class="page-item">
                                            <a href="search-name?index=<%= (index-1)%>" class="page-link" aria-label="Go to previous page">Previous</a>
                                        </li>
                                    </c:if>
                                    <c:forEach begin="1" end="<%= (endPage)%>" var="i">
                                        <li class="page-item ${index == i ? 'active' : ''}">
                                            <a href="search-name?index=${i}" class="page-link">${i}</a>
                                        </li> 
                                    </c:forEach>
                                    <c:if test="<%= (index<endPage)%>">
                                        <li class="page-item">
                                            <a href="search-name?index=<%= (index+1)%>" class="page-link" aria-label="Go to next page">Next</a>
                                        </li>
                                    </c:if>
                                </ul>
                            </c:otherwise>
                        </c:choose>
                    </c:otherwise>
                </c:choose>
            </div>
            <section class="container py-5">
                <div class="row">
                    <div class="col-md-4 col-md-4-1 text-center">
                        <i class="fas fa-cogs fa-3x"></i>
                        <h3>High Quality</h3>
                        <p>We ensure the highest quality in our products and services.</p>
                    </div>
                    <div class="col-md-4 col-md-4-1 text-center">
                        <i class="fas fa-concierge-bell fa-3x"></i>
                        <h3>Excellent Service</h3>
                        <p>Our customer service is dedicated to your satisfaction.</p>
                    </div>
                    <div class="col-md-4 col-md-4-1 text-center">
                        <i class="fas fa-user-friends fa-3x"></i>
                        <h3>Strong Partnership</h3>
                        <p>We build and maintain strong relationships with our partners.</p>
                    </div>
                </div>
            </section>
        </div>
    </div>

    <%@include file="includes/scroll.jsp" %>

    <%@include file="includes/foot.jsp" %>

    <%@include file="includes/footer.jsp" %>
</body>
</html>
