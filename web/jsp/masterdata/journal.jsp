<jsp:useBean class="IAS.Bean.masterdata.journalFormBean" id="journalFormBean" scope="request"></jsp:useBean>
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
                    <input class="IASTextBox" TABINDEX="1" type="text" name="id" id="id" value="<jsp:getProperty name="journalFormBean" property="id"/>"/>
                </span>
            </div>

           <div class="IASFormFieldDiv">
                <span class="IASFormDivSpanLabel">
                    <label>Journal Code:</label>
                </span>
                <span class="IASFormDivSpanInputBox">
                    <input class="IASTextBoxMandatory" TABINDEX="2" type="text" name="journalCode" id="journalCode" value="<jsp:getProperty name="journalFormBean" property="journalCode"/>"/>
                </span>
            </div>

           <div class="IASFormFieldDiv">
                <span class="IASFormDivSpanLabel">
                    <label>Journal Name:</label>
                </span>
                <span class="IASFormDivSpanInputBox">
                    <input class="IASTextBoxMandatory" TABINDEX="3" type="text" name="journalName" id="journalName" value="<jsp:getProperty name="journalFormBean" property="journalName"/>"/>
                </span>
            </div>

           <div class="IASFormFieldDiv">
                <span class="IASFormDivSpanLabel">
                    <label>ISSN Number:</label>
                </span>
                <span class="IASFormDivSpanInputBox">
                    <input class="IASTextBox" TABINDEX="4" type="text" name="issnNo" id="issnNo" value="<jsp:getProperty name="journalFormBean" property="issnNo"/>"/>
                </span>
            </div>

           <div class="IASFormFieldDiv">
                <span class="IASFormDivSpanLabel">
                    <label>No of Pages:</label>
                </span>
                <span class="IASFormDivSpanInputBox">
                    <input class="IASTextBox" TABINDEX="5" type="text" name="pages" id="pages" value="<jsp:getProperty name="journalFormBean" property="pages"/>"/>
                </span>
            </div>

           <div class="IASFormFieldDiv">
                <span class="IASFormDivSpanLabel">
                    <label>Start Year:</label>
                </span>
                <span class="IASFormDivSpanInputBox">
                    <input class="IASTextBox" TABINDEX="6" type="text" name="startYear" id="startYear" value="<jsp:getProperty name="journalFormBean" property="startYear"/>"/>
                </span>
            </div>

            <div class="IASFormFieldDiv">
                <span class="IASFormDivSpanLabel">
                    <label>No of Issues:</label>
                </span>
                <span class="IASFormDivSpanInputBox">
                    <input class="IASTextBox" TABINDEX="7" type="text" name="issues" id="issues" value="<jsp:getProperty name="journalFormBean" property="issues"/>"/>
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
            <input onclick="setActionValue('save')"  class="IASButton" TABINDEX="8" type="submit" value="Save" id="btnSave" name="btnSubmitAction"/>
        </div>
        <div id="editBtnDiv">
            <input onclick="setActionValue('edit')" class="IASButton" TABINDEX="9" type="submit" value="Edit" id="btnEdit" name="btnSubmitAction"/>
        </div>
        
    </div>
</fieldset>       


