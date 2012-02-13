<%--
    Document   : Subscription
--%>
<jsp:useBean class="IAS.Bean.Subscriber.subscriberFormBean" id="subscriberFormBean" scope="request"></jsp:useBean>
<fieldset class="subMainFieldSet">
    <legend>Subscription Details</legend>

    <div class="IASFormLeftDiv">
        <div class="IASFormFieldDiv">
            <span class="IASFormDivSpanLabel">
                <label>Subscriber ID:</label>
            </span>

            <span class="IASFormDivSpanInputBox">
                <input class="IASTextBox" TABINDEX="1" readonly type="text" name="subscriberNumber" id="subscriberNumber" value="${subscriberFormBean.subscriberNumber}"/>
            </span>
        </div>


        <div class="IASFormFieldDiv">
            <span class="IASFormDivSpanLabel">
                <label>Subscriber Name:</label>
            </span>

            <span class="IASFormDivSpanInputBox">
                <input class="IASTextBox" TABINDEX="2" readonly type="text" name="subscriberName" id="subscriberName" value="${subscriberFormBean.subscriberName}"/>
            </span>
        </div>
    </div>

    <div class="IASFormRightDiv">

       <%-- <div class="IASFormFieldDiv">
            <span class="IASFormDivSpanLabel">
                <label>Refund(If any):</label>
            </span>

            <span class="IASFormDivSpanInputBox">
                <input class="IASTextBox" TABINDEX="13" type="text" name="subscriptionRefund" id="subscriptionRefund" value=""/>
            </span>

            <span class="IASFormDivSpanLabel">
                <input class="IASButton" TABINDEX="14" type="submit" value="Calculate Refund" id="btnSubscriptionRefund" name="btnSubscriptionRefund"/>
            </span>
        </div>--%>

        <div class="IASFormFieldDiv">
            <span class="IASFormDivSpanLabel">
                <label>Remarks</label>
            </span>

            <span class="IASFormDivSpanInputBox">
                <textarea class="IASTextArea" TABINDEX="12" name="remarks" id="remarks"></textarea>
            </span>
        </div>
    </div>

</fieldset>

