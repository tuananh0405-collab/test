<%-- 
    Document   : vnpay_return
    Created on : Mar 13, 2024, 6:46:07 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.net.URLEncoder" %>
<%@page import="java.nio.charset.StandardCharsets" %>
<%@page import="config.Config" %>

<%@page import="java.util.Iterator" %>
<%@page import="java.util.Collections" %>
<%@page import="java.util.List" %>
<%@page import="java.util.ArrayList" %>
<%@page import="java.util.Enumeration" %>
<%@page import="java.util.Map" %>
<%@page import="java.util.HashMap" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
        <meta name="description" content="">
        <meta name="author" content="">
        <title>KẾT QUẢ THANH TOÁN</title>
        <%@include file="includes/head.jsp" %>
    </head>
    <body>
        <%
    //Begin process return from VNPAY
    Map fields = new HashMap();
    for (Enumeration params = request.getParameterNames(); params.hasMoreElements(); ) {
        String fieldName = URLEncoder.encode((String) params.nextElement(), StandardCharsets.US_ASCII.toString());
        String fieldValue = URLEncoder.encode(request.getParameter(fieldName), StandardCharsets.US_ASCII.toString());
        if ((fieldValue != null) && (fieldValue.length() > 0)) {
            fields.put(fieldName, fieldValue);
        }
    }

    String vnp_SecureHash = request.getParameter("vnp_SecureHash");
    if (fields.containsKey("vnp_SecureHashType")) {
        fields.remove("vnp_SecureHashType");
    }
    if (fields.containsKey("vnp_SecureHash")) {
        fields.remove("vnp_SecureHash");
    }
    String signValue = Config.hashAllFields(fields);

        %>
        <!--Begin display -->
        <div class="container">
            <div class="header clearfix">
                <h3 class="text-muted">KẾT QUẢ THANH TOÁN</h3>
            </div>
            <div class="table-responsive">
                <div class="form-group">
                    <label>Mã giao dịch thanh toán:</label>
                    <label><%=request.getParameter("vnp_TxnRef")%>
                    </label>
                </div>
                <div class="form-group">
                    <label>Số tiền:</label>
                    <label><%=request.getParameter("vnp_Amount")%>
                    </label>
                </div>
                <div class="form-group">
                    <label>Mô tả giao dịch:</label>
                    <label><%=request.getParameter("vnp_OrderInfo")%>
                    </label>
                </div>
                <div class="form-group">
                    <label>Mã lỗi thanh toán:</label>
                    <label><%=request.getParameter("vnp_ResponseCode")%>
                    </label>
                </div>
                <div class="form-group">
                    <label>Mã giao dịch tại CTT VNPAY-QR:</label>
                    <label><%=request.getParameter("vnp_TransactionNo")%>
                    </label>
                </div>
                <div class="form-group">
                    <label>Mã ngân hàng thanh toán:</label>
                    <label><%=request.getParameter("vnp_BankCode")%>
                    </label>
                </div>
                <div class="form-group">
                    <label>Thời gian thanh toán:</label>
                    <label><%=request.getParameter("vnp_PayDate")%>
                    </label>
                </div>
                <div class="form-group">
                    <label>Tình trạng giao dịch:</label>
                    <label>
                        <%
                            boolean paymentSuccess = false;
                            if (signValue.equals(vnp_SecureHash)) {
                                if ("00".equals(request.getParameter("vnp_TransactionStatus"))) {
                                    paymentSuccess = true;
                                    out.print("Thành công");
                                } else {
                                    out.print("Không thành công");
                                }

                            } else {
                                out.print("invalid signature");
                            }
                        %></label>
                </div>
                <button id="registerButton" type="button" class="btn btn-primary">View Orders</button>
            </div>
            <p>
                &nbsp;
            </p>
            <footer class="footer">
                <p>&copy; VNPAY 2020</p>
            </footer>
        </div>
        <%@include file="includes/foot.jsp" %>
    </body>

    <%
    if (paymentSuccess) {
    %>
    <script>
        $(document).ready(function () {
            $.ajax({
                url: "/check-out",
                type: "POST",
                data: {},
                success: function (response) {
                    alert("Ordered successfully!");
                },
                error: function (xhr, status, error) {
                    alert("Có lỗi xảy ra: " + error);
                }
            });
        });

        document.addEventListener("DOMContentLoaded", function () {
            var home = document.getElementById("registerButton");

            home.addEventListener("click", function (event) {
                event.preventDefault();

                window.location = "http://localhost:9999/ShoppingCart/orders.jsp";

            });
        });
    </script>
    <%
        } else {
    %>
    <script type="text/javascript">
        document.addEventListener("DOMContentLoaded", function () {
            var home = document.getElementById("registerButton");

            home.addEventListener("click", function (event) {
                event.preventDefault();

                window.location = "http://localhost:9999/ShoppingCart/orders.jsp";

            });
        });
    </script>
    <%
}
    %>
</html>
