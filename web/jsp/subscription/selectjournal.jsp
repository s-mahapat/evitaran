<%@page import="IAS.Class.util"%>
<div class="IASFormLeftDiv">
    <div class="IASFormFieldDiv">
        <span class="IASFormDivSpanInputBox">
            <select size="11" TABINDEX="11" name="journalName" id="journalName" multiple="multiple">
            </select>
        </span>
    </div>
</div>

<div class="IASFormRightDiv">
    <div class="IASFormFieldDiv">
        <label class="inlinelabel">Start Year:</label>
        <select class="IASComboBoxMandatory" TABINDEX="11" name="subscriptionStartYear" id="subscriptionStartYear" onchange="">
            <%
                int year = Integer.parseInt(util.getDateString("yyyy"));
                for (int i = year; i <= year + 4; i++) {
                    out.println("<option value=\"" + i + "\">" + i + "</option>");
                }
            %>
        </select>
        <label class="inlinelabel">No of years:</label>
        <select class="IASComboBoxMandatory" TABINDEX="11" name="endYear" id="endYear">
            <%
                for (int j = 1; j <= 10; j++) {
                    out.println("<option value =\"" + j + "\">" + j + "</option>");
                }
                out.println("<option value =\"" + 100 + "\">" + 100 + "</option>");
            %>
        </select>
        <label class="inlinelabel">Start Month:</label>
        <select class="IASComboBoxMandatory" TABINDEX="11" name="startMonth" id="startMonth">
            <option value="1" selected>Jan</option>
            <option value="7">Jul</option>
        </select>
        <label class="inlinelabel">Copies:</label>
        <select class="IASComboBoxMandatory" TABINDEX="11" name="copies" id="copies">
            <%
                for (int i = 1; i <= 10; i++) {
                    out.println("<option value =\"" + i + "\">" + i + "</option>");
                }
            %>
        </select>
    </div>
    <div class="IASFormFieldDiv">
        <span class="IASFormDivSpanLabel">

        </span>

        <span class="IASFormDivSpanInputBox">

        </span>
        <span class="IASFormDivSpanLabel" style="margin-left: 5px;">

        </span>

        <span class="IASFormDivSpanInputBox">

        </span>
    </div>
</div>
<div class="actionBtnDiv">
    <input class="IASButton" style="margin-left: 0px;" TABINDEX="14" type="button" value="Add" id="btnAddLine" name="btnAddLine" onclick="addJournal()"/>
    <input class="IASButton" TABINDEX="15" type="button" value="Delete All" id="btnDeleteAll" name="btnDeleteAll" onclick="deleteRow('All')"/>
</div>
