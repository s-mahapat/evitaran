<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
     <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="../templates/style.jsp"%>
        <link rel="stylesheet" type="text/css" href="css/ml.css"/>
        <title>Mailing List</title>
        <script type="text/javascript" src="js/ml.js"></script>
        <script>
            //addOnloadEvent(makeReadOnly);
        </script>
    </head>
    <body>
        <%@include file="../templates/layout.jsp" %>
        <div id="bodyContainer">
            <form method="post" action="<%=request.getContextPath() + "/ml?action=pml"%>" name="mlForm">
                <div class="MainDiv">
                    <fieldset class="MainFieldset">
                        <fieldset class="subMainFieldSet">
                            <table class="datatable">
                                <thead>
                                    <tr>
                                        <td>Subscriber ID</td>
                                        <td>Subscriber Name</td>
                                        <td>Address</td>
                                        <td>Journal Name</td>
                                        <td>Copies</td>
                                    </tr>
                                </thead>
                            </table>
                        </fieldset>
                        <fieldset class="subMainFieldSet">
                            <div class="IASFormFieldDiv">
                                <div class="singleActionBtnDiv">
                                    <input class="IASButton" TABINDEX="1" type="submit" value="Print Mailing List" id="btnPrintML" name="btnPrintML"/>
                                </div>
                            </div>
                        </fieldset>
                    </fieldset>
                </div>
            </form>
        </div>
    </body>
</html>
