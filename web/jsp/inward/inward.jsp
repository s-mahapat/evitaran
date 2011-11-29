
<%@page import="IAS.Class.util"%>
<%-- Calendar --%>
<%--------------------------------------------------------------%>
<script type="text/javascript" src="<%=request.getContextPath() + "/js/inward/inward.js"%>"></script>
<script type="text/javascript">
    jQueryCalendar("paymentdate");
</script>
<%-----------------------------------------------------------------------------------------------------%>
<%-- Inward Info Field Set --%>
<%-----------------------------------------------------------------------------------------------------%>
<fieldset class="subMainFieldSet">
    <legend>Inward Info</legend>

    <%-- Inward Info left div --%>
    <div class="IASFormLeftDiv">


        <div class="IASFormFieldDiv">
            <span class="IASFormDivSpanLabel">
                <label>From:</label>
            </span>
            <span class="IASFormDivSpanInputBox">
                <input class="IASTextBox" TABINDEX="1" type="text" name="from" id="from" value=""/>
            </span>
        </div>


        <div class="IASFormFieldDiv">
            <span class="IASFormDivSpanLabel">
                <label>City:</label>
            </span>
            <span class="IASFormDivSpanInputBox">
                <input class="IASTextBox" TABINDEX="2" type="text" name="city" id="city" value=""/>
            </span>
        </div>
        <div class="IASFormFieldDiv">
            <span class="IASFormDivSpanLabel">
                <label>Pincode:</label>
            </span>
            <span class="IASFormDivSpanInputBox">
                <input class="IASTextBox" TABINDEX="4" type="text" name="pincode" id="pincode" value=""/>
            </span>
        </div>

        <div class="IASFormFieldDiv">
            <span class="IASFormDivSpanLabel">
                <label>Email:</label>
            </span>
            <span class="IASFormDivSpanInputBox">
                <input class="IASEmailTextBox" TABINDEX="3" type="text" name="email" id="email" value=""/>
            </span>
        </div>


    </div>

    <%-- Inward Info right div --%>
    <div class="IASFormRightDiv">


        <div class="IASFormFieldDiv">
            <span class="IASFormDivSpanLabel">
                <label>Inward Number:</label>
            </span>
            <span class="IASFormDivSpanInputBox">
                <input class="IASTextBox" readonly disabled type="text" name="inwardNumber" id="inwardNumber" value=""/>
            </span>
        </div>


        <div class="IASFormFieldDiv">
            <span class="IASFormDivSpanLabel">
                <label>Creation Date:</label>
            </span>
            <span class="IASFormDivSpanInputBox">
                <input class="IASDateTextBox" readonly type="text" name="inwardCreationDate" id="inwardCreationDate" value="<%=IAS.Class.util.getDateString()%>"/>
            </span>
        </div>

        <div class="IASFormFieldDiv">
            <span class="IASFormDivSpanLabel">
                <label>Subscriber ID:</label>
            </span>
            <span class="IASFormDivSpanInputBox">
                <input class="IASTextBoxMandatory" readonly type="text" name="subscriberId" id="subscriberId" value=""/>
            </span>
            <span class="IASFormDivSpanInputBox">
                <input class="IASButton" TABINDEX="16" type="button" name="btnSearchSubscriber" id="btnSearchSubscriber" value="Search Subscriber" onclick="validateSearchSubscriber()"/>
            </span>

        </div>
    </div>
</fieldset>


<%-----------------------------------------------------------------------------------------------------%>
<%-- Inward Details Field Set --%>
<%-----------------------------------------------------------------------------------------------------%>
<fieldset class="subMainFieldSet">
    <legend>Inward Details</legend>

    <%-- Inward Info left div --%>
    <div class="IASFormLeftDiv">


        <div class="IASFormFieldDiv">
            <span class="IASFormDivSpanLabel">
                <label>Purpose:</label>
            </span>
            <span class="IASFormDivSpanInputBox">
                <select class="IASComboBox" TABINDEX="4" name="purpose" id="purpose">
                    <option value ="new">New Subscription</option>
                    <option value ="renew">Renew Subscription</option>
                    <option value ="IASAgent">Address Change</option>
                    <option value ="IASAgent">Request for Invoice</option>
                    <option value ="IASAgent" style="line-height: 2em">Missing Issue</option>
                    <option value ="IASAgent">Reprint</option>
                    <option value="advertisement">Advertisement</option>
                    <option value="manuscript">Manuscript</option>
                    <option value="cash">Cash</option>
                    <option value="others">Others</option>
                </select>
            </span>
        </div>


        <div class="IASFormFieldDiv">
            <span class="IASFormDivSpanLabel">
                <label>Mode Of Payment:</label>
            </span>
            <span class="IASFormDivSpanInputBox">
                <select class="IASComboBox" TABINDEX="5" name="modeOfPayment" id="modeOfPayment">
                    <option value ="IASAgent">Cheque</option>
                    <option value ="IASAgent">Money Order</option>
                    <option value ="IASAgent">Cash</option>
                    <option value ="IASAgent">Demand Draft</option>
                </select>
            </span>
        </div>


        <div class="IASFormFieldDiv">
            <span class="IASFormDivSpanLabel">
                <label>Payment Date:</label>
            </span>
            <div class="dateDiv" id="dateDiv"></div>
            <span class="IASFormDivSpanInputBox">
                <input type="text" class="IASDateTextBox" readonly size="10" name="paymentdate" id="paymentdate" value="<%=IAS.Class.util.getDateString()%>"/>
            </span>

        </div>


        <div class="IASFormFieldDiv">
            <span class="IASFormDivSpanLabel">
                <label>Amount:</label>
            </span>
            <span class="IASFormDivSpanInputBox">
                <input class="IASTextBox" TABINDEX="7" type="text" name="amount" id="amount" value=""/>
            </span>
        </div>


        <div class="IASFormFieldDiv">
            <span class="IASFormDivSpanLabel">
                <label>Currency:</label>
            </span>
            <span class="IASFormDivSpanInputBox">
                <select class="IASComboBox" TABINDEX="8" name="currency" id="currency">
                    <option value ="IASAgent">INR</option>
                    <option value ="IASAgent">USD</option>
                </select>
            </span>
        </div>


        <div class="IASFormFieldDiv">
            <span class="IASFormDivSpanLabel">
                <label>Cheque Return:</label>
            </span>
            <span class="IASFormDivSpanInputBox">
                <input class="IASCheckBox" TABINDEX="9" type="checkbox" name="checkReturn" id="checkReturn" onchange="enableCheckReturn()"/>
            </span>
        </div>

        <div class="IASFormFieldDiv">
            <span class="IASFormDivSpanLabel">
                <label>Reason For Return:</label>
            </span>
            <span class="IASFormDivSpanInputBox">
                <select class="IASComboBox" TABINDEX="10" type="checkbox" name="checkReturnReason" id="checkReturnReason">
                    <option value="0">Select</option>
                    <option value="1">Incorrect Name</option>
                    <option value="2">Bounced</option>
                    <option value="2">Other</option>
                </select>
            </span>
            <span class="IASFormDivSpanInputBox">
                <input class="IASTextBox" TABINDEX="11" type="text" name="checkReturnReasonOther" id="checkReturnReasonOther" value=""/>
            </span>
        </div>


        <div class="IASFormFieldDiv">
            <span class="IASFormDivSpanLabel">
                <label>Receipt Number:</label>
            </span>
            <span class="IASFormDivSpanInputBox">
                <input class="IASTextBox" TABINDEX="11" type="text" name="receiptNumber" id="receiptNumber" value=""/>
            </span>
        </div>
    </div>

    <%-- Inward Info right div --%>
    <div class="IASFormRightDiv">


        <div class="IASFormFieldDiv">
            <span class="IASFormDivSpanLabel">
                <label>Remarks:</label>
            </span>
            <span class="IASFormDivSpanInputBox">
                <textarea class="IASTextArea" TABINDEX="11" name="remarks" id="remarks"></textarea>
            </span>
        </div>
    </div>
</fieldset>


<%-----------------------------------------------------------------------------------------------------%>
<%-- Create Inward Actions Field Set --%>
<%-----------------------------------------------------------------------------------------------------%>
<fieldset class="subMainFieldSet">
    <div class="actionBtnDiv">
        <input onclick="setActionValue('edit')" class="IASButton" TABINDEX="12" type="submit" value="Edit Inward" id="btnEditInward" name="submitAction"/>
        <input onclick="setActionValue('save')" class="IASButton" TABINDEX="13" type="submit" value="Save" id="btnSaveInward" name="submitAction"/>
        <input onclick="setActionValue('sendAck')" class="IASButton" TABINDEX="14" type="submit" value="Send Acknowledgement" id="btnSendAck" name="submitAction"/>
        <input onclick="setActionValue('sendReturn')" class="IASButton" TABINDEX="15" type="submit" value="Send Return" id="btnSendReturn" name="submitAction"/>
    </div>
</fieldset>

