<%--
    Document   : index
    Created on : Oct 9, 2011, 8:49:53 PM
    Author     : Kulu
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <jsp:include page="../templates/style.jsp"></jsp:include>
    <title>Login</title>
    <script type="text/javascript" src="js/login.js"></script>
    <script type="text/javascript" src="js/popup.js"></script>
    <link rel="stylesheet" type="text/css" href="css/index.css" />
</head>
<body onload="init()">
<jsp:include page="../templates/header.jsp"></jsp:include>
<%--<jsp:include page="../templates/loginsidebar.jsp"></jsp:include>--%>
<div id="bodyContainer">
    <div id="loginDiv" class="MainDiv">
          <fieldset class="subMainFieldSet">
              <legend>Error</legend>
              <label>Invalid username or password. Please try again </label>
              <a href="<%=request.getContextPath() + "/home"%>">login</a>
           </fieldset>
     </div>
</div>
</body>
</html>
