<%--
    Document   : Edit Subscriber
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <jsp:include page="../templates/style.jsp"></jsp:include>
        <link rel="stylesheet" type="text/css" href="<%=request.getContextPath() + "/css/subscriber.css"%>"/>
        <title>Edit Subscriber</title>
        <script type="text/javascript" src="<%=request.getContextPath() + "/js/subscriber/subscriber.js"%>"></script>
        <script type="text/javascript" src="<%=request.getContextPath() + "/js/subscriber/createsubscriber.js"%>"></script>
        <script type="text/javascript" src="<%=request.getContextPath() + "/js/subscriber/editsubscriber.js"%>"></script>
        <script>
            addOnloadEvent(makeEditSubscriberReadOnly);
            addOnloadEvent(subtypeDescriptionAppend);
            addOnloadEvent(subtypeCodeAppend);
        </script>
        <script>
            $(document).ready(function() {
                jdsAppend("/JDS/CMasterData?md=sub_type","subtype","subtype");
            });
        </script>
    </head>
    <body>

        <%@include file="../templates/layout.jsp" %>
        <div id="bodyContainer">
            <form method="post" action="<%=request.getContextPath() + "/subscriber"%>" name="subscriberForm" onsubmit = "return validateNewSubscriber()">
                <div class="MainDiv">
                    <fieldset class="MainFieldset">
                        <legend>Edit Subscriber</legend>
                        <%@include file="subscriber.jsp"%>
                    </fieldset>
                </div>
            </form>
        </div>
    </body>
</html>