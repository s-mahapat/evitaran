<%-- 
    Document   : commitSendReminders
    Created on : Nov 24, 2011, 7:25:34 AM
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
                <div class="MainDiv">
                    <fieldset class="MainFieldset">
                        <legend>Send Reminders</legend>
                    </fieldset>
                    <fieldset class="subMainFieldSet">
                            <legend>Sent Reminders to the following</legend>
                            <table class="datatable">
                                <thead>
                                    <tr>
                                       <td>Subscriber ID</td>
                                       <td>Subscriber Name</td>
                                       <td>Mode of Reminder</td>
                                    </tr>
                                </thead> 
                                <tbody>
                                    <tr>
                                        <td>100</td>
                                        <td>Alok Modak</td>
                                        <td>E-Mail</td>
                                    </tr>
                                    <tr>
                                        <td>200</td>
                                        <td>Deepali Gokhale</td>
                                        <td>Print</td>
                                    </tr>                                    
                                </tbody>
                            </table>
                    </fieldset>
                </div>
         </div>        
    </body>
</html>
