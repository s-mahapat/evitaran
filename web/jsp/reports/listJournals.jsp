<%--
    Document   : List Journal - Print
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="../templates/style.jsp" %>
        <link rel="stylesheet" type="text/css" href="css/report/journal.css" />

        <title>List and Print Journals</title>
        
        <script type="text/javascript" src="<%=request.getContextPath() + "/js/reports/listJournal.js"%>"></script>
        
        <script type="text/javascript">
            $(document).ready(function() {
                jdsAppend("<%=request.getContextPath() + "/CMasterData?md=journalGroupName"%>","journalGroupName","journalGroupName");
            });

        </script>  
        <script type="text/javascript">
           // var selectedJournal = 0;
            var selectedId = 0;
            //initally set to false, after the first search the flag is set to true
            var isPageLoaded = false;

            $(function(){

                $("#journalTable").jqGrid({
                    url:"<%=request.getContextPath() + "/reports?action=listJournal"%>",
                    datatype: 'xml',
                    mtype: 'GET',
                    width: '100%',
                    height: 240,
                    autowidth: true,
                    forceFit: true,
                    sortable: true,
                    loadonce: false,
                    rownumbers: true,
                    emptyrecords: "No Journal",
                    loadtext: "Loading...",
                    colNames:['Journal Id','Journal Code','Journal Name','ISSN No','No of Pages', 'Start Year','issues'],
                    colModel :[
                        {name:'id', index:'id', width:50, align:'center', xmlmap:'id'},
                        {name:'journalCode', index:'journalCode', width:80, align:'center', xmlmap:'journalCode'},
                        {name:'journalName', index:'journalName', width:80, align:'center', xmlmap:'journalName'},
                        {name:'issnNo', index:'issnNo', width:80, align:'center', xmlmap:'issnNo'},
                        {name:'pages', index:'pages', width:80, align:'center', xmlmap:'pages'},
                        {name:'startYear', index:'startYear', width:80, align:'center', xmlmap:'startYear'},
                        {name:'issues', index:'issues', width:80, align:'center', xmlmap:'issues'}
                        
                    ],
                    xmlReader : {
                        root: "results",
                        row: "row",
                        page: "journal>page",
                        total: "journal>total",
                        records : "journal>records",
                        repeatitems: false,
                        id: "id"
                    },
                    pager: '#pager',
                    rowNum:15,
                    rowList:[15,30,45],
                    viewrecords: true,
                    gridview: true,
                    caption: '&nbsp;',
                    gridComplete: function() {
                        var ids = jQuery("#journalTable").jqGrid('getDataIDs');
                        if(ids.length > 0){
                            $("#printReportBtn").button("enable");
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

            // called when the search button is clicked



            // called when the search button is clicked
            function searchJournal(){
                if(validateSearchJournal() == true)
                    {
                        isPageLoaded = true;

                        jQuery("#journalTable").setGridParam({postData:
                                {journalGroupName          : $("#journalGroupName").val(),
                                selall                     : $("#selall:checked").length
                            }});
                        jQuery("#journalTable").setGridParam({ datatype: "xml" });
                        jQuery("#journalTable").trigger("clearGridData");
                        jQuery("#journalTable").trigger("reloadGrid");
                    }
                }
                
            function getChecked(){
                if (document.getElementById("selall").value == 1 ){
                    document.getElementById("selall").value = 0;
                }else {
                    document.getElementById("selall").value = 1;
                }
            }
            // draw the date picker.
            //jQueryDatePicker("from","to");

        </script>
    </head>
    <body>
        <%@include file="../templates/layout.jsp" %>

        <div id="bodyContainer">
            <form method="post" action="" name="listJournals">
                <div class="MainDiv">
                    <fieldset class="MainFieldset">
                        <legend>List and Print Journals</legend>

                        <%-----------------------------------------------------------------------------------------------------%>
                        <%-- Search Criteria Field Set --%>
                        <%-----------------------------------------------------------------------------------------------------%>
                        <fieldset class="subMainFieldSet">
                            <legend>Search Criteria</legend>

                            <%-- Search Criteria left div --%>
                            <div class="IASFormLeftDiv">
                                <div class="IASFormFieldDiv">
                                    <span class="IASFormDivSpanLabel">
                                        <label>Journal Group:</label>
                                    </span>
                                    <span class="IASFormDivSpanInputBox">
                                        <select class="IASComboBox" TABINDEX="1" name="journalGroupName" id="journalGroupName">
                                            <option value="0" selected>Select</option>
                                        </select>
                                    </span>
                                </div>
                            </div>
                            <div class="IASFormRightDiv">

                                <div class="IASFormFieldDiv">
                                    <span class="IASFormDivSpanLabel">
                                        <label>All Journals</label>
                                    </span>
                                    <span class="IASFormDivSpanInputBox">
                                        <input class="IASCheckBox" TABINDEX="2" type="checkbox" name="selall" id="selall" onclick="getChecked()"/>
                                    </span>
                                </div> 
                            </div>

                            <div class="IASFormFieldDiv">
                                <div id="searchBtnDiv">
                                    <input class="IASButton" TABINDEX="3" type="button" onclick="searchJournal()" value="Search"/>
                                </div>
                                    
                                <div id="resetBtnDiv">
                                    <input class="IASButton" TABINDEX="4" type="reset" value="Reset"/>
                                </div>
                            </div>

                        </fieldset>


                        <%-----------------------------------------------------------------------------------------------------%>
                        <%-- Search Result Field Set --%>
                        <%-----------------------------------------------------------------------------------------------------%>
                        <fieldset class="subMainFieldSet">
                            <legend>Search Result</legend>

                            <table class="datatable" id="journalTable"></table>
                            <div id="pager"></div>
                        </fieldset>
                        
                        <%-----------------------------------------------------------------------------------------------------%>
                        <%-- Print Action Field Set --%>
                        <%-----------------------------------------------------------------------------------------------------%>
                        
                        
                        <fieldset class="subMainFieldSet">
                            <div class="IASFormFieldDiv">
                                <div class="singleActionBtnDiv">
                                    <input class="IASButton" type="button" value="Print" disabled id="printReportBtn" onclick="printReport();"/>
                                </div>
                            </div>
                        </fieldset>
                    </fieldset>
                </div>
            </form>
        </div>
    </body>
</html>