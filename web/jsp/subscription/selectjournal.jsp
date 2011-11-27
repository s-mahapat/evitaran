<%--
    Document   : Select Journal
--%>
<fieldset class="subMainFieldSet">
    <legend>Select Journal</legend>

    <div class="IASFormFieldDiv">
        <span class="IASFormDivSpanLabel">
            <label>Start Year:</label>
        </span>

        <span class="IASFormDivSpanInputBox">
            <select class="IASComboBox" TABINDEX="11" name="subscriptionStartYear" id="subscriptionStartYear">
                <option value ="IASAgent">2007</option>
                <option value ="IASAgent">2008</option>
            </select>
        </span>


        <span class="IASFormDivSpanLabel">
            <label>Journal name:</label>
        </span>

        <span class="IASFormDivSpanInputBox">
            <select class="IASComboBox" TABINDEX="11" name="journalName" id="journalName">
                <option value ="journal">Pramana</option>
                <option value ="journal">Resonance</option>
                <option value ="journal">Material Science</option>
            </select>
        </span>


        <span class="IASFormDivSpanLabel">
            <label>Number Of Copies:</label>
        </span>

        <span class="IASFormDivSpanInputBox">
            <input class="IASTextBoxForNumbers" TABINDEX="13" type="text" name="noOfCopies" id="noOfCopies" value=""/>
        </span>


        <span class="IASFormDivSpanLabel">
            <label>Number Of Years:</label>
        </span>

        <span class="IASFormDivSpanInputBox">
            <input class="IASTextBoxForNumbers" TABINDEX="13" type="text" name="noOfYears" id="noOfYears" value=""/>
        </span>

        <span class="IASFormDivSpanInputBox">
            <input class="IASButton" TABINDEX="14" type="button" value="Add Journal" id="btnAddLine" name="btnAddLine" onclick="addJournalToList(subscriptionForm)"/>
        </span>
    </div>
</fieldset>



