<jsp:useBean class="IAS.Bean.masterdata.subTypeFormBean" id="subTypeFormBean" scope="request"></jsp:useBean>

<%-----------------------------------------------------------------------------------------------------%>
<%-- Create New subscriber Type Data Field Set --%>
<%-----------------------------------------------------------------------------------------------------%>

<fieldset class="subMainFieldSet">
    <div class="IASFormFieldDiv">
        <div class="IASFormLeftDiv">
            <div class="IASFormFieldDiv">
                <span class="IASFormDivSpanLabel">
                    <label>Subscriber Type Id:</label>
                </span>
                <span class="IASFormDivSpanInputBox">
                    <input class="IASTextBox" TABINDEX="1" readonly="readonly" type="text" name="id" id="id" value="<jsp:getProperty name="subTypeFormBean" property="id"/>"/>
                </span>
            </div>

           <div class="IASFormFieldDiv">
                <span class="IASFormDivSpanLabel">
                    <label>Sub Type Code:</label>
                </span>
                <span class="IASFormDivSpanInputBox">
                    <input class="IASTextBoxMandatory" TABINDEX="2" type="text" name="subtypecode" id="subtypecode" value="<jsp:getProperty name="subTypeFormBean" property="subtypecode"/>"/>
                </span>
            </div>

           <div class="IASFormFieldDiv">
                <span class="IASFormDivSpanLabel">
                    <label>Subscriber Type:</label>
                </span>
                <span class="IASFormDivSpanInputBox">
                    <input class="IASTextBoxMandatory" TABINDEX="3" type="text" name="subtypedesc" id="subtypedesc" value="<jsp:getProperty name="subTypeFormBean" property="subtypedesc"/>"/>
                </span>
            </div>

            <div class="IASFormFieldDiv">
                <span class="IASFormDivSpanLabel">
                    <label>Free/ Paid</label>
                </span>
                <span class="IASFormDivSpanInputBox">

                    <select class="IASComboBoxMandatory" TABINDEX="4" name="subtype" id="subtype" onchange="setNoofFreeCopies()">
                        <option value ="Paid">Paid</option>
                        <option value ="Free">Free</option>
                    </select>
                </span>
            </div>

            <div class="IASFormFieldDiv">
                <span class="IASFormDivSpanLabel">
                    <label>Nationality</label>
                </span>
                <span class="IASFormDivSpanInputBox">
                    <select class="IASComboBoxMandatory" TABINDEX="5" name="nationality" id="nationality">
                        <option value ="I">Indian</option>
                        <option value ="F">Foreign</option>
                    </select>
                </span>
            </div>

            <div class="IASFormFieldDiv">
                <span class="IASFormDivSpanLabel">
                    <label>Institutional</label>
                </span>
                <span class="IASFormDivSpanInputBox">
                    <select class="IASComboBoxMandatory" TABINDEX="6" name="institutional" id="institutional">
                        <option value ="I">Institute</option>
                        <option value ="P">Personal</option>
                    </select>
                </span>
            </div>
           <div class="IASFormFieldDiv">
                <span class="IASFormDivSpanLabel">
                    <label>Free Copies:</label>
                </span>
                <span class="IASFormDivSpanInputBox">
                    <input class="IASTextBoxMandatory" TABINDEX="7" type="text" name="freejrnl" id="freejrnl" value="<jsp:getProperty name="subTypeFormBean" property="freejrnl"/>"/>
                </span>
            </div>

           <div class="IASFormFieldDiv">
                <span class="IASFormDivSpanLabel">
                    <label>Discount if any %:</label>
                </span>
                <span class="IASFormDivSpanInputBox">
                    <input class="IASTextBox" TABINDEX="8" type="text" name="discount" id="discount" value="<jsp:getProperty name="subTypeFormBean" property="discount"/>"/>
                </span>
            </div>
         </div>
    </div>
</fieldset>
<%-----------------------------------------------------------------------------------------------------%>
<%-- Create New subscriber Type Actions Field Set --%>
<%-----------------------------------------------------------------------------------------------------%>

<fieldset class="subMainFieldSet">
    <div class="IASFormFieldDiv">
        <input type="hidden" name="action" id="action"/>
        <div id="saveBtnDiv">
            <input onclick="setActionValue('save')"  class="IASButton" TABINDEX="9" type="submit" value="save" id="btnSave" name="btnSubmitAction"/>
        </div>
        <div id="editBtnDiv">
            <input onclick="setActionValue('edit')" class="IASButton" TABINDEX="10" type="submit" value="edit" id="btnEdit" name="btnSubmitAction"/>
        </div>
    </div>
</fieldset>

