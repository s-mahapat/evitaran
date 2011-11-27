<%--
    Document   : View Subscription
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <jsp:include page="../templates/style.jsp"></jsp:include>
        <link rel="stylesheet" type="text/css" href="<%=request.getContextPath() + "/css/subscription.css"%>"/>
        <title>Edit Subscription</title>
        <script type="text/javascript" src="js/common.js"></script>
        <script type="text/javascript" src="<%=request.getContextPath() + "/js/subscription/editsubscription.js"%>"></script>
        <script type="text/javascript" src="<%=request.getContextPath() + "/js/subscription/subscription.js"%>"></script>
        <script>
            addOnloadEvent(makeAddNewSubscriptionReadOnly);
            addOnloadEvent(function(){listSubscription("View")});
        </script>
    </head>
    <body>
        <%@include file="../templates/layout.jsp" %>
        <div id="bodyContainer">
            <form method="post" action="<%=request.getContextPath() + "/subscription"%>" name="subscriptionForm">
                <div class="MainDiv">
                    <fieldset class="MainFieldset">
                        <legend>Edit Subscription</legend>
                        <%@include file="subscriptiondetails.jsp"%>
                        <%@include file="selectjournal.jsp"%>
                        <%@include file="subscriptionlist.jsp"%>
                        <%@include file="subscriptionactions.jsp"%>
                    </fieldset>
                </div>
            </form>
        </div>
    </body>
</html>