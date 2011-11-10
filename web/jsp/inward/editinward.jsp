<%--
    Document   : Create Inward
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <jsp:include page="../templates/style.jsp"></jsp:include>
        <link rel="stylesheet" type="text/css" href="../css/inward.css" />

        <title>Edit Inward</title>

        <%--------------------------------------------------------------%>
        <%-- Calendar --%>
        <%--------------------------------------------------------------%>
        <script src="../js/CalendarPopup.js" type="text/javascript"></script>
        <script type="text/javascript">
            var calFrom = new CalendarPopup("dateDiv");
            calFrom.showNavigationDropdowns();
        </script>

    </head>
    <body>

        <%@include file="../templates/layout.jsp" %>
        <div id="bodyContainer">
            <form method="post" action="" name="inwardForm">
                <div class="MainDiv">
                    <fieldset class="MainFieldset">
                        <legend>Edit Inward</legend>
                        <%@include file="inward.jsp"%>
                        </fieldset>
                </div>
            </form>
        </div>
    </body>
</html>