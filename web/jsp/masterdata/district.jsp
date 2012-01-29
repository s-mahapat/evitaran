<jsp:useBean class="IAS.Bean.masterdata.districtFormBean" id="districtFormBean" scope="request"></jsp:useBean>
<%-----------------------------------------------------------------------------------------------------%>
<%-- District Basic data Field Set --%>
<%-----------------------------------------------------------------------------------------------------%>

<fieldset class="subMainFieldSet">
    <legend>District</legend>
    <div class="IASFormFieldDiv">
        <div class="IASFormLeftDiv">
            <div class="IASFormFieldDiv">
                <span class="IASFormDivSpanLabel">
                    <label>District Id:</label>
                </span>
                <span class="IASFormDivSpanInputBox">
                    <input class="IASTextBoxMandatory" TABINDEX="1" type="text" name="districtId" id="districtId" value="<jsp:getProperty name="districtFormBean" property="districtId"/>"/>
                </span>
            </div>
            <div class="IASFormFieldDiv">
                <span class="IASFormDivSpanLabel">
                    <label>District:</label>
                </span>
                <span class="IASFormDivSpanInputBox">
                    <input class="IASTextBoxMandatory" TABINDEX="1" type="text" name="district" id="district" value="<jsp:getProperty name="districtFormBean" property="district"/>"/>
                </span>
            </div>
        </div>
     </div>
</fieldset>
<%-----------------------------------------------------------------------------------------------------%>
<%-- District Basic Action Field Set --%>
<%-----------------------------------------------------------------------------------------------------%>

<fieldset class="subMainFieldSet">
    <div class="IASFormFieldDiv">
        <input type="hidden" name="action" id="action"/>
        <div id="saveBtnDiv">
            <input onclick="setActionValue('save')"  class="IASButton" TABINDEX="2" type="submit" value="save" id="btnSave" name="btnSubmitAction"/>
        </div>
        <div id="editBtnDiv">
            <input onclick="setActionValue('edit')" class="IASButton" TABINDEX="2" type="submit" value="edit" id="btnEdit" name="btnSubmitAction"/>
        </div>
    </div>
</fieldset>


