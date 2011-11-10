<%--
    Document   : Search Inward
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
        <script src="js/gatekeeperinward.js" type="text/javascript"></script>
        <script type="text/javascript">
            var calPopup = new CalendarPopup("dateDiv");
            calPopup.showNavigationDropdowns();
        </script>

    </head>
    <body>
        <%@include file="../templates/layout.jsp" %>
        <div id="bodyContainer">
            <form method="post" action="<%=request.getParameter("next")%>" name="searchInwardForm" onsubmit="return validate()">
                <input type="hidden" value="" name="selectedInward" id="selectedInward"/>
                <div class="MainDiv">
                    <fieldset class="MainFieldset">
                        <legend>Search Inward</legend>

                        <%-----------------------------------------------------------------------------------------------------%>
                        <%-- Search Criteria Field Set --%>
                        <%-----------------------------------------------------------------------------------------------------%>
                        <fieldset class="subMainFieldSet">
                            <legend>Search Criteria</legend>

                            <%-- Search Criteria left div --%>
                            <div class="IASFormLeftDiv">


                                <div class="IASFormFieldDiv">
                                    <span class="IASFormDivSpanLabel">
                                        <label>Inward Number:</label>
                                    </span>
                                    <span class="IASFormDivSpanInputBox">
                                        <input class="IASTextBox" TABINDEX="1" type="text" name="inwardNumber" id="inwardNumber" value=""/>
                                    </span>
                                </div>


                                <div class="IASFormFieldDiv">
                                    <span class="IASFormDivSpanLabel">
                                        <label>Cheque Number:</label>
                                    </span>
                                    <span class="IASFormDivSpanInputBox">
                                        <input class="IASTextBox" TABINDEX="2" type="text" name="chequeNumber" id="chequeNumber" value=""/>
                                    </span>
                                </div>
                            </div>


                            <%-- Search Criteria right div --%>
                            <div class="IASFormRightDiv">


                                <div class="IASFormFieldDiv">
                                    <span class="IASFormDivSpanLabel">
                                        <label>City:</label>
                                    </span>
                                    <span class="IASFormDivSpanInputBox">
                                        <input class="IASTextBox" TABINDEX="3" type="text" name="city" id="city" value=""/>
                                    </span>
                                </div>


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
                                           <a href="#" onClick="calPopup.select(document.searchInwardForm.fromDate,'anchor1','dd/MM/yyyy');
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
                                           <a href="#" onClick="calPopup.select(document.searchInwardForm.toDate,'anchor2','dd/MM/yyyy');
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
                            <legend>Search Result</legend>

                            <table class="datatable">
                                <thead>
                                    <tr>
                                        <td>Select</td>
                                        <td>Inward Number</td>
                                        <td>Received Date</td>
                                        <td>From</td>
                                        <td>City</td>
                                        <td>Cheque#</td>
                                        <td>Purpose</td>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td><input type="radio" id="123" name="Inward"/></td>
                                        <td>123</td>
                                        <td>12/10/2011</td>
                                        <td>ABC Book Store</td>
                                        <td>Bangalore</td>
                                        <td>176787</td>
                                        <td>New Subscription</td>

                                    </tr>
                                    <tr>
                                        <td><input type="radio" id="124" name="Inward"/></td>
                                        <td>124</td>
                                        <td>13/10/2011</td>
                                        <td>Book Store</td>
                                        <td>Bangalore</td>
                                        <td>176787</td>
                                        <td>New Subscription</td>
                                    </tr>
                                </tbody>
                            </table>
                        </fieldset>
                        <fieldset class="subMainFieldSet">
                            <div class="IASFormFieldDiv">
                                <div class="singleActionBtnDiv">
                                    <input class="IASButton" TABINDEX="8" type="submit" value="Next" id="btnNext" name="btnNext"/>
                                </div>
                            </div>
                        </fieldset>
                    </fieldset>
                </div>
            </form>
        </div>
        <script type="text/javascript">
            function setInward(e){
                document.getElementById("selectedInward").value = e.target.id;
            }
            var inwards = document.getElementsByName("Inward");
            for(var i=0;i<inwards.length;i++){
                inwards[i].addEventListener("click", setInward, true);
            }
        </script>
    </body>
</html>