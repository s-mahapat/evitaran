<%@page import="IAS.Class.util"%>
<jsp:useBean class="IAS.Bean.Inward.inwardFormBean" id="inwardFormBean" scope="request"></jsp:useBean>
<script type="text/javascript" src="<%=request.getContextPath() + "/js/inward/inward.js"%>"></script>
<script type="text/javascript">
    $(document).ready(function() {
        jdsAppend("<%=request.getContextPath() + "/CMasterData?md=country"%>","country","country");
        jdsAppend("<%=request.getContextPath() + "/CMasterData?md=state"%>","state","state");
        jdsAppend("<%=request.getContextPath() + "/CMasterData?md=city"%>","city","city");
        jdsAppend("<%=request.getContextPath() + "/CMasterData?md=purpose"%>","purpose","inwardPurpose");
        jdsAppend("<%=request.getContextPath() + "/CMasterData?md=payment_mode"%>","payment_mode","paymentMode");
        jdsAppend("<%=request.getContextPath() + "/CMasterData?md=currency"%>","currency","currency");
    });

    jQueryCalendar("paymentDate");
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
                <input class="IASTextBoxMandatoryWide" maxlength="64" TABINDEX="1" type="text" name="from" id="from" value="<jsp:getProperty name="inwardFormBean" property="from"/>"/>
            </span>
        </div>
        <div class="IASFormFieldDiv">
            <span class="IASFormDivSpanLabel">
                <label>Country:</label>
            </span>
            <span class="IASFormDivSpanInputBox">
                <select class="IASComboBoxMandatory" TABINDEX="2" name="country" id="country">
                    <option value="0" selected >Select</option>
                    <%
                        if (!inwardFormBean.getCountry().isEmpty()) {
                            out.println("<option value=" + "\"" + inwardFormBean.getCountry() + "\"" + " selected >" + inwardFormBean.getCountry() + "</option>");
                        }
                    %>
                </select>
                <%--<input class="IASTextBoxMandatory" TABINDEX="2" name="country" id="country" value="<jsp:getProperty name="inwardFormBean" property="country"/>"--%>
            </span>
        </div>
        <div class="IASFormFieldDiv">
            <span class="IASFormDivSpanLabel">
                <label>State:</label>
            </span>
            <span class="IASFormDivSpanInputBox">
                <select class="IASComboBox" TABINDEX="3" name="state" id="state">
                    <option value="" selected >Select</option>
                    <%
                        if (inwardFormBean.getState() != null && !inwardFormBean.getState().isEmpty()) {
                            out.println("<option value=" + "\"" + inwardFormBean.getState() + "\"" + " selected >" + inwardFormBean.getState() + "</option>");
                        }
                    %>
                </select>
                <%--<input class="IASTextBoxMandatory" TABINDEX="3" name="state" id="state" value="<jsp:getProperty name="inwardFormBean" property="state"/>"--%>
            </span>
        </div>
        <div class="IASFormFieldDiv">
            <span class="IASFormDivSpanLabel">
                <label>City:</label>
            </span>
            <span class="IASFormDivSpanInputBox">
                <select class="IASComboBoxMandatory" TABINDEX="4" name="city" id="city">
                    <option value="" selected >Select</option>
                    <%
                        if (inwardFormBean.getCity() != null && !inwardFormBean.getCity().isEmpty()) {
                            out.println("<option value=" + "\"" + inwardFormBean.getCity() + "\"" + " selected >" + inwardFormBean.getCity() + "</option>");
                        }
                    %>
                </select>
                <%--<input class="IASTextBoxMandatory" TABINDEX="4" name="city" id="city" value="<jsp:getProperty name="inwardFormBean" property="city"/>"--%>
            </span>
        </div>

        <div class="IASFormFieldDiv">
            <span class="IASFormDivSpanLabel">
                <label>PIN Code:</label>
            </span>
            <span class="IASFormDivSpanInputBox">
                <input class="IASTextBox" maxlength="11" TABINDEX="5" type="text" name="pincode" id="pincode" value="${inwardFormBean.pincodeAsText}"/>
            </span>
        </div>

        <div class="IASFormFieldDiv">
            <span class="IASFormDivSpanLabel">
                <label>Email:</label>
            </span>
            <span class="IASFormDivSpanInputBox">
                <input class="IASEmailTextBox" maxlength="64" TABINDEX="6" type="text" name="email" id="email" onblur="validateEmail(this.id)" value="${inwardFormBean.email}"/>
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
                <input class="IASTextBoxInward" TABINDEX="-1" readonly type="text" name="inwardNumber" id="inwardNumber" value="<jsp:getProperty name="inwardFormBean" property="inwardNumber"/>"/>
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
                <input class="IASTextBox" TABINDEX="-1" readonly type="text" name="subscriberId" id="subscriberId" value="${inwardFormBean.subscriberIdAsText}"/>
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
                <input class="IASTextBox" maxlength="64" TABINDEX="8" type="text" name="institution" id="institution" value="${inwardFormBean.institution}"/>
            </span>
        </div>

        <div class="IASFormFieldDiv">
            <span class="IASFormDivSpanLabel">
                <label>Department:</label>
            </span>
            <span class="IASFormDivSpanInputBox">
                <input class="IASTextBox" maxlength="64" TABINDEX="9" type="text" name="department" id="department" value="${inwardFormBean.department}"/>
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
                <select class="IASComboBoxMandatory" TABINDEX="10" name="inwardPurpose" id="inwardPurpose">
                    <option value="0">Select</option>
                    <%
                        if (inwardFormBean.getInwardPurpose() != null) {
                            out.println("<option value=" + "\"" + inwardFormBean.getInwardPurpose() + "\"" + " selected >" + inwardFormBean.getInwardPurpose() + "</option>");
                        }
                    %>
                </select>
            </span>
        </div>


        <div class="IASFormFieldDiv">
            <span class="IASFormDivSpanLabel">
                <label>Mode Of Payment:</label>
            </span>
            <span class="IASFormDivSpanInputBox">
                <select class="IASComboBox" TABINDEX="11" name="paymentMode" id="paymentMode">
                    <option value="">Select</option>
                    <%
                        if (inwardFormBean.getPaymentMode() != null && inwardFormBean.getPaymentMode().length() > 0) {
                            out.println("<option value=" + "\"" + inwardFormBean.getPaymentMode() + "\"" + " selected >" + inwardFormBean.getPaymentMode() + "</option>");
                        }
                    %>
                </select>
            </span>
        </div>

        <div class="IASFormFieldDiv">
            <span class="IASFormDivSpanLabel">
                <label>Bank Name:</label>
            </span>
            <span class="IASFormDivSpanInputBox">
                <input class="IASTextBox" maxlength="64" TABINDEX="12" type="text" name="bankName" id="bankName" value="${inwardFormBean.bankName}"/>
            </span>
        </div>

        <div class="IASFormFieldDiv">
            <span class="IASFormDivSpanLabel">
                <label>Cheque/DD/MO No:</label>
            </span>
            <span class="IASFormDivSpanInputBox">
                <input class="IASTextBox" maxlength="11" TABINDEX="13" type="text" name="chqddNumber" id="chqddNumber" value="${inwardFormBean.chqddNumberAsText}"/>
            </span>
        </div>


        <div class="IASFormFieldDiv">
            <span class="IASFormDivSpanLabel">
                <label>Payment Date:</label>
            </span>
            <div class="dateDiv" id="dateDiv"></div>
            <span class="IASFormDivSpanInputBox">
                <input type="text" class="IASDateTextBox" TABINDEX="14" readonly size="10" name="paymentDate" id="paymentDate" value="${inwardFormBean.paymentDate}"/>
            </span>

        </div>


        <div class="IASFormFieldDiv">
            <span class="IASFormDivSpanLabel">
                <label>Amount:</label>
            </span>
            <span class="IASFormDivSpanInputBox">
                <input class="IASTextBox" TABINDEX="15" type="text" name="amount" id="amount" value="${inwardFormBean.amount}"/>
            </span>
        </div>


        <div class="IASFormFieldDiv">
            <span class="IASFormDivSpanLabel">
                <label>Currency:</label>
            </span>
            <span class="IASFormDivSpanInputBox">
                <select class="IASComboBox" TABINDEX="16" name="currency" id="currency">
                    <option value="">Select</option>
                    <%
                        if (inwardFormBean.getCurrency() != null && inwardFormBean.getCurrency().length() > 0) {
                            out.println("<option value=" + "\"" + inwardFormBean.getCurrency() + "\"" + " selected >" + inwardFormBean.getCurrency() + "</option>");
                        }
                    %>
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
                <input class="IASTextBox" maxlength="11" TABINDEX="17" type="text" name="receiptNumber" id="receiptNumber" value="${inwardFormBean.receiptNumberAsText}"/>
            </span>
        </div>
        <div class="IASFormFieldDiv">
            <span class="IASFormDivSpanLabel">
                <label>Cheque/DD Return:</label>
            </span>
            <span class="IASFormDivSpanInputBox">
                <input class="IASCheckBox" TABINDEX="18" type="checkbox" name="chequeDDReturn" id="chequeDDReturn" value="1" disabled
                       <%
                           if (inwardFormBean.isChequeDDReturn())
                               out.println("checked");
                       %>
                       />
            </span>
        </div>
        <div class="IASFormFieldDiv">
            <span class="IASFormDivSpanLabel">
                <label>Reason For Return:</label>
            </span>
            <span class="IASFormDivSpanInputBox">
                <input class="IASTextBox" TABINDEX="19" type="text" name="chequeDDReturnReason" id="chequeDDReturnReason" value="${inwardFormBean.chequeDDReturnReason}" readonly>
            </span>
            <span class="IASFormDivSpanInputBox">
                <input class="IASTextBox" TABINDEX="20" type="text" name="chequeDDReturnReasonOther" id="chequeDDReturnReasonOther" value="${inwardFormBean.chequeDDReturnReasonOther}" readonly/>
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
                <label>Acknowledgement Date:</label>
            </span>
            <span class="IASFormDivSpanInputBox">
                <input class="IASTextBox" TABINDEX="22" disabled type="text" name="ackDate" id="ackDate" value="${inwardFormBean.ackDate}"/>
            </span>
        </div>

        <div class="IASFormFieldDiv">
            <span class="IASFormDivSpanLabel">
                <label>Remarks:</label>
            </span>
            <span class="IASFormDivSpanInputBox">
                <textarea class="IASTextArea" maxlength="100" TABINDEX="23" name="remarks" id="remarks">${inwardFormBean.remarks}</textarea>
            </span>
        </div>
    </div>
</fieldset>


<%-----------------------------------------------------------------------------------------------------%>
<%-- Create Inward Actions Field Set --%>
<%-----------------------------------------------------------------------------------------------------%>
<fieldset class="subMainFieldSet">
    <div class="actionBtnDiv">
        <input onclick="setActionValue('save')" TABINDEX="24" class="IASButton" type="submit" value="Save" id="btnSaveInward" name="submitAction"/>
        <input onclick="setActionValue('edit')" TABINDEX="25" class="IASButton" type="submit" value="Edit Inward" id="btnEditInward" name="submitAction"/>
        <input onclick="setActionValue('sendAck')" TABINDEX="26" class="IASButton" type="submit" value="Send Acknowledgement" id="btnSendAck" name="submitAction"
               <%
                //inwardFormBean.isCompleted()== true ? out.println("enabled") : out.println("disabled");
                if(inwardFormBean.isCompleted() == true)
                    out.println(" enabled");
                else
                    out.println(" disabled");
               %>
        />
        <input onclick="setActionValue('sendReturn')" TABINDEX="27" class="IASButton" type="submit" value="Send Return" id="btnSendReturn" name="submitAction"/>
    </div>
</fieldset>

