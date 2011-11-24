<%-- 
    Document   : sendReminders.jsp
    Created on : Nov 15, 2011, 8:24:51 AM
    Author     : aloko
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="../templates/style.jsp" %>
        <title>Send Reminders</title>
    </head>
    <body>
        <%@include file="../templates/layout.jsp" %>
        
        <div id="bodyContainer">
            <form method="post" action="<%=request.getContextPath() + "/reminders?action=search"%>" name="search">
                <div class="MainDiv">
                    <fieldset class="MainFieldset">
                        <legend>Send Reminders</legend>
                    </fieldset>
                    <fieldset class="subMainFieldSet">
                            <legend>Search subscribers who need to renew</legend>
                            <table class="datatable">
                                <thead>
                                    <tr>
                                        <td>Select</td>
                                       <td>Type of Reminder</td>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td> <input class="IASRadioButton" TABINDEX="1" type="radio" name="selectTypeOfReminder"/> </td>
                                        <td>Type 1 Reminder</td>
                                    </tr>
                                    <tr>
                                        <td> <input class="IASRadioButton" TABINDEX="2" type="radio" name="selectTypeOfReminder"/> </td>
                                        <td>Type 2 Reminder</td>
                                    </tr>
                                    <tr>
                                        <td> <input class="IASRadioButton" TABINDEX="3" type="radio" name="selectTypeOfReminder"/> </td>
                                        <td>Type 3 Reminder</td>
                                    </tr>
                                </tbody>
                            </table>
                    </fieldset>
                    
                    <%--Actions--%>
                    <fieldset class="subMainFieldSet">
                        <div class="IASFormFieldDiv">
                            <div id="okBtnDiv">
                                <input class="IASButton" TABINDEX="4" type="submit" value="Search" name="btnSubmit"/>
                            </div>
                        </div>
                    </fieldset>
                </div>
            </form>
        </div>
    </body>
</html>
