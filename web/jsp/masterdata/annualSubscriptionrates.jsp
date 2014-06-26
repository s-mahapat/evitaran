<%--
    Document   : Annual Subscription Rate
    Author     : aloko
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <jsp:include page="../templates/style.jsp"></jsp:include>
            <link rel="stylesheet" type="text/css" href="css/masterdata/rate.css"/>
            <title>Journal Subscription Rate</title>
            <script type="text/javascript" src="<%=request.getContextPath() + "/js/masterdata/annualSubscriptionRate.js"%>"></script>
        <script type="text/javascript" src="<%=request.getContextPath() + "/js/masterdata/validateJournalSubjectGroup.js"%>"></script>
        <script type="text/javascript" src="<%=request.getContextPath() + "/js/common.js"%>"></script>
        <script type="text/javascript" src="js/jquery/grid.common.js"></script>
        <script type="text/javascript" src="js/jquery/grid.inlinedit.js"></script>
        <script type="text/javascript" src="js/jquery/grid.celledit.js"></script>
        <script>
            //addOnloadEvent(makeSubjectGroupReadOnly);
        </script>


        <script type="text/javascript">
            var rowid = 0;
            //initally set to false, after the first search the flag is set to true
            var isPageLoaded = false;
            var stat = 'true';
            var lastSel;

            $(document).ready(function(){
                //jQuery("#annualSubscriptionRateTable").jqGrid('navGrid',"#IASFormFieldDiv",{add:false,del:false});
                jdsAppend("<%=request.getContextPath() + "/CMasterData?md=year"%>","year","year");
                jdsAppend("<%=request.getContextPath() + "/CMasterData?md=journalGroupName"%>","journalGroupName","journalGroupName");
                jdsAppend("<%=request.getContextPath() + "/CMasterData?md=subtypedesc1"%>","subtypedesc","subtypedesc");

                jQuery("#btnSave,#btnCancel,#btnEdit").attr("disabled",true);
                jQuery("#noofYear,#rate,#btnAdd").attr("disabled",true);
            });

            $(function(){

                $("#annualSubscriptionRateTable").jqGrid({
                    url:"<%=request.getContextPath()%>/annualSubscriptionRate",
                    datatype: 'xml',
                    mtype: 'GET',
                    width: '100%',
                    height: Constants.jqgrid.HEIGHT,
                    autowidth: true,
                    forceFit: true,
                    sortable: true,
                    loadonce: true,
                    rownumbers: true,
                    emptyrecords: "No Journal Groups Found",
                    loadtext: "Loading...",
                    //colNames:['Journal Group Id','Journal Group Name','Journal Name','Select'],
                    colNames:['Id','Journal Group Name','Subscriber Type', 'Start Year', 'No of years','Rate','Active','Date When Defined'],
                    colModel :[
                        //{name:'id', index:'id', width:50, align:'center', xmlmap:'id'},
                        //{name:'journalGroupName', index:'journalGroupName', width:50, align:'center', xmlmap:'journalGroupName'},
                        {name:'id', index:'id', width:20, align:'center', xmlmap:'id'},
                        {name:'journalGroupName', index:'journalGroupName', width:80, align:'center', xmlmap:'journalGroupName'},
                        {name:'subtypedesc', index:'subtypedesc', width:100, align:'center', xmlmap:'subtypedesc'},
                        {name:'year', index:'year', width:60, align:'center', xmlmap:'year'},
                        {name:'period', index:'period', width:60, align:'center', xmlmap:'period'},
                        {name:'rate', index:'rate', width:60, align:'center', xmlmap:'rate'},
                        {name:'active', index:'active', width:40, align:'center', xmlmap:'active', formatter: "checkbox", editable: true, edittype:'checkbox', editoptions: {value:"Yes:1,No:0"}},
                        {name:'dateWhenDefined', index:'dateWhenDefined', width:60, align:'center', xmlmap:'dateWhenDefined'}
                    ],
                    xmlReader : {
                        root: "results",
                        row: "row",
                        page: "results>page",
                        total: "results>total",
                        records : "results>records",
                        repeatitems: false,
                        id: "id"
                    },
                    pager: '#pager',
                    rowNum:15,
                    rowList:[15,30,45],
                    viewrecords: true,
                    gridview: true,
                    caption: '&nbsp;',
                    editurl:"<%=request.getContextPath()%>/annualSubscriptionRate?action=save",
                    gridComplete: function() {
                        var ids = jQuery("#annualSubscriptionRateTable").jqGrid('getDataIDs');

                        for (var i = 0; i < ids.length; i++) {
                            jQuery("#annualSubscriptionRateTable").jqGrid('setRowData', ids[i]);
                        }
                    },
                    beforeRequest: function(){
                        return isPageLoaded;
                    },
                    loadError: function(xhr,status,error){
                        alert("Failed getting data from server" + status);
                    },
                    onSelectRow: function(id){
                        if(id && id!==lastSel){ 
                            jQuery('#annualSubscriptionRateTable').restoreRow(lastSel); 
                            lastSel=id;
                            rowid=id;
                        }
                        //jQuery('#grid_id').editRow(id, true); 
                    },                            

                });

            });

            // This is to enable correct controls when the Define Rates button is clicked
            /*
            function addRate(){
                //check if search criteria is initial, raise alert else enable the data entry
                if ($("#year").val() == 0) {
                    alert("Select Year");
                }

                else if ($("#journalGroupName").val() == 0){
                    alert("Select Journal Group Name");
                }

                else if ($("#subtypedesc").val() == 0){
                    alert("Select Subscriber Type");
                }

                else {
                    //make the entry fields enabled
                    jQuery("#noofYear").attr("disabled",false);
                    jQuery("#rate").attr("disabled",false);
                    jQuery("#btnSave,#btnCancel,#btnAdd").attr("disabled",false);
                    //Make the selection fields disable
                    jQuery("#year").attr("disabled",true);
                    jQuery("#journalGroupName").attr("disabled",true);
                    jQuery("#subtypedesc").attr("disabled",true);
                }
            }
            */
            
            function verifyIfRateExists(year,journalGroupName,subtypedesc,noofYear){

                $.ajax({
                    type: 'POST',
                    dataType: 'xml',
                    async: false,
                    /*
                    url: "annualSubscriptionRate?action=verify&year=" +  $("#year").val()
                    + "&journalGroupName=" + $("#journalGroupName").val()
                    + "&subtypedesc=" + $("#subtypedesc").val()
                    + "&noofYear=" + $("#noofYear").val(),
                    */
                    url: "annualSubscriptionRate?action=verify"
                    + "&year=" +  year
                    + "&journalGroupName=" + journalGroupName
                    + "&subtypedesc=" + subtypedesc
                    + "&noofYear=" + noofYear,                   

                    success: function(xmlResponse, textStatus, jqXHR){

                        $(xmlResponse).find("results").each(function(){
                            exists = $(this).find("exists").text();
                        });
                        if (exists == 0){
                            // Rate does not exist
                            //var str = 'doesNotExist';
                            stat = 'false';
                            return false;
                        }
                        else {
                            // Rate exists
                            //var str = 'exists';
                            stat = 'true';
                            return true;
                        }
                    },
                    error: function(jqXHR,textStatus,errorThrown){
                        alert("Failed to get response from server. : " + errorThrown);
                        return false;
                    }
                   });
               }            

            // Called when the user clicks on Add new rate
            function add(){
                //check if search criteria is initial, raise alert else enable search for Records
                if ($("#year").val() == 0) {
                    alert("Select Year");
                }

                else if ($("#journalGroupName").val() == 0){
                    alert("Select Journal Group Name");
                }

                else if ($("#subtypedesc").val() == 0){
                    alert("Select Subscriber Type");
                }
                
                else if ($("#noofYear").val() == 0) {
                    alert("Enter Period");
                }

                else if ($("#rate").val() == 0){
                    alert("Enter Rate");
                }

                else {
                    verifyIfRateExists($("#year").val(),$("#journalGroupName").val(),$("#subtypedesc").val(),$("#noofYear").val());
                    //alert(stat.toString());
                    if(stat.toString() == 'false') {
                        isPageLoaded = true;
                        jQuery("#annualSubscriptionRateTable").setGridParam({postData:
                                {year                   : $("#year").val(),
                                journalGroupName        : $("#journalGroupName").val(),
                                subtypedesc          : $("#subtypedesc").val(),
                                noofYear                : $("#noofYear").val(),
                                rate                    : $("#rate").val(),
                                action                  : "addNewRate"
                            }});

                        jQuery("#annualSubscriptionRateTable").setGridParam({ datatype: "xml" });
                        jQuery("#annualSubscriptionRateTable").trigger("clearGridData");
                        jQuery("#annualSubscriptionRateTable").trigger("reloadGrid");

                    } else {
                        alert("Active Rate already present for Year: " +  $("#year").val() + ", Journal Group " + $("#journalGroupName").val()
                        + ", Subscriber Type: " + $("#subtypedesc").val() + ", No of Years: " + $("#noofYear").val() + "."
                        + "\nTo define a new rate for the same combination, select the rate from the table below and disable the rate by using the EDIT/SAVE button");
                    }
                }
            }

            function search(){
                //check if search criteria is initial, raise alert else enable search for Records
                if ($("#year").val() == 0) {
                    alert("Select Year");
                }

                else if ($("#journalGroupName").val() == 0){
                    alert("Select Journal Group Name");
                }

                else if ($("#subtypedesc").val() == 0){
                    alert("Select Subscriber Type");
                }

                else {
                    isPageLoaded = true;
                    jQuery("#annualSubscriptionRateTable").setGridParam({postData:
                            {year       : $("#year").val(),
                            journalGroupName        : $("#journalGroupName").val(),
                            subtypedesc             : $("#subtypedesc").val(),
                            action                  : "search"
                        }});

                    jQuery("#annualSubscriptionRateTable").setGridParam({ datatype: "xml" });
                    jQuery("#annualSubscriptionRateTable").trigger("clearGridData");
                    jQuery("#annualSubscriptionRateTable").trigger("reloadGrid");
                    
                    jQuery("#noofYear,#rate,#btnAdd,#btnEdit").attr("disabled",false);                 

                }
            }
            
            function cancelAnnualSubscriptionRates(){
                //Clear the content of the table
                /*
                var ids = jQuery("#annualSubscriptionRateTable").jqGrid('getDataIDs');

                for (var i = 0; i < ids.length; i++) {
                    jQuery("#annualSubscriptionRateTable").jqGrid('restoreRow',ids[i]);
                }
                */
                jQuery("#annualSubscriptionRateTable").jqGrid('restoreRow',rowid);
                jQuery("#btnSave,#btnCancel").attr("disabled",true);
                jQuery("btnEdit").attr("disabled",false);

            }            
            
            function editAnnualSubscriptionRates(){
                
                jQuery("#annualSubscriptionRateTable").jqGrid('editRow', rowid, false);
                
                /*
                var ids = jQuery("#annualSubscriptionRateTable").jqGrid('getDataIDs');

                for (var i = 0; i < ids.length; i++) {
                    jQuery("#annualSubscriptionRateTable").jqGrid('editRow',ids[i]);
                }
                
                this.disabled = 'true';
                */
                jQuery("#btnSave,#btnCancel").attr("disabled",false);
                jQuery("btnEdit").attr("disabled",true);
            }
            
            function saveAnnualSubscriptionRates(){
                
                //verifyIfRateExists($("#year").val(),$("#journalGroupName").val(),$("#subtypedesc").val(),$("#noofYear").val());
                // Check only when we are make a rate active, else does not matter
                if($("#annualSubscriptionRateTable").getCell(rowid, 'active') == 'Yes') {
                    //alert("Check Mark applied");
                    verifyIfRateExists(
                                        $("#annualSubscriptionRateTable").getCell(rowid, 'year'),
                                        $("#annualSubscriptionRateTable").getCell(rowid, 'journalGroupName'),
                                        $("#annualSubscriptionRateTable").getCell(rowid, 'subtypedesc'),
                                        $("#annualSubscriptionRateTable").getCell(rowid, 'period')
                                        );

                    //alert(stat.toString());
                    if(stat.toString() == 'false') {
                        //alert("Active Rate Does not exist");
                    } else {
                        alert("Active Rate already present for Year: " +  $("#year").val() + ", Journal Group " + $("#journalGroupName").val()
                        + ", Subscriber Type: " + $("#subtypedesc").val() + ", No of Years: " + $("#noofYear").val() + "."
                        + "\nTo define a new rate for the same combination, select the rate from the table below and disable the existing rate by using the EDIT/SAVE button");
                
                        return;
                    }
                } else {
                    //alert("Check Mark removed");
                }

                jQuery("#annualSubscriptionRateTable").jqGrid('saveRow', rowid, {url:"<%=request.getContextPath()%>/annualSubscriptionRate?action=save"});
                jQuery("#btnEdit").attr("disabled",false);
                jQuery("#btnSave,#btnCancel").attr("disabled",true);
                jQuery("#annualSubscriptionRateTable").trigger("reloadGrid");

                /*
                var ids = jQuery("#annualSubscriptionRateTable").jqGrid('getDataIDs');
                for (var i = 0; i < ids.length; i++)
                {
                    jQuery("#annualSubscriptionRateTable").setGridParam({editurl: "<%=request.getContextPath()%>/journalSubjectGroup?action=save" 
                                        + "&id" + $("#annualSubscriptionRateTable").getCell(ids[i], 'id')
                                        + "&journalGroupName" + $("#annualSubscriptionRateTable").getCell(ids[i], 'journalGroupName')
                                        + "&subtypedesc=" + $("#annualSubscriptionRateTable").getCell(ids[i], 'subtypedesc')
                                        + "&year=" + $("#annualSubscriptionRateTable").getCell(ids[i], 'year')
                                        + "&period=" + $("#annualSubscriptionRateTable").getCell(ids[i], 'period')
                                        + "&rate=" + $("#annualSubscriptionRateTable").getCell(ids[i], 'rate')
                                        + "&active=" + $("#annualSubscriptionRateTable").getCell(ids[i], 'active')
                                        });
                    jQuery("#annualSubscriptionRateTable").jqGrid('saveRow',ids[i]);
                }
                */
            }            

        </script>
    </head>
    <body>

        <%@include file="../templates/layout.jsp" %>
        <div id="bodyContainer">
            <form method="post" action="">
                <div class="MainDiv">
                    <fieldset class="MainFieldset">
                        <legend>Journal Subscription Rates</legend>
                        <fieldset class="subMainFieldSet">
                            <legend>Selection Criteria</legend>
                            <%-- Search Criteria left div --%>
                            <div class="IASFormLeftDiv">
                                <div class="IASFormFieldDiv">
                                    <div class="IASFormFieldDiv">
                                        <span class="IASFormDivSpanLabel">
                                            <label>Year:</label>
                                        </span>
                                        <span class="IASFormDivSpanInputBox">
                                            <select class="IASComboBox allusers" TABINDEX="1" name="year" id="year">
                                                <option value="0">Select</option>
                                            </select>
                                        </span>
                                    </div>
                                    <div class="IASFormFieldDiv">
                                        <span class="IASFormDivSpanLabel">
                                            <label>Journal Group:</label>
                                        </span>
                                        <span class="IASFormDivSpanInputBox">
                                            <select class="IASComboBoxWide allusers" TABINDEX="2" name="journalGroupName" id="journalGroupName">
                                                <option value="0">Select</option>
                                            </select>
                                        </span>
                                    </div>

                                </div>
                            </div>
                            <%-- Search Criteria right div --%>
                            <div class="IASFormRightDiv">
                                <div class="IASFormFieldDiv">
                                    <div class="IASFormFieldDiv">
                                        <span class="IASFormDivSpanLabel">
                                            <label>Subscriber Type:</label>
                                        </span>
                                        <span class="IASFormDivSpanInputBox">
                                            <select class="IASComboBox allusers" TABINDEX="3" name="subtypedesc" id="subtypedesc">
                                                <option value="0" selected>Select</option>
                                            </select>
                                        </span>
                                    </div>
                                </div>
                            </div>
                            <div class="actionBtnDiv">
                                <input class="IASButton allusers" TABINDEX="4" type="button" value="Display Rates" id="btnSearch" name="btnSearch" onclick="search()"/>
                                <%--<input class="IASButton" TABINDEX="4" type="button" value="Define Rates" id="btnAddRate" name="btnAddRate" onclick="addRate()"/>--%>
                            </div>

                        </fieldset>

                        <fieldset class="subMainFieldSet">
                            <legend>Add New Rates</legend>
                            <div class="IASFormLeftDiv">
                                <div class="IASFormFieldDiv">
                                    <span class="IASFormDivSpanLabel">
                                        <label>No of Years:</label>
                                    </span>
                                    <span class="IASFormDivSpanInputBox">
                                        <input class="IASTextBoxMandatory" TABINDEX="5" type="text" name="noofYear" id="noofYear" value="" onchange="isNumber(this.id)"/>
                                    </span>
                                </div>
                            </div>
                            <div class="IASFormRightDiv">
                                <div class="IASFormFieldDiv">
                                    <span class="IASFormDivSpanLabel">
                                        <label>Rate:</label>
                                    </span>
                                    <span class="IASFormDivSpanInputBox">
                                        <input class="IASTextBoxMandatory" TABINDEX="6" type="text" name="rate" id="rate" value="" onchange="isNumber(this.id)"/>
                                    </span>
                                </div>
                            </div>

                            <div class="actionBtnDiv">
                                <input class="IASButton" TABINDEX="7" type="button" value="Add Rates" id="btnAdd" name="btnAdd" onclick="add()"/>
                            </div>

                        </fieldset>
                        <%-----------------------------------------------------------------------------------------------------%>
                        <%-- Search Result Field Set --%>
                        <%-----------------------------------------------------------------------------------------------------%>
                        <fieldset class="subMainFieldSet">
                            <legend>Rates Table</legend>

                            <table class="datatable" id="annualSubscriptionRateTable"></table>
                            <div id="pager"></div>
                        </fieldset>

                        <%-----------------------------------------------------------------------------------------------------%>
                        <%-- Journal Actions Field Set --%>
                        <%-----------------------------------------------------------------------------------------------------%>

                        <fieldset class="subMainFieldSet">
                            <div class="IASFormFieldDiv">
                                <div id="editBtnDiv">
                                    <input class="IASButton" TABINDEX="8" type="button" value="Edit" onclick="editAnnualSubscriptionRates()" id="btnEdit" name="btnEditAction"/>
                                </div>
                                <div id="saveBtnDiv">
                                    <input class="IASButton" TABINDEX="9" type="button" value="Save" onclick="saveAnnualSubscriptionRates()" id="btnSave" name="btnSaveAction"/>
                                </div>
                                <div id="cancelBtnDiv">
                                    <input class="IASButton" TABINDEX="10" type="button" value="Cancel" onclick="cancelAnnualSubscriptionRates()" id="btnCancel" name="btnCancelAction"/>
                                </div>
                            </div>
                        </fieldset>
                    </fieldset>
                </div>
            </form>
        </div>
    </body>
</html>
