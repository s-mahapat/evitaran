<%--
    Document   : Add New Subscription
--%>
<jsp:useBean class="IAS.Bean.Subscriber.subscriberFormBean" id="subscriberFormBean" scope="request"></jsp:useBean>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <jsp:include page="../templates/style.jsp"></jsp:include>
        <link rel="stylesheet" type="text/css" href="<%=request.getContextPath() + "/css/subscription.css"%>"/>
        <title>Edit Subscription</title>
        <script type="text/javascript" src="js/common.js"></script>
        <script type="text/javascript" src="<%=request.getContextPath() + "/js/subscription/editsubscription.js"%>"></script>
        <script type="text/javascript" src="<%=request.getContextPath() + "/js/subscription/subscription.js"%>"></script>
        <script type="text/javascript" src="<%=request.getContextPath() + "/js/jquery/jquery.blockUI.js"%>"></script>
        <script type="text/javascript">
            $(document).ready(function(){
                $().ajaxStart($.blockUI).ajaxStop($.unblockUI);
                getSubscriptionInfo();
            })
        </script>
    </head>
    <body>
        <%@include file="../templates/layout.jsp" %>
        <div id="bodyContainer">
            <form name="subscriptionForm">

                <div class="MainDiv">
                    <fieldset class="MainFieldset">
                        <legend>Edit Subscription</legend>
                        <fieldset class="subMainFieldSet">
                            <legend>Subscription Details</legend>

                            <div class="IASFormLeftDiv">
                                <div class="IASFormFieldDiv">
                                    <span class="IASFormDivSpanLabel">
                                        <label>Subscriber ID:</label>
                                    </span>

                                    <span class="IASFormDivSpanInputBox">
                                        <input class="IASDisabledTextBox" TABINDEX="1" readonly type="text" name="subscriberNumber" id="subscriberNumber" value="${subscriberFormBean.subscriberNumber}"/>
                                    </span>
                                </div>
                                <div class="IASFormFieldDiv">
                                    <span class="IASFormDivSpanLabel">
                                        <label>Subscriber Name:</label>
                                    </span>

                                    <span class="IASFormDivSpanInputBox">
                                        <input class="IASDisabledTextBoxWide" TABINDEX="2" readonly type="text" name="subscriberName" id="subscriberName" value="${subscriberFormBean.subscriberName}"/>
                                    </span>
                                </div>
                                <div class="IASFormFieldDiv">
                                    <span class="IASFormDivSpanLabel">
                                        <label>Subscription ID:</label>
                                    </span>

                                    <span class="IASFormDivSpanInputBox">
                                        <input class="IASDisabledTextBox" TABINDEX="3" readonly type="text" name="subscriptionID" id="subscriptionID" value="<%=request.getParameter("id")%>"/>
                                    </span>
                                </div>
                                <div class="IASFormFieldDiv">
                                    <span class="IASFormDivSpanLabel">
                                        <label>Agent:</label>
                                    </span>

                                    <span class="IASFormDivSpanInputBox">
                                        <input class="IASDisabledTextBox" TABINDEX="4" readonly type="text" name="agentName" id="agentName" value=""/>
                                    </span>
                                </div>
                            </div>

                            <div class="IASFormRightDiv">
                                <div class="IASFormFieldDiv">
                                    <span class="IASFormDivSpanLabel">
                                        <label>Inward Number:</label>
                                    </span>

                                    <span class="IASFormDivSpanInputBox">
                                        <input class="IASDisabledTextBox" TABINDEX="-1" readonly type="text" name="inwardNumber" id="inwardNumber" value=""/>
                                    </span>
                                </div>
                                <div class="IASFormFieldDiv">
                                    <span class="IASFormDivSpanLabel">
                                        <label>Amount Paid:</label>
                                    </span>

                                    <span class="IASFormDivSpanInputBox">
                                        <input class="IASDisabledTextBox" TABINDEX="-1" readonly type="text" name="amount" id="amount" value=""/>
                                    </span>
                                </div>
                                <div class="IASFormFieldDiv">
                                    <span class="IASFormDivSpanLabel">
                                        <label>Subscription Total(INR):</label>
                                    </span>

                                    <span class="IASFormDivSpanInputBox">
                                        <input class="IASDisabledTextBox" TABINDEX="-1" readonly type="text" name="subscriptionTotalValue" id="subscriptionTotalValue" value=""/>
                                    </span>
                                </div>
                                <div class="IASFormFieldDiv">
                                    <span class="IASFormDivSpanLabel">
                                        <label>Balance(INR):</label>
                                    </span>

                                    <span class="IASFormDivSpanInputBox">
                                        <input class="IASDisabledTextBox" TABINDEX="-1" readonly type="text" name="balance" id="balance" value=""/>
                                    </span>
                                </div>

                            </div>

                        </fieldset>

                        <%@include file="editjournal.jsp"%>
                         <%--<fieldset class="subMainFieldSet">
                            <div class="actionBtnDiv">
                                <input onclick="saveSubscription()" class="IASButton" TABINDEX="101" type="button" value="Save" id="btnSaveSubscription" name="btnSubmitAction"/>
                            </div>
                        </fieldset>--%>
                    </fieldset>
                </div>
            </form>
        </div>
    </body>
</html>