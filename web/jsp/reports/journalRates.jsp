<%--
    Document   : Journal Rate - Print
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="../templates/style.jsp" %>
        <link rel="stylesheet" type="text/css" href="css/report/journal.css" />

        <title>Annual Rates for Journal</title>
    </head>
    <body>
        <%@include file="../templates/layout.jsp" %>

        <div id="bodyContainer">
            <form method="post" action="" name="listJournals">
                <div class="MainDiv">
                    <fieldset class="MainFieldset">
                        <legend>List and Print Annual Journals Rates</legend>

                        <%-----------------------------------------------------------------------------------------------------%>
                        <%-- Search Criteria Field Set --%>
                        <%-----------------------------------------------------------------------------------------------------%>
                        <fieldset class="subMainFieldSet">
                            <legend>Search Criteria</legend>

                            <%-- Search Criteria left div --%>
                            <div class="IASFormLeftDiv">


                                <div class="IASFormFieldDiv">
                                    <span class="IASFormDivSpanLabel">
                                        <label>Journal Code:</label>
                                    </span>
                                    <span class="IASFormDivSpanInputBox">
                                     <select class="IASComboBox" TABINDEX="6" name="journalCode" id="journalCode">
                                        <option value ="test1">      </option>
                                    </select>
                                    </span>
                                </div>

                                <div class="IASFormFieldDiv">
                                    <span class="IASFormDivSpanLabel">
                                        <label>Journal Name</label>
                                    </span>
                                    <span class="IASFormDivSpanInputBox">
                                     <select class="IASComboBox" TABINDEX="6" name="journalName" id="journalName">
                                        <option value ="test1">            </option>
                                    </select>
                                    </span>
                                </div>
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

                           <%-- Search Criteria Right div --%>
                            <div class="IASFormLeftDiv">


                                <div class="IASFormFieldDiv">
                                    <span class="IASFormDivSpanLabel">
                                        <label>Sub Type Code:</label>
                                    </span>
                                    <span class="IASFormDivSpanInputBox">
                                     <select class="IASComboBox" TABINDEX="6" name="subTypeCode" id="subTypeCode">
                                        <option value ="test1">IP</option>
                                    </select>
                                    </span>
                                </div>

                                <div class="IASFormFieldDiv">
                                    <span class="IASFormDivSpanLabel">
                                        <label>Subscriber Type</label>
                                    </span>
                                    <span class="IASFormDivSpanInputBox">
                                     <select class="IASComboBox" TABINDEX="6" name="subType" id="subType">
                                        <option value ="test1">Indian Personnel</option>
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
                            <legend>Search Result for "Indian Personnel"</legend>

                            <table class="datatable">
                                <thead>
                                    <tr>
                                        <td>Subscriber Type</td>
                                        <td>Journal Name</td>
                                        <td>ISSN No</td>
                                        <td>No Of Pages</td>
                                        <td>Start Year</td>
                                        <td>Annual Rate</td>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>Indian Personnel</td>
                                        <td>Prammana</td>
                                        <td>1776</td>
                                        <td>270</td>
                                        <td>1976</td>
                                        <td>1200</td>
                                    </tr>
                                    <tr>
                                        <td>Indian Personnel</td>
                                        <td>Current Science</td>
                                        <td>1498</td>
                                         <td>150</td>
                                        <td>1985</td>
                                        <td>1600</td>
                                    </tr>
                                    <tr>
                                        <td>Indian Personnel</td>
                                        <td>Resonance</td>
                                        <td>1998</td>
                                         <td>220</td>
                                        <td>1992</td>
                                        <td>750</td>
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