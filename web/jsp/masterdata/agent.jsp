
<%-- Calendar --%>
<%--------------------------------------------------------------%>
<script src="<%=request.getContextPath() + "/js/CalendarPopup.js"%>" type="text/javascript"></script>
<script type="text/javascript">
    //var calFrom = new CalendarPopup("dateDiv");
    //calFrom.showNavigationDropdowns();
    $(function() {
		$( "#regDate" ).datepicker({
			showOn: "button",
                        dateFormat: 'dd/mm/yy',
			buttonImage: "images/calendar.gif",
			buttonImageOnly: true
		});
	});

</script>
<%-----------------------------------------------------------------------------------------------------%>
<%-- Agent Data Basic data Field Set --%>
<%-----------------------------------------------------------------------------------------------------%>

<fieldset class="subMainFieldSet">
    <div class="IASFormFieldDiv">
        <legend>Agent Details</legend>
        <div class="IASFormLeftDiv">
            <div class="IASFormFieldDiv">
                <span class="IASFormDivSpanLabel">
                    <label>Agent Id:</label>
                </span>
                <span class="IASFormDivSpanInputBox">
                    <input class="IASTextBox" TABINDEX="1" type="text" name="agentId" id="agentId" value=""/>
                </span>
            </div>

           <div class="IASFormFieldDiv">
                <span class="IASFormDivSpanLabel">
                    <label>Agent Name:</label>
                </span>
                <span class="IASFormDivSpanInputBox">
                    <input class="IASTextBox" TABINDEX="10" type="text" name="agentName" id="agentName" value=""/>
                </span>
            </div>
        </div>
        <div class="IASFormRightDiv">

           <div class="IASFormFieldDiv">
                <span class="IASFormDivSpanLabel">
                    <label>Subscriber Type</label>
                </span>
                <span class="IASFormDivSpanInputBox">
                   <select class="IASComboBox" TABINDEX="6" name="subType" id="subType">
                        <option value ="AEG">AGENT</option>
                   </select>
                </span>
            </div>

           <div class="IASFormFieldDiv">
                <span class="IASFormDivSpanLabel">
                    <label>Registration Date:</label>
                </span>
                <%---------- Date Division -----------%>
                    <div class="dateDiv" id="dateDiv"></div>

                    <%------ From Date Input Box ------%>
                    <span class="IASFormDivSpanInputBox">
                         <input type="text" class="IASDateTextBox" readonly size="10" name="regDate" id="regDate"/>
                  </span>
              </div>
         </div>
    </div>
</fieldset>
<%-----------------------------------------------------------------------------------------------------%>
<%-- Agent Data Address Field Set --%>
<%-----------------------------------------------------------------------------------------------------%>

<fieldset class="subMainFieldSet">
    <div class="IASFormFieldDiv">
        <legend>Address Details</legend>

        <div class="IASFormLeftDiv">
            <div class="IASFormFieldDiv">
                <span class="IASFormDivSpanLabel">
                    <label>email Id:</label>
                </span>
                <span class="IASFormDivSpanInputBox">
                    <input class="IASTextBox" TABINDEX="1" type="text" name="emailId" id="emailId" value=""/>
                </span>
            </div>

           <div class="IASFormFieldDiv">
                <span class="IASFormDivSpanLabel">
                    <label>Address 1:</label>
                </span>
                <span class="IASFormDivSpanInputBox">
                    <input class="IASTextBox" TABINDEX="10" type="text" name="address1" id="address1" value=""/>
                </span>
            </div>


           <div class="IASFormFieldDiv">
                <span class="IASFormDivSpanLabel">
                    <label>Address 2:</label>
                </span>
                <span class="IASFormDivSpanInputBox">
                    <input class="IASTextBox" TABINDEX="10" type="text" name="address2" id="address2" value=""/>
                </span>
            </div>
         </div>

         <div class="IASFormRightDiv">
           <div class="IASFormFieldDiv">
                <span class="IASFormDivSpanLabel">
                    <label>City:</label>
                </span>
                <span class="IASFormDivSpanInputBox">
                    <input class="IASTextBox" TABINDEX="10" type="text" name="city" id="city" value=""/>
                </span>
            </div>

           <div class="IASFormFieldDiv">
                <span class="IASFormDivSpanLabel">
                    <label>Country:</label>
                </span>
                <span class="IASFormDivSpanInputBox">
                    <input class="IASTextBox" TABINDEX="10" type="text" name="country" id="country" value=""/>
                </span>
            </div>

           <div class="IASFormFieldDiv">
                <span class="IASFormDivSpanLabel">
                    <label>PIN Code:</label>
                </span>
                <span class="IASFormDivSpanInputBox">
                    <input class="IASTextBox" TABINDEX="10" type="text" name="pinCode" id="pinCode" value=""/>
                </span>
            </div>
         </div>
    </div>
</fieldset>
<%-----------------------------------------------------------------------------------------------------%>
<%-- Agent Actions Field Set --%>
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


