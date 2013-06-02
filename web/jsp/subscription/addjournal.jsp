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
                $("#journalName").multiselect({
                    noneSelectedText: 'Select Journals',
                    height: 300,
                    selectedList: 2,
                    selectedText: "# of # selected"
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
            url:'',
            //data: "subscriberNumber=" + $("#subscriberNumber").val(),
            datatype: 'local',
            mtype: 'GET',
            height: 280,
            autowidth: true,
            forceFit: true,
            sortable: true,
            loadonce: false,
            rownumbers: true,
            sortname:'subscriptionDate',
            emptyrecords: "No subscription(s) to view",
            loadtext: "Loading...",
            colNames: ['Journal Group','Journal Price Group ID','Journal Cost (INR)', 'Start Year','Start Month','End Year','Copies','Total (INR)','Delete'],
            colModel: [
                {
                    name:"journalName",
                    index:"journalName",
                    align:"center",
                    key: true,
                    width:140

                },
                {
                    name:"journalPriceGroupID",
                    index:"journalPriceGroupID",
                    align:"center",
                    hidden: true,
                    width:140

                },
                {
                    name:"journalCost",
                    index:"journalCost",
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
                    name:"startMonth",
                    index:"startMonth",
                    width:40,
                    align:"center",
                    formatter: monthNumberToName,
                    unformat: monthNameToNumber
                },
                {
                    name:"endYear",
                    index:"endYear",
                    width:60,
                    align:"center"
                },
                {
                    name:"Copies",
                    index:"Copies",
                    width:60,
                    align:"center"
                },
                {
                    name:"Total",
                    index:"Total",
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
            //caption: '&nbsp;',
            viewrecords: true,
            gridview: true,
            rowNum:20
        });
    });


</script>

<fieldset class="subMainFieldSet">
    <legend>Select Journal</legend>
    <%@include file="selectjournal.jsp" %>

    <div class="IASFormFieldDiv" id="newSubscriptiondiv" style="margin-top: 15px;">
        <table class="datatable" id="newSubscription"></table>
        <div id="pager"></div>
    </div>
    <div id="subscriptionTotal">
        <span style="margin-right: 10px;">
            <label>Discount(%):</label>
            <span id="discount"></span>
        </span>
        <span>Subscription Total(INR):</span>
        <span id="subscriptionTotalValue">0</span>
    </div>
    <div id="journalGroupContents"></div>
</fieldset>



