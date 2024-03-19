<%-- 
    Document   : blogitem
    Created on : Feb 5, 2024, 7:23:59 PM
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
        <%@include file="includes/head.jsp" %>
        <title>Blog Details</title>
                <link rel="shortcut icon" href="./images/cropped-favicon.jpg" type="image/x-icon"  />

        <style>
      .blog-content{
	font-size: 1em;
	border-left: 5px solid #8EE5EE;
	padding-left: 15px;
}
.date{
	font-size: 1em;
	font-weight: 400;
	color: #9C9C9C;
	margin-top: -10px;
	text-decoration: underline;
	text-decoration-color: currentColor;
}
.blog-title{
	font-size: 2.5em;
	margin-top: 5px;
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
                        <li class="breadcrumb-item logo"><a href="blog">Blog</a></li>
                        <li class="breadcrumb-item logo">Blog Detail</li>
                    </ol>
                </nav>
            </div>
        </div>

        <c:set var="b" value="${requestScope.blog}"/>
        <!--        <div class="container">
                    <h2 class="mt-5 mb-3 text-center">${b.title}</h2>
                    <img src="images/${b.image}" alt="${b.title}" style="width: 800px; height: 400px"/>
                    <p class="mb-5">${b.lastUpdated}</p>
                    <p class="mb-5">${b.content}</p>
                </div>-->

        <div class="container ">
            <div class="section row pb-10">
                <div class="col-8">
                    <div class="blog-post">
                        <h1 class="blog-title">${b.title}</h1>
                        <h2 class="date">Posted ${b.lastUpdated}</h2>
                        <p class="blog-content">${b.content}</p>
                        <a class="op-50">Thanks for Reading.</a>
                    </div>
                </div>

                <aside class="col-4">
                    <div class="side-post">
                        <img src="images/${b.image}" alt="img">
                    </div>
                </aside>
            </div>
        </div>

        <%@include file="includes/scroll.jsp" %>

        <%@include file="includes/foot.jsp" %>

        <%@include file="includes/footer.jsp" %>
    </body>
</html>
