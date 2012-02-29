<jsp:useBean class="IAS.Bean.masterdata.countryFormBean" id="countryFormBean" scope="request"></jsp:useBean>
<%-----------------------------------------------------------------------------------------------------%>
<%-- Country Basic data Field Set --%>
<%-----------------------------------------------------------------------------------------------------%>

<fieldset class="subMainFieldSet">
    <legend>Country</legend>
    <div class="IASFormFieldDiv">
        <div class="IASFormLeftDiv">
            <div class="IASFormFieldDiv">
                <span class="IASFormDivSpanLabel">
                    <label>Country Id:</label>
                </span>
                <span class="IASFormDivSpanInputBox">
                    <input class="IASTextBox" TABINDEX="1" readonly="readonly" type="text" name="id" id="id" value="<jsp:getProperty name="countryFormBean" property="id"/>"/>
                </span>
            </div>
            <div class="IASFormFieldDiv">
                <span class="IASFormDivSpanLabel">
                    <label>Country:</label>
                </span>
                <span class="IASFormDivSpanInputBox">
                    <input class="IASTextBoxMandatory" TABINDEX="2" type="text" name="country" id="country" value="<jsp:getProperty name="countryFormBean" property="country"/>"/>
                </span>
            </div>
        </div>
     </div>
</fieldset>
<%-----------------------------------------------------------------------------------------------------%>
<%-- Country Basic Action Field Set --%>
<%-----------------------------------------------------------------------------------------------------%>

<fieldset class="subMainFieldSet">
    <div class="IASFormFieldDiv">
        <input type="hidden" name="action" id="action"/>
        <div id="saveBtnDiv">
            <input onclick="setActionValue('save')"  class="IASButton" TABINDEX="3" type="submit" value="save" id="btnSave" name="btnSubmitAction"/>
        </div>
        <div id="editBtnDiv">
            <input onclick="setActionValue('edit')" class="IASButton" TABINDEX="4" type="submit" value="edit" id="btnEdit" name="btnSubmitAction"/>
        </div>
    </div>
</fieldset>


