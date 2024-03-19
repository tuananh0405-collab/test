<%-- 
    Document   : blog
    Created on : Feb 4, 2024, 10:02:15 PM
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
        <title>Blogs</title>
                <link rel="shortcut icon" href="./images/cropped-favicon.jpg" type="image/x-icon"  />

        <script type="text/javascript">
            function doBlog(id) {
                window.location = "blog-item?id=" + id;
            }
        </script>
        <style>
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
                        <li class="breadcrumb-item logo">Blog</li>
                    </ol>
                </nav>
            </div>
        </div>

        <div class="container">
            <h1 class="my-4 text-center">Blogs</h1>
            <div class="row">
                <c:forEach  var="blog" items="${listB}">
                    <div class="col-md-4 pb-3">
                        <div class="card w-100" style="width: 18rem">
                            <div class="image-container" style="height: 250px; width: auto; position: relative;">
                                <img class="card-img-top" src="images/${blog.image}" alt="${blog.title}"/>
                                <button class="view-detail" onclick="doBlog('${blog.id}')">View Detail</button>
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
                                <div class="card-body">
                                    <h4 class="card-title">${blog.title}</h4>
                                    <p class="card-text">${blog.content}</p>
                                    <p class="card-text"><small class="text-muted">${blog.lastUpdated}</small></p>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
            <div style="text-align: center;" class="clearfix">
                <div class="hint-text">Showing <b>${tag}</b> out of <b>${endP}</b> entries</div>
                <ul class="pagination" style="display: flex; align-items: center; justify-content: center;">
                    <c:if test="${tag>1}">
                        <li class="page-item">
                            <a href="blog?index=${tag-1}" class="page-link" aria-label="Go to previous page">Previous</a>
                        </li>
                    </c:if>
                    <c:forEach begin="1" end="${endP}" var="i">
                        <li class="page-item ${tag == i?"active":""}">
                            <a href="blog?index=${i}" class="page-link">${i}</a>
                        </li> 
                    </c:forEach>
                    <c:if test="${tag < endP}">
                        <li class="page-item">
                            <a href="blog?index=${tag+1}" class="page-link" aria-label="Go to next page">Next</a>
                        </li>
                    </c:if>
                </ul>
            </div>
        </div>

        <%@include file="includes/scroll.jsp" %>

        <%@include file="includes/foot.jsp" %>

        <%@include file="includes/footer.jsp" %>
    </body>
</html>
