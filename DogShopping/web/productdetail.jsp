<%-- 
    Document   : productdetail
    Created on : Feb 13, 2024, 9:58:07 PM
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
    
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Details</title>
        <link rel="shortcut icon" href="./images/cropped-favicon.jpg" type="image/x-icon"  />

        <%@include file="includes/head.jsp" %>
        <script type="text/javascript">
            function doImage(id) {
                window.location = "product-detail?id=" + id;
            }

        </script>
        <style type="text/css">
            .card-img-top:hover {
                cursor: pointer;
            }
            .card {
                transition: all 0.3s ease-in-out;
            }

            .card:hover {
                transform: translateY(-5px);
                box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2);
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
                        <li class="breadcrumb-item logo"><a href="product-pagination">Products</a></li>
                        <li class="breadcrumb-item logo">Details</li>
                    </ol>
                </nav>
            </div>
        </div>

        <div class="container">

            <c:set value="${requestScope.product}" var="p"/>
            <div class="row gx-5">
                <aside class="col-lg-6">
                    <div class="border rounded-4 mb-3 d-flex justify-content-center">
                        <a data-fslightbox="mygalley" class="rounded-4" target="_blank" data-type="image" href="images/${p.image}">
                            <img style="max-width: 100%; max-height: 100vh; margin: auto; height: 300px; width: auto;" class="rounded-4 fit" src="images/${p.image}" />
                        </a>
                    </div>
                </aside>
                <main class="col-lg-6">
                    <div class="ps-lg-3">
                        <h4 class="title text-dark">
                            ${p.name}
                        </h4>
                        <div class="d-flex">
                            <p style="margin-right: 10px">Price: </p>
                            <p style="text-decoration: line-through; color: red; margin-right: 10px">$${p.getPrice()}</p>
                            <span>$<fmt:formatNumber value="${p.getPrice()*(100-p.getDiscount())/100}" type="number" maxFractionDigits="2"/></span>
                        </div>

                        <p>
                            ${p.description}
                        </p>

                        <div class="row">
                            <dt class="col-3">Type:</dt>
                            <dd class="col-9"><a href="product-pagination?category=${p.getCategory()}">${p.getCategory()}</a></dd>
                        </div>

                        <div class="row">
                            <dt class="col-3">Discount:</dt>
                            <dd class="col-9">${p.getDiscount()}%</dd>
                        </div>

                        <div class="row">
                            <dt class="col-3">Stock:</dt>
                            <dd class="col-9">${p.getStock()}</dd>
                        </div>

                        <hr />
                        <div class="mt-3 d-flex justify-content-between">
                            <a href="add-to-cart?id=${p.id}" class="btn btn-danger">Add to cart</a>
                            <a href="order-now?quantity=1&id=${p.id}" class="btn btn-primary">Buy now</a>
                        </div>
                    </div>
                </main>
            </div>

            <h4 style="text-align: center; padding: 20px 0;">Related Products</h4>

            <div class="row">
                <c:forEach var="c" items="${requestScope.list}">
                    <div class="col-md-4 pb-3">
                        <div class="card w-100" style="width: 18rem; position: relative;">
                            <!--<image class="card-img-top" src="images/${c.getImage()}" alt="${c.getImage()}" style="height: 240px; width: auto;" onclick="doImage('${c.getId()}')"/>-->

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

                            <div class="card-body">
                                <h5 class="card-title">${c.getName()}</h5>
                                <div class="price-box" style="display: flex; align-items: center; justify-content: space-between;">
                                    <p style="font-weight: bold;">Price:</p> 
                                    <p>$<fmt:formatNumber value="${c.getPrice()}" type="number" maxFractionDigits="2"/></p>
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
            </div>

            <h2 class="text-center">Comments</h2>
            <div class="row d-flex align-items-center justify-content-center">
                <div class="col-8">
                    <c:choose>
                        <c:when test="${requestScope.cmts != null}">
                            <c:forEach var="c" items="${requestScope.cmts}">
                                <div class="card card-white post" style="margin-bottom: 5px">
                                    <div class="post-heading">
                                        <div class="float-left image">
                                            <img src="http://bootdey.com/img/Content/user_1.jpg" class="img-circle avatar" alt="user profile image">
                                        </div>
                                        <div class="float-left meta">
                                            <div class="title h5">
                                                <a href="#"><b>${c.getUser().getName()}</b></a>
                                                made a comment.
                                            </div>
                                            <h6 class="text-muted time">${c.getDateComment()}</h6>
                                        </div>
                                    </div> 
                                    <div class="post-description"> 
                                        <p>${c.getComment()}</p>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <h3 class="text-center">No comment</h3>
                        </c:otherwise>
                    </c:choose>
                </div>
                <div class="col-8">
                    <h3 class="text-center">Add a comment</h3>
                    <div class="d-flex align-items-center justify-content-center">
                        <form action="product-detail" method="post" class="mb-3">
                            <input type="hidden" name="uid" value="${sessionScope.auth.id}"/>
                            <input type="hidden" name="id" value="${p.id}"/>
                            <input type="text" name="comment" required style="border-radius:20px; width: 300px"/>
                            <button type="submit" value="search" class="btn btn-outline-primary rounded-pill">
                                <!--<i class="fa-solid fa-magnifying-glass"></i>-->
                                <i class="fa-regular fa-comment"></i>
                            </button>
                        </form> 
                    </div>
                </div>
            </div>
            <style type="text/css">
                .card-white  .card-heading {
                    color: #333;
                    background-color: #fff;
                    border-color: #ddd;
                    border: 1px solid #dddddd;
                }
                .card-white  .card-footer {
                    background-color: #fff;
                    border-color: #ddd;
                }
                .card-white .h5 {
                    font-size:14px;
                }
                .card-white .time {
                    font-size:12px;
                }
                .post .post-heading {
                    height: 95px;
                    padding: 20px 15px;
                }
                .post .post-heading .avatar {
                    width: 60px;
                    height: 60px;
                    display: block;
                    margin-right: 15px;
                }
                .post .post-heading .meta .title {
                    margin-bottom: 0;
                }
                .post .post-heading .meta .title a {
                    color: black;
                }
                .post .post-heading .meta .title a:hover {
                    color: #aaaaaa;
                }
                .post .post-heading .meta .time {
                    margin-top: 8px;
                    color: #999;
                }
                .post .post-image .image {
                    width: 100%;
                    height: auto;
                }
                .post .post-description {
                    padding: 15px;
                }
                .post .post-description p {
                    font-size: 14px;
                }
                .post .post-description .stats {
                    margin-top: 20px;
                }
                .post .post-description .stats .stat-item {
                    display: inline-block;
                    margin-right: 15px;
                }
                .post .post-description .stats .stat-item .icon {
                    margin-right: 8px;
                }
                .post .post-footer {
                    border-top: 1px solid #ddd;
                    padding: 15px;
                }
                .post .post-footer .input-group-addon a {
                    color: #454545;
                }
                .post .post-footer .comments-list {
                    padding: 0;
                    margin-top: 20px;
                    list-style-type: none;
                }
                .post .post-footer .comments-list .comment {
                    display: block;
                    width: 100%;
                    margin: 20px 0;
                }
                .post .post-footer .comments-list .comment .avatar {
                    width: 35px;
                    height: 35px;
                }
                .post .post-footer .comments-list .comment .comment-heading {
                    display: block;
                    width: 100%;
                }
                .post .post-footer .comments-list .comment .comment-heading .user {
                    font-size: 14px;
                    font-weight: bold;
                    display: inline;
                    margin-top: 0;
                    margin-right: 10px;
                }
                .post .post-footer .comments-list .comment .comment-heading .time {
                    font-size: 12px;
                    color: #aaa;
                    margin-top: 0;
                    display: inline;
                }
                .post .post-footer .comments-list .comment .comment-body {
                    margin-left: 50px;
                }
                .post .post-footer .comments-list .comment > .comments-list {
                    margin-left: 50px;
                }
            </style>
        </div>

        <%@include file="includes/scroll.jsp" %>

        <%@include file="includes/foot.jsp" %>

        <%@include file="includes/footer.jsp" %>
    </body>
</html>
