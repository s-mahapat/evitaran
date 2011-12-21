<%--
    Document   : Display Country
    Author     : Deepali
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <jsp:include page="../templates/style.jsp"></jsp:include>
        <link rel="stylesheet" type="text/css" href="css/masterdata/country.css"/>
        <title>Display Country</title>
        <script type="text/javascript" src="js/masterdata/displayCountry.js"></script>
        <script>
            addOnloadEvent(makeReadOnly);
        </script>
    </head>
    <body>

        <%@include file="../templates/layout.jsp" %>
        <div id="bodyContainer">
            <form method="post" action="<%=request.getContextPath() + "/country"%>" name="countryForm">
                <div class="MainDiv">
                    <fieldset class="MainFieldset">
                        <legend>Display Country</legend>
                        <%@include file="country.jsp"%>
                        </fieldset>
                </div>
            </form>
        </div>
    </body>
</html>