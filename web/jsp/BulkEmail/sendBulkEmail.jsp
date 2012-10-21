<%--
    Document   : sendBulkEmail
    Created on : Oct 13, 2012, 9:02:12 AM
    Author     : aloko
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <jsp:include page="../templates/style.jsp"></jsp:include>
        <title>Send Bulk Email</title>
        <script src="js/tiny_mce_3.4.7/tiny_mce.js" type="text/javascript"></script>
        <script src="js/tiny_mce_3.4.7/plugins/tabfocus/editor_plugin.js" type="text/javascript"></script>
        <script src="js/BulkEmail/BulkEmail.js" type="text/javascript"></script>

        <script type="text/javascript">
            $(document).ready(function(){
                //makeCreateReadOnly();
            });
        </script>

        <script type="text/javascript" >
            // Script for editor
            tinyMCE.init({
            mode : "exact",
            elements : "content",
            auto_focus : "content",
            plugins : "tabfocus",

            //theme : "simple",
            theme : "advanced",

            // Theme options - button# indicated the row# only

            theme_advanced_buttons1 : "newdocument,|,bold,italic,underline,|,justifyleft,justifycenter,justifyright,fontselect,fontsizeselect,formatselect",
            //theme_advanced_buttons2 : "cut,copy,paste,|,bullist,numlist,|,outdent,indent,|,undo,redo,|,forecolor,backcolor",
            theme_advanced_buttons2 : "cut,copy,paste,|,bullist,numlist,|,outdent,indent,|,undo,redo,|,link,unlink,|,forecolor,backcolor",
            theme_advanced_buttons3 : "",
            theme_advanced_toolbar_location : "top",
            theme_advanced_toolbar_align : "left",
            theme_advanced_resizing : true,

            //tab_focus : ':subject,:btnSendEmail',
            //tabfocus_elements : ":prev,:next"
            tabfocus_elements : ":subject,:btnSendEmail",

            height : "300"
        });
        </script>

    </head>

    <body>

        <%@include file="../templates/layout.jsp" %>
        <div id="bodyContainer">
            <form method="post" action="" name="cityForm">
                <div class="MainDiv">
                    <fieldset class="MainFieldset">
                        <legend>Send Bulk Email</legend>
                        <fieldset class="subMainFieldSet">
                        <legend>Email Composer</legend>
                            <div class="IASFormFieldDiv">
                                <div class="IASFormFieldDiv">
                                    <span class="IASFormDivSpanLabelEmail">
                                        <label>To:</label>
                                    </span>
                                    <span class="IASFormDivSpanInputBoxEmail">
                                        <input class="IASTextBoxMandatoryMax" TABINDEX="1" type="text" name="to" id="to" onblur="validateIds()"/>
                                    </span>
                                </div>
                                <div class="IASFormFieldDiv">
                                    <span class="IASFormDivSpanLabelMax">
                                        <label>(EMail ID's should be comma or space separated)</label>
                                    </span>
                                </div>
                                <div class="IASFormFieldDiv">
                                    <span class="IASFormDivSpanLabelSpecial">
                                        <label>Select Email ID's from database</label>
                                    </span>
                                    <span class="IASFormDivSpanInputBox">
                                        <input class="IASCheckBox" TABINDEX="2" type="checkbox" name="selall" id="selall" value ="1" onclick="getChecked()"/>
                                    </span>
                                </div>
                                <div class="IASFormFieldDiv">
                                    <span class="IASFormDivSpanLabelEmail">
                                        <label>Subject:</label>
                                    </span>
                                    <span class="IASFormDivSpanInputBoxEmail">
                                        <input class="IASTextBoxMandatoryMax" TABINDEX="3" type="text" name="subject" id="subject" />
                                    </span>
                                 </div>
                                <div class="IASFormFieldDiv">
                                    <span class="IASFormDivSpanLabelEmail">
                                        <label>Content:</label>
                                    </span>
                                    <span class="IASFormDivSpanContentAreaNoLeftMargin">
                                        <%--<textarea name="content" id="content" style="width:100%" rows="10" TABINDEX="3"></textarea>--%>
                                        <input class="IASTextBoxMandatoryMax" TABINDEX="4" type="text" name="content" id="content" />
                                    </span>
                                </div>
                           </div>
                        </fieldset>
                        <fieldset class="subMainFieldSet">
                            <div class="IASFormCenterDiv">
                                <div id="saveBtnDiv">
                                    <input class="IASButton" TABINDEX="5" type="button" value="Send Email" id="btnSendEmail" name="btnSendEmail" onclick="sendmail()"/>
                                </div>
                            </div>
                        </fieldset>
                    </fieldset>
                </div>
            </form>
        </div>
    </body>
</html>
