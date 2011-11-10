<%--
    Document   : Process Inward
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="../templates/style.jsp" %>
        <link rel="stylesheet" type="text/css" href="css/inward.css" />

        <title>Search Inward</title>

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
            <form method="post" action="" name="processInwardForm">
                <div class="MainDiv">
                    <fieldset class="MainFieldset">
                        <legend>Process Inward</legend>

                        <%-----------------------------------------------------------------------------------------------------%>
                        <%-- Search Criteria Field Set --%>
                        <%-----------------------------------------------------------------------------------------------------%>
                        <fieldset class="subMainFieldSet">
                            <legend>Filter Criteria</legend>

                            <%-- Search Criteria left div --%>
                            <div class="IASFormLeftDiv">


                                <div class="IASFormFieldDiv">
                                    <span class="IASFormDivSpanLabel">
                                        <label>Purpose:</label>
                                    </span>
                                    <span class="IASFormDivSpanInputBox">
                                        <select class="IASComboBox" TABINDEX="1" name="purpose" id="purpose">
                                            <option value ="IASAgent"> </option>
                                            <option value ="IASAgent">Create New Subscription</option>
                                            <option value ="IASAgent">Renew Subscription</option>
                                        </select>
                                    </span>
                                </div>
                            </div>


                            <%-- Search Criteria right div --%>
                            <div class="IASFormRightDiv">

                                <div class="IASFormFieldDiv">
                                    <%------ Date Range Label ------%>
                                    <span class="IASFormDivSpanLabel">
                                        <label>Date Range:</label>
                                    </span>

                                    <%---------- Date Division -----------%>
                                    <div class="dateDiv" id="dateDiv"></div>

                                    <%------ From Date Input Box ------%>
                                    <span class="IASFormDivSpanInputBox">
                                        <input class="IASDateTextBox" readonly size="10" value="" id="fromDate"/>
                                           <a href="#" onClick="calPopup.select(document.processInwardForm.fromDate,'anchor1','dd/MM/yyyy');
                                               return false;" NAME="anchor1" ID="anchor1">
                                            <img class="calendarIcon" alt="select" src="" TABINDEX="2" />
                                        </a>
                                    </span>

                                    <%-- Hyphen between From date and To Date --%>
                                    <span class="IASFormDivSpanForHyphen">
                                        <label> - </label>
                                    </span>

                                    <%--------------- To Date Input Box --------------%>
                                    <span class="IASFormDivSpanInputBoxForSearchInward">
                                        <input class="IASDateTextBox" readonly size="10" value="" id="toDate"/>
                                           <a href="#" onClick="calPopup.select(document.processInwardForm.toDate,'anchor2','dd/MM/yyyy');
                                               return false;" NAME="anchor2" ID="anchor2">
                                            <img class="calendarIcon" alt="select" src=""  TABINDEX="3"/>
                                        </a>
                                    </span>
                                </div>
                            </div>

                            <div class="IASFormFieldDiv">
                                <div id="filterBtnDiv">
                                    <input class="IASButton" type="submit" value="Filter"  TABINDEX="4"/>
                                </div>

                                <div id="resetBtnDiv">
                                    <input class="IASButton" type="reset" value="Reset"  TABINDEX="5"/>
                                </div>
                            </div>

                        </fieldset>



                        <%-----------------------------------------------------------------------------------------------------%>
                        <%-- Search Result Field Set --%>
                        <%-----------------------------------------------------------------------------------------------------%>
                        <fieldset class="subMainFieldSet">
                            <legend>Inwards</legend>

                            <table class="datatable">
                                <thead>
                                    <tr>
                                        <td>Inward Number</td>
                                        <td>Purpose</td>
                                        <td>Inward Creation Date</td>
                                        <td>From</td>
                                        <td>Follow On Actions</td>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>121</td>
                                        <td>New Subscription</td>
                                        <td>12/10/2011</td>
                                        <td>Pinki Pachisia</td>
                                        <td><a href="#">Create New Subscription</a></td>
                                    </tr>
                                    <tr>
                                        <td>122</td>
                                        <td>Process Renewal</td>
                                        <td>12/10/2011</td>
                                        <td>Shailendra Mahapatra</td>
                                        <td><a href="#">Process Renewal</a></td>
                                    </tr>
                                    <tr>
                                        <td>123</td>
                                        <td>Address Change</td>
                                        <td>14/10/2011</td>
                                        <td>Deepali Gokhale</td>
                                        <td><a href="#">Address Change</a></td>
                                    </tr>
                                    <tr>
                                        <td>124</td>
                                        <td>Request For Invoice</td>
                                        <td>15/10/2011</td>
                                        <td>Alok Modak</td>
                                        <td><a href="#">Request For Invoice</a></td>
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