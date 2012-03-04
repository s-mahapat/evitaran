<%--
    Document   : Display Journal Price Group
    Author     : Deepali
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <jsp:include page="../templates/style.jsp"></jsp:include>
        <link rel="stylesheet" type="text/css" href="css/masterdata/priceGroup.css"/>
        <title>Display Journal Price Group</title>
        <script type="text/javascript" src="js/masterdata/displayPriceGroup.js"></script>
        <script>
            addOnloadEvent(makePriceGroupReadOnly);
        </script>
    </head>
    <body>

        <%@include file="../templates/layout.jsp" %>
        <div id="bodyContainer">
            <form method="post" action="<%=request.getContextPath() + "/priceGroup"%>" name="priceGroupForm">
                <div class="MainDiv">
                    <fieldset class="MainFieldset">
                        <legend>Display Journal Price Group</legend>
                        <%@include file="journalPriceGroup.jsp"%>
                        </fieldset>
                </div>
            </form>
        </div>
    </body>
</html>