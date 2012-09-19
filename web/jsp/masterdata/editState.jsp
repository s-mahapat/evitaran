<%--
    Document   : Edit State
    Author     : Deepali
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <jsp:include page="../templates/style.jsp"></jsp:include>
        <link rel="stylesheet" type="text/css" href="css/masterdata/state.css"/>
        <title>Edit State</title>
        <script type="text/javascript" src="js/masterdata/editState.js"></script>
        <script type="text/javascript" src="js/masterdata/validateState.js"></script>
        <script type="text/javascript" src="js/common.js"></script>
        <script>
            $(document).ready(function() {
                makeEditReadOnly();
            });
        </script>
    </head>
    <body>

        <%@include file="../templates/layout.jsp" %>
        <div id="bodyContainer">
            <form method="post" action="<%=request.getContextPath() + "/state"%>" name="stateForm" onsubmit="return validateState()">
                <div class="MainDiv">
                    <fieldset class="MainFieldset">
                        <legend>Edit State</legend>
                        <%@include file="state.jsp"%>
                        </fieldset>
                </div>
            </form>
        </div>
    </body>
</html>