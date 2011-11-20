<%--
    Document   : Print Subscriber List
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="../templates/style.jsp" %>
        <link rel="stylesheet" type="text/css" href="css/report/subscriber.css" />

        <title>List subscriber</title>
    </head>
    <body>
        <%@include file="../templates/layout.jsp" %>

        <div id="bodyContainer">
            <form method="post" action="" name="searchSubTypeForm">
                <div class="MainDiv">
                    <fieldset class="MainFieldset">
                        <legend>List and Print Subscriber</legend>

                        <%-----------------------------------------------------------------------------------------------------%>
                        <%-- Search Criteria Field Set --%>
                        <%-----------------------------------------------------------------------------------------------------%>
                        <div class="IASFormLeftDiv">

                            <div class="IASFormFieldDiv">
                                <span class="IASFormDivSpanLabel">
                                    <label>Subscriber ID:</label>
                                </span>

                                <span class="IASFormDivSpanInputBox">
                                    <input class="IASTextBox" TABINDEX="1" type="text" name="subscriberID" id="subscriberID" value=""/>
                                </span>
                            </div>


                            <div class="IASFormFieldDiv">
                                <span class="IASFormDivSpanLabel">
                                    <label>Subscriber Name:</label>
                                </span>

                                <span class="IASFormDivSpanInputBox">
                                    <input class="IASTextBox" TABINDEX="2" type="text" name="subscriberName" id="subscriberName" value=""/>
                                </span>
                            </div>


                            <div class="IASFormFieldDiv">
                                <span class="IASFormDivSpanLabel">
                                    <label>Address:</label>
                                </span>

                                <span class="IASFormDivSpanInputBox">
                                    <textarea class="IASTextArea" TABINDEX="3" name="subscriberAddress" id="subscriberAddress"></textarea>
                                </span>
                            </div>


                            <div class="IASFormFieldDiv">
                                <span class="IASFormDivSpanLabel">
                                    <label>City:</label>
                                </span>

                                <span class="IASFormDivSpanInputBox">
                                    <input class="IASTextBox" TABINDEX="4" type="text" name="subscriberCity" id="subscriberCity" value=""/>
                                </span>
                            </div>


                            <div class="IASFormFieldDiv">
                                <span class="IASFormDivSpanLabel">
                                    <label>Pin Code:</label>
                                </span>

                                <span class="IASFormDivSpanInputBox">
                                    <input class="IASTextBox" TABINDEX="5" type="text" name="subscriberPinCode" id="subscriberPinCode" value=""/>
                                </span>
                            </div>


                            <div class="IASFormFieldDiv">
                                <span class="IASFormDivSpanLabel">
                                    <label>Subscriber Type:</label>
                                </span>

                                <span class="IASFormDivSpanInputBox">
                                    <select class="IASComboBox" TABINDEX="6" name="subscriberType" id="subscriberType">
                                        <option value ="test1">Free Subscriber</option>
                                    </select>
                                </span>
                            </div>

                        </div>

                        <div class="IASFormRightDiv">

                            <div class="IASFormFieldDiv">
                                <span class="IASFormDivSpanLabel">
                                    <label>Creation Date:</label>
                                </span>

                                <span class="IASFormDivSpanInputBox">
                                    <input class="IASDateTextBox" readonly type="text" name="creationDate" id="creationDate" value=""/>
                                </span>
                            </div>


                            <div class="IASFormFieldDiv">
                                <span class="IASFormDivSpanLabel">
                                    <label>Department:</label>
                                </span>

                                <span class="IASFormDivSpanInputBox">
                                    <input class="IASTextBox" TABINDEX="7" type="text" name="department" id="department" value=""/>
                                </span>
                            </div>


                            <div class="IASFormFieldDiv">
                                <span class="IASFormDivSpanLabel">
                                    <label>Country:</label>
                                </span>

                                <span class="IASFormDivSpanInputBox">
                                    <select class="IASComboBox" TABINDEX="8" name="subscriberCountry" id="subscriberCountry">
                                        <option value ="India">India</option>
                                    </select>
                                </span>
                            </div>


                            <div class="IASFormFieldDiv">
                                <span class="IASFormDivSpanLabel">
                                    <label>Email:</label>
                                </span>

                                <span class="IASFormDivSpanInputBox">
                                    <input class="IASEmailTextBox" TABINDEX="9" type="text" name="subscriberEmail" id="subscriberEmail" value=""/>
                                </span>
                            </div>


                            <div class="IASFormFieldDiv">
                                <span class="IASFormDivSpanLabel">
                                    <label>Agent:</label>
                                </span>

                                <span class="IASFormDivSpanInputBox">
                                    <select class="IASComboBox" TABINDEX="10" name="subscriberAgent" id="subscriberAgent">
                                        <option value ="IASAgent">IASAgent</option>
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
                            <legend>Search Result</legend>

                        <table class="datatable">
                            <thead>
                                <tr>
                                    <td>Subscriber Id</td>
                                    <td>Subscriber Name</td>
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
                                    <td>IAS1</td>
                                    <td>Bangalore</td>
                                    <td>560066</td>
                                    <td>India</td>
                                    <td>pinki@ias.com</td>
                                </tr>
                                <tr>
                                    <td>2</td>
                                    <td>Shailendra Mahapatra</td>
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