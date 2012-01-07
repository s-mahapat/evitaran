<%@page isErrorPage="true" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Exception _exception = (Exception)request.getAttribute("exception");
%>
<!DOCTYPE html>
<html>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <jsp:include page="../templates/style.jsp"></jsp:include>
            <title>Journal Distribution System</title>
        </head>
        <body>
        <%@include file="../templates/layout.jsp" %>
        <div id="bodyContainer">
            <div class="MainDiv">
                <fieldset class="MainFieldset">
                    <fieldset class="subMainFieldSet">


                        <table id="datatable">
                            <tr>
                                <td>Exception Class</td>
                                <td>
                                    <%
                                        if (_exception != null) {
                                            out.println(_exception.getClass());
                                        }
                                    %>
                                </td>
                            </tr>
                            <tr>
                                <td>Exception Message</td>
                                <td>
                                    <%
                                        if (_exception != null) {
                                            out.println(_exception.getMessage());
                                        }
                                    %>
                                </td>
                            </tr>
                            <tr>
                                <td>Exception stack trace</td>
                                <td>
                                    <%
                                        if (_exception != null) {
                                            _exception.printStackTrace(response.getWriter());
                                        }
                                    %>
                                </td>
                            </tr>
                        </table>
                    </fieldset>
                </fieldset>
            </div>


        </div>
    </body>
</html>
