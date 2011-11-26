<%--
    Document   : index
    Created on : Oct 9, 2011, 8:49:53 PM
    Author     : Kulu
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    if (request.getRemoteUser() != null) {
        response.sendRedirect(request.getContextPath() + "/jsp/home.jsp");
    }
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <%@include file="../templates/style.jsp"%>
        <title>Login</title>
        <script type="text/javascript" src="js/login.js"></script>
        <script>
            $(function() {
                $( "#loginDiv" ).tabs();
            });
        </script>
        <style>

            body{
                margin:0px;
                padding:0px;
                background-color: rgb(255, 237, 202);
                font-family: "Cambria",serif;
                font-size: 12px;
                /*width: 100%;*/
            }

            #header{

                width: 100%;
                position: fixed;
                top: 0px;
                height: auto;
                background-color: rgb(255, 237, 202);
            }
            #darksubheader{
                background-color: #cc9b00;
                height: 40px;
                margin-bottom: 1px;
                width: 100%;
            }

            #smalldarksubheader{
                background-color: #cc9b00;
                height: 26px;
                margin-left: 0px;
                margin-bottom: 1px;
                width: 12%;
                float: left;
            }

            #whitesubheader{
                background-color: white;
                height: 1px;
                width: 100%;
            }

            #lightsubheader{
                background-color: #FBDA81;
                height: 26px;
                width: 100%;
                margin-bottom: 1px;
            }

            #headertext{
                float: right;
                font-family:inherit;
                font-size: x-large;
                font-weight: bolder;
                color: #333333;
                margin-right: 10px;
                padding: 5px;
            }

            #sidebar{
                background-color: #cc9b00;
                top:68px;
                width: 12%; /*110*/
                float: left;
                position: fixed;
                height: 100%;
                padding-top: 60px;
                z-index: 2;
            }


            #loginDiv{
                margin: 15% auto;
                width: 40%;
                text-align: center;
                height: 200px;
            }

            #loginErrorMsg{

                margin-bottom: 20px;
                margin-top: 10px;
                text-align: center;
                color: red;
            }

            #resetpwdDiv{

                margin: 10% 10%;
            }

            .authField{

                width: 100%;
                margin: 10px auto;
                float: left;
            }

            .authLabel{
                width: 25%;
                float: left;
                margin-left: 10%;
                text-align: right;
            }

            .authInput{
                float: right;
                width: 50%;
                margin-right: 10%;
            }

            .authAction{

                margin-left: 45%;
                margin-top: 10px;
                float: left;
            }

            /*.IASButton{
               /* height: 20px;
                margin: 0px 20px;
                font-weight: bold;
                font-size: 12px;
            }*/


        </style>
    </head>
    <body onload="init()">
        <jsp:include page="../templates/header.jsp"></jsp:include>
        <jsp:include page="../templates/loginsidebar.jsp"></jsp:include>
            <div id="bodyContainer">
            <%--<form action="j_security_check" method="post" name="frmlogin" onsubmit="return validate('loginId','password')">--%>
            <form action="<%=request.getContextPath() + "/home"%>" method="post" name="frmlogin">
                <div id="loginDiv">
                    <ul>
                        <li><a href="#login">Login</a></li>
                        <li><a href="#resetpwd">Forgot Password</a></li>
                    </ul>
                    <div id="login">
                        <div class="authField">
                            <span class="authLabel">User Name</span>
                            <span class="authInput"><input type="text" style="width:160px" class="IASTextBox" name="j_user" id="loginFieldId"/></span>
                        </div>
                        <div class="authField">
                            <span class="authLabel">Password</span>
                            <span class="authInput"><input type="password" maxlength="16" style="width:160px" class="IASTextBox" name="j_pass" id="passwordField"/></span>
                        </div>
                        <div class="authAction">
                            <input type="submit" value="Login"/>
                            <input type="reset" value="Reset"/>
                        </div>
                    </div>
                    <div id="resetpwd">

                    </div>

                </div>
            </form>
        </div>
    </body>
</html>
