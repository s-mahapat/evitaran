<%@page import="IAS.Bean.inwardFormBean"%>
<%@page import="IAS.Class.util"%>
<%-- Calendar --%>
<%--------------------------------------------------------------%>
<script type="text/javascript" src="<%=request.getContextPath() + "/js/inward/inward.js"%>"></script>
<script type="text/javascript">
    $(document).ready(function() {
        jdsAutoComplete("/JDS/CMasterData?md=city","city","city");
        jdsAutoComplete("/JDS/CMasterData?md=country","country","country");
        jdsAutoComplete("/JDS/CMasterData?md=state","state","state");
        jdsAppend("/JDS/CMasterData?md=purpose","purpose","inwardPurpose");
        jdsAppend("/JDS/CMasterData?md=payment_mode","payment_mode","paymentMode");
        jdsAppend("/JDS/CMasterData?md=currency","currency","currency");
        jdsAppend("/JDS/CMasterData?md=return_reason","return_reason","checkReturnReason");
    });

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
                <input class="IASTextBoxMandatory" TABINDEX="1" type="text" name="from" id="from" value="<jsp:getProperty name="inwardFormBean" property="from"/>"/>
            </span>
        </div>
        <div class="IASFormFieldDiv">
            <span class="IASFormDivSpanLabel">
                <label>Country:</label>
            </span>
            <span class="IASFormDivSpanInputBox">
                <input class="IASTextBoxMandatory" TABINDEX="2" name="country" id="country" value="<jsp:getProperty name="inwardFormBean" property="country"/>">
            </span>
        </div>
        <div class="IASFormFieldDiv">
            <span class="IASFormDivSpanLabel">
                <label>State:</label>
            </span>
            <span class="IASFormDivSpanInputBox">
                <input class="IASTextBoxMandatory" TABINDEX="3" name="state" id="state" value="<jsp:getProperty name="inwardFormBean" property="state"/>">
            </span>
        </div>
        <div class="IASFormFieldDiv">
            <span class="IASFormDivSpanLabel">
                <label>City:</label>
            </span>
            <span class="IASFormDivSpanInputBox">
                <input class="IASTextBoxMandatory" TABINDEX="4" name="city" id="city" value="<jsp:getProperty name="inwardFormBean" property="city"/>">
            </span>
        </div>

        <div class="IASFormFieldDiv">
            <span class="IASFormDivSpanLabel">
                <label>PIN Code:</label>
            </span>
            <span class="IASFormDivSpanInputBox">
                <input class="IASTextBox" TABINDEX="5" type="text" name="pincode" id="pincode" value="${inwardFormBean.pincodeAsText}"/>
            </span>
        </div>

        <div class="IASFormFieldDiv">
            <span class="IASFormDivSpanLabel">
                <label>Email:</label>
            </span>
            <span class="IASFormDivSpanInputBox">
                <input class="IASEmailTextBox" TABINDEX="8" type="text" name="email" id="email" onblur="validateEmail(this.id)" value="${inwardFormBean.email}"/>
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
                <input class="IASTextBox" TABINDEX="-1" readonly disabled type="text" name="inwardNumber" id="inwardNumber" value="<jsp:getProperty name="inwardFormBean" property="inwardNumber"/>"/>
            </span>
        </div>


        <div class="IASFormFieldDiv">
            <span class="IASFormDivSpanLabel">
                <label>Inward Date:</label>
            </span>
            <span class="IASFormDivSpanInputBox">
                <input class="IASDateTextBox" TABINDEX="-1" readonly type="text" name="inwardCreationDate" id="inwardCreationDate" value="${inwardFormBean.inwardCreationDate}"/>
            </span>
        </div>

        <div class="IASFormFieldDiv">
            <span class="IASFormDivSpanLabel">
                <label>Subscriber ID:</label>
            </span>
            <span class="IASFormDivSpanInputBox">
                <input class="IASTextBox" TABINDEX="6" readonly type="text" name="subscriberId" id="subscriberId" value="${inwardFormBean.subscriberIdAsText}"/>
            </span>
            <span class="IASFormDivSpanInputBox">
                <input class="IASButton" TABINDEX="7" type="button" name="btnSearchSubscriber" id="btnSearchSubscriber" value="Search Subscriber" onclick="validateSearchSubscriber()"/>
            </span>

        </div>
        <div class="IASFormFieldDiv">
            <span class="IASFormDivSpanLabel">
                <label>Institution:</label>
            </span>
            <span class="IASFormDivSpanInputBox">
                <input class="IASTextBox" TABINDEX="5" type="text" name="institution" id="institution" value="${inwardFormBean.institution}"/>
            </span>
        </div>

        <div class="IASFormFieldDiv">
            <span class="IASFormDivSpanLabel">
                <label>Department:</label>
            </span>
            <span class="IASFormDivSpanInputBox">
                <input class="IASTextBox" TABINDEX="5" type="text" name="department" id="department" value="${inwardFormBean.department}"/>
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
                <select class="IASComboBox" TABINDEX="9" name="inwardPurpose" id="inwardPurpose">
                    <option value="0">Select</option>
                </select>
            </span>
        </div>


        <div class="IASFormFieldDiv">
            <span class="IASFormDivSpanLabel">
                <label>Mode Of Payment:</label>
            </span>
            <span class="IASFormDivSpanInputBox">
                <select class="IASComboBox" TABINDEX="10" name="paymentMode" id="paymentMode">
                    <option value="0">Select</option>
                </select>
            </span>
        </div>

        <div class="IASFormFieldDiv">
            <span class="IASFormDivSpanLabel">
                <label>Bank Name:</label>
            </span>
            <span class="IASFormDivSpanInputBox">
                <input class="IASTextBox" TABINDEX="11" type="text" name="bankName" id="bankName" value="${inwardFormBean.bankName}"/>
            </span>
        </div>

        <div class="IASFormFieldDiv">
            <span class="IASFormDivSpanLabel">
                <label>Cheque/DD No:</label>
            </span>
            <span class="IASFormDivSpanInputBox">
                <input class="IASTextBox" TABINDEX="12" type="text" name="chqddNumber" id="chqddNumber" value="${inwardFormBean.chqddNumberAsText}"/>
            </span>
        </div>


        <div class="IASFormFieldDiv">
            <span class="IASFormDivSpanLabel">
                <label>Payment Date:</label>
            </span>
            <div class="dateDiv" id="dateDiv"></div>
            <span class="IASFormDivSpanInputBox">
                <input type="text" class="IASDateTextBox" TABINDEX="13" readonly size="10" name="paymentdate" id="paymentdate" value="${inwardFormBean.paymentDate}"/>
            </span>

        </div>


        <div class="IASFormFieldDiv">
            <span class="IASFormDivSpanLabel">
                <label>Amount:</label>
            </span>
            <span class="IASFormDivSpanInputBox">
                <input class="IASTextBox" TABINDEX="14" type="text" name="amount" id="amount" value="${inwardFormBean.amount}"/>
            </span>
        </div>


        <div class="IASFormFieldDiv">
            <span class="IASFormDivSpanLabel">
                <label>Currency:</label>
            </span>
            <span class="IASFormDivSpanInputBox">
                <select class="IASComboBox" TABINDEX="15" name="currency" id="currency">
                    <option value="0">Select</option>
                </select>
            </span>
        </div>


    </div>

    <%-- Inward Info right div --%>
    <div class="IASFormRightDiv">

        <div class="IASFormFieldDiv">
            <span class="IASFormDivSpanLabel">
                <label>Receipt Number:</label>
            </span>
            <span class="IASFormDivSpanInputBox">
                <input class="IASTextBox" TABINDEX="16" type="text" name="receiptNumber" id="receiptNumber" value="${inwardFormBean.receiptNumber}"/>
            </span>
        </div>
        <div class="IASFormFieldDiv">
            <span class="IASFormDivSpanLabel">
                <label>Cheque/DD Return:</label>
            </span>
            <span class="IASFormDivSpanInputBox">
                <input class="IASCheckBox" TABINDEX="17" type="checkbox" name="checkReturn" id="checkReturn" onclick="enableCheckReturn()" value="1"/>
            </span>
        </div>
        <div class="IASFormFieldDiv">
            <span class="IASFormDivSpanLabel">
                <label>Reason For Return:</label>
            </span>
            <span class="IASFormDivSpanInputBox">
                <select class="IASComboBoxWide" TABINDEX="18" type="checkbox" name="checkReturnReason" id="checkReturnReason">
                    <option value="0">Select</option>
                </select>
            </span>
            <span class="IASFormDivSpanInputBox">
                <input class="IASTextBox" TABINDEX="19" type="text" name="checkReturnReasonOther" id="checkReturnReasonOther" value="${inwardFormBean.chequeReturnReasonOther}"/>
            </span>
        </div>
        <div class="IASFormFieldDiv">
            <span class="IASFormDivSpanLabel">
                <label>Acknowledgement Date:</label>
            </span>
            <span class="IASFormDivSpanInputBox">
                <input class="IASTextBox" TABINDEX="20" disabled type="text" name="ackDate" id="ackDate" value="${inwardFormBean.ackDate}"/>
            </span>
        </div>
        <div class="IASFormFieldDiv">
            <span class="IASFormDivSpanLabel">
                <label>Return Date:</label>
            </span>
            <span class="IASFormDivSpanInputBox">
                <input class="IASTextBox" TABINDEX="21" disabled type="text" name="returnDate" id="returnDate" value="${inwardFormBean.returnDate}"/>
            </span>
        </div>
        <div class="IASFormFieldDiv">
            <span class="IASFormDivSpanLabel">
                <label>Remarks:</label>
            </span>
            <span class="IASFormDivSpanInputBox">
                <textarea class="IASTextArea" TABINDEX="22" name="remarks" id="remarks" value="${inwardFormBean.remarks}"></textarea>
            </span>
        </div>
    </div>
</fieldset>


<%-----------------------------------------------------------------------------------------------------%>
<%-- Create Inward Actions Field Set --%>
<%-----------------------------------------------------------------------------------------------------%>
<fieldset class="subMainFieldSet">
    <div class="actionBtnDiv">
        <input onclick="setActionValue('save')" TABINDEX="23" class="IASButton" type="submit" value="Save" id="btnSaveInward" name="submitAction"/>
        <input onclick="setActionValue('edit')" TABINDEX="24" class="IASButton" type="submit" value="Edit Inward" id="btnEditInward" name="submitAction"/>
        <input onclick="setActionValue('sendAck')" TABINDEX="25" class="IASButton" type="submit" value="Send Acknowledgement" id="btnSendAck" name="submitAction"/>
        <input onclick="setActionValue('sendReturn')" TABINDEX="26" class="IASButton" type="submit" value="Send Return" id="btnSendReturn" name="submitAction"/>
    </div>
</fieldset>

