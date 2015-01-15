<%@page import="IAS.Class.util"%>
<jsp:useBean class="IAS.Bean.Inward.inwardFormBean" id="inwardFormBean" scope="request"></jsp:useBean>
<script type="text/javascript" src="<%=request.getContextPath() + "/js/inward/inward.js"%>"></script>
<script>
    $(document).ajaxStop(function () {
        MakePaymentFieldsMandatory();
    });
    $(document).ready(function () {
        $("#subscriberId").focus();

        // get the inward complete state from the bean
        var iscomplete = ${inwardFormBean.completed};

        // disable the send return button if the inward is not complete yet
        // perform other actions that are required when inward is not complete inside this
        if (iscomplete === false) {
            //$("#btnSendReturn").button("disable");
        } else {
            // do not let the user modify the inward or send
            // chq return once the inward in complete
            $("#btnEditInward").hide();
            //$("#btnSendReturn").hide();
        }

        $(function () {
            $("#btnSearchSubscriber")
                    .button({icons: {primary: "ui-icon-circle-zoomin"}})
                    .click(function () {
                        if ($("#subscriberId").val()) {

                            ValidateSubscriber();
                        } else {
                            $("#dialog").dialog('open');
                            validateSearchSubscriber();
                        }
                        return false;
                    });
        });

        $(function () {
            $("#btnResetSubscriber")
                    .button({icons: {primary: "ui-icon-trash"}})
                    .click(function () {
                        clearSubscriber();
                        return false;
                    });
        });

        $(function () {
            $("#btnUE")
                    .button("disable")
                    .click(function () {
                        $("#agentName").val("");
                        $("#agentName").change();
                        return false;
                    })
                    .parent()
                    .buttonset();
        });

        $(function () {
            $("#add-new-city").button()
                    .click(function () {
                        $("#new-city-dialog-form").dialog("open");
                    });
        });


        $("#inwardPurpose").change(function () {
            var inward_purpose = $("#inwardPurpose").val();
            // if the inward type is new subscription disable the search subscriber button
            if (inward_purpose.toLowerCase() == 0) {
                $("#btnSearchSubscriber").button("disable");
                $("#btnResetSubscriber").button("disable");
            } else {
                $("#btnSearchSubscriber").button("enable");
                $("#btnResetSubscriber").button("enable");
            }
        });

        $("#agentName").change(function () {
            // disable the search subscriber and reset button
            if (!isEmptyValue($("#agentName").val())) {
                $("#btnSearchSubscriber").button("disable");
                $("#btnResetSubscriber").button("disable");
                $("#btnUE").button("enable");
                $("#btnResetUE").button("enable");
            }
            else {
                $("#btnSearchSubscriber").button("enable");
                $("#btnResetSubscriber").button("enable");
                $("#btnUE").button("disable");
                $("#btnResetUE").button("disable");
            }
        });

        $("#new-city-dialog-form").dialog({
            autoOpen: false,
            height: 200,
            width: 250,
            modal: true,
            buttons: {
                Save: function () {
                    var new_city = $("#newcity").val();
                    if (new_city === "") {
                        return;
                    }
                    $.ajax({
                        type: "POST",
                        url: "<%=request.getContextPath()%>" + "/city?action=add&city=" + new_city,
                        async: false,
                        dataType: "json",
                        success: function (json) {
                            id = json['id'];
                            message = json['message'];
                            if (parseInt(id) > 0) {
                                $("#city-add-message").removeClass("ui-state-error-text");
                                $("#city-add-message").addClass("ui-state-highlight");
                                $("#city").val(new_city);
                            } else {
                                $("#city-add-message").addClass("ui-state-error-text");
                            }
                            $("#city-add-message").text(message);
                        },
                        error: function () {
                            alert("Error getting data from server");
                        }
                    });
                },
                Cancel: function () {
                    $(this).dialog("close");
                }
            },
            close: function () {
                $("#city-add-message").val("").removeClass("ui-state-error-text");
                $("#city-add-message").val("").removeClass("ui-state-highlight");
            }
        });

        // create a dialog on the div id=dialog
        $("#dialog").dialog({
            height: 680,
            width: 1200,
            modal: true,
            autoOpen: false,
            buttons: {
                "Select": function () {
                    $(this).dialog("close");
                    
                    // call this function from the subscriberlist.jsp
                    subscriber = dlg_getSelectedSubscriber();
                    
                    // called from inward.js
                    setSubscriber(subscriber);
                    
                },
                "Cancel": function () {
                    $(this).dialog("close");
                }
            },
            close: function () {
                
            }
        });

    });
</script>

<%-----------------------------------------------------------------------------------------------------%>
<%-- Inward Info Field Set --%>
<%-----------------------------------------------------------------------------------------------------%>
<fieldset class="subMainFieldSet">
    <%--<legend>Inward Info</legend>--%>
    <input type="hidden" name="inwardID" value="${inwardFormBean.inwardID}"/>

    <%-- Inward Info left div --%>
    <div class="IASFormLeftDiv">

        <div class="IASFormFieldDiv">
            <span class="IASFormDivSpanLabel">
                <label>Subscriber No:</label>
            </span>
            <span class="IASFormDivSpanInputBox ui-widget">
                <input autocomplete="off" class="IASTextBox" TABINDEX="1" type="text" name="subscriberId" id="subscriberId" value="${inwardFormBean.subscriberIdAsText}"/>
                <span class="" style="font-size: 0.85em; float: next; vertical-align: top;">
                    <button type="button" id="btnSearchSubscriber" TABINDEX="2">Search</button>
                    <button type="button" id="btnResetSubscriber" TABINDEX="3">Reset</button>
                </span>
            </span>

        </div>

        <div id="dialog">
            <%@include file="../subscriber/subscriberlist.jsp" %>
        </div>

        <div class="IASFormFieldDiv">
            <span class="IASFormDivSpanLabel">
                <label>From:</label>
            </span>
            <span class="IASFormDivSpanInputBox">
                <input class="IASTextBoxMandatoryWide required" autofocus maxlength="64" TABINDEX="4" type="text" name="from" id="from" value="<jsp:getProperty name="inwardFormBean" property="from"/>"/>
            </span>
        </div>
        <div class="IASFormFieldDiv">
            <span class="IASFormDivSpanLabel">
                <label>Country:</label>
            </span>
            <span class="IASFormDivSpanInputBox">
                <select class="IASComboBoxMandatory" TABINDEX="5" name="country" id="country">
                    <option value="" selected >Select</option>
                    <%
                        if (inwardFormBean.getCountry() != null && !inwardFormBean.getCountry().isEmpty()) {
                            out.println("<option value=" + "\"" + inwardFormBean.getCountry() + "\"" + " selected >" + inwardFormBean.getCountry() + "</option>");
                        }
                    %>
                </select>
            </span>
        </div>
        <div class="IASFormFieldDiv">
            <span class="IASFormDivSpanLabel">
                <label>State:</label>
            </span>
            <span class="IASFormDivSpanInputBox">
                <select class="IASComboBox" TABINDEX="6" name="state" id="state">
                    <option value="" selected >Select</option>
                    <%
                        if (inwardFormBean.getState() != null && !inwardFormBean.getState().isEmpty()) {
                            out.println("<option value=" + "\"" + inwardFormBean.getState() + "\"" + " selected >" + inwardFormBean.getState() + "</option>");
                        }
                    %>
                </select>
            </span>
        </div>
        <div class="IASFormFieldDiv">
            <span class="IASFormDivSpanLabel">
                <label>District:</label>
            </span>
            <span class="IASFormDivSpanInputBox">
                <input class="IASTextBox" TABINDEX="7" name="district" id="district"
                       value="<% if (inwardFormBean.getDistrict() == "" || inwardFormBean.getDistrict() == null) {
                               out.println("");
                           } else {
                               out.println(inwardFormBean.getDistrict());
                           }
                       %>"/>
                <%--<jsp:getProperty name="inwardFormBean" property="district"/>"/>--%>
            </span>
        </div>
        <div class="IASFormFieldDiv">
            <span class="IASFormDivSpanLabel">
                <label>City:</label>
            </span>
            <span class="IASFormDivSpanInputBox">
                <input class="IASTextBoxMandatory required" TABINDEX="8" name="city" id="city" value="<jsp:getProperty name="inwardFormBean" property="city"/>"/>
                <span class="" style="font-size: 0.85em; float: next; vertical-align: top;">
                    <button type="button" id="add-new-city">Add city</button>
                </span>
            </span>

            <div id="new-city-dialog-form" title="New city" >
                <p class="validateTips">All form fields are required.</p>
                <form>
                    <label for="name">City Name</label>
                    <input type="text" name="newcity" id="newcity" class="text ui-widget-content ui-corner-all" >
                </form>
                <p class="" id="city-add-message"></p>
            </div>
        </div>
        <div class="IASFormFieldDiv">
            <span class="IASFormDivSpanLabel">
                <label for="pincode">PIN Code:</label>
            </span>
            <span class="IASFormDivSpanInputBox">
                <input class="IASTextBox digits" maxlength="6" TABINDEX="9" type="text" name="pincode" id="pincode" value="${inwardFormBean.pincodeAsText}"/>
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
                <input class="IASDisabledTextBox smalltextbox" TABINDEX="-1" readonly type="text" name="inwardNumber" id="inwardNumber" value="<jsp:getProperty name="inwardFormBean" property="inwardNumber"/>"/>
            </span>
        </div>
        <div class="IASFormFieldDiv">
            <div>
                <span class="IASFormDivSpanLabel">
                    <label>Date:</label>
                </span>
                <span class="IASFormDivSpanInputBox">
                    <input class="IASDateTextBox" TABINDEX="-1" readonly type="text" name="inwardCreationDate" id="inwardCreationDate" value="${inwardFormBean.inwardCreationDate}"/>
                </span>
            </div>
        </div>
        <div class="IASFormFieldDiv">
            <span class="IASFormDivSpanLabel">
                <label>Agent:</label>
            </span>
            <span class="IASFormDivSpanInputBox">
                <input autocomplete="off" class="IASTextBoxWide" TABINDEX="10" type="text" name="agentName" id="agentName" value="${inwardFormBean.agentName}"/>
                <%--<select class="IASComboBoxWide" TABINDEX="10" name="agentName" id="agentName">
                    <option value="" selected >Select</option>
                    <%
                        if (inwardFormBean.getAgentName() != null && !inwardFormBean.getAgentName().isEmpty()) {
                            out.println("<option value=" + "\"" + inwardFormBean.getAgentName() + "\"" + " selected >" + inwardFormBean.getAgentName() + "</option>");
                        }
                    %>
                </select>--%>
            </span>
        </div>

        <div class="IASFormFieldDiv">
            <span class="IASFormDivSpanLabel">
                <label>Purpose:</label>
            </span>
            <span class="IASFormDivSpanInputBox">
                <select class="IASComboBoxMandatory" TABINDEX="11" name="inwardPurpose" id="inwardPurpose" onchange="selectPaymentType(this.value)">
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
                <label>Department:</label>
            </span>
            <span class="IASFormDivSpanInputBox">
                <input class="IASTextBoxWide" maxlength="64" TABINDEX="12" type="text" name="department" id="department" value="${inwardFormBean.department}"/>
            </span>
        </div>

        <div class="IASFormFieldDiv">
            <span class="IASFormDivSpanLabel">
                <label>Institution:</label>
            </span>
            <span class="IASFormDivSpanInputBox">
                <input class="IASTextBoxWide" maxlength="64" TABINDEX="13" type="text" name="institution" id="institution" value="${inwardFormBean.institution}"/>
            </span>
        </div>

        <div class="IASFormFieldDiv">
            <span class="IASFormDivSpanLabel">
                <label>Email:</label>
            </span>
            <span class="IASFormDivSpanInputBox">
                <input class="IASTextBoxWide" maxlength="128" TABINDEX="14" type="email" name="email" id="email" value="${inwardFormBean.email}"/>
            </span>
        </div>
    </div>
</fieldset>


<%-----------------------------------------------------------------------------------------------------%>
<%-- Inward Details Field Set --%>
<%-----------------------------------------------------------------------------------------------------%>
<fieldset class="subMainFieldSet">
    <%--<legend>Inward Details</legend>--%>

    <%-- Inward Info left div --%>
    <div class="IASFormLeftDiv">
        <div class="IASFormFieldDiv">
            <span class="IASFormDivSpanLabel">
                <label>Payment Mode:</label>
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
                <label>Instrument No:</label>
            </span>
            <span class="IASFormDivSpanInputBox">
                <input class="IASTextBox" autocomplete="off" maxlength="6" TABINDEX="17" type="text" name="chqddNumber" id="chqddNumber" value="${inwardFormBean.chqddNumberAsText}"/>
            </span>
        </div>


        <div class="IASFormFieldDiv">
            <span class="IASFormDivSpanLabel">
                <label>Instrument Date:</label>
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
                <label>Letter No:</label>
            </span>
            <span class="IASFormDivSpanInputBox">
                <input class="IASTextBox" TABINDEX="21" maxlength="40" type="text" name="letterNumber" id="letterNumber" value="${inwardFormBean.letterNumber}"/>
            </span>
        </div>

        <div class="IASFormFieldDiv">
            <span class="IASFormDivSpanLabel">
                <label>Letter Date:</label>
            </span>
            <span class="IASFormDivSpanInputBox">
                <input class="IASDateTextBox" readonly TABINDEX="22" type="text" name="letterDate" id="letterDate" value="${inwardFormBean.letterDate}"/>
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
                <input class="IASDisabledTextBox" maxlength="11" disabled TABINDEX="23" type="text" name="receiptNumber" id="receiptNumber" value="${inwardFormBean.receiptNumberAsText}"/>
            </span>
        </div>
        <div class="IASFormFieldDiv">
            <span class="IASFormDivSpanLabel">
                <label>Cheque Return:</label>
            </span>
            <span class="IASFormDivSpanInputBox">
                <input class="IASCheckBox" TABINDEX="24" type="checkbox" name="chequeDDReturn" id="chequeDDReturn" value="1" disabled
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
            <span class="IASFormDivSpanInputBox IASFormDivSpanSmallInputBox" style="">
                <input class="IASDisabledTextBox" TABINDEX="25" type="text" name="chequeDDReturnReason" id="chequeDDReturnReason" value="${inwardFormBean.chequeDDReturnReason}" readonly>
            </span>
            <span class="">

            </span>
        </div>
        <div class="IASFormFieldDiv">
            <span class="IASFormDivSpanLabel">
                <label>Reason Other:</label>
            </span>
            <span class="IASFormDivSpanInputBox IASFormDivSpanSmallInputBox" style="">
                <input class="IASDisabledTextBox" TABINDEX="26" type="text" name="chequeDDReturnReasonOther" id="chequeDDReturnReasonOther" value="${inwardFormBean.chequeDDReturnReasonOther}" readonly/>
            </span>
        </div>
        <div class="IASFormFieldDiv">
            <span class="IASFormDivSpanLabel">
                <label>Return Date:</label>
            </span>
            <span class="IASFormDivSpanInputBox">
                <input class="IASDateTextBox" TABINDEX="27" disabled type="text" name="returnDate" id="returnDate" value="${inwardFormBean.returnDate}"/>
            </span>
        </div>
        <div class="IASFormFieldDiv">
            <span class="IASFormDivSpanLabel">
                <label>Ack Date:</label>
            </span>
            <span class="IASFormDivSpanInputBox">
                <input class="IASDateTextBox" TABINDEX="28" disabled type="text" name="ackDate" id="ackDate" value="${inwardFormBean.ackDate}"/>
            </span>
        </div>

        <div class="IASFormFieldDiv">
            <span class="IASFormDivSpanLabel">
                <label>Remarks:</label>
            </span>
            <span class="IASFormDivSpanInputBox">
                <textarea class="IASTextArea" maxlength="200" cols="40" rows="5" TABINDEX="29" name="remarks" id="remarks" style="text-align: left;">${inwardFormBean.remarks}</textarea>
            </span>
        </div>

        <div class="IASFormFieldDiv">
            <span class="IASFormDivSpanLabel">
                <label>Language:</label>
            </span>
            <span class="IASFormDivSpanInputBox">
                <select class="IASComboBox" TABINDEX="30" name="language" id="language">
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
</fieldset>


<%-----------------------------------------------------------------------------------------------------%>
<%-- Create Inward Actions Field Set --%>
<%-----------------------------------------------------------------------------------------------------%>
<fieldset class="subMainFieldSet">
    <div class="actionBtnDiv">
        <button onclick="setActionValue('save');" TABINDEX="29" class="IASButton SaveButton" id="btnSaveInward" name="submitAction"/>Save</button>
        <button onclick="location.href = 'inward?action=view&inwardNumber=${inwardFormBean.inwardNumber}';" type="button" TABINDEX="30" class="IASButton CancelButton" id="btnCancel">Cancel</button>
        <input onclick="location.href = 'main?action=createinward';" TABINDEX="31" class="IASButton" type="button" value="New Inward" id="btnNewInward" name="btnNewInward"/>
        <input onclick="setActionValue('edit');" TABINDEX="32" class="IASButton" type="submit" value="Edit Inward" id="btnEditInward" name="submitAction"/>
        <input onclick="setActionValue('sendAck');" TABINDEX="32" class="IASButton" type="submit" value="Send Acknowledgement" id="btnSendAck" name="submitAction"/>
        <input onclick="setActionValue('sendReturn');" TABINDEX="34" class="IASButton" type="submit" value="Send Return" id="btnSendReturn" name="submitAction"/>
    </div>
</fieldset>

