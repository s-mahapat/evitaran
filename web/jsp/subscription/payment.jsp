<%--
    Document   : payment
    Created on : Dec 19, 2012, 7:14:36 PM
    Author     : smahapat
--%>
<jsp:useBean class="IAS.Bean.Inward.inwardFormBean" id="inwardFormBean" scope="request"></jsp:useBean>
<jsp:useBean class="IAS.Bean.Subscriber.subscriberFormBean" id="subscriberFormBean" scope="request"></jsp:useBean>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="../templates/style.jsp" %>
        <script type="text/javascript" src="<%=request.getContextPath() + "/js/subscription/payment.js"%>"></script>
        <title>Subscription Payment</title>
        <script type="text/javascript">
            $(document).ready(function(){
                var inward_amount = ${inwardFormBean.amount};
                drawPaymentTable(inward_amount);
            });
        </script>
    </head>
    <body>
        <%@include file="../templates/layout.jsp" %>
        <div id="bodyContainer">
            <form method="POST" action="inward?action=followOnProcess" name="paymentForm">
                <input type="hidden" id="subtypeid" value="${subscriberFormBean.subtypeID}">
                <div class="MainDiv">
                    <fieldset class="MainFieldset">
                        <legend>Payment</legend>
                        <fieldset class="subMainFieldSet">
                            <div class="IASFormLeftDiv">
                                <div class="IASFormFieldDiv">
                                    <span class="IASFormDivSpanLabel">
                                        <label>Subscriber No:</label>
                                    </span>

                                    <span class="IASFormDivSpanInputBox">
                                        <input class="IASDisabledTextBox" TABINDEX="1" readonly type="text" name="subscriberNumber" id="subscriberNumber" value="${subscriberFormBean.subscriberNumber}"/>
                                    </span>

                                    <span class="IASFormDivSpanLabelLeftAligned">
                                        <label>Subscriber Type: ${subscriberFormBean.subtypecode}</label>
                                    </span>
                                </div>
                                <div class="IASFormFieldDiv">
                                    <span class="IASFormDivSpanLabel">
                                        <label>Subscriber Name:</label>
                                    </span>

                                    <span class="IASFormDivSpanInputBox">
                                        <input class="IASDisabledTextBoxWide" TABINDEX="-1" readonly type="text" name="subscriberName" id="subscriberName" value="${subscriberFormBean.subscriberName}"/>
                                    </span>
                                </div>

                            </div>

                            <div class="IASFormRightDiv">

                                <div class="IASFormFieldDiv">
                                    <span class="IASFormDivSpanLabel">
                                        <label>Inward Number:</label>
                                    </span>

                                    <span class="IASFormDivSpanInputBox">
                                        <input type="hidden" disabled name="inwardID" id="inwardID" value="${inwardFormBean.inwardID}"/>
                                        <input type="hidden" name="purpose" id="purpose" value="${inwardFormBean.inwardPurposeID}"/>
                                        <input class="IASDisabledTextBox" TABINDEX="-1" readonly type="text" name="inwardNumber" id="inwardNumber" value="${inwardFormBean.inwardNumber}"/>
                                    </span>
                                </div>

                                <div class="IASFormFieldDiv">
                                    <span class="IASFormDivSpanLabel">
                                        <label>Inward Amount:</label>
                                    </span>

                                    <span class="IASFormDivSpanInputBox">
                                        <input class="IASDisabledTextBox" TABINDEX="-1" readonly type="text" name="amount" id="amount" value="${inwardFormBean.amount}"/>
                                    </span>
                                </div>
                            </div>

                        </fieldset>
                        <fieldset class="subMainFieldSet">
                            <table class="datatable" id="paymentTable"></table>
                            <div id="pager"></div>
                        </fieldset>
                        <fieldset class="subMainFieldSet">
                            <div class="actionBtnDiv">
                                <input class="IASButton" TABINDEX="1" type="submit" value="Save"/>
                            </div>
                        </fieldset>
                    </fieldset>
                </div>
            </form>
        </div>
    </body>
</html>
