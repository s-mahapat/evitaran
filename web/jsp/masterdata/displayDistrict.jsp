<%--
    Document   : Display District
    Author     : Deepali
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <jsp:include page="../templates/style.jsp"></jsp:include>
        <link rel="stylesheet" type="text/css" href="css/masterdata/district.css"/>
        <title>Display District</title>
        <script type="text/javascript" src="js/masterdata/displayDistrict.js"></script>
        <script>
            addOnloadEvent(makeReadOnly);
        </script>
    </head>
    <body>

        <%@include file="../templates/layout.jsp" %>
        <div id="bodyContainer">
            <form method="post" action="<%=request.getContextPath() + "/district"%>" name="districtForm">
                <div class="MainDiv">
                    <fieldset class="MainFieldset">
                        <legend>Display District</legend>
                        <%@include file="district.jsp"%>
                        </fieldset>
                </div>
            </form>
        </div>
    </body>
</html>