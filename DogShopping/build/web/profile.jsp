<%-- 
    Document   : profile
    Created on : Mar 5, 2024, 10:48:11 PM
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
        <title>Profile</title>
                <link rel="shortcut icon" href="./images/cropped-favicon.jpg" type="image/x-icon"  />

        <style>
            .gradient-custom {
                /* fallback for old browsers */
                background: #f6d365;

                /* Chrome 10-25, Safari 5.1-6 */
                background: -webkit-linear-gradient(to right bottom, rgba(246, 211, 101, 1), rgba(253, 160, 133, 1));

                /* W3C, IE 10+/ Edge, Firefox 16+, Chrome 26+, Opera 12+, Safari 7+ */
                background: linear-gradient(to right bottom, rgba(246, 211, 101, 1), rgba(253, 160, 133, 1))
            }
        </style>
    </head>
    <body>
        <%@include file="includes/navbar.jsp" %>

        <c:set var="c" value="${sessionScope.auth}"/>
<!--        <div class="container">
            <form action="update-user" method="post" style="margin-top: 140px">
                <div class="form-group">
                    <input type="hidden" class="form-control" name="id" value="${c.id}" readonly/>
                </div>
                <div class="form-group">
                    <label>Username: </label>
                    <input type="text" class="form-control" name="name" value="${c.name}" required/>
                </div>
                <div class="form-group">
                    <label>Email Address: </label>
                    <input type="email" class="form-control" name="email" value="${c.email}" required/>
                </div>
                <div class="form-group">
                    <label>Password: </label>
                    <input type="password" class="form-control" name="password" value="${c.password}" required/>
                </div>
                <div class="form-group">
                    <label>Role ID: </label>
                    <input type="number" class="form-control" name="roleid" value="${c.roleid}" required/>
                </div>
                <div class="form-group">
                    <label>Phone: </label>
                    <input type="text" class="form-control" name="phone" value="${c.phone}" required/>
                </div>
            </form>
        </div>-->
<!--style="background-color: #f4f5f7;"-->
<section class="vh-100 profilePage" >
  <div class="container py-5 h-100">
    <div class="row d-flex justify-content-center align-items-center h-100">
      <div class="col col-lg-6 mb-4 mb-lg-0">
        <div class="card mb-3" style="border-radius: .5rem;">
          <div class="row g-0">
            <div class="col-md-4 gradient-custom text-center text-white"
              style="border-top-left-radius: .5rem; border-bottom-left-radius: .5rem;">
              <img src="https://mdbcdn.b-cdn.net/img/Photos/new-templates/bootstrap-chat/ava1-bg.webp"
                alt="Avatar" class="img-fluid my-5" style="width: 80px;" />
              <h5>${c.name}</h5>
              <p>${c.roleid}</p>
              <i class="far fa-edit mb-5"></i>
            </div>
            <div class="col-md-8">
              <div class="card-body p-4">
                <h6>Information</h6>
                <hr class="mt-0 mb-4">
                <div class="row pt-1">
                  <div class="col-6 mb-3">
                    <h6>Email</h6>
                    <p class="text-muted">${c.email}</p>
                  </div>
                  <div class="col-6 mb-3">
                    <h6>Phone</h6>
                    <p class="text-muted">${c.phone}</p>
                  </div>
                </div>
                <h6>Projects</h6>
                <hr class="mt-0 mb-4">
                <div class="row pt-1">
                  <div class="col-6 mb-3">
                    <h6>Recent</h6>
                    <p class="text-muted">Malfunction</p>
                  </div>
                  <div class="col-6 mb-3">
                    <h6>Most Viewed</h6>
                    <p class="text-muted">Malfunction</p>
                  </div>
                </div>
                <div class="d-flex justify-content-start ">
                    <a href="#!" class="mr-2"><i class="fab fa-facebook-f fa-lg me-3"></i></a>
                  <a href="#!" class="mr-2"><i class="fab fa-twitter fa-lg me-3"></i></a>
                  <a href="#!" class="mr-2"><i class="fab fa-instagram fa-lg"></i></a>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</section>

        <%@include file="includes/scroll.jsp" %>

        <%@include file="includes/foot.jsp" %>

        <%@include file="includes/footer.jsp" %>
    </body>
</html>
