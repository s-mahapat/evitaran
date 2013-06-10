<%@page isErrorPage="true" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <jsp:include page="../templates/style.jsp"></jsp:include>
        <title>Journal Distribution System</title>
        <script type="text/javascript">
            $(document).ready(function(){
                var continueurl = window.location;
                $("#logout").attr('href', 'main?action=logout&continue=' + continueurl);
            });

        </script>
    </head>
    <body>
        <%@include file="../templates/layout.jsp" %>
        <div id="bodyContainer">
            <div class="MainDiv">
                <fieldset class="MainFieldset">
                    <fieldset class="subMainFieldSet">
                        <div id="accessdenied">&nbsp;</div>
                        <div id="accessdeniedtext">
                            <p>
                                You do not have access to this page. Please <b><a href="" id="logout">log in</a></b> as an administrator.
                            </p>
                        </div>

                    </fieldset>
                </fieldset>
            </div>


        </div>
    </body>
</html>