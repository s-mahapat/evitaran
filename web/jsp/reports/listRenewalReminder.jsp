<%--
    Document   : Print Reminder Renewal List
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="../templates/style.jsp" %>
        <link rel="stylesheet" type="text/css" href="css/report/listRenReminder.css" />

        <title>Print Reminder Renewal List</title>
        <%--------------------------------------------------------------%>
        <%-- Calendar --%>
        <%--------------------------------------------------------------%>
        <script src="js/CalendarPopup.js" type="text/javascript"></script>
        <script type="text/javascript">
            var calPopup = new CalendarPopup("dateDiv");
            calPopup.showNavigationDropdowns();
        </script>

    </head>
    <body>
        <%@include file="../templates/layout.jsp" %>

        <div id="bodyContainer">
            <form method="post" action="" name="listrenReminder">
                <div class="MainDiv">
                    <fieldset class="MainFieldset">
                        <legend>Print Reminder Renewal List</legend>

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
                                    <label>Reminder Type</label>
                                </span>
                                <span class="IASFormDivSpanInputBox">
                                 <select class="IASComboBox" TABINDEX="6" name="remType" id="remType">
                                    <option value ="G">Gentle Reminder</option>
                                    <option value ="S">Strong Reminder</option>
                                    <option value ="S">Harsh Reminder</option>
                                 </select>
                                </span>
                            </div>
                            <div class="IASFormFieldDiv">
                                <%------ Date Range Label ------%>
                                <span class="IASFormDivSpanLabel">
                                    <label>Reminder Date:</label>
                                </span>

                                <%---------- Date Division -----------%>
                                <div class="dateDiv" id="dateDiv"></div>

                                <%------ From Date Input Box ------%>
                                <span class="IASFormDivSpanInputBox">
                                    <input class="IASDateTextBox" readonly size="10" value="" id="fromDate"/>
                                       <a href="#" onClick="calPopup.select(document.listrenReminder.fromDate,'anchor1','dd/MM/yyyy');
                                           return false;" NAME="anchor1" ID="anchor1">
                                        <img class="calendarIcon" alt="select" src="" TABINDEX="4"/>
                                    </a>
                                </span>

                                <%-- Hyphen between From date and To Date --%>
                                <span class="IASFormDivSpanForHyphen">
                                    <label> - </label>
                                </span>

                                <%--------------- To Date Input Box --------------%>
                                <span class="IASFormDivSpanInputBoxForSearchInward">
                                    <input class="IASDateTextBox" readonly size="10" value="" id="toDate"/>
                                       <a href="#" onClick="calPopup.select(document.listrenReminder.toDate,'anchor2','dd/MM/yyyy');
                                           return false;" NAME="anchor2" ID="anchor2">
                                        <img class="calendarIcon" alt="select" src="" TABINDEX="5"/>
                                    </a>
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
                            <legend>Reminder List</legend>

                        <table class="datatable">
                            <thead>
                                <tr>
                                    <td>Subscriber Id</td>
                                    <td>Subscriber Name</td>
                                    <td>Journal/s</td>
                                    <td>No. Of Copies</td>
                                    <td>Total Amount</td>
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
                                    <td>2, 5 ,5</td>
                                    <td>4000</td>
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
                                    <td>450</td>
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