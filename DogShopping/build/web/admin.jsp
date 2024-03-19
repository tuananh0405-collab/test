<%-- 
    Document   : admin
    Created on : Feb 18, 2024, 10:34:39 PM
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
        <title>JSP Page</title>
        <%@include file="includes/head.jsp" %>
    </head>
    <body>
        <c:if test="${sessionScope.auth.getRoleid()==1}">
            <div class="card-header my-3 d-flex align-items-center justify-content-between">
                <a href="#"><h5>Dashboard</h5></a>
                <a class="nav-link" href="logout">Log out</a>
            </div>
            <div class="row">
                <%@include file="includes/asideadmin.jsp" %>

                <main role="main" class="col-md-9 ml-sm-auto col-lg-10 px-4">

                    <div class="row">
                        <div class="col-sm-3">
                            <div class="card bg-light border-0">
                                <i class="fa fa-users  mb-2" style="font-size: 50px; padding-top: 25px"></i>
                                <div class="card-body">
                                    <h4 class="card-title text-center">Total Users: ${requestScope.totalUsers}</h4>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-3">
                            <div class="card bg-light border-0">
                                <i class="fa fa-th-large mb-2" style="font-size: 50px; padding-top: 25px"></i>
                                <div class="card-body">
                                    <h4 class="card-title text-center">Total Categories: ${totalCategories}</h4>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-3">
                            <div class="card bg-light border-0">
                                <i class="fa fa-th mb-2" style="font-size: 50px; padding-top: 25px"></i>
                                <div class="card-body">
                                    <h4 class="card-title text-center">Total Products: ${totalProducts}</h4>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-3">
                            <div class="card bg-light border-0">
                                <i class="fa fa-list mb-2" style="font-size: 50px; padding-top: 25px"></i>
                                <div class="card-body">
                                    <h4 class="card-title text-center">Total Orders: ${totalOrders}</h4>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="graph col-sm-6">
                            <c:set var="labels" value="" />
                            <c:set var="data" value="" />
                            <c:forEach var="entry" items="${requestScope.data}" varStatus="loop">
                                <c:set var="key" value="${entry.key}" />
                                <c:set var="value" value="${entry.value}" />
                                <c:set var="labels" value="${labels}'${key}'${not loop.last ? ',' : ''}" />
                                <c:set var="data" value="${data}${value}${not loop.last ? ',' : ''}" />
                            </c:forEach>
                            <c:if test="${requestScope.type eq 'cate'}">
                                <img src="https://quickchart.io/chart?c={
                                     type:'pie',data:{labels:[${labels}], 
                                     datasets:[{data:[${data}]}]}}" 
                                     alt="alt" style="height: 300px;width: 500px;"/>
                                <p class="text-center">Products for each Category</p>          
                            </c:if>
                        </div>
                        <div class="graph col-sm-6">
                            <c:set var="labels" value="" />
                            <c:set var="data1" value="" />
                            <c:forEach var="entry" items="${requestScope.data1}" varStatus="loop">
                                <c:set var="key" value="${entry.key}" />
                                <c:set var="value" value="${entry.value}" />
                                <c:set var="labels" value="${labels}'${key}'${not loop.last ? ',' : ''}" />
                                <c:set var="data1" value="${data1}${value}${not loop.last ? ',' : ''}" />
                            </c:forEach>
                            <c:if test="${requestScope.type eq 'cate'}">
                                <img src="https://quickchart.io/chart?c={
                                     type:'horizontalBar',data:{labels:[${labels}], 
                                     datasets:[
                                     {
                                     label: 'Number of orders',
                                     backgroundColor: 'rgba(254, 55, 122, 0.5)',
                                     borderColor: 'rgba(255,99,132,1)',
                                     borderWidth: 1,
                                     data:[${data1}]}
                                     ]}}" 
                                     alt="alt" style="height: 300px;width: 500px;"/>
                                <p class="text-center">Most Buyed Product</p>          
                            </c:if>
                        </div>
                    </div>
                </main>
            </div>
        </c:if>
        <c:if test="${sessionScope.auth.getRoleid()!=1}">
            <%@include file="includes/access_denied.jsp" %>
        </c:if>
        <%@include file="includes/footer.jsp" %>
    </body>
</body>
</html>
