<%--
    Document   : Add New subscriber type
    Author     : Alok
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <jsp:include page="../templates/style.jsp"></jsp:include>
        <link rel="stylesheet" type="text/css" href="css/masterdata/subType.css"/>
        <title>Add Subscriber Type</title>
        <script type="text/javascript" src="js/masterdata/addSubType.js"></script>
        <script type="text/javascript" src="js/masterdata/validateSubType.js"></script>
        <script>
            addOnloadEvent(makeCreateReadOnly);
        </script>
    </head>
    <body>

        <%@include file="../templates/layout.jsp" %>
        <div id="bodyContainer">
            <form method="post" action="<%=request.getContextPath() + "/subType"%>" name="subTypeForm" onsubmit="return validateSubType()">
                <div class="MainDiv">
                    <fieldset class="MainFieldset">
                        <legend>Add Subscriber Type</legend>
                        <%@include file="subType.jsp"%>
                        </fieldset>
                </div>
            </form>
        </div>
    </body>
</html>
