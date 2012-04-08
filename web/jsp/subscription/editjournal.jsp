<%--
    Document   : Select Journal
--%>
<%@page import="IAS.Class.util"%>
<script type="text/javascript">
    var journalInfo = {};
    $(document).ready(function(){

        //jdsAppend("CMasterData?md=journals", "journalName", "journalName");

        $.ajax({
            type: "GET",
            url: "CMasterData?md=journal_groups",
            dataType: "xml",
            success: function(xml){

                $(xml).find("row").each(function(){
                    $(this).find("id").each(function(){
                        groupid = $(this).text();
                    });
                    $(this).find("journalGroupName").each(function(){
                        journalName = $(this).text();
                        $("#journalName").append("<option value='" + groupid + "'>" + journalName + "</option");
                    });
                });
            },
            complete: function(){
                var html=null;
            },
            error: function() {
                alert("XML File could not be found");
            }
        });

        $("#newSubscription").jqGrid({
            url:'subscription?oper=subid&id=' + $("#subscriptionID").val(),
            datatype: 'xml',
            mtype: 'GET',
            height: 240,
            autowidth: true,
            forceFit: true,
            sortable: true,
            loadonce: false,
            rownumbers: true,
            sortname:'journalGroupName',
            emptyrecords: "No subscription(s) to view",
            loadtext: "Loading...",
            colNames: ['Journal Group','Journal Cost (INR)','Start Year','End Year','Copies','Total (INR)','Delete'],
            colModel: [
                {
                    name:"journalGroupName",
                    index:"journalGroupName",
                    align:"center",
                    key: true,
                    width:140

                },
                {
                    name:"journalGroupCost",
                    index:"journalGroupCost",
                    align:"center",
                    width:60
                },
                {
                    name:"startYear",
                    index:"startYear",
                    width:60,
                    align:"center"
                },
                {
                    name:"endYear",
                    index:"endYear",
                    width:60,
                    align:"center"
                },
                {
                    name:"copies",
                    index:"copies",
                    width:60,
                    align:"center"
                },
                {
                    name:"total",
                    index:"total",
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
            xmlReader : {
                root: "results",
                row: "row",
                repeatitems: false,
                id: "journalGroupName"
            },
            gridComplete: function(){

            },
            loadError: function(xhr,status,error){
                alert("Failed getting data from server" + status);
            },
            loadComplete: function(xml){
                var totalSubscriptionValue = 0
                $(xml).find("results").find("row").find("total").each(function(){
                    totalSubscriptionValue += parseFloat($(this).text()) ;
                });
                //alert(totalSubscriptionValue);
                $("#subscriptionTotalValue").text(totalSubscriptionValue);
            },
            caption: '&nbsp;',
            viewrecords: true,
            gridview: true,
            rowNum:20
        });
    });


</script>

<fieldset class="subMainFieldSet">
    <legend>Select Journal</legend>

    <div class="IASFormFieldDiv">
        <span class="IASFormDivSpanLabel" style="width:auto;">
            <label>Start Year:</label>
        </span>

        <span class="IASFormDivSpanInputBoxLessMargin">
            <select class="IASComboBoxMandatory" TABINDEX="11" name="subscriptionStartYear" id="subscriptionStartYear" onchange="setEndYear()">
                <%
                    int year = Integer.parseInt(util.getDateString("yyyy"));
                    for (int i = year; i <= year + 4; i++) {
                        out.println("<option value=\"" + i + "\">" + i + "</option>");
                    }
                %>
            </select>
        </span>

        <span class="IASFormDivSpanLabel" style="margin-left:15px;width: auto;">
            <label>End Year:</label>
        </span>

        <span class="IASFormDivSpanInputBoxLessMargin">
            <select class="IASComboBoxMandatory" TABINDEX="11" name="endYear" id="endYear">
                <%
                    for (int j = 0; j <= 4; j++) {
                        out.println("<option value =\"" + (j + year) + "\">" + (j + year) + "</option>");
                    }
                %>
            </select>
        </span>

        <span class="IASFormDivSpanLabel" style="margin-left:15px;width: auto;">
            <label>Journal Price Year:</label>
        </span>

        <span class="IASFormDivSpanInputBoxLessMargin">
            <select class="IASComboBoxMandatory" TABINDEX="11" name="priceYear" id="priceYear">
                <%
                    for (int j = 0; j <= 1; j++) {
                        out.println("<option value =\"" + (year + j) + "\">" + (year + j) + "</option>");
                    }
                %>
            </select>
        </span>

        <span class="IASFormDivSpanLabel" style="margin-left:15px;width: auto;">
            <label>Journal Group</label>
        </span>

        <span class="IASFormDivSpanInputBoxLessMargin">
            <select class="IASComboBoxMandatory" TABINDEX="11" name="journalName" id="journalName">
            </select>
        </span>

        <span class="IASFormDivSpanLabel" style="margin-left:15px;width: auto;">
            <label>Copies:</label>
        </span>

        <span class="IASFormDivSpanInputBoxLessMargin">
            <select class="IASComboBoxMandatory" TABINDEX="11" name="copies" id="copies">
                <%
                    for (int i = 1; i <= 10; i++) {
                        out.println("<option value =\"" + i + "\">" + i + "</option>");
                    }
                %>
            </select>
        </span>
        <span class="IASFormDivSpanInputBox" style="margin-left:35px;">
            <input class="IASButton" TABINDEX="14" type="button" value="Add" id="btnAddLine" name="btnAddLine" onclick="addJournal()"/>
            <input class="IASButton" TABINDEX="15" type="button" value="Delete All" id="btnDeleteAll" name="btnDeleteAll" onclick="deleteRow('All')"/>
        </span>
    </div>
    <div class="IASFormFieldDiv" id="newSubscriptiondiv" style="margin-top: 15px;">
        <table class="datatable" id="newSubscription"></table>
        <div id="pager"></div>
    </div>
    <div id="subscriptionTotal">
        <span>Subscription Total(INR):</span>
        <span id="subscriptionTotalValue">0</span>
    </div>
    <div id="journalGroupContents"></div>
</fieldset>



