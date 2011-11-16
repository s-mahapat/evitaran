<%-----------------------------------------------------------------------------------------------------%>
<%-- Journal Data Field Set --%>
<%-----------------------------------------------------------------------------------------------------%> 

<fieldset class="subMainFieldSet">
    <div class="IASFormFieldDiv">
        <div class="IASFormLeftDiv">    
            <div class="IASFormFieldDiv">
                <span class="IASFormDivSpanLabel">
                    <label>Journal Id:</label>
                </span>
                <span class="IASFormDivSpanInputBox">
                    <input class="IASTextBox" TABINDEX="1" type="text" name="journalId" id="journalId" value=""/>
                </span>
            </div>

           <div class="IASFormFieldDiv">
                <span class="IASFormDivSpanLabel">
                    <label>Journal Code:</label>
                </span>
                <span class="IASFormDivSpanInputBox">
                    <input class="IASTextBox" TABINDEX="10" type="text" name="journalCode" id="journalCode" value=""/>
                </span>
            </div>

           <div class="IASFormFieldDiv">
                <span class="IASFormDivSpanLabel">
                    <label>Journal Name:</label>
                </span>
                <span class="IASFormDivSpanInputBox">
                    <input class="IASTextBox" TABINDEX="10" type="text" name="journalName" id="journalName" value=""/>
                </span>
            </div>

           <div class="IASFormFieldDiv">
                <span class="IASFormDivSpanLabel">
                    <label>ISSN Number:</label>
                </span>
                <span class="IASFormDivSpanInputBox">
                    <input class="IASTextBox" TABINDEX="10" type="text" name="issnNo" id="issnNo" value=""/>
                </span>
            </div>

           <div class="IASFormFieldDiv">
                <span class="IASFormDivSpanLabel">
                    <label>No of Pages:</label>
                </span>
                <span class="IASFormDivSpanInputBox">
                    <input class="IASTextBox" TABINDEX="10" type="text" name="noOfPages" id="noOfPages" value=""/>
                </span>
            </div>

           <div class="IASFormFieldDiv">
                <span class="IASFormDivSpanLabel">
                    <label>Start Year:</label>
                </span>
                <span class="IASFormDivSpanInputBox">
                    <input class="IASTextBox" TABINDEX="10" type="text" name="startYear" id="startYear" value=""/>
                </span>
            </div>
         </div>
    </div>
</fieldset> 
<%-----------------------------------------------------------------------------------------------------%>
<%-- Journal Actions Field Set --%>
<%-----------------------------------------------------------------------------------------------------%> 

<fieldset class="subMainFieldSet">
    <div class="IASFormFieldDiv">
        <input type="hidden" name="action" id="action"/>
        <div id="saveBtnDiv">
            <input onclick="setActionValue('save')"  class="IASButton" TABINDEX="101" type="submit" value="Save" id="btnSave" name="btnSubmitAction"/>
        </div>
        <div id="updateBtnDiv">
            <input onclick="setActionValue('update')" class="IASButton" TABINDEX="101" type="submit" value="Edit Subscription" id="btnEdit" name="btnSubmitAction"/>
        </div>
    </div>
</fieldset>       


