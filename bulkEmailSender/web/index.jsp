<%--
    Document   : index
    Created on : Dec 19, 2011, 12:58:47 PM
    Author     : aloko
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title class="ui-dialog ui-dialog-content ui-dialog-title">Bulk EMail Sender</title>

        <script src="js/jquery-ui-1.8.16/js/jquery-1.6.2.min.js"  type="text/javascript"></script>
        <script src="js/jquery-ui-1.8.16/js/jquery-ui-1.8.16.custom.min.js"  type="text/javascript"></script>
        <link href="js/jquery-ui-1.8.16/css/ui-lightness/jquery-ui-1.8.16.custom.css" rel="stylesheet" type="text/css" />
        <script src="js/tiny_mce_3.4.7/tiny_mce.js" type="text/javascript"></script>
        <script src="js/common.js" type="text/javascript"></script>

        <script>
        // Script for tab
        $(function() {
            $( "#tabs" ).tabs({
			ajaxOptions: {
				error: function( xhr, status, index, anchor ) {
					$( anchor.hash ).html(
						"Couldn't load this tab. We'll try to fix this as soon as possible. " +
						"If this wouldn't be a demo." );
                    }
                }
            });
        });
        </script>

        <script type="text/javascript" >
        // Script for editor
            tinyMCE.init({
            mode : "textareas",
            //theme : "simple"

            theme : "advanced",

            // Theme options - button# indicated the row# only

            theme_advanced_buttons1 : "newdocument,|,bold,italic,underline,|,justifyleft,justifycenter,justifyright,fontselect,fontsizeselect,formatselect",
            theme_advanced_buttons2 : "cut,copy,paste,|,bullist,numlist,|,outdent,indent,|,undo,redo,|,forecolor,backcolor",
            theme_advanced_buttons3 : "",
            theme_advanced_toolbar_location : "top",
            theme_advanced_toolbar_align : "left",
            theme_advanced_resizing : false

        });
        </script>

        <script>
        // Script for button
        $("#sendEmailButton").click(function(){
            $("#sendEmailButton").attr('value', 'Send New Email');
            alert("hmm");
         });
        </script>

        <script>
            addOnLoadEvent(makeReadOnly);
        </script>

    </head>
    <body>
        <h1>Bulk EMail Sender!</h1>
        <div id="tabs">
            <ul>
                <li><a href="#tabs-1">Compose Message</a></li>
                <li><a href="reports.jsp">Reports</a></li>
                <li><a href="tasks.jsp">Pending Tasks</a></li>
                <li><a href="testing.jsp">Testing</a></li>
            </ul>
            <div id="tabs-1">
                <form method="post" action="sendEMail">
                <%--<form method="post">--%>

                    <p> EMail ID: <input type="text" id="emailid" name="emailid" size="35"/></p>
                    <p> Subject: <input type="text" id="subject" name="subject" size="35"/></p>

                    <textarea name="content" id="content" style="width:100%"></textarea>

                    <br>

                    <%--<button class="ui-button ui-button-text-only ui-widget ui-state-default ui-corner-all">
                        <span class="ui-button-text">Send EMail</span>
                    </button>
                    --%>

                    <input type="submit" value="Send EMail" id="sendEmailButton" name ="sendEmailButton" onclick="changeState()"/>

                </form>
            </div>
        </div>
    </body>
</html>
