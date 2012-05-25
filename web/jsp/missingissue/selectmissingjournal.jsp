<%--
    Document   : Select Journal
--%>
<%@page import="IAS.Class.util"%>
<script type="text/javascript">
    var journalInfo = {};
    $(document).ready(function(){

        jdsAppend("<%=request.getContextPath() + "/CMasterData?md=month"%>","month","month");
        jdsAppend("<%=request.getContextPath() + "/CMasterData?md=journalname"%>","journalName","journalName");

        $("#addmissingissueTable").jqGrid({
            url:'',
            //data: "subscriberNumber=" + $("#subscriberNumber").val(),
            datatype: 'local',
            mtype: 'GET',
            height: 210,
            autowidth: true,
            forceFit: true,
            sortable: true,
            loadonce: false,
            rownumbers: true,
            sortname:'subscriptionDate',
            emptyrecords: "No subscription(s) to view",
            loadtext: "Loading...",
            colNames: ['Journal Name', 'Month', 'Year', 'Delete'],
            colModel: [
                {
                    name:"journalName",
                    index:"journalName",
                    align:"center",
                    key: true,
                    width:140

                },
                {
                    name:"month",
                    index:"month",
                    width:40,
                    align:"center"
                },
                {
                    name:"year",
                    index:"year",
                    width:60,
                    align:"center"
                },
                {
                    name:"delete",
                    index:"delete",
                    width:40,
                    align:"center"
                }

            ],
            caption: '&nbsp;',
            viewrecords: true,
            gridview: true,
            rowNum:20
        });
    });


</script>

<fieldset class="subMainFieldSet">
    <legend>Select Journal</legend>
    <div class="IASFormLeftDiv">
        <div class="IASFormFieldDiv">       

            <span class="IASFormDivSpanLabel" style="margin-left:15px;width: auto;">
                <label>Journal Name:</label>
            </span>

            <span class="IASFormDivSpanInputBoxLessMargin">
                <select class="IASComboBoxMandatory" TABINDEX="11" name="journalName" id="journalName">
                </select>
            </span>

        </div>
    </div>

    <div class="IASFormRightDiv">
        <div class="IASFormFieldDiv">

            <span class="IASFormDivSpanLabel" style="margin-left:15px;width: auto;">
                <label>Month:</label>
            </span>

            <span class="IASFormDivSpanInputBoxLessMargin">
                <select class="IASComboBoxMandatory" TABINDEX="11" name="month" id="month">
                    <option value="0">Select</option>

                </select>
            </span>

            <span class="IASFormDivSpanLabel" style="width:auto;">
                <label>Year:</label>
            </span>

            <span class="IASFormDivSpanInputBoxLessMargin">
                <select class="IASComboBoxMandatory" TABINDEX="11" name="year" id="year">
                    <%
                        int year = Integer.parseInt(util.getDateString("yyyy"));
                            out.println("<option value=\"" + year + "\">" + year + "</option>");
                            year = year - 1;
                            out.println("<option value=\"" + year  + "\">" + year + "</option>");

                    %>
                </select>
            </span>
        </div>
    </div>
    
    <span class="actionBtnDiv" style="margin-left:5px;">
        <input class="IASButton" TABINDEX="14" type="button" value="Add" id="btnAddLine" name="btnAddLine" onclick="addJournal()"/>
        <input class="IASButton" TABINDEX="15" type="button" value="Delete All" id="btnDeleteAll" name="btnDeleteAll" onclick="deleteRow('All')"/>
    </span>

    <div class="IASFormFieldDiv" id="addmissingissueTablediv" style="margin-top: 15px;">
        <table class="datatable" id="addmissingissueTable"></table>
        <div id="pager"></div>
    </div>
    <div id="journalGroupContents"></div>
</fieldset>



