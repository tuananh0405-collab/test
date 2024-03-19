<%-- 
    Document   : product
    Created on : Feb 4, 2024, 10:01:53 PM
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
    List<String> categories = pd.getCategories();
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
        <title>Main Shop</title>
        <link rel="shortcut icon" href="./images/cropped-favicon.jpg" type="image/x-icon"  />

        <style>
            .categoryDisplay {
                cursor: pointer;
                border: 1px solid orange;
                border-radius: 50px;
                background: none;
                padding: 8px 12px;
                font-size: 14px;
                margin-bottom: 4px;
            }

            .categoryDisplay:hover {
                background: orange;
                color: white;
            }
            .btn-outline-primary {
                border: none;
                cursor: pointer;
                border-radius: 20px;
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
            .card{
                /*box-shadow: 3px 3px 3px 3px grey;*/

            }

            .card1 {
                transition: all 0.3s ease-in-out;
            }

            .card1:hover {
                transform: translateY(-5px);
                box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2);
            }
        </style>
        <%
            String message = (String) request.getSession().getAttribute("message");
            if (message!=null && message!="") {
        %>
        <script type="text/javascript">
            window.onload = function () {
                var message = '<%=message%>';
                if (message !== null && message !== '') {
                    alert(message, 2000);
                }
            };
        </script>
        <script src="includes/alert.js"></script>
        <%
            }
            request.getSession().removeAttribute("message");
        %>
        <script type="text/javascript">
            function doImage(id) {
                window.location = "product-detail?id=" + id;
            }

            function doFilter(value) {
                window.location = "product-pagination?items=${requestScope.items}&choice-item=" + value;
            }
        </script>
        <script>
            window.onload = function () {
                var checkboxes = document.querySelectorAll('input[type=checkbox][name=supplier]');
                checkboxes.forEach(function (checkbox) {
                    checkbox.addEventListener('change', function () {
                        var checkedValues = Array.from(document.querySelectorAll('input[type=checkbox][name=supplier]:checked')).map(function (c) {
                            return c.value;
                        });
                        window.location = "product-pagination?items=${requestScope.items}&suppliers=" + checkedValues.join(',');
                    });
                });
            };
        </script>
    </head>
    <body>
        <%@include file="includes/navbar.jsp" %>

        <div class="row nav-history">
            <div class="col">
                <nav aria-label="breadcrumb" class="rounded-3 p-3">
                    <ol class="breadcrumb d-flex align-items-center justify-content-center pt-3">
                        <li class="breadcrumb-item logo"><a href="index.jsp">Home</a></li>
                        <li class="breadcrumb-item logo">Product</li>
                    </ol>
                </nav>
            </div>
        </div>

        <div class="container">

            <div class="row ">
                <div class="col-md-3 card w-50 mx-auto mt-3">
                    <div class="card-body">
                        <form action="product-pagination?items=${requestScope.items}">
                            <label><h5>Search by name:</h5></label>
                            <input type="hidden" name="items" value="${requestScope.items}"/>
                            <div class="row"> 
                                <input type="text" name="name" />
                                <!--                            <button type="submit" value="Search"><i class="fa-solid fa-magnifying-glass"></i></button></div>-->
                                <button type="submit" value="Search" class="btn btn-outline-primary rounded-pill">
                                    <i class="fa-solid fa-magnifying-glass"></i>
                                </button></div>
                                <c:set var="name" value="${requestScope.name}"/>
                        </form>
                        <br/>
                        <form action="product-pagination" class="d-flex flex-column">
                            <label><h5>Search by Category:</h5></label>
                            <c:forEach var="c" items="<%= categories%>">
                                <input class="categoryDisplay" type="hidden" name="items" value="${requestScope.items}"/>
                                <input class="categoryDisplay" type="submit" name="category" value="${c}"/>
                            </c:forEach>
                            <c:set var="category" value="${requestScope.category}"/>
                        </form>
                        <br/>
                        <form action="product-pagination?items=${requestScope.items}" class="d-flex flex-column">
                            <label><h5>Search by Price:</h5></label>
                            <input type="hidden" name="items" value="${requestScope.items}"/>
                            <label for="from">From</label><input type="number" id="from" name="from" value="${requestScope.from}"/>
                            <label for="to">To</label><input type="number" id="to" name="to" value="${requestScope.to}"/>
                            <c:set var="from" value="${requestScope.from}"/>
                            <c:set var="to" value="${requestScope.to}"/>
                            <button class="btn btn-outline-success btn-rounded btn-sm my-0 mt-2" type="submit">Search</button>
                            <!--<input type="submit" value="Search"/>-->
                        </form>
                        <br/>
                        <form action="product-pagination?items=${requestScope.items}" class="d-flex flex-column">
                            <label><h5>Search by Supplier:</h5></label>
                            <input type="hidden" name="items" value="${requestScope.items}"/>
                            <c:forEach var="s" items="${requestScope.suppliers}">
                                <div class="d-flex align-items-center" style="gap: 5px">
                                    <input style="display: block" type="checkbox" id="supplier${s.id}" name="supplier" value="${s.id}"/>
                                    <label for="supplier${s.id}" style="margin: 0">${s.name}</label>
                                </div>
                            </c:forEach>
                        </form>
                    </div>
                </div>
                <div class="col-md-9">
                    <div class="card-header my-3 align-items-right d-flex justify-content-between bg-light">
                        <div class="d-flex">
                            <label>Sort by : </label>&nbsp
                            <form>
                                <select name="choice-item" onchange="doFilter(this.value)">
                                    <c:choose>
                                        <c:when test="${param['choice-item'] == 'Increasing'}">
                                            <option value="Increasing" selected>Increasing price</option>
                                            <option value="Decreasing">Decreasing price</option>
                                            <option value="Alphabet">Alphabet</option>
                                            <option value="All" >All</option>
                                        </c:when>
                                        <c:when test="${param['choice-item'] == 'Decreasing'}">
                                            <option value="Decreasing" selected>Decreasing price</option>
                                            <option value="Increasing">Increasing price</option>
                                            <option value="Alphabet">Alphabet</option>
                                            <option value="All">All</option>
                                        </c:when>
                                        <c:when test="${param['choice-item'] == 'Alphabet'}">
                                            <option value="Alphabet" selected>Alphabet</option>
                                            <option value="Increasing">Increasing price</option>
                                            <option value="Decreasing">Decreasing price</option>
                                            <option value="All">All</option>
                                        </c:when>
                                        <c:otherwise>
                                            <option value="All" selected>All</option>
                                            <option value="Increasing">Increasing price</option>
                                            <option value="Decreasing">Decreasing price</option>
                                            <option value="Alphabet">Alphabet</option>
                                        </c:otherwise>
                                    </c:choose>
                                </select>
                            </form>
                        </div>
                        <div class="d-flex justify-content-center align-items-center">
                            <a href="product-pagination?items=2" style="padding-right: 10px">
                                <!--<i class="fa-solid fa-table-cells-large"></i>-->
                                <svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="grid-2" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512" class="svg-inline--fa fa-grid-2 fa-lg"><path fill="currentColor" d="M224 80c0-26.5-21.5-48-48-48H80C53.5 32 32 53.5 32 80v96c0 26.5 21.5 48 48 48h96c26.5 0 48-21.5 48-48V80zm0 256c0-26.5-21.5-48-48-48H80c-26.5 0-48 21.5-48 48v96c0 26.5 21.5 48 48 48h96c26.5 0 48-21.5 48-48V336zM288 80v96c0 26.5 21.5 48 48 48h96c26.5 0 48-21.5 48-48V80c0-26.5-21.5-48-48-48H336c-26.5 0-48 21.5-48 48zM480 336c0-26.5-21.5-48-48-48H336c-26.5 0-48 21.5-48 48v96c0 26.5 21.5 48 48 48h96c26.5 0 48-21.5 48-48V336z" class=""></path></svg>
                            </a>
                            <a href="product-pagination?items=3">
                                <!--<i class="fa-solid fa-table-cells"></i>-->
                                <svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="grid" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 448 512" class="svg-inline--fa fa-grid fa-lg"><path fill="currentColor" d="M0 72C0 49.9 17.9 32 40 32H88c22.1 0 40 17.9 40 40v48c0 22.1-17.9 40-40 40H40c-22.1 0-40-17.9-40-40V72zM0 232c0-22.1 17.9-40 40-40H88c22.1 0 40 17.9 40 40v48c0 22.1-17.9 40-40 40H40c-22.1 0-40-17.9-40-40V232zM128 392v48c0 22.1-17.9 40-40 40H40c-22.1 0-40-17.9-40-40V392c0-22.1 17.9-40 40-40H88c22.1 0 40 17.9 40 40zM160 72c0-22.1 17.9-40 40-40h48c22.1 0 40 17.9 40 40v48c0 22.1-17.9 40-40 40H200c-22.1 0-40-17.9-40-40V72zM288 232v48c0 22.1-17.9 40-40 40H200c-22.1 0-40-17.9-40-40V232c0-22.1 17.9-40 40-40h48c22.1 0 40 17.9 40 40zM160 392c0-22.1 17.9-40 40-40h48c22.1 0 40 17.9 40 40v48c0 22.1-17.9 40-40 40H200c-22.1 0-40-17.9-40-40V392zM448 72v48c0 22.1-17.9 40-40 40H360c-22.1 0-40-17.9-40-40V72c0-22.1 17.9-40 40-40h48c22.1 0 40 17.9 40 40zM320 232c0-22.1 17.9-40 40-40h48c22.1 0 40 17.9 40 40v48c0 22.1-17.9 40-40 40H360c-22.1 0-40-17.9-40-40V232zM448 392v48c0 22.1-17.9 40-40 40H360c-22.1 0-40-17.9-40-40V392c0-22.1 17.9-40 40-40h48c22.1 0 40 17.9 40 40z" class=""></path></svg>
                            </a>
                        </div>
                    </div>
                    <div class="row">
                        <c:forEach items="${list}" var="c">
                            <c:choose>
                                <c:when test="${requestScope.items==2}">
                                    <div class="col-md-6 pb-3">
                                        <div class="card card1 w-100" style="width: 18rem; position: relative;">
                                            <!--<image class="card-img-top" src="images/${c.getImage()}" alt="${c.getImage()}" style="height: 250px; width: 100%;" onclick="doImage('${c.getId()}')"/>-->

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
                                                <h5 class="card-title text-center text-uppercase">${c.getName()}</h5>
                                                <div class="price-box" style="display: flex; align-items: center; justify-content: space-between;">
                                                    <p style="font-weight: bold;">Price:</p> 
                                                    <p style="text-decoration: line-through; color: red">$${c.getPrice()}</p>
                                                    <p>$<fmt:formatNumber value="${c.getPrice()*(100-c.getDiscount())/100}" type="number" maxFractionDigits="2"/></p>
                                                </div>
                                                <div class="description">${c.getDescription()}</div>
                                                <h6 class="category">Category: <a  style="text-decoration: none"  href="product-pagination?category=${c.getCategory()}">${c.getCategory()}</a></h6>
                                                <div class="mt-3 d-flex justify-content-between">
                                                    <a href="add-to-cart?id=${c.getId()}" class="btn btn-danger">Add to cart</a>
                                                    <a href="order-now?quantity=1&id=${c.getId()}" class="btn btn-primary">Buy now</a>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div class="col-md-4 pb-3">
                                        <div class="card card1 w-100" style="width: 18rem; position: relative;">
                                            <!--<image class="card-img-top" src="images/${c.getImage()}" alt="${c.getImage()}" style="height: 150px; width: 100%;" onclick="doImage('${c.getId()}')"/>-->

                                            <div class="image-container" style="height: 150px; width: 100%; position: relative;">
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
                                                <h5 class="card-title text-center text-uppercase">${c.getName()}</h5>
                                                <div class="price-box" style="display: flex; align-items: center; justify-content: space-between;">
                                                    <p style="font-weight: bold;">Price:</p> 
                                                    <p style="text-decoration: line-through; color: red">$${c.getPrice()}</p>
                                                    <p>$<fmt:formatNumber value="${c.getPrice()*(100-c.getDiscount())/100}" type="number" maxFractionDigits="2"/></p>
                                                </div>
                                                <div class="description">${c.getDescription()}</div>
                                                <h6 class="category">Category: <a style="text-decoration: none" href="product-pagination?category=${c.getCategory()}">${c.getCategory()}</a></h6>
                                                <div class="mt-3 d-flex justify-content-between">
                                                    <a href="add-to-cart?id=${c.getId()}" class="btn btn-danger">Add to cart</a>
                                                    <a href="order-now?quantity=1&id=${c.getId()}" class="btn btn-primary">Buy now</a>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>
                    </div>
                    <div style="text-align: center;" class="clearfix">
                        <div class="hint-text">Showing <b>${requestScope.tag}</b> out of <b>${requestScope.endP}</b> entries</div>
                        <ul class="pagination" style="display: flex; align-items: center; justify-content: center;">
                            <c:choose>
                                <c:when test="${requestScope.category!=null}">
                                    <c:if test="${requestScope.tag>1}">
                                        <li class="page-item">
                                            <a href="product-pagination?index=${requestScope.tag-1}&category=${category}&choice-item=${param['choice-item']}&items=${requestScope.items}" class="page-link" aria-label="Go to previous page">Previous</a>
                                        </li>
                                    </c:if>
                                    <c:forEach begin="1" end="${requestScope.endP}" var="i">
                                        <li class="page-item ${requestScope.tag == i?"active":""}">
                                            <a href="product-pagination?index=${i}&category=${category}&choice-item=${param['choice-item']}&items=${requestScope.items}" class="page-link">${i}</a>
                                        </li> 
                                    </c:forEach>
                                    <c:if test="${requestScope.tag < requestScope.endP}">
                                        <li class="page-item">
                                            <a href="product-pagination?index=${requestScope.tag+1}&category=${category}&choice-item=${param['choice-item']}&items=${requestScope.items}" class="page-link" aria-label="Go to next page">Next</a>
                                        </li>
                                    </c:if>
                                </c:when>
                                <c:when test="${requestScope.name!=null}">
                                    <c:if test="${requestScope.tag>1}">
                                        <li class="page-item">
                                            <a href="product-pagination?index=${requestScope.tag-1}&name=${name}&choice-item=${param['choice-item']}&items=${requestScope.items}" class="page-link" aria-label="Go to previous page">Previous</a>
                                        </li>
                                    </c:if>
                                    <c:forEach begin="1" end="${requestScope.endP}" var="i">
                                        <li class="page-item ${requestScope.tag == i?"active":""}">
                                            <a href="product-pagination?index=${i}&name=${name}&choice-item=${param['choice-item']}&items=${requestScope.items}" class="page-link">${i}</a>
                                        </li> 
                                    </c:forEach>
                                    <c:if test="${requestScope.tag < requestScope.endP}">
                                        <li class="page-item">
                                            <a href="product-pagination?index=${requestScope.tag+1}&name=${name}&choice-item=${param['choice-item']}&items=${requestScope.items}" class="page-link" aria-label="Go to next page">Next</a>
                                        </li>
                                    </c:if>
                                </c:when>
                                <c:when test="${requestScope.from!=null || requestScope.to!=null}">
                                    <c:if test="${requestScope.tag>1}">
                                        <li class="page-item">
                                            <a href="product-pagination?index=${requestScope.tag-1}&from=${from}&to=${to}&choice-item=${param['choice-item']}&items=${requestScope.items}" class="page-link" aria-label="Go to previous page">Previous</a>
                                        </li>
                                    </c:if>
                                    <c:forEach begin="1" end="${requestScope.endP}" var="i">
                                        <li class="page-item ${requestScope.tag == i?"active":""}">
                                            <a href="product-pagination?index=${i}&from=${from}&to=${to}&choice-item=${param['choice-item']}&items=${requestScope.items}" class="page-link">${i}</a>
                                        </li> 
                                    </c:forEach>
                                    <c:if test="${requestScope.tag < requestScope.endP}">
                                        <li class="page-item">
                                            <a href="product-pagination?index=${requestScope.tag+1}&from=${from}&to=${to}&choice-item=${param['choice-item']}&items=${requestScope.items}" class="page-link" aria-label="Go to next page">Next</a>
                                        </li>
                                    </c:if>
                                </c:when>
                                <c:otherwise>
                                    <c:if test="${requestScope.tag>1}">
                                        <li class="page-item">
                                            <a href="product-pagination?index=${requestScope.tag-1}&choice-item=${param['choice-item']}&items=${requestScope.items}" class="page-link" aria-label="Go to previous page">Previous</a>
                                        </li>
                                    </c:if>
                                    <c:forEach begin="1" end="${requestScope.endP}" var="i">
                                        <li class="page-item ${requestScope.tag == i?"active":""}">
                                            <a href="product-pagination?index=${i}&choice-item=${param['choice-item']}&items=${requestScope.items}" class="page-link">${i}</a>
                                        </li> 
                                    </c:forEach>
                                    <c:if test="${requestScope.tag < requestScope.endP}">
                                        <li class="page-item">
                                            <a href="product-pagination?index=${requestScope.tag+1}&choice-item=${param['choice-item']}&items=${requestScope.items}" class="page-link" aria-label="Go to next page">Next</a>
                                        </li>
                                    </c:if>
                                </c:otherwise>
                            </c:choose>
                        </ul>
                    </div>
                </div>

            </div>
        </div>

        <%@include file="includes/scroll.jsp" %>

        <%@include file="includes/foot.jsp" %>

        <%@include file="includes/footer.jsp" %>
    </body>
</html>
