<%--
    Document   : Edit Country
    Author     : Deepali
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <jsp:include page="../templates/style.jsp"></jsp:include>
        <link rel="stylesheet" type="text/css" href="css/masterdata/country.css"/>
        <title>Edit Country</title>
        <script type="text/javascript" src="js/masterdata/editCountry.js"></script>
        <script type="text/javascript" src="js/masterdata/validateCountry.js"></script>
        <script>
            $(document).ready(function() {
                makeEditReadOnly();
            });
        </script>
    </head>
    <body>

        <%@include file="../templates/layout.jsp" %>
        <div id="bodyContainer">
            <form method="post" action="<%=request.getContextPath() + "/country"%>" name="countryForm" onsubmit="return validateCountry()">
                <div class="MainDiv">
                    <fieldset class="MainFieldset">
                        <legend>Edit Country</legend>
                        <%@include file="country.jsp"%>
                        </fieldset>
                </div>
            </form>
        </div>
    </body>
</html>