<%-- 
    Document   : searchedReminders
    Created on : Nov 20, 2011, 4:37:20 PM
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
            <form method="post" action="<%=request.getContextPath() + "/reminders?action=commitSendReminders"%>" name="search">
                <div class="MainDiv">
                    <fieldset class="MainFieldset">
                        <legend>Send Reminders</legend>
                    </fieldset>
                    <fieldset class="subMainFieldSet">
                            <legend>Search subscribers who need to renew</legend>
                            <table class="datatable">
                                <thead>
                                    <tr>
                                       <td>Subscriber ID</td>
                                       <td>Subscriber Name</td>
                                       <td>Send Reminder</td>
                                       <td>Mode of Reminder</td>
                                    </tr>
                                </thead> 
                                <tbody>
                                    <tr>
                                        <td>100</td>
                                        <td>Alok Modak</td>
                                        <td><input class="IASCheckBox" TABINDEX="1" type="checkbox" name="sendReminderSelected" id="sendReminderSelected" /></td>
                                        <td>
                                            <input class="IASRadioButton" TABINDEX="2" type="radio" name="sendViaEmail" id="sendViaEmail"/>Email   
                                            <input class="IASRadioButton" TABINDEX="3" type="radio" name="sendViaEmail" id="sendViaPrint"/>Print
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>200</td>
                                        <td>Deepali Gokhale</td>
                                        <td><input class="IASCheckBox" TABINDEX="4" type="checkbox" name="sendReminderSelected" id="sendReminderSelected" /></td>
                                        <td>
                                            <input class="IASRadioButton" TABINDEX="5" type="radio" name="sendViaEmail" id="sendViaEmail"/>Email   
                                            <input class="IASRadioButton" TABINDEX="6" type="radio" name="sendViaEmail" id="sendViaPrint"/>Print
                                        </td>
                                    </tr>                                    
                                </tbody>
                            </table>
                    </fieldset>
                    
                    <%--Actions--%>
                    <fieldset class="subMainFieldSet">
                        <div class="IASFormFieldDiv">
                            <div id="okBtnDiv">
                                <input class="IASButton" TABINDEX="7" type="submit" value="Send Reminder" name="btnSubmit"/>
                            </div>
                        </div>
                    </fieldset>
                    
                </div>
            </form>
         </div>        
    </body>
</html>
