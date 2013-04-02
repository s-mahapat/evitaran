<%@page language="java" import="java.util.*" %>
<jsp:useBean class="IAS.Bean.Subscriber.subscriberFormBean" id="subscriberFormBean" scope="request"></jsp:useBean>
<fieldset class="subMainFieldSet">
    <legend>Subscriber</legend>

    <div class="IASFormLeftDiv">

        <div class="IASFormFieldDiv">
            <span class="IASFormDivSpanLabel">
                <label>Subscriber No:</label>
            </span>

            <span class="IASFormDivSpanInputBox">
                <input class="IASDisabledTextBox" readonly type="text" name="subscriberNumber" id="subscriberNumber" value="${subscriberFormBean.subscriberNumber}"/>
            </span>
        </div>


        <div class="IASFormFieldDiv">
            <span class="IASFormDivSpanLabel">
                <label>Subscriber Name:</label>
            </span>

            <span class="IASFormDivSpanInputBox">
                <input class="IASTextBoxMandatoryWide" TABINDEX="1" maxlength="64" type="text" name="subscriberName" id="subscriberName" value="${subscriberFormBean.subscriberName}"/>
            </span>
        </div>

        <div class="IASFormFieldDiv">
            <span class="IASFormDivSpanLabel">
                <label>Shipping Address:</label>
            </span>

            <span class="IASFormDivSpanInputBox">
                <textarea onkeydown="return imposeMaxLength(event, this, 128);" onchange="copyShippingAddress()" rows="4" cols="35" class="IASTextArea" TABINDEX="2" name="shippingAddress" id="shippingAddress">${subscriberFormBean.shippingAddress}</textarea>
            </span>
        </div>

        <div class="IASFormFieldDiv">
            <span class="IASFormDivSpanLabel">
                <label>Invoice Address:</label>
            </span>
            <span class="IASFormDivSpanInputBox">
                <input type="checkbox" id="copyshipaddress" TABINDEX="3" name="sameInvoiceAddress" onchange="copyShippingAddress()"><label>Same as Shipping Address</label>
            </span>

        </div>
        <div class="IASFormFieldDiv">
            <span class="IASFormDivSpanLabel">
                <label>&nbsp;</label>
            </span>
            <span class="IASFormDivSpanInputBox">
                <textarea onkeydown="return imposeMaxLength(event, this, 128);" rows="4" cols="35" class="IASTextArea" TABINDEX="4" name="invoiceAddress" id="invoiceAddress">${subscriberFormBean.invoiceAddress}</textarea>
            </span>
        </div>

        <div class="IASFormFieldDiv">
            <span class="IASFormDivSpanLabel">
                <label>City:</label>
            </span>

            <span class="IASFormDivSpanInputBox">
                <input class="IASTextBoxMandatory" TABINDEX="5" name="city" id="city" value="${subscriberFormBean.city}"/>
            </span>
        </div>

        <div class="IASFormFieldDiv">
            <span class="IASFormDivSpanLabel">
                <label>District:</label>
            </span>

            <span class="IASFormDivSpanInputBox">
                <select class="IASComboBox" TABINDEX="6" name="district" id="district">
                    <option value="0" selected >Select</option>
                    <%
                        if (subscriberFormBean.getDistrict() != null && !subscriberFormBean.getDistrict().isEmpty()) {
                            out.println("<option value=" + "\"" + subscriberFormBean.getDistrict() + "\"" + " selected >" + subscriberFormBean.getDistrict() + "</option>");
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
                <select class="IASComboBoxMandatory" TABINDEX="7" name="state" id="state">
                    <option value="" selected >Select</option>
                    <%
                        if (subscriberFormBean.getState() != null && !subscriberFormBean.getState().isEmpty()) {
                            out.println("<option value=" + "\"" + subscriberFormBean.getState() + "\"" + " selected >" + subscriberFormBean.getState() + "</option>");
                        }
                    %>
                </select>
                <%--<input class="IASTextBoxMandatory" TABINDEX="3" name="state" id="state" value="<jsp:getProperty name="inwardFormBean" property="state"/>"--%>
            </span>
        </div>

        <div class="IASFormFieldDiv">
            <span class="IASFormDivSpanLabel">
                <label>Country:</label>
            </span>

            <span class="IASFormDivSpanInputBox">
                <select class="IASComboBoxMandatory" TABINDEX="8" name="country" id="country">
                    <option value="0" selected >Select</option>
                    <%
                        if (subscriberFormBean.getCountry() != null && !subscriberFormBean.getCountry().isEmpty()) {
                            out.println("<option value=" + "\"" + subscriberFormBean.getCountry() + "\"" + " selected >" + subscriberFormBean.getCountry() + "</option>");
                        }
                    %>
                </select>
            </span>
        </div>

        <div class="IASFormFieldDiv">
            <span class="IASFormDivSpanLabel">
                <label>Pin Code:</label>
            </span>

            <span class="IASFormDivSpanInputBox">
                <input class="IASTextBox" maxlength="6" TABINDEX="9" type="text" name="pincode" id="pincode" value="${subscriberFormBean.pincodeAsText}"/>
            </span>
        </div>


        <div class="IASFormFieldDiv">
            <span class="IASFormDivSpanLabel">
                <label>Subscriber Type:</label>
            </span>

            <span class="IASFormDivSpanInputBox">
                <select class="IASComboBoxSmallMandatory" TABINDEX="10" name="subtype" id="subtype"
                        onchange="subtypeAppend()">
                    <option value="" selected >Select</option>
                    <%
                        if (subscriberFormBean.getSubtype() != null && !subscriberFormBean.getSubtype().isEmpty()) {
                            out.println("<option value=" + "\"" + subscriberFormBean.getSubtype() + "\"" + " selected >" + subscriberFormBean.getSubtype() + "</option>");
                        }
                    %>
                </select>
            </span>
        </div>
        <div class="IASFormFieldDiv">
            <span class="IASFormDivSpanLabel">
                <label>Description:</label>
            </span>
            <span class="IASFormDivSpanInputBox">
                <select class="IASComboBoxMandatory" TABINDEX="11" name="subtypedesc" id="subtypedesc"
                        onchange="subtypeCodeAppend()">
                    <option value="">Select</option>
                    <%
                        if (subscriberFormBean.getSubtypedesc() != null && !subscriberFormBean.getSubtypedesc().isEmpty()) {
                            out.println("<option value=" + "\"" + subscriberFormBean.getSubtypedesc() + "\"" + " selected >" + subscriberFormBean.getSubtypedesc() + "</option>");
                        }
                    %>
                </select>

            </span>
        </div>
        <div class="IASFormFieldDiv">
            <span class="IASFormDivSpanLabel">
                <label>Subscriber Code:</label>
            </span>
            <span class="IASFormDivSpanInputBox">
                <input type="hidden" id="subtypecode_hidden" name="subtypecode" />
                <label id="subtypecode" name="subtypecode"></label>
            </span>

        </div>
    </div>

    <div class="IASFormRightDiv">

        <div class="IASFormFieldDiv">
            <span class="IASFormDivSpanLabel">
                <label>Creation Date:</label>
            </span>

            <span class="IASFormDivSpanInputBox">
                <input class="IASDateTextBox" readonly type="text" name="subscriberCreationDate" id="subscriberCreationDate" value="${subscriberFormBean.subscriberCreationDate}"/>
            </span>
        </div>


        <div class="IASFormFieldDiv">
            <span class="IASFormDivSpanLabel">
                <label>Department:</label>
            </span>

            <span class="IASFormDivSpanInputBox">
                <input class="IASTextBoxWide" TABINDEX="12" maxlength="64" type="text" name="department" id="department" value="${subscriberFormBean.department}"/>
            </span>
        </div>

        <div class="IASFormFieldDiv">
            <span class="IASFormDivSpanLabel">
                <label>Institution:</label>
            </span>

            <span class="IASFormDivSpanInputBox">
                <input class="IASTextBoxWide" TABINDEX="13" maxlength="64" type="text" name="institution" id="institution" value="${subscriberFormBean.institution}"/>
            </span>
        </div>


        <div class="IASFormFieldDiv">
            <span class="IASFormDivSpanLabel">
                <label>Email:</label>
            </span>

            <span class="IASFormDivSpanInputBox">
                <input class="IASTextBoxWide" TABINDEX="14" maxlength="64" type="text" name="email" id="email" onblur="validateEmail(this.id)" value="${subscriberFormBean.email}"/>
            </span>
        </div>

        <div class="IASFormFieldDiv">
            <span class="IASFormDivSpanLabel">
                <label>Phone:</label>
            </span>

            <span class="IASFormDivSpanInputBox">
                <input class="IASTextBox" TABINDEX="15" maxlength="50" type="text" name="phone" id="phone" value="${subscriberFormBean.phone}"/>
            </span>
        </div>

        <div class="IASFormFieldDiv">
            <span class="IASFormDivSpanLabel">
                <label>Fax:</label>
            </span>

            <span class="IASFormDivSpanInputBox">
                <input class="IASTextBox" TABINDEX="16" maxlength="50" type="text" name="fax" id="fax" value="${subscriberFormBean.fax}"/>
            </span>
        </div>

        <div class="IASFormFieldDiv">
            <span class="IASFormDivSpanLabel">
                <label>Deactivate</label>
            </span>

            <span class="IASFormDivSpanInputBox">
                <input type="checkbox" class="IASCheckBox" disabled TABINDEX="17" name="deactive" id="deactive" onclick="deActivateSubscriber()"
                       <%
                           String isEnabled = "enabled";
                           if (subscriberFormBean.isDeactive() == true) {
                               out.println(" checked ");
                               isEnabled = "disabled";
                           }
                       %>
                       />
            </span>
        </div>

        <div class="IASFormFieldDiv">
            <span class="IASFormDivSpanLabel">
                <label>Deactivation Date:</label>
            </span>

            <span class="IASFormDivSpanInputBox">
                <input class="IASDateTextBox"  TABINDEX="-1" readonly type="text" name="deactivationDate" id="deactivationDate" value="${subscriberFormBean.deactivationDate}"/>
            </span>
        </div>

    </div>

</fieldset>

<%--Actions--%>

<fieldset class="subMainFieldSet">
    <div class="actionBtnDiv">
        <input onclick="setActionValue('edit')" class="IASButton" TABINDEX="18" type="submit" value="Edit" id="btnEditSubscriber" name="btnSubmitAction"/>
        <button onclick="setActionValue('save')" class="IASButton SaveButton" TABINDEX="19" type="submit" value="Save" id="btnSaveSubscriber" name="btnSubmitAction"/>Save</button>
        <button onclick="location.href='subscriber?action=display&subscriberNumber=${subscriberFormBean.subscriberNumber}'" class="IASButton CancelButton" TABINDEX="19" type="button" id="btnCancel"/>Cancel</button>
    </div>
</fieldset>
