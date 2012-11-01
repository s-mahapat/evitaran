<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <jsp:include page="../templates/style.jsp"></jsp:include>
        <title>Change Password</title>
        
        <script type="text/javascript" src="js/login.js"></script>

        <script type="text/javascript">
            $(function() {
                $( "#changepwd" ).tabs();
            });
        </script>

        <style>
            #bodyContainer{
                margin-top: 68px;
                width: 100%;
                overflow: auto;
                float: left;
            }


            #changepwd{
                margin: 10% auto 0 auto;
                width: 40%;
                text-align: center;
                height: 250px;
            }
            
            #loginErrorMsg{

                text-align: center;
                color: red;
            }

            .authField{
                width: 100%;
                margin: 10px auto;
                float: left;
            }

            .authLabel{
                width: 35%;
                float: left;
                margin-left: 1%;
                text-align: right;
            }

            .authInput{
                float: left;
                width: 50%;
                margin-right: 5px;
                margin-left: 10px;
                text-align: left;
            }

            .authAction{

                margin-left: 42%;
                margin-top: 20px;
                float: left;
            }
        </style>
    </head>
    <body>
        <div id="bodyContainer">
            <form name="changepwd" action="usermgr/changepwd" method="post" onsubmit="return validateChangePassword()">
                <div id="changepwd">
                    <ul>
                        <li><a href="#changepwdform">Change Password</a></li>
                    </ul>
                    <div id="changepwdform">
                        <div class="authField">
                            <span class="authLabel">User Name</span>
                            <span class="authInput"><input type="text" class="IASTextBoxMandatoryWide" name="email" value="" id="loginFieldId"/></span>
                        </div>
                        <div class="authField">
                            <span class="authLabel">New Password</span>
                            <span class="authInput"><input type="password" maxlength="16" class="IASTextBoxMandatoryWide" value="" name="passwordField" id="passwordField"/></span>
                        </div>
                        <div class="authField">
                            <span class="authLabel">Retype new Password</span>
                            <span class="authInput"><input type="password" maxlength="16" class="IASTextBoxMandatoryWide" value="" name="renterPasswordField" id="renterPasswordField"/></span>
                        </div>
                        <div class="authAction">
                            <input type="submit" value="Change"/>
                            <input type="reset" value="Reset"/>
                        </div>

                    </div>
                </div>
                <div id="loginErrorMsg"></div>
            </form>
        </div>

    </body>
</html>
