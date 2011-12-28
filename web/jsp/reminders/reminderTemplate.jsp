<%--
    Document   : Reminder Template
    Author     : Alok Modak
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <jsp:include page="../templates/style.jsp"></jsp:include>
        <link rel="stylesheet" type="text/css" href="css/masterdata/reminder.css"/>
        <link rel="stylesheet" type="text/css" href="<%=request.getContextPath() + "/css/invoice/invoice.css"%>" media="screen"/>
        <link rel="stylesheet" type="text/css" href="<%=request.getContextPath() + "/css/invoice/invoiceprint.css"%>" media="print"/>

        <title>Send Reminder</title>
        <script type="text/javascript" src="js/masterdata/reminder.js"></script>

    </head>
    <body>

        <%@include file="../templates/layout.jsp" %>
        <div id="bodyContainer">
            <form method="post" action="<%=request.getContextPath() + "/reminders"%>" name="reminderTemplateForm">
                <div class="MainDiv">
                    <fieldset class="MainFieldset">
                        <legend>Send Reminder</legend>
                        <fieldset class="subMainFieldSet">
                            <div class="IASFormFieldDiv">
                                <div class="IASFormLeftDiv">
                                    <div class="IASFormFieldDiv">
                                        <span class="IASFormDivSpanLabel">
                                            <label>Mail</label>
                                        </span>
                                        <span class="IASFormDivSpanInputBox">
                                            <input class="IASOptionButton" TABINDEX="10" type="radio" name="mail" id="mail" value=""/>
                                        </span>
                                        <span class="IASFormDivSpanLabelRadio">
                                            <label>Print</label>
                                        </span>
                                        <span class="IASFormDivSpanInputBox">
                                            <input class="IASOptionButton" TABINDEX="10" type="radio" name="Print" id="Print" value=""/>
                                        </span>
                                    </div>                                
                                </div>
                            </div>
                        </fieldset>
                        <fieldset class="subMainFieldSet">
                            <div class="IASFormFieldDiv">
                                <div class="singleActionBtnDiv">
                                    <input class="IASButton" type="button" value="Print" onclick="javascript:window.print();"/>
                                </div>
                            </div>
                        </fieldset>
                        <%@include file="reminderType1.jsp"%>
                        </fieldset>
                </div>
            </form>
        </div>
    </body>
</html>