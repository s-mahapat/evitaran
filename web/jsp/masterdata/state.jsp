
<%-----------------------------------------------------------------------------------------------------%>
<%-- State Basic data Field Set --%>
<%-----------------------------------------------------------------------------------------------------%>

<fieldset class="subMainFieldSet">
    <legend>State</legend>
    <div class="IASFormFieldDiv">
        <div class="IASFormLeftDiv">
            <div class="IASFormFieldDiv">
                <span class="IASFormDivSpanLabel">
                    <label>State Id:</label>
                </span>
                <span class="IASFormDivSpanInputBox">
                    <input class="IASTextBox" TABINDEX="1" type="text" name="stateId" id="stateId" value=""/>
                </span>
            </div>
            <div class="IASFormFieldDiv">
                <span class="IASFormDivSpanLabel">
                    <label>State:</label>
                </span>
                <span class="IASFormDivSpanInputBox">
                    <input class="IASTextBox" TABINDEX="1" type="text" name="state" id="state" value=""/>
                </span>
            </div>
        </div>
     </div>
</fieldset>
<%-----------------------------------------------------------------------------------------------------%>
<%-- State Basic Action Field Set --%>
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


