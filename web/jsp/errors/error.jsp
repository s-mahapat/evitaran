<%--
    Document   : error
    Created on : Dec 11, 2011, 8:57:02 AM
    Author     : Shailendra Mahapatra
--%>
<%@page import="java.io.PrintWriter" %>
<%@page import="java.io.ByteArrayOutputStream"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <jsp:include page="../templates/style.jsp"></jsp:include>
       <title>Journal Distribution System - Error</title>
    </head>
    <body>
        <%@include file="../templates/layout.jsp" %>
        <div id="bodyContainer">

        <%
            try {
                // Analyze the servlet exception

                Integer statusCode = (Integer) request.getAttribute("javax.servlet.error.status_code");

                String exceptionType = (String) request.getAttribute("javax.servlet.error.exception_type");

                String errorMsg = (String) request.getAttribute("javax.servlet.error.message");

                String requestUri = (String) request.getAttribute("javax.servlet.error.request_uri");
                if (requestUri == null) {
                    requestUri = "Unknown";
                }

                Throwable throwable = (Throwable) request.getAttribute("javax.servlet.error.exception");

                String servletName = (String) request.getAttribute("javax.servlet.error.servlet_name");
                if (servletName == null) {
                    servletName = "Unknown";
                }


                out.println("Kindly report the following messages to "
                        + "<A HREF=\"mailto:deepaligokhale7@gmail.com\">Deepali Gokhale</A>"
                        + "<br></br>");
                out.println("Click on the link to goto <a href=\""
                        + response.encodeURL("http://localhost:8080/JDS/jsp/home")
                        + "\">Home Page</a>."
                        + "<br></br>");

                out.println("<h2>Error information</h2>");
                out.println("Current Date and Time: " + new java.util.Date(System.currentTimeMillis()) + "<br></br>");
                out.println("The status code : " + statusCode + "<br></br>");
                out.println("Exception type : " + exceptionType + "<br></br>");
                out.println("Error Message : " + errorMsg + "<br></br>");
                out.println("Servlet Name : " + servletName + "</br></br>");
                out.println("The request URI: " + requestUri + "<br><br>");
                //out.println("Exception Type : " + throwable.getClass( ).getName( ) + "</br></br>");
                //out.println("The exception message: " + throwable.getMessage( ) + "<br></br>");
                out.println("Remote address: " + request.getRemoteAddr() + "tried to load http://" + request.getServerName() + request.getRequestURI() + "</br></br>");
                out.println("User agent = " + request.getHeader("User-Agent") + "</br></br>");

                Object JDSexception = request.getAttribute("javax.servlet.error.exception");
                // if we have the exception dump it out to the page
                if (JDSexception != null) {
                    ByteArrayOutputStream bos = null;
                    try {
                        out.println("<p><hr noshade><p><pre>");
                        bos = new ByteArrayOutputStream();
                        PrintWriter writer = new PrintWriter(bos, true);
                        ((Exception) exception).printStackTrace(writer);
                        out.println(bos.toString());
                    } finally {
                        out.println("</pre>");
                        if (bos != null) {
                            bos.close();
                        }
                    }
                }
            } finally {
                out.close();
            }
        %>
        </div>
    </body>
</html>
