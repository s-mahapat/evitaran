<%@page isErrorPage="true"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
                        <table class="datatable">
                            <%
                                if (exception != null) {
                                    out.println("<tr><td>Exception Class</td><td>");
                                    out.println(exception.getClass());
                                    out.println("</tr></td>");

                                    out.println("<tr><td>Exception Message</td><td>");
                                    out.println(exception.getMessage());
                                    out.println("</tr></td>");
                                    out.flush();
                                }

                            %>
                        </table>
                        <p>
                            <b>Exception Stack Trace</b>
                        </p>
                        <p>
                            <%
                                if (exception != null) {
                                    StackTraceElement elements[] = exception.getStackTrace();
                                    for (int i = 0, n = elements.length; i < n; i++) {

                                        out.println("<p>");
                                        out.println("Class: " + elements[i].getClassName() + "<br>");
                                        out.println("Method Name: " + elements[i].getMethodName() + "<br>");
                                        out.println("Line Number: " + elements[i].getLineNumber() + "<br>");
                                        out.println("File Name: " + elements[i].getFileName() + "<br>");
                                        out.println("</p>");
                                    }
                                    //exception.printStackTrace(response.getWriter());

                                }
                            %>
                        </p>

                    </fieldset>
                </fieldset>
            </div>
        </div>
    </body>
</html>