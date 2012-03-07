<%--
    Document   : Edit Journal Subject Group
    Author     : Deepali
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <jsp:include page="../templates/style.jsp"></jsp:include>
        <link rel="stylesheet" type="text/css" href="css/masterdata/subjectGroup.css"/>
        <title>Edit Journal Subject Group</title>
        <script type="text/javascript" src="js/masterdata/editSubjectGroup.js"></script>
        <script>
            $(document).ready(function() {
                makeEditReadOnly();
            });
        </script>
    </head>
    <body>

        <%@include file="../templates/layout.jsp" %>
        <div id="bodyContainer">
            <form method="post" action="<%=request.getContextPath() + "/subjectGroup"%>" name="subjectGroupForm">
                <div class="MainDiv">
                    <fieldset class="MainFieldset">
                        <legend>Edit Journal Subject Group</legend>
                        <%@include file="journalSubGroup.jsp"%>
                        </fieldset>
                </div>
            </form>
        </div>
    </body>
</html>