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
            var selectedId = 0;
            //initally set to false, after the first search the flag is set to true
            var isPageLoaded = false;

            $(document).ready(function(){
                //jQuery("#annualSubscriptionRateTable").jqGrid('navGrid',"#IASFormFieldDiv",{add:false,del:false});
                jdsAppend("<%=request.getContextPath() + "/CMasterData?md=year"%>","year","year");
                jdsAppend("<%=request.getContextPath() + "/CMasterData?md=journalGroupName"%>","journalGroupName","journalGroupName");
                jdsAppend("<%=request.getContextPath() + "/CMasterData?md=subscriberType"%>","subscriberType","subscriberType");
                jQuery("#noofYear").attr("disabled",true);
                jQuery("#rate").attr("disabled",true);
                jQuery("#btnSave,#btnCancel,#btnAdd").attr("disabled",true);
             });

            $(function(){

                $("#annualSubscriptionRateTable").jqGrid({
                    url:"<%=request.getContextPath()%>/annualSubscriptionRate",
                    datatype: 'xml',
                    mtype: 'GET',
                    width: '100%',
                    height: 240,
                    autowidth: true,
                    forceFit: true,
                    sortable: true,
                    loadonce: true,
                    rownumbers: true,
                    emptyrecords: "No Journal Groups Found",
                    loadtext: "Loading...",
                    //colNames:['Journal Group Id','Journal Group Name','Journal Name','Select'],
                    colNames:['Id','Journal Group Name','Subscriber Type', 'Start Year', 'No of years','Rate'],
                    colModel :[
                        //{name:'id', index:'id', width:50, align:'center', xmlmap:'id'},
                        //{name:'journalGroupName', index:'journalGroupName', width:50, align:'center', xmlmap:'journalGroupName'},
                        {name:'id', index:'id', width:80, align:'center', xmlmap:'id'},
                        {name:'journalGroupName', index:'journalGroupName', width:80, align:'center', xmlmap:'journalGroupName'},
                        {name:'subtypedesc', index:'subtypedesc', width:80, align:'center', xmlmap:'subtypedesc'},
                        {name:'year', index:'year', width:80, align:'center', xmlmap:'year'},
                        {name:'period', index:'period', width:80, align:'center', xmlmap:'period'},
                        {name:'rate', index:'rate', width:80, align:'center', xmlmap:'rate'},

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
                    }

                });

            });

            function addRate(){
                //check if search criteria is initial, raise alert else enable the data entry
                if ($("#year").val() == 0) {
                    alert("Select Year");
                }

                else if ($("#journalGroupName").val() == 0){
                    alert("Select Journal Group Name");
                }

                else if ($("#subscriberType").val() == 0){
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
                    jQuery("#subscriberType").attr("disabled",true);
                }
            }

            function cancel(){
                //Clear the content of the table
                var ids = jQuery("#annualSubscriptionRateTable").jqGrid('getDataIDs');

                for (var i = 0; i < ids.length; i++) {
                    jQuery("#annualSubscriptionRateTable").jqGrid('restoreRow',ids[i]);
                }
                //make the entry fields disabled
                jQuery("#noofYear").attr("disabled",true);
                jQuery("#rate").attr("disabled",true);
                jQuery("#btnSave,#btnCancel,#btnAdd").attr("disabled",true);
                //Make the selection fields enable
                jQuery("#year").attr("disabled",false);
                jQuery("#journalGroupName").attr("disabled",false);
                jQuery("#subscriberType").attr("disabled",false);
            }

            // Called when the user clicks on Add new subject group
            function add(){
                //check if search criteria is initial, raise alert else enable search for Records
                if ($("#noofYear").val() == 0) {
                    alert("Enter Period");
                }

                else if ($("#rate").val() == 0){
                    alert("Enter Rate");
                }

                else {
                        isPageLoaded = true;
                        jQuery("#annualSubscriptionRateTable").setGridParam({postData:
                                {year                   : $("#year").val(),
                                journalGroupName        : $("#journalGroupName").val(),
                                subscriberType          : $("#subscriberType").val(),
                                noofYear                  : $("#noofYear").val(),
                                rate                    : $("#rate").val(),
                                action                  : "addAndSearch"
                            }});

                        jQuery("#annualSubscriptionRateTable").setGridParam({ datatype: "xml" });
                        jQuery("#annualSubscriptionRateTable").trigger("clearGridData");
                        jQuery("#annualSubscriptionRateTable").trigger("reloadGrid");

                        //make the entry fields disabled
                        jQuery("#noofYear").attr("disabled",true);
                        jQuery("#rate").attr("disabled",true);
                        jQuery("#btnSave,#btnCancel,#btnAdd").attr("disabled",true);
                        //Make the selection fields enable
                        jQuery("#year").attr("disabled",false);
                        jQuery("#journalGroupName").attr("disabled",false);
                        jQuery("#subscriberType").attr("disabled",false);
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

                else if ($("#subscriberType").val() == 0){
                    alert("Select Subscriber Type");
                }

                else {
                        isPageLoaded = true;
                        jQuery("#annualSubscriptionRateTable").setGridParam({postData:
                                {year       : $("#year").val(),
                                journalGroupName        : $("#journalGroupName").val(),
                                subscriberType          : $("#subscriberType").val(),
                                action                  : "search"
                            }});

                        jQuery("#annualSubscriptionRateTable").setGridParam({ datatype: "xml" });
                        jQuery("#annualSubscriptionRateTable").trigger("clearGridData");
                        jQuery("#annualSubscriptionRateTable").trigger("reloadGrid");

                    }
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
                                                <span class="IASFormDivSpanInputBox">
                                                    <span class="IASFormDivSpanLabel">
                                                        <label>Year:</label>
                                                    </span>
                                                    <select class="IASComboBox" TABINDEX="1" name="year" id="year">
                                                        <option value="0">Select</option>
                                                    </select>
                                                </span>
                                            </div>
                                            <div class="IASFormFieldDiv">
                                                <span class="IASFormDivSpanLabel">
                                                    <label>Journal Group:</label>
                                                </span>
                                                <span class="IASFormDivSpanInputBox">
                                                    <select class="IASComboBox" TABINDEX="2" name="journalGroupName" id="journalGroupName">
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
                                                    <label>Subscriber Type</label>
                                                </span>
                                                <span class="IASFormDivSpanInputBox">
                                                    <select class="IASComboBox" TABINDEX="1" name="subscriberType" id="subscriberType">
                                                        <option value="0" selected>Select</option>
                                                    </select>
                                                </span>
                                            </div>
                                        </div>
                                    </div>

                            </fieldset>
                            <fieldset class="subMainFieldSet">
                                <legend>Actions - Search / Add</legend>
                                    <div class="IASFormFieldDiv">
                                        <div id="searchBtnDiv">
                                             <input class="IASButton" TABINDEX="3" type="button" value="Display Rates" id="btnSearch" name="btnSearch" onclick="search()"/>
                                        </div>
                                        <div id="defineRateBtnDiv">
                                             <input class="IASButton" TABINDEX="4" type="button" value="Define Rates" id="btnAddRate" name="btnAddRate" onclick="addRate()"/>
                                        </div>
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
                                                <input class="IASTextBoxMandatory" TABINDEX="1" type="text" name="noofYear" id="noofYear" value="" onchange="isNumber(this.id)"/>
                                            </span>
                                        </div>
                                     </div>
                                     <div class="IASFormRightDiv">
                                        <div class="IASFormFieldDiv">
                                            <span class="IASFormDivSpanLabel">
                                                <label>Rate:</label>
                                            </span>
                                            <span class="IASFormDivSpanInputBox">
                                                <input class="IASTextBoxMandatory" TABINDEX="2" type="text" name="rate" id="rate" value="" onchange="isNumber(this.id)"/>
                                            </span>
                                        </div>
                                    </div>

                                    <div class="IASFormFieldDiv">
                                        <div id="addBtnDiv">
                                             <input class="IASButton" TABINDEX="3" type="button" value="Add Rates" id="btnAdd" name="btnAdd" onclick="add()"/>
                                        </div>
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
                                    <div id="cancelBtnDiv">
                                        <input class="IASButton" TABINDEX="6" type="button" value="Cancel" onclick="cancel()" id="btnCancel" name="btnCancelAction"/>
                                    </div>
                                </div>
                            </fieldset>
                    </fieldset>
                </div>
            </form>
        </div>
    </body>
</html>
