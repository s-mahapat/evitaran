
<%@page import="IAS.Bean.Inward.inwardFormBean"%>
<jsp:useBean class="IAS.Bean.Subscriber.subscriberFormBean" id="subscriberFormBean" scope="request"></jsp:useBean>
<%
    inwardFormBean _inwardFormBean = (inwardFormBean) request.getSession().getAttribute("inwardUnderProcess");
    String inwardNumber = _inwardFormBean.getInwardNumber();
    float amount = _inwardFormBean.getAmount();
    String agent = _inwardFormBean.getAgentName() != null ? _inwardFormBean.getAgentName() : "";
    int agent_id = _inwardFormBean.getAgentID();
    //String inwardPurpose = request.getParameter("purpose");
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
        <script type="text/javascript" src="js/jquery/jquery.multiselect.min.js"></script>
        <link rel="stylesheet" type="text/css" href="<%=request.getContextPath() + "/css/jquery/jquery.multiselect.css"%>"/>
        <script type="text/javascript">
            var duplicates = false;
            $(document).ready(function(){
                $("#purpose").val(<%=request.getParameter("purpose")%>);
            });
        </script>

    </head>
    <body>
        <%@include file="../templates/layout.jsp" %>
        <div id="bodyContainer">
            <form id="subscriptionForm" name="subscriptionForm" action="inward?action=followOnProcess" method="POST">
                <input type="hidden" name="purpose" id="purpose" value="<%=request.getParameter("purpose")%>"/>
                <input type="hidden" name="subid" id="subid" value="${subscriberFormBean.subscriberID}"/>
                <input type="hidden" name="inwardNumber" id="inwardNumber" value="<%=inwardNumber%>"/>
                <input type="hidden" name="subscriberNumber" id="subscriberNumber" value="${subscriberFormBean.subscriberNumber}"/>
                <input type="hidden" name="agentid" id="agentid" value="<%=agent_id%>"/>
                <input type="hidden" name="balance" id="balance" value="0"/>
                <input type="hidden" name="createAgntSubscription" id="createAgntSubscription" value="<%=request.getParameter("createAgntSubscription")%>"/>
                <div class="MainDiv">
                    <fieldset class="MainFieldset">
                        <legend>Add New Subscription</legend>
                        <fieldset class="subMainFieldSet">
                            <legend>Subscription Details</legend>

                            <div class="IASFormLeftDiv">
                                <div class="IASFormFieldDiv">
                                    <span class="IASFormDivSpanLabel">
                                        <label for="subscriberNumber">Subscriber No:</label>
                                    </span>

                                    <span class="IASFormSpanLabelData">
                                        <label name="subscriberNumber" id="subscriberNumberLabel">${subscriberFormBean.subscriberNumber}</label>
                                    </span>
                                </div>
                                <div class="IASFormFieldDiv">
                                    <span class="IASFormDivSpanLabel">
                                        <label>Subscriber Name:</label>
                                    </span>

                                    <span class="IASFormSpanLabelData">
                                        <label name="subscriberName" id="subscriberName">${subscriberFormBean.subscriberName} (${subscriberFormBean.subtypecode})</label>
                                    </span>
                                </div>
                                <div class="IASFormFieldDiv">
                                    <span class="IASFormDivSpanLabel">
                                        <label>Inward Number:</label>
                                    </span>

                                    <span class="IASFormSpanLabelData">
                                        <label id="inwardNumberlabel"><%=inwardNumber%></label>
                                    </span>
                                </div>

                            </div>

                            <div class="IASFormRightDiv">
                                <div class="IASFormFieldDiv">
                                    <span class="IASFormDivSpanLabel">
                                        <label>Inward Amount:</label>
                                    </span>

                                    <span class="IASFormSpanLabelData">
                                        <label name="amount" id="amount"><%=amount%></label>
                                    </span>
                                </div>
                                <div class="IASFormFieldDiv">
                                    <span class="IASFormDivSpanLabel">
                                        <label>Agent:</label>
                                    </span>

                                    <span class="IASFormSpanLabelData">
                                        <label name="agent" id="agent"><%=agent%></label>
                                    </span>
                                </div>
                                <div class="IASFormFieldDiv">
                                    <span class="IASFormDivSpanLabel">
                                        <label>Balance:</label>
                                    </span>

                                    <span class="IASFormSpanLabelData">
                                        <label name="balancelabel" id="balancelabel"></label>
                                    </span>
                                </div>
                            </div>

                        </fieldset>
                        <%@include file="addjournal.jsp"%>
                        <fieldset class="subMainFieldSet">

                            <div class="actionBtnDiv">
                                <input type="hidden" name="action" id="action"/>
                                <button onclick="saveSubscription()" class="IASButton SaveButton" TABINDEX="101" type="button" value="Save" id="btnSaveSubscription" name="btnSubmitAction"/>Save</button>
                            </div>

                        </fieldset>
                    </fieldset>
                </div>
            </form>
        </div>
    </body>
</html>