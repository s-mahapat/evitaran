<%--
    Document   : Search Agent
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="../templates/style.jsp" %>
        <link rel="stylesheet" type="text/css" href="css/masterdata/agent.css" />

        <title>Search Agent</title>

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
            <form method="post" action="" name="searchAgentForm">
                <div class="MainDiv">
                    <fieldset class="MainFieldset">
                        <legend>Search Agent</legend>

                        <%-----------------------------------------------------------------------------------------------------%>
                        <%-- Search Criteria Field Set --%>
                        <%-----------------------------------------------------------------------------------------------------%>
                        <fieldset class="subMainFieldSet">
                            <legend>Search Criteria</legend>

                            <%-- Search Criteria left div --%>
                            <div class="IASFormLeftDiv">


                                <div class="IASFormFieldDiv">
                                    <span class="IASFormDivSpanLabel">
                                        <label>Agent Name:</label>
                                    </span>
                                    <span class="IASFormDivSpanInputBox">
                                        <input class="IASTextBox" TABINDEX="1" type="text" name="agentName" id="agentName" value=""/>
                                    </span>
                                </div>


                                <div class="IASFormFieldDiv">
                                    <span class="IASFormDivSpanLabel">
                                        <label>address:</label>
                                    </span>
                                    <span class="IASFormDivSpanInputBox">
                                        <input class="IASTextBox" TABINDEX="2" type="text" name="address" id="address" value=""/>
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
                                        <label>Reg. Date Range:</label>
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
                                        <td>Agent Id</td>
                                        <td>Agent Name</td>
                                        <td>Registration Date</td>
                                        <td>Address</td>
                                        <td>City</td>
                                        <td>Pin code</td>
                                        <td>email id</td>
                                        <td>View/Edit</td>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>123</td>
                                        <td>LM Book Stores</td>
                                        <td>12/10/2011</td>
                                        <td>M G Road</td>
                                        <td>Bangalore</td>
                                        <td>5600045</td>
                                        <td>lmbooks@gmail.com</td>
                                        <td><a href="<%=request.getContextPath() + "/agent?action=view"%>">view</a><a href="<%=request.getContextPath() + "/agent?action=edit"%>">edit</a></td>
                                    </tr>
                                    <tr>
                                        <td>55</td>
                                        <td>Sapna Book House</td>
                                        <td>19/09/2009</td>
                                        <td>M G Road</td>
                                        <td>New Delhi</td>
                                        <td>4500022</td>
                                        <td>info@sapna.co.in</td>
                                        <td><a href="<%=request.getContextPath() + "/agent?action=view"%>">view</a><a href="<%=request.getContextPath() + "/agent?action=edit"%>">edit</a></td>
                                    </tr>
                                    <tr>
                                        <td>100</td>
                                        <td>Books N Books</td>
                                        <td>12/10/2010</td>
                                        <td>M G Road</td>
                                        <td>Mumbai</td>
                                        <td>560045</td>
                                        <td>inquiry@booksnbooks.com</td>
                                        <td><a href="<%=request.getContextPath() + "/agent?action=view"%>">view</a><a href="<%=request.getContextPath() + "/agent?action=edit"%>">edit</a></td>
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