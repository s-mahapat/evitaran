<%--
    Document   : Create Journal
    Author     : Deepali
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <jsp:include page="../templates/style.jsp"></jsp:include>
        <link rel="stylesheet" type="text/css" href="css/masterdata/journal.css"/>
        <title>Create Journal</title>
        <script type="text/javascript" src="js/masterdata/addJournal.js"></script>
        <script type="text/javascript" src="js/masterdata/validateJournal.js"></script>
        <script>
            $(document).ready(function(){
                makeCreateReadOnly();
            });
        </script>
    </head>
    <body>

        <%@include file="../templates/layout.jsp" %>
        <div id="bodyContainer">
            <form method="post" action="<%=request.getContextPath() + "/journal"%>" name="journalForm" onsubmit="return validateJournal()">
                <div class="MainDiv">
                    <fieldset class="MainFieldset">
                        <legend>Add Journal</legend>
                        <%@include file="journal.jsp"%>
                        </fieldset>
                </div>
            </form>
        </div>
    </body>
</html>