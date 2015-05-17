<%--
    Document   : tasks
    Created on : Dec 23, 2011, 12:47:54 PM
    Author     : aloko
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Pending Tasks</title>
    </head>
    <body>
        <h1>Pending Tasks</h1>
        <ol>
            <li>EMail: POP3 settings</li>
            <li>EMail: Communicating failure of sending message to user</li>
            <li>EMail: Will this utility work if there is a proxy server</li>
            <li>Report: Insert search criteria</li>
        </ol>
        <h1>Completed Tasks</h1>
        <ol>
            <li>Report: Create the jsp</li>
            <li>Report: Create the servlet which will respond to the jqgrid response</li>
            <li>EMail: Check if comma separated list is accepted</li>
            <li>EMail: Check if space separated list is accepted</li>
            <li>Editor: Remove features from the editor which are not required</li>
            <li>EMail: Performance for sending 1 email: ~ 5sec</li>
            <li>EMail: What if one of the emailID among the list is wrong?- No way to know. <br>
                The message will be sent to the SMTP server. The SMTP server will forward <br>
                the email to the destination. When the destination rejects, it comes back <br>
                to the inbox. The only way to check if an emailID is invalid is to check the inbox
            </li>
            <li>EMail: Attachments</li>
            <li>EMail: Config file/ Screen for accepting email setting parameters</li>
        </ol>
    </body>
</html>
