<%--
    Document   : Edit subscriber type
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <jsp:include page="../templates/style.jsp"></jsp:include>
        <link rel="stylesheet" type="text/css" href="../css/subType.css" />
        <title>Add Subscriber Type</title>
        <script type="text/javascript" src="../js/masterdata/editSubType.js"></script>
        <script>
            addOnloadEvent(makeReadOnly);
        </script>
    </head>
    <body>

        <%@include file="../templates/layout.jsp" %>
        <div id="bodyContainer">
            <form method="post" action="editNewSubtype.jsp" name="editNewSubType">
                <div class="MainDiv">
                    <fieldset class="MainFieldset">
                        <legend>Edit Subscriber Type</legend>
                        <%@include file="subType.jsp"%>
                        </fieldset>
                </div>
            </form>
        </div>
    </body>
</html>