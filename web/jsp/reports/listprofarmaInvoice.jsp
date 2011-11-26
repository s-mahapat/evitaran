<%--
    Document   : List and Print Profarma Invoice
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="../templates/style.jsp" %>
        <link rel="stylesheet" type="text/css" href="css/report/listProfarma.css" />

        <title>list and Print Profarma Invoice</title>
    </head>
    <body> 
        <%@include file="../templates/layout.jsp" %>

        <div id="bodyContainer">
            <form method="post" action="" name="listProfarma">
                <div class="MainDiv">
                    <fieldset class="MainFieldset">
                        <legend>Search Criteria</legend>

                        <%-----------------------------------------------------------------------------------------------------%>
                        <%-- Search Criteria Field Set --%>
                        <%-----------------------------------------------------------------------------------------------------%>
                        <fieldset class="subMainFieldSet">
                            <legend>Statement of Label for Journal</legend>

                            <%-- Search Criteria left div --%>
                            <div class="IASFormLeftDiv">
                                
                                <div class="IASFormFieldDiv">
                                    <span class="IASFormDivSpanLabel">
                                        <label>Journal Name</label>
                                    </span>
                                    <span class="IASFormDivSpanInputBox">
                                     <select class="IASComboBox" TABINDEX="1" name="journalName" id="journalName">
                                        <option value ="p">Pramanna</option>
                                        <option value ="CS">Current Science</option>
                                        <option value ="RES">Resonance</option>
                                    </select>
                                    </span>
                                </div>

                                <div class="IASFormFieldDiv">
                                    <span class="IASFormDivSpanLabel">
                                        <label>Year</label>
                                    </span>
                                    <span class="IASFormDivSpanInputBox">
                                     <select class="IASComboBox" TABINDEX="2" name="year" id="year">
                                        <option value ="yr">2011</option>
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
                                     <select class="IASComboBox" TABINDEX="1" name="subType" id="subType">
                                        <option value ="IP">Indian Personnel</option>
                                        <option value ="ISC">Indian Institution</option>
                                    </select>
                                    </span>
                                </div>

                                <div class="IASFormFieldDiv">
                                    <span class="IASFormDivSpanLabel">
                                        <label>From</label>
                                    </span>
                                    <span class="IASFormDivSpanInputBox">
                                        <input class="IASOptionButton" TABINDEX="10" type="radio" name="free" id="free" value=""/>
                                    </span>
                                    <span class="IASFormDivSpanLabel">
                                        <label>To</label>
                                    </span>                                    
                                    <span class="IASFormDivSpanInputBox">
                                        <input class="IASOptionButton" TABINDEX="10" type="radio" name="Paid" id="Paid" value=""/>
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
                                        <td>RES</td>
                                        <td>Resonance</td>
                                        <td>Indian Institutes</td>
                                         <td>220</td>
                                        <td>6</td>
                                    </tr>
                                    <tr>
                                        <td>Total</td>
                                        <td> </td>
                                        <td> </td>
                                        <td>9325</td>
                                        <td>13445</td>
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