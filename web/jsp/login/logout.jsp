<%--
    Document   : logout
    Created on : Oct 31, 2011, 6:03:48 PM
    Author     : Shailendra Mahapatra
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    session.invalidate();
    response.sendRedirect(request.getContextPath() + "/jsp/home.jsp");
%>


