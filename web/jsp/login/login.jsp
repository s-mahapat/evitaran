<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <%--@include file="../templates/style.jsp"--%>
        <%@include file="../templates/jquery.jsp" %>
        <script type="text/javascript" src="<%=request.getContextPath() + "/js/login.js"%>"></script>
        <title>Login</title>
        <script type="text/javascript">
            $(function() {
                $( "#loginDiv" ).tabs();
            });
        </script>
        <link href="<%=request.getContextPath() + "/css/style.css"%>" type="text/css" rel="stylesheet"/>
        <style>
            #bodyContainer{
                margin-left: auto;
                margin-right: auto;
                margin-top: -140px;
                position: absolute;
                top: 50%;
                width: 100%;
                left: 0;
                font-size: small;
                text-align: center;
            }


            #loginDiv{
                margin-left: auto;
                margin-right: auto;
                width: 50%;
                text-align: center;
                height: 280px;
            }

            #loginErrorMsg{

                text-align: center;
                color: red;
            }

            #resetpwdDiv{

                margin: 10% 10%;
            }

            .authField{

                width: 100%;
                margin: 20px auto;
                float: left;
                display: inline-table;
            }

            .authLabel{
                width: 25%;
                float: left;
                margin-left: 0%;
                margin-right: 0px;
                text-align: right;
                padding: 6px;
            }

            .authInput{
                float: left;
                width: 40%;
                margin-left: 20px;
            }

            .login{
                font-size: larger;
                padding: 6px;
                height: 25px;
            }

            .authAction{

                margin-left: 42%;
                margin-top: 20px;
                float: left;
            }

        </style>
    </head>
    <body>
        <jsp:include page="../templates/header.jsp"></jsp:include>
        <%--<jsp:include page="../templates/loginsidebar.jsp"></jsp:include>--%>
        <div id="bodyContainer">
            <form action="<%=request.getContextPath() + "/j_security_check"%>" method="post" name="frmlogin" onsubmit="return validate('loginFieldId','passwordField')">
                <div id="loginDiv">
                    <ul>
                        <li><a href="#login">Login</a></li>
                        <li><a href="#resetpwd">Forgot Password</a></li>
                    </ul>
                    <div id="login">
                        <div class="authField">
                            <span class="authLabel">User Name</span>
                            <span class="authInput"><input type="text" style="width:250px" class="IASTextBoxMandatory login" name="j_username" value="" id="loginFieldId" placeholder="Email" onblur="validateEmail(this.id)"/></span>
                        </div>
                        <div class="authField">
                            <span class="authLabel">Password</span>
                            <span class="authInput"><input type="password" maxlength="16" style="width:250px" class="IASTextBoxMandatory login" value="" name="j_password" placeholder="Password" id="passwordField"/></span>
                        </div>
                        <div class="authAction">
                            <input type="submit" value="Login"/>
                            <input type="reset" value="Reset"/>
                        </div>

                    </div>

                    <div id="resetpwd">
                        <div class="authField">
                            <span class="authLabel">Email ID:</span>
                            <span class="authInput"><input type="text" style="width:250px" class="IASTextBoxMandatoryWide" name="userEmail" id="userEmail"/></span>
                        </div>
                        <div class="authAction">
                            <input id="resetpwdbtn" type="button" value="Reset Password" onclick="ResetPassword()"/>
                        </div>
                    </div>

                </div>
                <div id="loginErrorMsg"></div>

            </form>
        </div>
    </body>
</html>
