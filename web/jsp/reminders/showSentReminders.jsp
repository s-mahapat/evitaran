<%-- 
    Document   : showSentReminders
    Created on : Nov 15, 2011, 8:48:40 AM
    Author     : aloko
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <%-- head defines what appears in the IE tab --%>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="../templates/style.jsp" %>
        <title>Show Sent Reminders</title>
    </head>
    
    <%-- body defines how the actual page will be visible. 
         This page divided into 4 sections using divisions
         header defined in header.jsp. div id is called as "header"
         sidebar defined in sidebar.jsp. div id is called as "sidebar"
         footer defined in footer.jsp. div id is called as "footer".
         All these are included in layout.jsp and are common to all pages.
         How each division appears i.e location, size, color is defined in style.css for each id
         If you want to further specialise the style, then define a class 
    --%>    
    <body>

        <%@include file="../templates/layout.jsp" %>
        
        <div id="bodyContainer">
            <form method="post" action="<%=request.getContextPath() + "/reminders"%>" name="showSentReminders">
                <div class="MainDiv">
                    <fieldset class="MainFieldset">
                        <legend>Show Sent Reminders</legend>
                        
                    </fieldset>
                </div>>
            </form>
        </div>
        <h1>Hello World!</h1>
    </body>
</html>
