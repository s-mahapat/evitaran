<%--
    Document   : Subscriber
--%>
<fieldset class="subMainFieldSet">
    <legend>Subscriber</legend>

    <div class="IASFormLeftDiv">

        <div class="IASFormFieldDiv">
            <span class="IASFormDivSpanLabel">
                <label>Subscriber ID:</label>
            </span>

            <span class="IASFormDivSpanInputBox">
                <input class="IASTextBox" TABINDEX="1" type="text" name="subscriberID" id="subscriberID" value=""/>
            </span>
        </div>


        <div class="IASFormFieldDiv">
            <span class="IASFormDivSpanLabel">
                <label>Subscriber Name:</label>
            </span>

            <span class="IASFormDivSpanInputBox">
                <input class="IASTextBox" TABINDEX="2" type="text" name="subscriberName" id="subscriberName" value=""/>
            </span>
        </div>


        <div class="IASFormFieldDiv">
            <span class="IASFormDivSpanLabel">
                <label>Address:</label>
            </span>

            <span class="IASFormDivSpanInputBox">
                <textarea class="IASTextArea" TABINDEX="3" name="subscriberAddress" id="subscriberAddress"></textarea>
            </span>
        </div>


        <div class="IASFormFieldDiv">
            <span class="IASFormDivSpanLabel">
                <label>City:</label>
            </span>

            <span class="IASFormDivSpanInputBox">
                <input class="IASTextBox" TABINDEX="4" type="text" name="subscriberCity" id="subscriberCity" value=""/>
            </span>
        </div>


        <div class="IASFormFieldDiv">
            <span class="IASFormDivSpanLabel">
                <label>Pin Code:</label>
            </span>

            <span class="IASFormDivSpanInputBox">
                <input class="IASTextBox" TABINDEX="5" type="text" name="subscriberPinCode" id="subscriberPinCode" value=""/>
            </span>
        </div>


        <div class="IASFormFieldDiv">
            <span class="IASFormDivSpanLabel">
                <label>Subscriber Type:</label>
            </span>

            <span class="IASFormDivSpanInputBox">
                <select class="IASComboBox" TABINDEX="6" name="subscriberType" id="subscriberType">
                    <optgroup id="optGrp1" label="Paid Subscribers">
                        <option value ="subtype">IC - Indian Schools and Colleges</option>
                        <option value ="subtype">II - Indian Institutes</option>
                        <option value ="subtype">IP - Indian Institutes</option>
                        <option value ="subtype">IN - Indian Institutes</option>
                        <option value ="subsubtype">IF - Foreign Personnel</option>
                        <option value ="subsubtype">IF - Foreign Institute</option>
                    </optgroup>
                    <optgroup id="optGrp2" label="Free Subscribers">
                        <option value ="subtype">FELJM - Fellows</option>
                        <option value ="subtype">XXX - Summer Fellows</option>
                        <option value ="subtype">AS - Associates</option>
                        <option value ="subtype">EBALL - Editorial Board Members</option>
                        <option value ="subtype">EI - Indian Exchange</option>
                        <option value ="subtype">EF - Foreign Exchange</option>
                        <option value ="subtype">JGrant - Grant</option>
                        <option value ="subtype">XXX - Authors</option>
                        <option value ="subtype">IC - Indian Schools and Colleges</option>
                    </optgroup>
                    <option value ="subtype">Agent Subscribers</option>
                    <option value ="subtype">Agents</option>
                    <option value ="subtype">Kishore Vaigyanik Yojana</option>
                </select>
            </span>
        </div>

    </div>

    <div class="IASFormRightDiv">

        <div class="IASFormFieldDiv">
            <span class="IASFormDivSpanLabel">
                <label>Creation Date:</label>
            </span>

            <span class="IASFormDivSpanInputBox">
                <input class="IASDateTextBox" readonly type="text" name="creationDate" id="creationDate" value=""/>
            </span>
        </div>


        <div class="IASFormFieldDiv">
            <span class="IASFormDivSpanLabel">
                <label>Department:</label>
            </span>

            <span class="IASFormDivSpanInputBox">
                <input class="IASTextBox" TABINDEX="7" type="text" name="department" id="department" value=""/>
            </span>
        </div>


        <div class="IASFormFieldDiv">
            <span class="IASFormDivSpanLabel">
                <label>Country:</label>
            </span>

            <span class="IASFormDivSpanInputBox">
                <select class="IASComboBox" TABINDEX="8" name="subscriberCountry" id="subscriberCountry">
                    <option value ="India">India</option>
                </select>
            </span>
        </div>


        <div class="IASFormFieldDiv">
            <span class="IASFormDivSpanLabel">
                <label>Email:</label>
            </span>

            <span class="IASFormDivSpanInputBox">
                <input class="IASEmailTextBox" TABINDEX="9" type="text" name="subscriberEmail" id="subscriberEmail" value=""/>
            </span>
        </div>


        <div class="IASFormFieldDiv">
            <span class="IASFormDivSpanLabel">
                <label>Agent:</label>
            </span>

            <span class="IASFormDivSpanInputBox">
                <select class="IASComboBox" TABINDEX="10" name="subscriberAgent" id="subscriberAgent">
                    <option value ="IASAgent">IASAgent</option>
                </select>
            </span>
        </div>

    </div>

</fieldset>

<%--Actions--%>

<fieldset class="subMainFieldSet">
    <div class="IASFormFieldDiv">
        <input type="hidden" name="action" id="action"/>
        <div id="editSubscriberBtnDiv">
            <input onclick="setActionValue('edit')" class="IASButton" TABINDEX="100" type="submit" value="Edit Details" id="btnEditSubscriber" name="btnSubmitAction"/>
        </div>
        <div id="saveSubscriberBtnDiv">
            <input onclick="setActionValue('save')" class="IASButton" TABINDEX="101" type="submit" value="Save" id="btnSaveSubscriber" name="btnSubmitAction"/>
        </div>
        <div id="displaySubscriberBtnDiv">
            <input onclick="setActionValue('display')" class="IASButton" TABINDEX="102" type="submit" value="View Details" id="btnDisplaySubscriber" name="btnSubmitAction"/>
        </div>
        <div id="viewsubscriptionBtnDiv">
            <input onclick="setActionValue('view')" class="IASButton" TABINDEX="102" type="submit" value="View Subscription" id="btnViewSubscription" name="btnSubmitAction"/>
        </div>
        <div id="addsubscriptionBtnDiv">
            <input onclick="setActionValue('add')" class="IASButton" TABINDEX="102" type="submit" value="Add Subscription" id="btnAddSubscription" name="btnSubmitAction"/>
        </div>
        <div id="generateProformaInvoiceBtnDiv">
            <input onclick="setActionValue('gpi')" class="IASButton" TABINDEX="102" type="submit" value="Generate Proforma Invoice" id="btnGenerateProformaInvoice" name="btnSubmitAction"/>
        </div>
        <div id="missingIssueListBtnDiv">
            <input onclick="setActionValue('mil')" class="IASButton" TABINDEX="102" type="submit" value="Missing Issue List" id="btnMissingIssueList" name="btnSubmitAction"/>
        </div>
    </div>
</fieldset>
