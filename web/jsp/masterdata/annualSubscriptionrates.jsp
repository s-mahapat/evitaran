<%--
    Document   : Define Rate for Journal
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="../templates/style.jsp" %>
        <link rel="stylesheet" type="text/css" href="css/masterdata/rate.css" />

        <title>Define Rate for Journal</title>
    </head>
    <body>
        <%@include file="../templates/layout.jsp" %>

        <div id="bodyContainer">
            <form method="post" action="" name="rateForm">
                <div class="MainDiv">
                    <fieldset class="MainFieldset">
                        <legend>Define Rate for Journal</legend>

                        <%-----------------------------------------------------------------------------------------------------%>
                        <%-- Search Criteria Field Set --%>
                        <%-----------------------------------------------------------------------------------------------------%>
                        <fieldset class="subMainFieldSet">
                            <legend>Rate Defining Criteria</legend>

                            <%-- Search Criteria left div --%>
                            <div class="IASFormLeftDiv">


                                <div class="IASFormFieldDiv">
                                    <span class="IASFormDivSpanLabel">
                                        <label>Year</label>
                                    </span>
                                    <span class="IASFormDivSpanInputBox">
                                     <select class="IASComboBox" TABINDEX="6" name="year" id="year">
                                        <option value ="1">2009</option>
                                        <option value ="2">2010</option>
                                        <option value ="3">2011</option>
                                        <option value ="3">2012</option>
                                    </select>
                                    </span>
                                 </div>
                            </div>
                            <div class="IASFormRightDiv">

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
                                    <option value ="AGE">Agent</option>
                                    <option value ="KVPY">Kishore Vaigyanik Pariyojana</option>
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
                            <legend>Rates</legend>

                            <table class="datatable">
                                <thead>
                                    <tr>
                                        <td>Journal Id</td>
                                        <td>Journal Code</td>
                                        <td>Journal Name</td>
                                        <td>1 Year</td>
                                        <td>2 Year</td>
                                        <td>3 Year</td>
                                        <td>5 Year</td>
                                     </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>1</td>
                                        <td>P</td>
                                        <td>Prammana</td>
                                        <td> <input class="IASTextBoxForNumbers" TABINDEX=" " type="text" name="rate1" id="rate1" value="500"/> </td>
                                        <td> <input class="IASTextBoxForNumbers" TABINDEX=" " type="text" name="rate1" id="rate1" value="1000"/> </td>
                                        <td> <input class="IASTextBoxForNumbers" TABINDEX=" " type="text" name="rate1" id="rate1" value="1450"/> </td>
                                        <td> <input class="IASTextBoxForNumbers" TABINDEX=" " type="text" name="rate1" id="rate1" value="2300"/> </td>
                                    </tr>
                                    <tr>
                                        <td>2</td>
                                        <td>JAA</td>
                                        <td>Journal of astrophysics and Astronomy</td>
                                        <td> <input class="IASTextBoxForNumbers" TABINDEX=" " type="text" name="rate1" id="rate1" value="450"/> </td>
                                        <td> <input class="IASTextBoxForNumbers" TABINDEX=" " type="text" name="rate1" id="rate1" value="850"/> </td>
                                        <td> <input class="IASTextBoxForNumbers" TABINDEX=" " type="text" name="rate1" id="rate1" value="1300"/> </td>
                                        <td> <input class="IASTextBoxForNumbers" TABINDEX=" " type="text" name="rate1" id="rate1" value="1900"/> </td>
                                    </tr>
                                    <tr>
                                        <td>3</td>
                                        <td>MS</td>
                                        <td>Proceedings (Mathematical Sciences)</td>
                                        <td> <input class="IASTextBoxForNumbers" TABINDEX=" " type="text" name="rate1" id="rate1" value="500"/> </td>
                                        <td> <input class="IASTextBoxForNumbers" TABINDEX=" " type="text" name="rate1" id="rate1" value="1000"/> </td>
                                        <td> <input class="IASTextBoxForNumbers" TABINDEX=" " type="text" name="rate1" id="rate1" value="1450"/> </td>
                                        <td> <input class="IASTextBoxForNumbers" TABINDEX=" " type="text" name="rate1" id="rate1" value="2300"/> </td>
                                    </tr>
                                     <tr>
                                        <td>4</td>
                                        <td>EPS</td>
                                        <td>Journal of Earth System Science </td>
                                        <td> <input class="IASTextBoxForNumbers" TABINDEX=" " type="text" name="rate1" id="rate1" value="400"/> </td>
                                        <td> <input class="IASTextBoxForNumbers" TABINDEX=" " type="text" name="rate1" id="rate1" value="650"/> </td>
                                        <td> <input class="IASTextBoxForNumbers" TABINDEX=" " type="text" name="rate1" id="rate1" value="1250"/> </td>
                                        <td> <input class="IASTextBoxForNumbers" TABINDEX=" " type="text" name="rate1" id="rate1" value="1900"/> </td>
                                    </tr>
                                     <tr>
                                        <td>5</td>
                                        <td>CS</td>
                                        <td>Journal of Chemical Sciences </td>
                                        <td> <input class="IASTextBoxForNumbers" TABINDEX=" " type="text" name="rate1" id="rate1" value="800"/> </td>
                                        <td> <input class="IASTextBoxForNumbers" TABINDEX=" " type="text" name="rate1" id="rate1" value="1500"/> </td>
                                        <td> <input class="IASTextBoxForNumbers" TABINDEX=" " type="text" name="rate1" id="rate1" value="2250"/> </td>
                                        <td> <input class="IASTextBoxForNumbers" TABINDEX=" " type="text" name="rate1" id="rate1" value="3500"/> </td>
                                    </tr>
                                     <tr>
                                        <td>6</td>
                                        <td>BMS</td>
                                        <td>Bulletin of Materials Science</td>
                                        <td> <input class="IASTextBoxForNumbers" TABINDEX=" " type="text" name="rate1" id="rate1" value="500"/> </td>
                                        <td> <input class="IASTextBoxForNumbers" TABINDEX=" " type="text" name="rate1" id="rate1" value="1000"/> </td>
                                        <td> <input class="IASTextBoxForNumbers" TABINDEX=" " type="text" name="rate1" id="rate1" value="1450"/> </td>
                                        <td> <input class="IASTextBoxForNumbers" TABINDEX=" " type="text" name="rate1" id="rate1" value="2300"/> </td>
                                    </tr>
                                     <tr>
                                        <td>7</td>
                                        <td>S</td>
                                        <td>Sadhana</td>
                                        <td> <input class="IASTextBoxForNumbers" TABINDEX=" " type="text" name="rate1" id="rate1" value="1000"/> </td>
                                        <td> <input class="IASTextBoxForNumbers" TABINDEX=" " type="text" name="rate1" id="rate1" value="1900"/> </td>
                                        <td> <input class="IASTextBoxForNumbers" TABINDEX=" " type="text" name="rate1" id="rate1" value="2800"/> </td>
                                        <td> <input class="IASTextBoxForNumbers" TABINDEX=" " type="text" name="rate1" id="rate1" value="4500"/> </td>
                                    </tr>
                                     <tr>
                                        <td>8</td>
                                        <td>JB</td>
                                        <td>Journal of Biosciences</td>
                                        <td> <input class="IASTextBoxForNumbers" TABINDEX=" " type="text" name="rate1" id="rate1" value="500"/> </td>
                                        <td> <input class="IASTextBoxForNumbers" TABINDEX=" " type="text" name="rate1" id="rate1" value="1000"/> </td>
                                        <td> <input class="IASTextBoxForNumbers" TABINDEX=" " type="text" name="rate1" id="rate1" value="1450"/> </td>
                                        <td> <input class="IASTextBoxForNumbers" TABINDEX=" " type="text" name="rate1" id="rate1" value="2300"/> </td>
                                    </tr>
                                     <tr>
                                        <td>9</td>
                                        <td>JG</td>
                                        <td>Journal of Genetics</td>
                                        <td> <input class="IASTextBoxForNumbers" TABINDEX=" " type="text" name="rate1" id="rate1" value="800"/> </td>
                                        <td> <input class="IASTextBoxForNumbers" TABINDEX=" " type="text" name="rate1" id="rate1" value="1500"/> </td>
                                        <td> <input class="IASTextBoxForNumbers" TABINDEX=" " type="text" name="rate1" id="rate1" value="2250"/> </td>
                                        <td> <input class="IASTextBoxForNumbers" TABINDEX=" " type="text" name="rate1" id="rate1" value="3500"/> </td>
                                    </tr>
                                     <tr>
                                        <td>10</td>
                                        <td>RES</td>
                                        <td>Resonance – Journal of Science Education</td>
                                        <td> <input class="IASTextBoxForNumbers" TABINDEX=" " type="text" name="rate1" id="rate1" value="500"/> </td>
                                        <td> <input class="IASTextBoxForNumbers" TABINDEX=" " type="text" name="rate1" id="rate1" value="1000"/> </td>
                                        <td> <input class="IASTextBoxForNumbers" TABINDEX=" " type="text" name="rate1" id="rate1" value="1450"/> </td>
                                        <td> <input class="IASTextBoxForNumbers" TABINDEX=" " type="text" name="rate1" id="rate1" value="2300"/> </td>
                                    </tr>
                                     <tr>
                                        <td>11</td>
                                        <td>CURR</td>
                                        <td>Current Science</td>
                                        <td> <input class="IASTextBoxForNumbers" TABINDEX=" " type="text" name="rate1" id="rate1" value="500"/> </td>
                                        <td> <input class="IASTextBoxForNumbers" TABINDEX=" " type="text" name="rate1" id="rate1" value="1000"/> </td>
                                        <td> <input class="IASTextBoxForNumbers" TABINDEX=" " type="text" name="rate1" id="rate1" value="1450"/> </td>
                                        <td> <input class="IASTextBoxForNumbers" TABINDEX=" " type="text" name="rate1" id="rate1" value="2300"/> </td>
                                    </tr>
                                     <tr>
                                        <td>12</td>
                                        <td>All</td>
                                        <td>All</td>
                                        <td> <input class="IASTextBoxForNumbers" TABINDEX=" " type="text" name="rate1" id="rate1" value="5000"/> </td>
                                        <td> <input class="IASTextBoxForNumbers" TABINDEX=" " type="text" name="rate2" id="rate2" value="9500"/> </td>
                                        <td> <input class="IASTextBoxForNumbers" TABINDEX=" " type="text" name="rate3" id="rate3" value="14000"/> </td>
                                        <td> <input class="IASTextBoxForNumbers" TABINDEX=" " type="text" name="rate5" id="rate5" value="22000"/> </td>
                                    </tr>
                                </tbody>
                            </table>
                        </fieldset>
                        <%-----------------------------------------------------------------------------------------------------%>
                        <%-- Create New subscriber Type Actions Field Set --%>
                        <%-----------------------------------------------------------------------------------------------------%>

                        <fieldset class="subMainFieldSet">
                            <div class="IASFormFieldDiv">
                                <input type="hidden" name="action" id="action"/>
                                <div id="saveBtnDiv">
                                    <input onclick="setActionValue('save')"  class="IASButton" TABINDEX="101" type="submit" value="save" id="btnSave" name="btnSubmitAction"/>
                                </div>
                                <div id="editBtnDiv">
                                    <input onclick="setActionValue('edit')" class="IASButton" TABINDEX="101" type="submit" value="edit" id="btnEdit" name="btnSubmitAction"/>
                                </div>
                            </div>
                        </fieldset>
                    </fieldset>
                </div>
            </form>
        </div>
    </body>
</html>