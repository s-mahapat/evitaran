<%-- 
        Document   : showSentRemindersSearchOutput
    Created on : Nov 20, 2011, 4:39:20 PM
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
            <div class="MainDiv">
                <fieldset class="MainFieldset">
                    <legend>Show Sent Reminders</legend>
                </fieldset>

                <fieldset class="subMainFieldSet">
                <legend>Sent Reminders: Type 1</legend>
                <table class="datatable">
                    <thead>
                        <tr>
                           <td>Subscriber ID</td>
                           <td>Subscriber Name</td>
                           <td>Sent Reminder Date</td>
                           <td>Mode of Reminder</td>
                        </tr>
                    </thead> 
                    <tbody>
                        <tr>
                            <td>100</td>
                            <td>Alok Modak</td>
                            <td>10-Nov-2011</td>
                            <td>Print</td>
                        </tr>
                        <tr>
                            <td>200</td>
                            <td>Deepali Gokhale</td>
                            <td>10-Nov-2011</td>
                            <td>Print</td>
                        </tr>                                    
                    </tbody>
                </table>
            </div>
        </div>
    </body>
</html>
