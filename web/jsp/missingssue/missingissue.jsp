<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="../templates/style.jsp"%>
        <link rel="stylesheet" type="text/css" href="css/ml.css"/>
        <title>Missing Issue List</title>
    </head>
    <body>

        <%@include file="../templates/layout.jsp" %>
        <div id="bodyContainer">
            <form method="POST" action="<%=request.getContextPath() + "/missingissue?action=view"%>" name="mlForm">
                <div class="MainDiv">
                    <fieldset class="MainFieldset">
                        <legend>Missing Issue List</legend>
                        <fieldset class="subMainFieldSet">

                        </fieldset>

                    </fieldset>
                </div>
            </form>
        </div>
    </body>
</html>
