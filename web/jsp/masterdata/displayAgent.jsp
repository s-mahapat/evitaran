<%--
    Document   : Display Agent
    Author     : Deepali
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <jsp:include page="../templates/style.jsp"></jsp:include>
        <link rel="stylesheet" type="text/css" href="css/masterdata/agent.css"/>
        <title>Display Agent</title>
        <script type="text/javascript" src="js/masterdata/displayAgent.js"></script>
        <script>
            $(document).ready(function() {
                makeReadOnly();
                makeAgentReadOnly();
            });
        </script>
    </head>
    <body>

        <%@include file="../templates/layout.jsp" %>
        <div id="bodyContainer">
            <form method="post" action="<%=request.getContextPath() + "/agent"%>" name="agentForm">
                <div class="MainDiv">
                    <fieldset class="MainFieldset">
                        <legend>Display Agent</legend>
                        <%@include file="agent.jsp"%>
                        </fieldset>
                </div>
            </form>
        </div>
    </body>
</html>