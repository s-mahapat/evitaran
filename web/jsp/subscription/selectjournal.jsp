<%--
    Document   : Select Journal
--%>
<%@page import="IAS.Class.util"%>

<fieldset class="subMainFieldSet">
    <legend>Select Journal</legend>

    <div class="IASFormFieldDiv">
        <span class="IASFormDivSpanLabel">
            <label>Start Year:</label>
        </span>

        <span class="IASFormDivSpanInputBox">
            <select class="IASComboBox" TABINDEX="11" name="subscriptionStartYear" id="subscriptionStartYear">
                <%
                    int year = Integer.parseInt(util.getDateString("yyyy"));
                    for (int i = year; i < year + 5; i++) {%>
                <option value ="year"><%= i%></option><%
                    }
                %>
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
            <select class="IASComboBox" TABINDEX="11" name="noOfCopies" id="noOfCopies">
                <%
                    for (int i = 0; i < 20; i++) {%>
                <option value ="copies"><%= i + 1%></option><%
                    }
                %>
            </select>
        </span>


        <span class="IASFormDivSpanLabel">
            <label>Number Of Years:</label>
        </span>

        <span class="IASFormDivSpanInputBox">
            <select class="IASComboBox" TABINDEX="11" name="noOfYears" id="noOfYears">
                <%
                    for (int j = 0; j < 20; j++) {%>
                <option value ="years"><%= j + 1%></option><%
                    }
                %>
            </select>
        </span>

        <span class="IASFormDivSpanLabel">
            <label>Select All Journals:</label>
        </span>
        <span class="IASFormDivSpanInputBox">
            <input class="IASCheckBox" TABINDEX="9" type="checkbox" name="selalljrnl" id="selAllJrnl" onclick="disableJrnl()"/>
        </span>


        <span class="IASFormDivSpanInputBox">
            <input class="IASButton" TABINDEX="14" type="button" value="Add" id="btnAddLine" name="btnAddLine" onclick="addJournalToList(subscriptionForm)"/>
        </span>
    </div>
</fieldset>



