<%-- 
    Document   : sentReminders
    Created on : Nov 15, 2011, 8:48:40 AM
    Author     : aloko
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="../templates/style.jsp" %>
        <title>Show Sent Reminders</title>
    </head>
        
    <body>

        <%@include file="../templates/layout.jsp" %>
        <div id="bodyContainer">
            <form method="post" action="<%=request.getContextPath() + "/reminders?action=searchSentReminders"%>" name="search">
                <div class="MainDiv">
                    <fieldset class="MainFieldset">
                        <legend>Show Sent Reminders</legend>
                    </fieldset>
                    <fieldset class="subMainFieldSet">
                            <legend>Show Sent Reminders Based on Type of Reminder</legend>
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
                                    <tr>
                                        <td> <input class="IASRadioButton" TABINDEX="4" type="radio" name="selectTypeOfReminder"/> </td>
                                        <td>Select All</td>
                                    </tr>
                                </tbody>
                            </table>
                    </fieldset>
                    
                    <%--Actions--%>
                    <fieldset class="subMainFieldSet">
                        <div class="IASFormFieldDiv">
                            <div id="okBtnDiv">
                                <input class="IASButton" TABINDEX="5" type="submit" value="Search" name="btnSubmit"/>
                            </div>
                        </div>
                    </fieldset>
                </div>
            </form>
        </div>
        

    </body>
</html>
