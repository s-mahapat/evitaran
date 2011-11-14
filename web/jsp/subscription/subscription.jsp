<%--
    Document   : Subscription
--%>
<fieldset class="subMainFieldSet">
    <legend>Subscription Details</legend>

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
                <label>Start Year:</label>
            </span>

            <span class="IASFormDivSpanInputBox">
                <select class="IASComboBox" TABINDEX="11" name="subscriptionStartYear" id="subscriptionStartYear">
                    <option value ="IASAgent">2007</option>
                    <option value ="IASAgent">2008</option>
                </select>
            </span>
        </div>
    </div>

    <div class="IASFormRightDiv">

        <div class="IASFormFieldDiv">
            <span class="IASFormDivSpanLabel">
                <label>Refund(If any):</label>
            </span>

            <span class="IASFormDivSpanInputBox">
                <input class="IASTextBox" TABINDEX="13" type="text" name="subscriptionRefund" id="subscriptionRefund" value=""/>
            </span>

            <span class="IASFormDivSpanLabel">
                <input class="IASButton" TABINDEX="14" type="submit" value="Calculate Refund" id="btnSubscriptionRefund" name="btnSubscriptionRefund"/>
            </span>
        </div>

        <div class="IASFormFieldDiv">
            <span class="IASFormDivSpanLabel">
                <label>Remarks</label>
            </span>

            <span class="IASFormDivSpanInputBox">
                <textarea class="IASTextArea" TABINDEX="12" name="subscriberRemarks" id="subscriberRemarks"></textarea>
            </span>
        </div>
    </div>

    <table class="datatable" TABINDEX="15">
        <thead>
            <tr>
                <td>Select</td>
                <td>Journal Code</td>
                <td>Journal Name</td>
                <td>Number Of Copies</td>
                <td>Number Of Year</td>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td><input class="IASCheckBox" type="checkbox" name="Select Journal" value=" "/></td>
                <td>1</td>
                <td>Pramana1</td>
                <td>2</td>
                <td>3</td>
            </tr>
            <tr>
                <td><input class="IASCheckBox" type="checkbox" name="Select Journal" value=" "/></td>
                <td>1</td>
                <td>Pramana2</td>
                <td>2</td>
                <td>1</td>
            </tr>
        </tbody>
    </table>
</fieldset>

<fieldset class="subMainFieldSet">

    <div class="IASFormFieldDiv">
        <input type="hidden" name="action" id="action"/>
        <div id="displaySubscriptionBtnDiv">
            <input onclick="setActionValue('view')" class="IASButton" TABINDEX="101" type="submit" value="View Subscription" id="btnViewSubscription" name="btnSubmitAction"/>
        </div>

        <div id="saveSubscriptionBtnDiv">
            <input onclick="setActionValue('save')"  class="IASButton" TABINDEX="101" type="submit" value="Save" id="btnSaveSubscription" name="btnSubmitAction"/>
        </div>

        <div id="editSubscriptionBtnDiv">
            <input onclick="setActionValue('edit')" class="IASButton" TABINDEX="101" type="submit" value="Edit Subscription" id="btnEditSubscription" name="btnSubmitAction"/>
        </div>
    </div>

</fieldset>