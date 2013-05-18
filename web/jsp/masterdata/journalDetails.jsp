<%--
    Document   : Journal Details
    Author     : Alok
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <jsp:include page="../templates/style.jsp"></jsp:include>
        <link rel="stylesheet" type="text/css" href="css/masterdata/journalDetails.css"/>
        <title>Journal Details</title>
        <script type="text/javascript" src="js/jquery/grid.common.js"></script>
        <script type="text/javascript" src="js/jquery/jquery.jqGrid.min.js"></script>
        <script type="text/javascript" src="js/jquery/grid.inlinedit.js"></script>
        <script type="text/javascript" src="js/jquery/grid.celledit.js"></script>
        <script>
            //addOnloadEvent(makePrintOrderReadOnly);
        </script>

        <script type="text/javascript">
            var selectedId = 0;
            //initally set to false, after the first search the flag is set to true
            var isPageLoaded = false;

            $(document).ready(function(){
                //jQuery("#journalDetailsTable").jqGrid('navGrid',"#IASFormFieldDiv",{edit:false,add:false,del:false});
                jdsAppend("<%=request.getContextPath() + "/CMasterData?md=year"%>","year","year");
                jdsAppend("<%=request.getContextPath() + "/CMasterData?md=journals"%>", "journalName", "journalName");
                jQuery("#btnEdit,#btnSave,#btnCancel").attr("disabled",true);
             });

            $(function(){

                $("#journalDetailsTable").jqGrid({
                    url:"<%=request.getContextPath()%>/journalDetails",
                    datatype: 'xml',
                    mtype: 'GET',
                    width: '100%',
                    height: 240,
                    autowidth: true,
                    forceFit: true,
                    sortable: true,
                    loadonce: true,
                    rownumbers: true,
                    emptyrecords: "No Journal Details for selected Year",
                    loadtext: "Loading...",
                    colNames:['Journal', 'Pages', 'No of issues this year','Page Size', 'No of volumes this year'],
                    colModel :[
                        {name:'journalName', index:'journalName', width: 120, align: 'center', xmlmap:'journalName'},
                        {name:'pages', index:'pages', width:40, align:'center', xmlmap:'pages', editable: true, edittype: 'text', editoptions: {rows:"1"}},
                        {name:'issues', index:'issues', width:40, align:'center', xmlmap:'issues', editable: true, edittype: 'text', editoptions: {rows:"1"}, editrules: {integer:true, minValue:0 }},
                        {name:'page_size', index:'page_size', width:40, align:'center', xmlmap:'page_size', editable: true, edittype: 'select', editoptions: {dataUrl:'<%=request.getContextPath()%>/journalDetails?action=getPageSize'}},
                        {name:'no_of_volumes', index:'no_of_volumes', width:40, align:'center', xmlmap:'no_of_volumes', editable: true, edittype: 'text', editoptions: {rows:"1"}, editrules: {integer:true, minValue:0 }}
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
                    rowNum:10,
                    rowList:[10,20,30],
                    viewrecords: true,
                    gridview: true,
                    caption: '&nbsp;',
                    editurl:"<%=request.getContextPath()%>/journalDetails?action=save",
                    gridComplete: function() {
                        var ids = jQuery("#journalDetailsTable").jqGrid('getDataIDs');

                        for (var i = 0; i < ids.length; i++) {
                            jQuery("#journalDetailsTable").jqGrid('setRowData', ids[i]);
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

            function editJournalDetails(){
                var ids = jQuery("#journalDetailsTable").jqGrid('getDataIDs');

                for (var i = 0; i < ids.length; i++) {
                    jQuery("#journalDetailsTable").jqGrid('editRow',ids[i]);
                }
                //this.disabled = 'true';
                //jQuery("#btnSave,#btnCancel").attr("disabled",false);
                jQuery("#btnSave,#btnCancel").button("enable");
            }

            function saveJournalDetails(){
                var ids = jQuery("#journalDetailsTable").jqGrid('getDataIDs');

                for (var i = 0; i < ids.length; i++) {
                    jQuery("#journalDetailsTable").setGridParam({editurl: "<%=request.getContextPath()%>/journalDetails?action=save" +
                                                                        "&year=" + $("#year").val() +
                                                                        "&journalName=" + $("#journalDetailsTable").getCell(ids[i], 'journalName')
                                                                });

                    jQuery("#journalDetailsTable").jqGrid('saveRow',ids[i]);
                }

                jQuery("#journalDetailsTable").setGridParam({postData:
                        {year       : $("#year").val(),
                        action       : "searchJournalDetails"
                    }});

                jQuery("#journalDetailsTable").setGridParam({ datatype: "xml" });
                jQuery("#journalDetailsTable").trigger("clearGridData");
                jQuery("#journalDetailsTable").trigger("reloadGrid");

                //jQuery("#btnSave,#btnCancel").attr("disabled",true);
                //jQuery("#btnEdit").attr("disabled",false);
                jQuery("#btnSave,#btnCancel").button("disable");
                jQuery("#btnEdit").button("enable");

            }

            function cancelJournalDetails(){
                var ids = jQuery("#journalDetailsTable").jqGrid('getDataIDs');

                for (var i = 0; i < ids.length; i++) {
                    jQuery("#journalDetailsTable").jqGrid('restoreRow',ids[i]);
                }
                jQuery("#btnSave,#btnCancel").attr("disabled",true);
                jQuery("#btnEdit").attr("disabled",false);
            }

            function getJournalDetails()
            {
                if($("#year").val() == 0){
                    alert("Select year");
                } else {
                    isPageLoaded = true;
                    jQuery("#journalDetailsTable").setGridParam({postData:
                                    {year       : $("#year").val(),
                                    action       : "searchJournalDetails"
                                }});
                    jQuery("#journalDetailsTable").setGridParam({ datatype: "xml" });
                    jQuery("#journalDetailsTable").trigger("clearGridData");
                    jQuery("#journalDetailsTable").trigger("reloadGrid");
                    jQuery("#btnEdit").attr("disabled",false);
                }
            }

        </script>
    </head>
    <body>

        <%@include file="../templates/layout.jsp" %>
        <div id="bodyContainer">
            <jsp:useBean class="IAS.Bean.masterdata.journalDetailsFormBean" id="journalDetailsFormBean" scope="request"></jsp:useBean>
            <form method="post" action="<%=request.getContextPath()%>/journalDetails?action=goToJournalVolumeDetails" name="journalDetailsFormBean">
                <div class="MainDiv">
                    <fieldset class="MainFieldset">
                        <legend>Display Journal Details</legend>
                            <fieldset class="subMainFieldSet">
                                <legend>Search Criterion</legend>
                                    <%-- Search Criteria left div --%>
                                    <div class="IASFormLeftDiv">
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
                                    </div>
                                    <div class="IASFormRightDiv">
                                        <div id="addBtnDiv">
                                            <input class="IASButton" TABINDEX="2" type="button" value="Get Journal Details" id="btnSearch" name="btnSearch" onclick="getJournalDetails()"/>
                                        </div>
                                    </div>
                            </fieldset>
                            <%-----------------------------------------------------------------------------------------------------%>
                            <%-- Search Result Field Set --%>
                            <%-----------------------------------------------------------------------------------------------------%>
                            <fieldset class="subMainFieldSet">
                                <legend>Journal Details</legend>

                                <table class="datatable" id="journalDetailsTable"></table>
                                <div id="pager"></div>
                            </fieldset>

                            <%-----------------------------------------------------------------------------------------------------%>
                            <%-- Journal Actions Field Set --%>
                            <%-----------------------------------------------------------------------------------------------------%>

                            <fieldset class="subMainFieldSet">
                                <div class="IASFormFieldDiv">
                                    <div id="editBtnDiv">
                                        <input class="IASButton" TABINDEX="3" type="button" value="Edit" onclick="editJournalDetails()" id="btnEdit" name="btnEditAction"/>
                                    </div>
                                    <div id="saveBtnDiv">
                                        <input class="IASButton" TABINDEX="4" type="button" value="Save" onclick="saveJournalDetails()" id="btnSave" name="btnSaveAction"/>
                                    </div>
                                    <div id="cancelBtnDiv">
                                        <input class="IASButton" TABINDEX="5" type="button" value="Cancel" onclick="cancelJournalDetails()" id="btnCancel" name="btnCancelAction"/>
                                    </div>
                                </div>
                            </fieldset>
                    </fieldset>
                </div>
            </form>
        </div>
    </body>
</html>
