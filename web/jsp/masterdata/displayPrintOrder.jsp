<%--
    Document   : Display Print Order
    Author     : Deepali
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <jsp:include page="../templates/style.jsp"></jsp:include>
        <%--<link rel="stylesheet" type="text/css" href="css/masterdata/printOrder.css"/>--%>
        <title>Add Print Order</title>
        <script type="text/javascript" src="js/masterdata/displayPrintOrder.js"></script>
        <script type="text/javascript" src="js/masterdata/validatePrintOrder.js"></script>
        <script type="text/javascript" src="js/jquery/grid.postext.js"></script>
        <script>
            $(document).ready(function() {
                makePrintOrderReadOnly();
            });
        </script>
    </head>
    <body>

        <%@include file="../templates/layout.jsp" %>
        <div id="bodyContainer">
            <jsp:useBean class="IAS.Bean.masterdata.printOrderFormBean" id="printOrderFormBean" scope="request"></jsp:useBean>
            <form method="post" action="<%=request.getContextPath() + "/printOrder"%>" name="printOrderForm" onsubmit="return validatePrintOrder()">
                <div class="MainDiv">
                    <fieldset class="MainFieldset">
                        <legend>Display Print Order</legend>
                        <%@include file="printOrder.jsp"%>
                    </fieldset>
                </div>
            </form>
        </div>
    </body>
</html>