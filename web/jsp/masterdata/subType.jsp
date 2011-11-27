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
                    <input class="IASTextBox" TABINDEX="10" type="text" name="subScriberTypeId" id="SubScriberTypeId" value=""/>
                </span>
            </div>

           <div class="IASFormFieldDiv">
                <span class="IASFormDivSpanLabel">
                    <label>Sub Type Code:</label>
                </span>
                <span class="IASFormDivSpanInputBox">
                    <input class="IASTextBox" TABINDEX="10" type="text" name="subScriberTypeCode" id="SubScriberTypeCode" value=""/>
                </span>
            </div>

           <div class="IASFormFieldDiv">
                <span class="IASFormDivSpanLabel">
                    <label>Subscriber Type:</label>
                </span>
                <span class="IASFormDivSpanInputBox">
                    <input class="IASTextBox" TABINDEX="10" type="text" name="subScriberType" id="SubScriberType" value=""/>
                </span>
            </div>

            <div class="IASFormFieldDiv">
                <span class="IASFormDivSpanLabel">
                    <label>Free</label>
                </span>
                <span class="IASFormDivSpanInputBox">
                    <input class="IASOptionButton" TABINDEX="10" type="radio" name="free" id="free" value=""/>
                </span>
                <span class="IASFormDivSpanLabelRadio">
                    <label>Paid</label>
                </span>
                <span class="IASFormDivSpanInputBox">
                    <input class="IASOptionButton" TABINDEX="10" type="radio" name="Paid" id="Paid" value=""/>
                </span>
            </div>

           <div class="IASFormFieldDiv">
                <span class="IASFormDivSpanLabel">
                    <label>No of Copies:</label>
                </span>
                <span class="IASFormDivSpanInputBox">
                    <input class="IASTextBox" TABINDEX="10" type="text" name="noOfCopies" id="noOfCopies" value=""/>
                </span>
            </div>

           <div class="IASFormFieldDiv">
                <span class="IASFormDivSpanLabel">
                    <label>Discount if any %:</label>
                </span>
                <span class="IASFormDivSpanInputBox">
                    <input class="IASTextBox" TABINDEX="10" type="text" name="discount" id="discount" value=""/>
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
            <input onclick="setActionValue('save')"  class="IASButton" TABINDEX="101" type="submit" value="save" id="btnSave" name="btnSubmitAction"/>
        </div>
        <div id="editBtnDiv">
            <input onclick="setActionValue('edit')" class="IASButton" TABINDEX="101" type="submit" value="edit" id="btnEdit" name="btnSubmitAction"/>
        </div>
    </div>
</fieldset>

