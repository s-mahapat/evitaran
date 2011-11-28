<%--
    Document   : Print Back Issue List
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="../templates/style.jsp" %>
        <link rel="stylesheet" type="text/css" href="css/report/listBackIssue.css" />

        <title>Print Back Issue List</title>
    </head>
    <body>
        <%@include file="../templates/layout.jsp" %>

        <div id="bodyContainer">
            <form method="post" action="" name="listBackIssueForm">
                <div class="MainDiv">
                    <fieldset class="MainFieldset">
                        <legend>Print Back Issue List</legend>

                        <%-----------------------------------------------------------------------------------------------------%>
                        <%-- Search Criteria Field Set --%>
                        <%-----------------------------------------------------------------------------------------------------%>
                     <fieldset class="subMainFieldSet">
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

                        <div class="IASFormRightDiv">

                            <div class="IASFormFieldDiv">
                                <span class="IASFormDivSpanLabel">
                                    <label>Month</label>
                                </span>
                                <span class="IASFormDivSpanInputBox">
                                 <select class="IASComboBox" TABINDEX="6" name="month" id="month">
                                    <option value ="1">Jan</option>
                                    <option value ="2">Feb</option>
                                    <option value ="3">Mar</option>
                                    <option value ="4">Apr</option>
                                    <option value ="5">May</option>
                                    <option value ="6">Jun</option>
                                    <option value ="7">Jul</option>
                                    <option value ="8">Aug</option>
                                    <option value ="9">Sep</option>
                                    <option value ="10">Oct</option>
                                    <option value ="11">Nov</option>
                                    <option value ="12">Dec</option>
                                 </select>
                                </span>
                            </div>
                            <div class="IASFormFieldDiv">
                                <span class="IASFormDivSpanLabel">
                                    <label>Year</label>
                                </span>
                                <span class="IASFormDivSpanInputBox">
                                 <select class="IASComboBox" TABINDEX="6" name="Year" id="Year">
                                    <option value ="1">2009</option>
                                    <option value ="2">2010</option>
                                    <option value ="3">2011</option>
                                 </select>
                                </span>
                            </div>

                        </div>

                        <div class="IASFormFieldDiv">
                            <div id="searchBtnDiv">
                                <input class="IASButton" TABINDEX="6" type="submit" value="Search"/>
                            </div>

                            <div id="resetBtnDiv">
                                <input class="IASButton" TABINDEX="7" type="reset" value="Reset"/>
                            </div>
                         </div>

                      </fieldset>



                        <%-----------------------------------------------------------------------------------------------------%>
                        <%-- Search Result Field Set --%>
                        <%-----------------------------------------------------------------------------------------------------%>
                        <fieldset class="subMainFieldSet">
                            <legend>List Back Issue Result</legend>

                        <table class="datatable">
                            <thead>
                                <tr>
                                    <td>Subscriber Id</td>
                                    <td>Subscriber Name</td>
                                    <td>Journal/s</td>
                                    <td>No of copies</td>
                                    <td>Subscriber Type</td>
                                    <td>Department</td>
                                    <td>City</td>
                                    <td>Pin Code</td>
                                    <td>Country</td>
                                    <td>Email</td>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>1</td>
                                    <td>Pinki Pachisia</td>
                                    <td>P, CS, RES</td>
                                    <td>2, 5, 5</td>
                                    <td>Indian Personnel</td>
                                    <td>IAS1</td>
                                    <td>Bangalore</td>
                                    <td>560066</td>
                                    <td>India</td>
                                    <td>pinki@ias.com</td>
                                </tr>
                                <tr>
                                    <td>2</td>
                                    <td>Shailendra Mahapatra</td>
                                    <td>JAA</td>
                                    <td>1</td>
                                    <td>Indian Personnel</td>
                                    <td>IAS2</td>
                                    <td>Bangalore</td>
                                    <td>560067</td>
                                    <td>India</td>
                                    <td>shail@ias.com</td>
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