
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
                    <input class="IASTextBox" TABINDEX="1" type="text" name="countryId" id="countryId" value=""/>
                </span>
            </div>
            <div class="IASFormFieldDiv">
                <span class="IASFormDivSpanLabel">
                    <label>Country:</label>
                </span>
                <span class="IASFormDivSpanInputBox">
                    <input class="IASTextBox" TABINDEX="1" type="text" name="country" id="country" value=""/>
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
            <input onclick="setActionValue('save')"  class="IASButton" TABINDEX="2" type="submit" value="save" id="btnSave" name="btnSubmitAction"/>
        </div>
        <div id="editBtnDiv">
            <input onclick="setActionValue('edit')" class="IASButton" TABINDEX="2" type="submit" value="edit" id="btnEdit" name="btnSubmitAction"/>
        </div>
    </div>
</fieldset>


