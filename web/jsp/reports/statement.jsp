<%--
    Document   : List Journal - Statement
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="../templates/style.jsp" %>
        <link rel="stylesheet" type="text/css" href="css/report/statement.css" />

        <title>Statement</title>
    </head>
    <body>
        <%@include file="../templates/layout.jsp" %>

        <div id="bodyContainer">
            <form method="post" action="" name="listJournals">
                <div class="MainDiv">
                    <fieldset class="MainFieldset">
                        <legend>Statement</legend>

                        <%-----------------------------------------------------------------------------------------------------%>
                        <%-- Search Criteria Field Set --%>
                        <%-----------------------------------------------------------------------------------------------------%>
                        <fieldset class="subMainFieldSet">
                            <legend>Statement</legend>

                            <%-- Search Criteria left div --%>
                            <div class="IASFormLeftDiv">


                                <div class="IASFormFieldDiv">
                                    <span class="IASFormDivSpanLabel">
                                        <label>Year</label>
                                    </span>
                                    <span class="IASFormDivSpanInputBox">
                                     <select class="IASComboBox" TABINDEX="6" name="year" id="year">
                                        <option value ="test1">2011</option>
                                    </select>
                                    </span>
                                </div>
                            </div>    

                            <div class="IASFormFieldDiv">
                                <div id="searchBtnDiv">
                                    <input class="IASButton" TABINDEX="3" type="submit" value="Search"/>
                                </div>

                                <div id="resetBtnDiv">
                                    <input class="IASButton" TABINDEX="4" type="reset" value="Reset"/>
                                </div>
                            </div>

                        </fieldset>



                        <%-----------------------------------------------------------------------------------------------------%>
                        <%-- Search Result Field Set --%>
                        <%-----------------------------------------------------------------------------------------------------%>
                        <fieldset class="subMainFieldSet">
                            <legend>Statement Result</legend>

                            <table class="datatable">
                                <thead>
                                    <tr>
                                        <td>Journal Code</td>
                                        <td>Journal Name</td>
                                        <td>Subscriber Type</td>
                                        <td>No Of subscribers</td>
                                        <td>number of copies</td>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>P</td>
                                        <td>Prammana</td>
                                        <td>Indian Personnel</td>
                                        <td>8945</td>
                                        <td>1</td>
                                    </tr>
                                    <tr>
                                        <td>CS</td>
                                        <td>Current Science</td>
                                        <td>Indian School and College</td>
                                         <td>150</td>
                                        <td>5</td>
                                    </tr>
                                    <tr>
                                        <td>3</td>
                                        <td>RES</td>
                                        <td>Resonance</td>
                                        <td>Indian Institutes</td>
                                         <td>220</td>
                                        <td>6</td>
                                    </tr>
                                </tbody>
                            </table>
                        </fieldset>
                        <fieldset class="subMainFieldSet">
                            <div class="IASFormFieldDiv">
                                <div class="singleActionBtnDiv">
                                    <input class="IASButton" type="button" value="Print" onclick="javascript:window.print();"/>
                                </div>
                            </div>
                        </fieldset>
                    </fieldset>
                </div>
            </form>
        </div>
    </body>
</html>