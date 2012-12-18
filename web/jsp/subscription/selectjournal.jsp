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
        <span class="IASFormDivSpanLabel">
            <label>Start Year:</label>
        </span>

        <span class="IASFormDivSpanInputBox">
            <select class="IASComboBoxMandatory" TABINDEX="11" name="subscriptionStartYear" id="subscriptionStartYear" onchange="setEndYear()">
                <%
                    int year = Integer.parseInt(util.getDateString("yyyy"));
                    for (int i = year; i <= year + 4; i++) {
                        out.println("<option value=\"" + i + "\">" + i + "</option>");
                    }
                %>
            </select>
        </span>
        <span class="IASFormDivSpanLabel">
            <label>No of years:</label>
        </span>

        <span class="IASFormDivSpanInputBox">
            <select class="IASComboBoxMandatory" TABINDEX="11" name="endYear" id="endYear">
                <%
                    for (int j = 1; j <= 10; j++) {
                        out.println("<option value =\"" + j + "\">" + j + "</option>");
                    }
                %>
            </select>
        </span>

        <%--!--<span class="IASFormDivSpanLabel">
    <label>End Year:</label>
</span>

        <span class="IASFormDivSpanInputBox">
            <select class="IASComboBoxMandatory" TABINDEX="11" name="endYear" id="endYear">
        <%
            for (int j = 0; j <= 4; j++) {
                out.println("<option value =\"" + (j + year) + "\">" + (j + year) + "</option>");
            }

        </select>
        </span>--%>
    </div>
    <div class="IASFormFieldDiv">
        <span class="IASFormDivSpanLabel">
            <label>Start Month:</label>
        </span>

        <span class="IASFormDivSpanInputBox">
            <select class="IASComboBoxMandatory" TABINDEX="11" name="startMonth" id="startMonth">
                <option value="1" selected>Jan</option>
                <option value="7">Jul</option>
            </select>
        </span>
        <span class="IASFormDivSpanLabel" style="margin-left: 5px;">
            <label>Copies:</label>
        </span>

        <span class="IASFormDivSpanInputBox">
            <select class="IASComboBoxMandatory" TABINDEX="11" name="copies" id="copies">
                <%
                    for (int i = 1; i <= 10; i++) {
                        out.println("<option value =\"" + i + "\">" + i + "</option>");
                    }
                %>
            </select>
        </span>
    </div>
</div>
<div class="actionBtnDiv">
    <input class="IASButton" style="margin-left: 0px;" TABINDEX="14" type="button" value="Add" id="btnAddLine" name="btnAddLine" onclick="addJournal()"/>
    <input class="IASButton" TABINDEX="15" type="button" value="Delete All" id="btnDeleteAll" name="btnDeleteAll" onclick="deleteRow('All')"/>
</div>
