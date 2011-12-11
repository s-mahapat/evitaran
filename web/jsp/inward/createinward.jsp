<%--
    Document   : Create Inward
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="en-US" xml:lang="en-US">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <jsp:include page="../templates/style.jsp"></jsp:include>
        <link rel="stylesheet" type="text/css" href="css/inward/inward.css"/>
        <title>Create Inward</title>
        <script type="text/javascript" src="js/inward/createinward.js"></script>

        <script>
            addOnloadEvent(makeReadOnly);
            var myArr = new Array;

            $(document).ready(function() {
                jdsAutoComplete("/JDS/CMasterData?md=city","city","city");
                jdsAutoComplete("/JDS/CMasterData?md=country","country","country");
                jdsAutoComplete("/JDS/CMasterData?md=state","state","state");
            });



        </script>
    </head>
    <body>

        <%@include file="../templates/layout.jsp" %>
        <div id="bodyContainer">
            <form method="post" action="<%=request.getContextPath() + "/inward"%>" name="inwardForm" onsubmit="return validateNewInward()">
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