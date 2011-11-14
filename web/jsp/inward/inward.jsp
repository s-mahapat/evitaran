
<%-- Calendar --%>
<%--------------------------------------------------------------%>
<script src="<%=request.getContextPath() + "/js/CalendarPopup.js"%>" type="text/javascript"></script>
<script type="text/javascript">
    var calFrom = new CalendarPopup("dateDiv");
    calFrom.showNavigationDropdowns();
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
                <label>Email:</label>
            </span>
            <span class="IASFormDivSpanInputBox">
                <input class="IASEmailTextBox" TABINDEX="3" type="text" name="email" id="email" value=""/>
            </span>
        </div>

        <div class="IASFormFieldDiv">
            <span class="IASFormDivSpanLabel">
                <label>Pincode:</label>
            </span>
            <span class="IASFormDivSpanInputBox">
                <input class="IASEmailTextBox" TABINDEX="4" type="text" name="pincode" id="pincode" value=""/>
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
                <input class="IASTextBox" readonly type="text" name="inwardNumber" id="inwardNumber" value=""/>
            </span>
        </div>


        <div class="IASFormFieldDiv">
            <span class="IASFormDivSpanLabel">
                <label>Creation Date:</label>
            </span>
            <span class="IASFormDivSpanInputBox">
                <input class="IASDateTextBox" readonly type="text" name="inwardCreationDate" id="inwardCreationDate" value=""/>
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
                <input class="IASButton" TABINDEX="16" type="button" value="Search Subscriber"
                       name="btnSearchSubscriber" id="btnSearchSubscriber" onclick="validateSearchSubscriber()"/>
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
                    <option value ="IASAgent">Create New Subscription</option>
                    <option value ="IASAgent">Renew Subscription</option>
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
                </select>
            </span>
        </div>


        <div class="IASFormFieldDiv">
            <span class="IASFormDivSpanLabel">
                <label>Payment Date:</label>
            </span>
            <span class="IASFormDivSpanInputBox">
                <input class="IASDateTextBox" readonly size="10" value="" id="paymentDate"/>
                <a href="#" onClick="calFrom.select(document.inwardForm.paymentDate,'anchor1','dd/MM/yyyy'); return false;" NAME="anchor1" ID="anchor1">
                    <img class="calendarIcon" alt="select" src="" TABINDEX="6"/>
                </a>
            </span>
            <div class="dateDiv" id="dateDiv"></div>
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
                <input class="IASCheckBox" TABINDEX="9" type="checkbox" name="checkReturn" id="checkReturn"/>
            </span>
        </div>

        <div class="IASFormFieldDiv">
            <span class="IASFormDivSpanLabel">
                <label>Reason:</label>
            </span>
            <span class="IASFormDivSpanInputBox">
                <select class="IASComboBox" TABINDEX="10" type="checkbox" name="checkReturnReason" id="checkReturnReason">
                    <option value="0">Select</option>
                    <option value="Other">Other</option>
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
    <div class="IASFormFieldDiv">
        <!--<div id="nextBtnDiv">
            <input class="IASButton" TABINDEX="12" type="submit" value="Next" name="btnNext"/>
        </div>
        <div id="processInwardBtnDiv">
            <input class="IASButton" TABINDEX="14" type="submit" value="Process Inward" name="btnProcessInward"/>
        </div>
        -->
        <div id="editInwardBtnDiv">
            <input class="IASButton" TABINDEX="14" type="button" value="Edit Inward" id="btnEditInward" name="btnEditInward"/>
        </div>
        <div id="saveBtnDiv">
            <input class="IASButton" TABINDEX="13" type="submit" value="Save" id="btnSave" name="btnSave"/>
        </div>

        <div id="sendAckBtnDiv">
            <input class="IASButton" TABINDEX="15" type="button" value="Send Acknowledgement" id="btnSendAck" name="btnSendAck"/>
        </div>
        <div id="sendReturnBtnDiv">
            <input class="IASButton" TABINDEX="16" type="button" value="Send Return" id="btnSendReturn" name="btnSendReturn"/>
        </div>
    </div>
</fieldset>

