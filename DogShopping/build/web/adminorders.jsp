<%-- 
    Document   : showusers
    Created on : Feb 19, 2024, 3:47:54 PM
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
        <c:if test="${sessionScope.auth.getRoleid()==1}">
            <div class="card-header my-3 d-flex align-items-center justify-content-between">
                <a href="#"><h5>Dashboard</h5></a>
                <a class="nav-link" href="logout">Log out</a>
            </div>
            <div class="row">
                <%@include file="includes/asideadmin.jsp" %>

                <main role="main" class="col-md-9 ml-sm-auto col-lg-10 px-4">
                    <form action="show-order">
                        <table class="table table-light">
                            <thead>
                                <tr>
                                    <th scope="col">id</th>
                                    <th scope="col">total price</th>
                                    <th scope="col">note</th>
                                    <th scope="col">address</th>
                                    <th scope="col">date</th>
                                    <th scope="col">user</th>

                                </tr>
                            </thead>
                            <tbody>

                                <c:forEach items="${list}" var="o">
                                    <tr>
                                        <td>àdasf</td>
                                        <td>àdasf</td>
                                        <td>àdasf</td>
                                        <td>àdasf</td>
                                        <td>àdasf</td>
                                        <td>àdasf</td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </form>
                    </main>
                </div>
        </c:if>
        <c:if test="${sessionScope.auth.getRoleid()!=1}">
            <%@include file="includes/access_denied.jsp" %>
        </c:if>
        <%@include file="includes/footer.jsp" %>
    </body>
</html>
