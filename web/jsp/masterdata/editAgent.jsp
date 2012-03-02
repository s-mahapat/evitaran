<%--
    Document   : Edit Agent
    Author     : Deepali
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <jsp:include page="../templates/style.jsp"></jsp:include>
        <link rel="stylesheet" type="text/css" href="css/masterdata/agent.css"/>
        <title>Edit Agent</title>
        <script type="text/javascript" src="js/masterdata/editAgent.js"></script>
        <script type="text/javascript" src="js/masterdata/validateSubType.js"></script>
        <script>
            addOnloadEvent(makeEditReadOnly);
        </script>
    </head>
    <body>

        <%@include file="../templates/layout.jsp" %>
        <div id="bodyContainer">
            <form method="post" action="<%=request.getContextPath() + "/agent"%>" name="agentForm" onsubmit="return validateAgent()">
                <div class="MainDiv">
                    <fieldset class="MainFieldset">
                        <legend>Edit Agent</legend>
                        <%@include file="agent.jsp"%>
                        </fieldset>
                </div>
            </form>
        </div>
    </body>
</html>