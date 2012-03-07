<%--
    Document   : Display State
    Author     : Deepali
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <jsp:include page="../templates/style.jsp"></jsp:include>
        <link rel="stylesheet" type="text/css" href="css/masterdata/state.css"/>
        <title>Display State</title>
        <script type="text/javascript" src="js/masterdata/displayState.js"></script>
        <script>
            $(document).ready(function() {
                makeReadOnly();
                makeStateReadOnly();
            });
        </script>
    </head>
    <body>

        <%@include file="../templates/layout.jsp" %>
        <div id="bodyContainer">
            <form method="post" action="<%=request.getContextPath() + "/state"%>" name="stateForm">
                <div class="MainDiv">
                    <fieldset class="MainFieldset">
                        <legend>Display State</legend>
                        <%@include file="state.jsp"%>
                        </fieldset>
                </div>
            </form>
        </div>
    </body>
</html>