<%--
    Document   : logout
    Created on : Oct 31, 2011, 6:03:48 PM
    Author     : Shailendra Mahapatra
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String url = request.getParameter("continue") != null ? request.getParameter("continue") : request.getContextPath() + "/jsp/home.jsp";
    session.invalidate();
    response.sendRedirect(url);
%>


