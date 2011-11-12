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
                    <label>Subscriber Type Code:</label>
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
                    <label>Free or Paid:</label>
                </span>
                <span class="IASFormDivSpanInputBox">
                    <input class="IASOptionButton" TABINDEX="10" type="radio" name="free" id="free" value=""/>
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
        <div id="AddNewSubTypeDiv">
            <input class="IASButton" TABINDEX="12" type="submit" value="Create New Sub type" name="btnAddNew"/>
        </div>    
        <div id="saveBtnDiv">
            <input class="IASButton" TABINDEX="13" type="button" value="Save" name="btnSave" onclick="aftersave()"/>
        </div>

    </div>
</fieldset>       


