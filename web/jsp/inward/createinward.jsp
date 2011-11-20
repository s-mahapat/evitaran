<%--
    Document   : Create Inward
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <jsp:include page="../templates/style.jsp"></jsp:include>
        <link rel="stylesheet" type="text/css" href="css/inward/inward.css"/>
        <title>Create Inward</title>
        <script type="text/javascript" src="js/inward/createinward.js"></script>

        <script>
            addOnloadEvent(makeReadOnly);
        </script>
    </head>
    <body>

        <%@include file="../templates/layout.jsp" %>
        <div id="bodyContainer">
            <form method="post" action="<%=request.getContextPath() + "/inward"%>" name="inwardForm">
                <div class="MainDiv">
                    <fieldset class="MainFieldset">
                        <legend>Create Inward</legend>
                        <%@include file="inward.jsp"%>
                        </fieldset>
                </div>
            </form>
        </div>
   </body>
</html>