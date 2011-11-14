<%--
    Document   : Search Subscriber
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="../templates/style.jsp" %>
        <link rel="stylesheet" type="text/css" href="<%=request.getContextPath() + "/css/subscriber.css"%>"/>
        <script type="text/javascript" src="<%=request.getContextPath() + "/js/subscriber/searchsubscriber.js"%>"></script>
        <title>Search Subscriber</title>

    </head>
    <body>
        <%@include file="../templates/layout.jsp" %>

        <div id="bodyContainer">
            <form method="post" action="<%=request.getContextPath() + "/subscriber"%>" name="searchInwardForm">
                <div class="MainDiv">
                    <fieldset class="MainFieldset">
                        <legend>Search Subscriber</legend>

                        <%-----------------------------------------------------------------------------------------------------%>
                        <%-- Search Criteria Field Set --%>
                        <%-----------------------------------------------------------------------------------------------------%>
                        <fieldset class="subMainFieldSet">
                            <legend>Search Criteria</legend>

                            <%-- Search Criteria left div --%>
                            <div class="IASFormLeftDiv">


                                <div class="IASFormFieldDiv">
                                    <span class="IASFormDivSpanLabel">
                                        <label>Subscriber Id:</label>
                                    </span>
                                    <span class="IASFormDivSpanInputBox">
                                        <input class="IASTextBox" TABINDEX="1" type="text" name="subscriberId" id="subscriberId" value=""/>
                                    </span>
                                </div>

                                <div class="IASFormFieldDiv">
                                    <span class="IASFormDivSpanLabel">
                                        <label>Subscriber Name:</label>
                                    </span>
                                    <span class="IASFormDivSpanInputBox">
                                        <input class="IASTextBox" TABINDEX="3" type="text" name="subscriberName" id="subscriberName" value=""/>
                                    </span>
                                </div>

                                <div class="IASFormFieldDiv">
                                    <span class="IASFormDivSpanLabel">
                                        <label>Email:</label>
                                    </span>
                                    <span class="IASFormDivSpanInputBox">
                                        <input class="IASEmailTextBox" TABINDEX="2" type="text" name="eMail" id="eMail" value=""/>
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
                                    <span class="IASFormDivSpanLabel">
                                        <label>Pin Code:</label>
                                    </span>
                                    <span class="IASFormDivSpanInputBox">
                                        <input class="IASTextBox" TABINDEX="3" type="text" name="pincode" id="pincode" value=""/>
                                    </span>
                                </div>

                            </div>

                            <div class="IASFormFieldDiv">                              
                                <div id="searchBtnDiv">
                                    <input class="IASButton" TABINDEX="6" type="button" value="Search" onclick="validateSearchSubscriber()"/>
                                </div>
                            </div>

                        </fieldset>

                        <fieldset class="subMainFieldSet">
                            <legend>Subscriber List</legend>

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
                                        <td>View/Edit</td>
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
                                        <td><a href="<%=request.getContextPath() + "/subscriber?action=display"%>">view</a>
                                            <a href="<%=request.getContextPath() + "/subscriber?action=edit"%>">edit</a></td>
                                    </tr>
                                    <tr>
                                        <td>2</td>
                                        <td>Shailendra Mahapatra</td>
                                        <td>IAS2</td>
                                        <td>Bangalore</td>
                                        <td>560067</td>
                                        <td>India</td>
                                        <td>shail@ias.com</td>
                                        <td><a href="<%=request.getContextPath() + "/subscriber?action=display"%>">view</a>
                                            <a href="<%=request.getContextPath() + "/subscriber?action=edit"%>">edit</a></td>
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