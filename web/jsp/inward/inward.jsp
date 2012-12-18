<%@page import="IAS.Class.util"%>
<jsp:useBean class="IAS.Bean.Inward.inwardFormBean" id="inwardFormBean" scope="request"></jsp:useBean>
<script type="text/javascript" src="<%=request.getContextPath() + "/js/inward/inward.js"%>"></script>
<script>
    $(document).ready(function(){
        $("#from").focus();

        // get the inward complete state from the bean
        var iscomplete = ${inwardFormBean.completed};

        // disable the send return button if the inward is not complete yet
        // perform other actions that are required when inward is not complete inside this
        if(iscomplete == false){
            $("#btnSendReturn").button("disable");
        }

        $(function() {
            $( "#btnSearchSubscriber" )
            .button()
            .click(function() {
                validateSearchSubscriber();
                return false;
            })
            .next()
            .button("disable")
            .click(function() {
                clearSubscriber();
                return false;
            })
            .parent()
            .buttonset();
        });

        $(function() {
            $( "#btnSearchSubscription" )
            .button("disable")
            .click(function() {
                validateSearchSubscription();
                return false;
            })
            .next()
            .button("disable")
            .click(function() {
                clearSubscription();
                return false;
            })
            .parent()
            .buttonset();
        });

        $(function() {
            $( "#btnUE" )
            .button("disable")
            .click(function(){$("#agentName").val("");$("#agentName").change();return false;})
            .parent()
            .buttonset();
        });

        $(function(){
            //$("#agentName")
            // disable the search subscriber and reset button
            if(!isEmptyValue($("#agentName").val())){
                $("#btnSearchSubscriber").button("disable");
                $("#btnResetSubscriber").button("disable");
                $("#btnUE").button("enable");
                $("#btnResetUE").button("enable");
            }
            else {
                //$("#btnSearchSubscriber").button("enable");
                //$("#btnResetSubscriber").button("enable");
                $("#btnUE").button("disable");
                $("#btnResetUE").button("disable");
            }
        });


        $("#inwardPurpose").change(function(){
            var inward_purpose = $("#inwardPurpose").val();
            // enable the search subscription button only for inward of type 'payment'
            if(inward_purpose.toLowerCase() == "payment"){
                enableSubscriptionID(true);
            }
            else{
                enableSubscriptionID(false);
            }
            // if the inward type is new subscription disable the search subscriber button
            if(inward_purpose.toLowerCase() == 0){
                $( "#btnSearchSubscriber" ).button("disable");
                $("#btnResetSubscriber").button("disable");
            }else{
                $( "#btnSearchSubscriber" ).button("enable");
                $("#btnResetSubscriber").button("enable");
            }
        });

        $("#agentName").change(function(){
            // disable the search subscriber and reset button
            if(!isEmptyValue($("#agentName").val())){
                $("#btnSearchSubscriber").button("disable");
                $("#btnResetSubscriber").button("disable");
                $("#btnUE").button("enable");
                $("#btnResetUE").button("enable");
            }
            else{
                $("#btnSearchSubscriber").button("enable");
                $("#btnResetSubscriber").button("enable");
                $("#btnUE").button("disable");
                $("#btnResetUE").button("disable");
            }
        });

        /*$("#subscriberId").bind( "autocompleteselect", function(event, ui) {
            alert("change");
            if(!ui.item){
                bvalidsubscriber = false;
                $(this).val('');
                $(this).focus();
            }else{
                bvalidsubscriber = true;
            }
        });*/

    });
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
                <input class="IASTextBoxMandatoryWide required" maxlength="64" TABINDEX="1" type="text" name="from" id="from" value="<jsp:getProperty name="inwardFormBean" property="from"/>"/>
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
                        if (inwardFormBean.getCountry() != null && !inwardFormBean.getCountry().isEmpty()) {
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
                <label>District:</label>
            </span>
            <span class="IASFormDivSpanInputBox">
                <input class="IASTextBox" TABINDEX="4" name="district" id="district"
                       value="<% if (inwardFormBean.getDistrict() == "" || inwardFormBean.getDistrict() == null) {
                               out.println("");
                           } else {
                               out.println(inwardFormBean.getDistrict());
                           }
                       %>"
                       <%--<jsp:getProperty name="inwardFormBean" property="district"/>"/>--%>
            </span>
        </div>
        <div class="IASFormFieldDiv">
            <span class="IASFormDivSpanLabel">
                <label>City:</label>
            </span>
            <span class="IASFormDivSpanInputBox">
                <input class="IASTextBoxMandatory required" TABINDEX="5" name="city" id="city" value="<jsp:getProperty name="inwardFormBean" property="city"/>"/>
            </span>
        </div>
        <div class="IASFormFieldDiv">
            <span class="IASFormDivSpanLabel">
                <label for="pincode">PIN Code:</label>
            </span>
            <span class="IASFormDivSpanInputBox">
                <input class="IASTextBox digits" maxlength="6" TABINDEX="6" type="text" name="pincode" id="pincode" value="${inwardFormBean.pincodeAsText}"/>
            </span>
        </div>

        <div class="IASFormFieldDiv">
            <span class="IASFormDivSpanLabel">
                <label>Email:</label>
            </span>
            <span class="IASFormDivSpanInputBox">
                <input class="IASEmailTextBox" maxlength="64" TABINDEX="7" type="text" name="email" id="email" onblur="validateEmail(this.id)" value="${inwardFormBean.email}"/>
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
                <input class="IASDisabledTextBox" TABINDEX="-1" readonly type="text" name="inwardNumber" id="inwardNumber" value="<jsp:getProperty name="inwardFormBean" property="inwardNumber"/>"/>
            </span>
            <span class="IASFormDivSpanLabelLeftAligned">
                <label>Date:</label>
            </span>
            <span class="IASFormDivSpanInputBox">
                <input class="IASDateTextBox" TABINDEX="-1" readonly type="text" name="inwardCreationDate" id="inwardCreationDate" value="${inwardFormBean.inwardCreationDate}"/>
            </span>
        </div>
        <div class="IASFormFieldDiv">
            <span class="IASFormDivSpanLabel">
                <label>Agent:</label>
            </span>
            <span class="IASFormDivSpanInputBox">
                <select class="IASComboBoxWide" TABINDEX="5" name="agentName" id="agentName">
                    <option value="" selected >Select</option>
                    <%
                        if (inwardFormBean.getagentName() != null && !inwardFormBean.getagentName().isEmpty()) {
                            out.println("<option value=" + "\"" + inwardFormBean.getagentName() + "\"" + " selected >" + inwardFormBean.getagentName() + "</option>");
                        }
                    %>
                </select>
            </span>
            <%--<span class="IASFormDivSpanInputBox" style="font-size: 8px;">
                <button id="btnUE" TABINDEX="13">Upload Excel</button>
                <button id="btnResetUE" TABINDEX="14">Reset</button>
            </span>--%>
        </div>

        <div class="IASFormFieldDiv">
            <span class="IASFormDivSpanLabel">
                <label>Purpose:</label>
            </span>
            <span class="IASFormDivSpanInputBox">
                <select class="IASComboBoxMandatory" TABINDEX="12" name="inwardPurpose" id="inwardPurpose" onchange="selectPaymentType(this.value)">
                    <option value="0">Select</option>
                    <%
                        if (inwardFormBean.getInwardPurpose() != null && !inwardFormBean.getInwardPurpose().isEmpty()) {
                            out.println("<option value=" + "\"" + inwardFormBean.getInwardPurpose() + "\"" + " selected >" + inwardFormBean.getInwardPurpose() + "</option>");
                        }
                    %>
                </select>
            </span>
        </div>

        <div class="IASFormFieldDiv">
            <span class="IASFormDivSpanLabel">
                <label>Subscriber No:</label>
            </span>
            <span class="IASFormDivSpanInputBox">
                <input autocomplete="off" class="IASTextBox" TABINDEX="13" type="text" name="subscriberId" id="subscriberId" value="${inwardFormBean.subscriberIdAsText}" onblur="removeInvalidSubscriber()"/>
            </span>
            <span class="IASFormDivSpanInputBox" style="font-size: 8px;">
                <button type="button" id="btnSearchSubscriber" TABINDEX="10">Search Subscriber</button>
                <button type="button" id="btnResetSubscriber" TABINDEX="11">Reset</button>
            </span>
        </div>

        <div class="IASFormFieldDiv">
            <span class="IASFormDivSpanLabel">
                <label>Subscription ID:</label>
            </span>
            <span class="IASFormDivSpanInputBox">
                <input class="IASDisabledTextBox" TABINDEX="-1" disabled type="text" name="subscriptionID" id="subscriptionid" value="${inwardFormBean.subscriptionIDAsText}"/>
            </span>
            <span class="IASFormDivSpanInputBox" style="font-size: 8px;">
                <button type="button" id="btnSearchSubscription" TABINDEX="13">Search Subscription</button>
                <button type="button" id="btnResetSubscription" TABINDEX="14">Reset</button>
                <%--<input class="IASButton" TABINDEX="7" type="button" name="btnSearchSubscriber" id="btnSearchSubscriber" value="Search Subscriber" onclick="validateSearchSubscriber()"/>
                <input class="IASButton" TABINDEX="-1" type="button" name="btnResetSubscriber" id="btnResetSubscriber" value="Reset" onclick="clearSubscriber()"/>--%>
            </span>
        </div>
        <div class="IASFormFieldDiv">
            <span class="IASFormDivSpanLabel">
                <label>Institution:</label>
            </span>
            <span class="IASFormDivSpanInputBox">
                <input class="IASTextBoxWide" maxlength="64" TABINDEX="8" type="text" name="institution" id="institution" value="${inwardFormBean.institution}"/>
            </span>
        </div>

        <div class="IASFormFieldDiv">
            <span class="IASFormDivSpanLabel">
                <label>Department:</label>
            </span>
            <span class="IASFormDivSpanInputBox">
                <input class="IASTextBoxWide" maxlength="64" TABINDEX="9" type="text" name="department" id="department" value="${inwardFormBean.department}"/>
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


        <%--<div class="IASFormFieldDiv">
            <span class="IASFormDivSpanLabel">
                <label>Purpose:</label>
            </span>
            <span class="IASFormDivSpanInputBox">
                <select class="IASComboBoxMandatory" TABINDEX="10" name="inwardPurpose" id="inwardPurpose">
                    <option value="0">Select</option>
                    <%
                        if (inwardFormBean.getInwardPurpose() != null && !inwardFormBean.getInwardPurpose().isEmpty()) {
                            out.println("<option value=" + "\"" + inwardFormBean.getInwardPurpose() + "\"" + " selected >" + inwardFormBean.getInwardPurpose() + "</option>");
                        }
                    %>
                </select>
            </span>
        </div>--%>


        <div class="IASFormFieldDiv">
            <span class="IASFormDivSpanLabel">
                <label>Mode Of Payment:</label>
            </span>
            <span class="IASFormDivSpanInputBox">
                <select class="IASComboBox" TABINDEX="15" name="paymentMode" id="paymentMode" onchange="MakePaymentFieldsMandatory()">
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
                <input class="IASTextBox" maxlength="64" TABINDEX="16" type="text" name="bankName" id="bankName" value="${inwardFormBean.bankName}"/>
            </span>
        </div>

        <div class="IASFormFieldDiv">
            <span class="IASFormDivSpanLabel">
                <label>Cheque/DD/MO No:</label>
            </span>
            <span class="IASFormDivSpanInputBox">
                <input class="IASTextBox" maxlength="6" TABINDEX="17" type="text" name="chqddNumber" id="chqddNumber" value="${inwardFormBean.chqddNumberAsText}"/>
            </span>
        </div>


        <div class="IASFormFieldDiv">
            <span class="IASFormDivSpanLabel">
                <label>Cheque Date:</label>
            </span>
            <div class="dateDiv" id="dateDiv"></div>
            <span class="IASFormDivSpanInputBox">
                <input type="text" class="IASDateTextBox" TABINDEX="18" readonly size="10" name="paymentDate" id="paymentDate" value="${inwardFormBean.paymentDate}"/>
            </span>

        </div>


        <div class="IASFormFieldDiv">
            <span class="IASFormDivSpanLabel">
                <label>Amount:</label>
            </span>
            <span class="IASFormDivSpanInputBox">
                <%
                    String amount = inwardFormBean.getAmount() > 0 ? String.valueOf(inwardFormBean.getAmount()) : "";
                %>
                <input class="IASTextBox number" TABINDEX="19" type="text" name="amount" id="amount" value="<%=amount%>"/>
            </span>
        </div>


        <div class="IASFormFieldDiv">
            <span class="IASFormDivSpanLabel">
                <label>Currency:</label>
            </span>
            <span class="IASFormDivSpanInputBox">
                <select class="IASComboBox" TABINDEX="20" name="currency" id="currency">
                    <option value="">Select</option>
                    <%
                        if (inwardFormBean.getCurrency() != null && inwardFormBean.getCurrency().length() > 0) {
                            out.println("<option value=" + "\"" + inwardFormBean.getCurrency() + "\"" + " selected >" + inwardFormBean.getCurrency() + "</option>");
                        }
                    %>
                </select>
            </span>
        </div>

        <div class="IASFormFieldDiv">
            <span class="IASFormDivSpanLabel">
                <label>Language:</label>
            </span>
            <span class="IASFormDivSpanInputBox">
                <select class="IASComboBox" TABINDEX="21" name="language" id="language">
                    <option value="">Select</option>
                    <%
                        if (inwardFormBean.getLanguage() != null && inwardFormBean.getLanguage().length() > 0) {
                            out.println("<option value=" + "\"" + inwardFormBean.getLanguage() + "\"" + " selected >" + inwardFormBean.getLanguage() + "</option>");
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
                <input class="IASDisabledTextBox" maxlength="11" disabled TABINDEX="22" type="text" name="receiptNumber" id="receiptNumber" value="${inwardFormBean.receiptNumberAsText}"/>
            </span>
        </div>
        <div class="IASFormFieldDiv">
            <span class="IASFormDivSpanLabel">
                <label>Cheque/DD Return:</label>
            </span>
            <span class="IASFormDivSpanInputBox">
                <input class="IASCheckBox" TABINDEX="23" type="checkbox" name="chequeDDReturn" id="chequeDDReturn" value="1" disabled
                       <%
                           if (inwardFormBean.isChequeDDReturn()) {
                               out.println("checked");
                           }
                       %>
                       />
            </span>
        </div>
        <div class="IASFormFieldDiv">
            <span class="IASFormDivSpanLabel">
                <label>Reason For Return:</label>
            </span>
            <span class="IASFormDivSpanInputBox">
                <input class="IASDisabledTextBox" TABINDEX="24" type="text" name="chequeDDReturnReason" id="chequeDDReturnReason" value="${inwardFormBean.chequeDDReturnReason}" readonly>
            </span>
            <span class="IASFormDivSpanInputBox">
                <input class="IASDisabledTextBox" TABINDEX="25" type="text" name="chequeDDReturnReasonOther" id="chequeDDReturnReasonOther" value="${inwardFormBean.chequeDDReturnReasonOther}" readonly/>
            </span>
        </div>
        <div class="IASFormFieldDiv">
            <span class="IASFormDivSpanLabel">
                <label>Return Date:</label>
            </span>
            <span class="IASFormDivSpanInputBox">
                <input class="IASDateTextBox" TABINDEX="26" disabled type="text" name="returnDate" id="returnDate" value="${inwardFormBean.returnDate}"/>
            </span>
        </div>
        <div class="IASFormFieldDiv">
            <span class="IASFormDivSpanLabel">
                <label>Ack Date:</label>
            </span>
            <span class="IASFormDivSpanInputBox">
                <input class="IASDateTextBox" TABINDEX="27" disabled type="text" name="ackDate" id="ackDate" value="${inwardFormBean.ackDate}"/>
            </span>
        </div>

        <div class="IASFormFieldDiv">
            <span class="IASFormDivSpanLabel">
                <label>Remarks:</label>
            </span>
            <span class="IASFormDivSpanInputBox">
                <textarea class="IASTextArea" maxlength="200" cols="40" rows="5" TABINDEX="28" name="remarks" id="remarks" style="text-align: left;">${inwardFormBean.remarks}</textarea>
            </span>
        </div>
    </div>
</fieldset>


<%-----------------------------------------------------------------------------------------------------%>
<%-- Create Inward Actions Field Set --%>
<%-----------------------------------------------------------------------------------------------------%>
<fieldset class="subMainFieldSet">
    <div class="actionBtnDiv">
        <input onclick="setActionValue('save')" TABINDEX="29" class="IASButton" type="submit" value="Save" id="btnSaveInward" name="submitAction"/>
        <input onclick="location.href='main?action=createinward'" TABINDEX="30" class="IASButton" type="button" value="New Inward" id="btnNewInward" name="btnNewInward"/>
        <input onclick="setActionValue('edit')" TABINDEX="31" class="IASButton" type="submit" value="Edit Inward" id="btnEditInward" name="submitAction"/>
        <input onclick="setActionValue('sendAck')" TABINDEX="32" class="IASButton" type="submit" value="Send Acknowledgement" id="btnSendAck" name="submitAction"/>
        <input onclick="setActionValue('sendReturn')" TABINDEX="33" class="IASButton" type="submit" value="Send Return" id="btnSendReturn" name="submitAction"/>
    </div>
</fieldset>

