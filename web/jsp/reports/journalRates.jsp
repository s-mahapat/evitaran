<%--
    Document   : Journal Rate - Print
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="../templates/style.jsp" %>
        <link rel="stylesheet" type="text/css" href="css/report/journalRates.css" />

        <title>Annual Rates for Journal</title>
    </head>
    <body>
        <%@include file="../templates/layout.jsp" %>

        <div id="bodyContainer">
            <form method="post" action="" name="listJournals">
                <div class="MainDiv">
                    <fieldset class="MainFieldset">
                        <legend>List and Print Annual Rates for Journal</legend>

                        <%-----------------------------------------------------------------------------------------------------%>
                        <%-- Search Criteria Field Set --%>
                        <%-----------------------------------------------------------------------------------------------------%>
                        <fieldset class="subMainFieldSet">
                            <legend>Search Criteria</legend>

                            <%-- Search Criteria left div --%>
                            <div class="IASFormLeftDiv">

                                <div class="IASFormFieldDiv">
                                    <span class="IASFormDivSpanLabel">
                                        <label>Journal Name</label>
                                    </span>
                                    <span class="IASFormDivSpanInputBox">
                                     <select class="IASComboBox" TABINDEX="6" name="journalName" id="journalName">
                                        <option value ="P">Pramanna</option>
                                        <option value ="JAA">Journal of astrophysics and Astronomy</option>
                                        <option value ="MS">Proceedings</option>
                                        <option value ="EPS">Journal of Earth System Science</option>
                                        <option value ="CS">Journal of Chemical Sciences</option>
                                        <option value ="BMS">Bulletin of Materials Science</option>
                                        <option value ="S">Sadhana</option>
                                        <option value ="JB">Journal of Biosciences</option>
                                        <option value ="JG">Journal of Genetics</option>
                                        <option value ="CURR">Current Science</option>
                                        <option value ="RES">Resonance</option>
                                    </select>
                                    </span>
                                </div>
                                <div class="IASFormFieldDiv">
                                    <span class="IASFormDivSpanLabel">
                                        <label>Year</label>
                                    </span>
                                    <span class="IASFormDivSpanInputBox">
                                     <select class="IASComboBox" TABINDEX="6" name="year" id="year">
                                        <option value ="test1">2009</option>
                                        <option value ="test1">2010</option>
                                        <option value ="test1">2011</option>
                                        <option value ="test1">2012</option>
                                    </select>
                                    </span>
                                </div>
                            </div>

                           <%-- Search Criteria Right div --%>
                            <div class="IASFormLeftDiv">

                                <div class="IASFormFieldDiv">
                                    <span class="IASFormDivSpanLabel">
                                        <label>Subscriber Type</label>
                                    </span>
                                    <span class="IASFormDivSpanInputBox">
                                     <select class="IASComboBox" TABINDEX="6" name="subType" id="subType">
                                        <option value ="IC">Indian Schools and colleges</option>
                                        <option value ="II">Indian institutes</option>
                                        <option value ="IP">Indian Personnel</option>
                                        <option value ="IN">Indian Industry Corporate</option>
                                        <option value ="FI">Foreign Institute</option>
                                        <option value ="FP">Foreign Personnel</option>
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