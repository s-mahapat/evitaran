<%--
    Document   : Search Journal
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="../templates/style.jsp" %>
        <link rel="stylesheet" type="text/css" href="css/masterdata/journal.css" />

        <title>Search Journal</title>
    </head>
    <body>
        <%@include file="../templates/layout.jsp" %>

        <div id="bodyContainer">
            <form method="post" action="" name="searchJournalForm">
                <div class="MainDiv">
                    <fieldset class="MainFieldset">
                        <legend>Search Journal</legend>

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
                                        <input class="IASTextBox" TABINDEX="1" type="text" name="journalCode" id="journalCode" value=""/>
                                    </span>
                                </div>
                            </div>    
                            <div class="IASFormRightDiv">

                                <div class="IASFormFieldDiv">
                                    <span class="IASFormDivSpanLabel">
                                        <label>Journal Name</label>
                                    </span>
                                    <span class="IASFormDivSpanInputBox">
                                        <input class="IASTextBox" TABINDEX="2" type="text" name="journalName" id="journalName" value=""/>
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
                            <legend>Search Result</legend>

                            <table class="datatable">
                                <thead>
                                    <tr>
                                        <td>Journal Id</td>
                                        <td>Journal Code</td>
                                        <td>Journal Name</td>
                                        <td>ISSN No</td>
                                        <td>View/Edit</td>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>1</td>
                                        <td>P</td>
                                        <td>Prammana</td>
                                        <td>1776</td>
                                        <td><a href="<%=request.getContextPath() + "/journal?action=view"%>">view</a><a href="<%=request.getContextPath() + "/journal?action=edit"%>">edit</a></td>
                                    </tr>
                                    <tr>
                                        <td>2</td>
                                        <td>CS</td>
                                        <td>Current Science</td>
                                        <td>1498</td>
                                        <td><a href="<%=request.getContextPath() + "/journal?action=view"%>">view</a><a href="<%=request.getContextPath() + "/journal?action=edit"%>">edit</a></td>
                                    </tr>
                                    <tr>
                                        <td>3</td>
                                        <td>RES</td>
                                        <td>Resonance</td>
                                        <td>1998</td>
                                        <td><a href="<%=request.getContextPath() + "/journal?action=view"%>">view</a><a href="<%=request.getContextPath() + "/journal?action=edit"%>">edit</a></td>
                                    </tr>
                                </tbody>
                            </table>
                        </fieldset>
                    </fieldset>
                </div>
            </form>
        </div>
    </body>
</html>