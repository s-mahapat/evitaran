<%--
    Document   : index
    Created on : Oct 9, 2011, 8:49:53 PM
    Author     : Kulu
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    if(request.getRemoteUser() != null){

        response.sendRedirect("home.jsp");
    }
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <%@include file="templates/style.jsp"%>
    <title>Login</title>
    <script type="text/javascript" src="js/login.js"></script>
    <link rel="stylesheet" type="text/css" href="css/index.css" />
</head>
<body onload="init()">
<jsp:include page="/templates/header.jsp"></jsp:include>
<jsp:include page="/templates/loginsidebar.jsp"></jsp:include>
<div id="bodyContainer">
    <form action="j_security_check" method="post" name="frmlogin" onsubmit="return validate('loginId','password')">
            <div id="loginDiv" class="MainDiv">
                <fieldset id="fieldsetLogin" class="subMainFieldSet">
                    <legend>Login</legend>
                    <div id="loginErrorMsg">&nbsp;</div>
                    <table border="0">
                        <tr>
                            <td align="right">Id:</td>
                            <td align="right"><input TABINDEX="1" size="20" type="textbox" value="" name="j_username" id="loginId"></input></td>
                        </tr>
                        <tr>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                        </tr>
                        <tr>
                            <td align="right">Password:</td>
                            <td align="right"><input TABINDEX="2" size="21" type="password" value="" id="password" name="j_password"></input></td>
                        </tr>
                         <tr>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                        </tr>
                        <tr>
                            <td>&nbsp;</td>
                            <td align="center"><input TABINDEX="3" type="submit" value="Login" name="btnSubmit"></input></td>
                        </tr>
                        <tr>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                        </tr>
                        <tr>
                            <td>&nbsp;</td>
                            <td><a href="resetpwd.jsp" onclick="return changePwdDialog('resetpwd.jsp','Reset Password')">Forgot Password</a></td>
                        </tr>
                    </table>

                </fieldset>

            </div>
        </form>
</div>
</body>
</html>
