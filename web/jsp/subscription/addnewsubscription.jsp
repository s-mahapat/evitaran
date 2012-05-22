
<%@page import="IAS.Bean.Inward.inwardFormBean"%>
<jsp:useBean class="IAS.Bean.Subscriber.subscriberFormBean" id="subscriberFormBean" scope="request"></jsp:useBean>
<%
    inwardFormBean _inwardFormBean = (inwardFormBean)request.getSession().getAttribute("inwardUnderProcess");
    String inwardNumber = _inwardFormBean.getInwardNumber();
    float amount = _inwardFormBean.getAmount();
    String inwardPurpose = request.getParameter("purpose");

%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <jsp:include page="../templates/style.jsp"></jsp:include>
        <link rel="stylesheet" type="text/css" href="<%=request.getContextPath() + "/css/subscription.css"%>"/>
        <title>Add New Subscription</title>
        <script type="text/javascript" src="js/common.js"></script>
        <script type="text/javascript" src="<%=request.getContextPath() + "/js/subscription/addnewsubscription.js"%>"></script>
        <script type="text/javascript" src="<%=request.getContextPath() + "/js/subscription/subscription.js"%>"></script>
        <script type="text/javascript" src="<%=request.getContextPath() + "/js/jquery/jquery.blockUI.js"%>"></script>
        <script type="text/javascript">
            $(document).ready(function(){
                $().ajaxStart($.blockUI).ajaxStop($.unblockUI);
                listSubscription("View");
                $("#purpose").val(<%=request.getParameter("purpose")%>);
            })
        </script>
    </head>
    <body>
        <%@include file="../templates/layout.jsp" %>
        <div id="bodyContainer">
            <form name="subscriptionForm" action="inward?action=followOnProcess" method="POST">
                <input type="hidden" name="purpose" id="purpose" value="<%=request.getParameter("purpose")%>"/>

                <div class="MainDiv">
                    <fieldset class="MainFieldset">
                        <legend>Add New Subscription</legend>
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
                                        <input class="IASDisabledTextBox" TABINDEX="-1" readonly type="text" name="subscriberName" id="subscriberName" value="${subscriberFormBean.subscriberName}"/>
                                    </span>
                                </div>
                                <div class="IASFormFieldDiv">
                                    <span class="IASFormDivSpanLabel">
                                        <label>Inward Number:</label>
                                    </span>

                                    <span class="IASFormDivSpanInputBox">
                                        <input class="IASDisabledTextBox" TABINDEX="-1" readonly type="text" name="inwardNumber" id="inwardNumber" value="<%=inwardNumber%>"/>
                                    </span>
                                </div>
                                    <div class="IASFormFieldDiv">
                                    <span class="IASFormDivSpanLabel">
                                        <label>Inward Amount:</label>
                                    </span>

                                    <span class="IASFormDivSpanInputBox">
                                        <input class="IASDisabledTextBox" TABINDEX="-1" readonly type="text" name="amount" id="amount" value="<%=amount%>"/>
                                    </span>
                                </div>
                            </div>

                            <div class="IASFormRightDiv">
                                <div class="IASFormFieldDiv">
                                    <span class="IASFormDivSpanLabel">
                                        <label>Subscription Number:</label>
                                    </span>

                                    <span class="IASFormDivSpanInputBox">
                                        <input class="IASDisabledTextBox" TABINDEX="4" readonly type="text" name="subscriptionNumber" id="subscriptionNumber" value=""/>
                                    </span>
                                </div>
                                <div class="IASFormFieldDiv">
                                    <span class="IASFormDivSpanLabel">
                                        <label>Remarks</label>
                                    </span>

                                    <span class="IASFormDivSpanInputBox">
                                        <textarea class="IASTextArea" TABINDEX="5" cols="20" rows="10" name="remarks" id="remarks"></textarea>
                                    </span>
                                </div>
                            </div>

                        </fieldset>
                        <%@include file="selectjournal.jsp"%>
                        <fieldset class="subMainFieldSet">

                            <div class="actionBtnDiv">
                                <input type="hidden" name="action" id="action"/>
                                <input onclick="saveSubscription()" class="IASButton" TABINDEX="101" type="button" value="Save" id="btnSaveSubscription" name="btnSubmitAction"/>
                            </div>

                        </fieldset>
                    </fieldset>
                </div>
            </form>
        </div>
    </body>
</html>