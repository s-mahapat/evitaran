<%--
    Document   : Circulation Figure for Journal
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="../templates/style.jsp" %>
        <link rel="stylesheet" type="text/css" href="css/report/circulationFigures.css" />

        <title>Circulation Figure</title>
    </head>
    <body> 
        <%@include file="../templates/layout.jsp" %>

        <div id="bodyContainer">
            <form method="post" action="" name="circulationFigures">
                <div class="MainDiv">
                    <fieldset class="MainFieldset">
                        <legend>Statement of Label for Journal</legend>

                        <%-----------------------------------------------------------------------------------------------------%>
                        <%-- Search Criteria Field Set --%>
                        <%-----------------------------------------------------------------------------------------------------%>
                        <fieldset class="subMainFieldSet">
                            <legend>Select Year</legend>

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
                            <legend>Result</legend>

                            <table class="datatable">
                                <thead>
                                    <tr>
                                        <td>Journal Code</td>
                                        <td>Journal Name</td>
                                        <td>Inst. India</td>
                                        <td>Inst. Abd</td>
                                        <td>Indi. India</td>
                                        <td>Indi. Abd</td>
                                        <td>Comp</td>
                                        <td>Auth</td>                                        
                                        <td>Total copies</td>
                                        <td>Print Order</td>
                                        <td>Balance Copies</td>                                        
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>P</td>
                                        <td>Prammana</td>
                                        <td>9600</td>
                                        <td>400</td>
                                        <td>7000</td>
                                        <td>500</td>
                                        <td>290</td>
                                        <td>60</td>                                        
                                        <td>17850</td>
                                        <td>18000</td>
                                        <td>150</td>
                                    </tr>
                                    <tr>
                                        <td>CS</td>
                                        <td>Current Science</td>
                                        <td>15000</td>
                                        <td>1754</td>
                                        <td>11345</td>
                                        <td>896</td>
                                        <td>68</td>
                                        <td>60</td>                                        
                                        <td>29123</td>
                                        <td>30000</td>
                                        <td>877</td>
                                    </tr>
                                    <tr>
                                        <td>RES</td>
                                        <td>Resonance</td>
                                        <td>12000</td>
                                        <td>5677</td>
                                        <td>8967</td>
                                        <td>1349</td>
                                        <td>78</td>
                                        <td>34</td>                                        
                                        <td>28105</td>
                                        <td>28500</td>
                                        <td>395</td>
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