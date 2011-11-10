<%--
    Document   : Generate Mailing List
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <base href="${pageContext.request.contextPath}">
        <%@include file="../templates/style.jsp"%>
        <link rel="stylesheet" type="text/css" href="css/ml.css"/>
        <title>Generate Mailing List</title>
        <script type="text/javascript" src="js/ml.js"></script>
        <script>
            //addOnloadEvent(makeReadOnly);
        </script>
    </head>
    <body>

        <%@include file="../templates/layout.jsp" %>
        <div id="bodyContainer">
            <form method="post" action="" name="mlForm">
                <div class="MainDiv">
                    <fieldset class="MainFieldset">
                        <legend>Generate Mailing List</legend>
                        <fieldset class="subMainFieldSet">
                            <legend>Mailing List Criteria</legend>
                            <div class="IASFormLeftDiv">
                                <div class="IASFormFieldDiv">
                                    <span class="IASFormDivSpanLabel">
                                        <label>Journal Name:</label>
                                    </span>
                                    <span class="IASFormDivSpanInputBox">
                                        <select class="IASComboBox" TABINDEX="1" name="journalName" id="journalName">
                                            <option value ="0">Select</option>
                                            <option value ="">Pramana</option>
                                            <option value ="">Resonance</option>
                                        </select>
                                    </span>
                                </div>

                                <div class="IASFormFieldDiv">
                                    <span class="IASFormDivSpanLabel">
                                        <label>Subscriber Type:</label>
                                    </span>
                                    <span class="IASFormDivSpanInputBox">
                                        <select class="IASComboBox" TABINDEX="2" name="subscriberType" id="subscriberType">
                                            <option value ="0">Select</option>
                                            <option value ="">Summer Fellow</option>
                                            <option value ="">FI</option>
                                        </select>
                                    </span>
                                </div>

                                <div class="IASFormFieldDiv">
                                    <span class="IASFormDivSpanLabel">
                                        <label>No. of Copies:</label>
                                    </span>
                                    <span class="IASFormDivSpanInputBox">
                                        <input TABINDEX="3" class="IASTextBox" maxlength="5" type="text" name="numOfCopies" id="numOfCopies" value=""/>
                                    </span>
                                </div>

                                <div class="IASFormFieldDiv">
                                    <span class="IASFormDivSpanLabel">
                                        <label>Month:</label>
                                    </span>
                                    <span class="IASFormDivSpanInputBox">
                                         <select class="IASComboBox" TABINDEX="4" name="mlMonth" id="mlMonth">
                                            <option value ="0">November</option>
                                        </select>
                                    </span>
                                </div>

                                <div class="IASFormFieldDiv">
                                    <span class="IASFormDivSpanLabel">
                                        <label>Year:</label>
                                    </span>
                                    <span class="IASFormDivSpanInputBox">
                                         <select class="IASComboBox" TABINDEX="5" name="mlYear" id="mlYear">
                                            <option value ="0">2011</option>
                                        </select>
                                    </span>
                                </div>
                            </div>
                        </fieldset>

                        <!--
                        /* Actions Field Set */
                        -->
                        <fieldset class="subMainFieldSet">
                            <div class="IASFormFieldDiv">
                                <div class="singleActionBtnDiv">
                                    <input class="IASButton" TABINDEX="6" type="submit" value="Generate Mailing List" id="btnGenerateML" name="btnGenerateML"/>
                                </div>

                            </div>
                        </fieldset>
                    </fieldset>
                </div>
            </form>
        </div>
    </body>
</html>