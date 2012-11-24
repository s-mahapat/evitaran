<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <jsp:include page="../templates/style.jsp"></jsp:include>
        <title>Download Templates</title>

    </head>
    <body>

        <%@include file="../templates/layout.jsp" %>
        <div id="bodyContainer">
            <form>
                <div class="MainDiv">
                    <fieldset class="MainFieldset">
                        <legend>Templates</legend>
                        <fieldset class="subMainFieldSet">
                            <table>
                                <tr>
                                    <td><a class="template" title="click here to download" href="templates?id=1">Agent Upload Excel Template</a></td>
                                </tr>
                            </table>                            
                        </fieldset>
                        <fieldset class="subMainFieldSet">
                            <legend>Migration Template</legend>
                        </fieldset>
                    </fieldset>
                </div>
            </form>
        </div>
    </body>
</html>