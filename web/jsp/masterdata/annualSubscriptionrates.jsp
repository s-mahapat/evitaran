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
        <script type="text/javascript" src="<%=request.getContextPath() + "/js/masterdata/journalSubjectGroup.js"%>"></script>
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
                jQuery("#journalGroupTable").jqGrid('navGrid',"#IASFormFieldDiv",{add:false,del:false});
                jdsAppend("<%=request.getContextPath() + "/CMasterData?md=year"%>","year","year");
                jdsAppend("<%=request.getContextPath() + "/CMasterData?md=subscriberType"%>","subscriberType","subscriberType");
                jQuery("#newJournalGroupName").attr("disabled",true);
                jQuery("#btnSave,#btnCancel").attr("disabled",true);
             });

            $(function(){

                $("#journalGroupTable").jqGrid({
                    url:"<%=request.getContextPath()%>/journalSubjectGroup",
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
                    colNames:['Journal Group Name','Subscriber Type', 'No of Years', 'Rate'],
                    colModel :[
                        //{name:'id', index:'id', width:50, align:'center', xmlmap:'id'},
                        //{name:'journalGroupName', index:'journalGroupName', width:50, align:'center', xmlmap:'journalGroupName'},
                        {name:'journalGroup', index:'journalGroup', width:80, align:'center', xmlmap:'journalGroup'},
                        {name:'subsTypeCode', index:'subsTypeCode', width:80, align:'center', xmlmap:'subsTypeCode'},
                        {name:'year', index:'year', width:80, align:'center', xmlmap:'year'},
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
                    editurl:"<%=request.getContextPath()%>/journalSubjectGroup?action=save",
                    gridComplete: function() {
                        var ids = jQuery("#journalGroupTable").jqGrid('getDataIDs');

                        for (var i = 0; i < ids.length; i++) {
                            jQuery("#journalGroupTable").jqGrid('setRowData', ids[i]);
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

            function save(){
                if(jQuery("#newJournalGroupName").val != "")
                {
                    alert("Add a new Journal Group Name");
                }
                else
                {
                    alert("Save called");

                    var ids = jQuery("#journalGroupTable").jqGrid('getDataIDs');

                    for (var i = 0; i < ids.length; i++) {
                        jQuery("#journalGroupTable").setGridParam({editurl: "<%=request.getContextPath()%>/journalSubjectGroup?action=save" +
                                                                            "&journalName=" + $("#journalGroupTable").getCell(ids[i], 'journalName') +
                                                                            "&year=" + $("#year").val()
                                                                            //"&journalGroupName=" + jQuery("#journalGroupName").val()
                                                                            //"&journalGroupName=" + $("#journalGroupName").getCell(ids[i], 'journalGroupName')
                                                                    });
                        jQuery("#journalGroupTable").jqGrid('saveRow',ids[i]);
                        //setGridParam requires a reload for value to reflect in the cell. Hence using setCell instead
                        //jQuery("#journalGroupTable").setGridParam({annualPrintOrder: aPO});
                    }

                    jQuery("#btnSave,#btnCancel").attr("disabled",true);
                    // Enable select of journal group name from the list box
                    jQuery("#journalGroupName").attr("disabled",false);
                    jQuery("#year").attr("disabled",false);
                    jQuery("#newJournalGroupName").attr("disabled",true);
                }
            }

            function cancel(){
                var ids = jQuery("#journalGroupTable").jqGrid('getDataIDs');

                for (var i = 0; i < ids.length; i++) {
                    jQuery("#journalGroupTable").jqGrid('restoreRow',ids[i]);
                }
                jQuery("#btnSave,#btnCancel").attr("disabled",true);
                // Enable select of journal group name from the list box
                jQuery("#journalGroupName").attr("disabled",false);
                jQuery("#year").attr("disabled",false);
                jQuery("#newJournalGroupName").val("");
                jQuery("#newJournalGroupName").attr("disabled",true);
            }

            // Called when the user clicks on Add new subject group
            function add(){
                isPageLoaded = true;
                // Check if year is selected

                //var year1 = jQuery("#year").text;
                //var year2 = jQuery("#year").val("value");
                var year2 = $("#year").val();
                //var year3 = jQuery("#year").value;
                //var selIndex = document.journalSubjectGroupFormBean.year.selectedIndex;
                //var year4 = document.journalSubjectGroupFormBean.year.options[selIndex].text;
                //alert("Year1: ", year1);
                alert("Year2: ", year2);
                //alert("Year3: ", year3);
                //alert("Year4: ", year4);
                if(!year2)
                {
                    alert('Select year');
                }
                else {

                // Clear if there are any existing data in the grid
                //jQuery("#journalGroupTable").clearGridData();
                // Enable the text box where the new group name can be added

                jQuery("#newJournalGroupName").val("");
                jQuery("#newJournalGroupName").attr("disabled",false);
                // Disable select of journal group name from the list box
                jQuery("#journalGroupName").attr("disabled",true);
                jQuery("#year").attr("disabled",true);
                // Enable save and cancel buttons
                jQuery("#btnSave,#btnCancel").attr("disabled",false);

                jQuery("#journalGroupTable").setGridParam({postData:
                                {action       : "add",
                                year          : $("#year").val()
                            }});
                //jQuery("#journalGroupTable").setGridParam({editurl: "<%=request.getContextPath()%>/journalGroupName?action=add"});
                jQuery("#journalGroupTable").setGridParam({ datatype: "xml" });
                jQuery("#journalGroupTable").trigger("clearGridData");
                jQuery("#journalGroupTable").trigger("reloadGrid");

                /*
                var ids = jQuery("#journalGroupTable").jqGrid('getDataIDs');

                for (var i = 0; i < ids.length; i++) {
                    //jQuery("#journalTable").jqGrid('setRowData', ids[i], { select: {disabled : false} });
                    $("#jqg_"+ids[i],"#journalGroupTable").attr("disabled",false);
                }
                */
               }
            }

            // Called when the journal group is selected from the list box
            function search(){
                if(jQuery("#journalGroupName").val != "Select")
                    {
                        isPageLoaded = true;
                        jQuery("#journalGroupTable").setGridParam({postData:
                                {journalGroupName       : $("#journalGroupName").val(),
                                action       : "search"
                            }});

                        jQuery("#journalGroupTable").setGridParam({ datatype: "xml" });
                        jQuery("#journalGroupTable").trigger("clearGridData");
                        jQuery("#journalGroupTable").trigger("reloadGrid");

                    }
                }

            function journalGroupNameAppend(){
                //if(jQuery("#year").val != "Select" & jQuery("#journalGroupName").val != "value")
                    //{
                jQuery("#journalGroupTable").clearGridData();
                $("#journalGroupName").empty();
                $("#journalGroupName").text("");

                var newOption = new Option("Select", "value");
                $(newOption).html("Select");
                $("#journalGroupName").append(newOption);

                var year = document.journalSubjectGroupFormBean.year.options[document.journalSubjectGroupFormBean.year.selectedIndex].text;
                requestURL = "/JDS/CMasterData?md=journalGroupName&mdvalue=" + year;
                jdsAppend(requestURL,"journalGroupName","journalGroupName");
                    //}
            }


        </script>
    </head>
    <body>

        <%@include file="../templates/layout.jsp" %>
        <div id="bodyContainer">
            <jsp:useBean class="IAS.Bean.masterdata.journalSubjectGroupFormBean" id="journalSubjectGroupFormBean" scope="request"></jsp:useBean>
            <form method="post" action="" name="journalSubjectGroupFormBean" onsubmit="return validatePrintOrder()">
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
                                                <select class="IASComboBox" TABINDEX="1" name="year" id="year" onchange="journalGroupNameAppend()">
                                                        <option value="0">Select</option>
                                                    </select>
                                                </span>
                                            </div>
                                            <div class="IASFormFieldDiv">
                                                <span class="IASFormDivSpanLabel">
                                                    <label>Journal Group:</label>
                                                </span>
                                                <span class="IASFormDivSpanInputBox">
                                                    <select class="IASComboBox" TABINDEX="2" name="journalGroupName" id="journalGroupName" onchange="search()">
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
                                                <input class="IASTextBoxMandatory" TABINDEX="1" type="text" name="noofYear" id="noofYear" value=""/>
                                            </span>
                                        </div>
                                     </div>
                                     <div class="IASFormRightDiv">
                                        <div class="IASFormFieldDiv">
                                            <span class="IASFormDivSpanLabel">
                                                <label>Rate:</label>
                                            </span>
                                            <span class="IASFormDivSpanInputBox">
                                                <input class="IASTextBoxMandatory" TABINDEX="2" type="text" name="rate" id="rate" value=""/>
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

                                <table class="datatable" id="journalGroupTable"></table>
                                <div id="pager"></div>
                            </fieldset>

                            <%-----------------------------------------------------------------------------------------------------%>
                            <%-- Journal Actions Field Set --%>
                            <%-----------------------------------------------------------------------------------------------------%>

                            <fieldset class="subMainFieldSet">
                                <div class="IASFormFieldDiv">
                                    <div id="saveBtnDiv">
                                        <input class="IASButton" TABINDEX="5" type="button" value="Save" onclick="save()" id="btnSave" name="btnSaveAction"/>
                                     </div>
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

