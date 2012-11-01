<%--
    Document   : resetpwd
    Created on : Oct 21, 2011, 11:25:24 PM
    Author     : Shailendra Mahapatra
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
         <jsp:include page="templates/style.jsp"></jsp:include>
         <script type="text/javascript" src="js/login.js"></script>
        <title>Reset Password</title>
    </head>
    <body>
        <form name="formResetPassword" method="post" action="" onsubmit="return validateEmail('loginId')">
            <div id="resetpwdDiv">
                Email Id:<input TABINDEX="1" size="25" type="textbox" value="" name="loginId" id="loginId"/>
                <input type="submit" value="Reset Password"/>
                <div id="loginErrorMsg">&nbsp;</div>
                <label>You will receive an email with the new password at the above email address. Please enter a correct and valid email address</label>
            </div>
        </form>
    </body>
</html>
