<%--
    Document   : Circulation Figure for Journal
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="../templates/style.jsp" %>
        <link rel="stylesheet" type="text/css" href="css/report/circulationFigures.css" />

        <title>List and Print Journals</title>
        
        <script type="text/javascript" src="<%=request.getContextPath() + "/js/reports/circulationFigures.js"%>"></script>
        
        <script type="text/javascript">
            $(document).ready(function() {
                jdsAppend("<%=request.getContextPath() + "/CMasterData?md=year"%>","year","year");
            });

        </script>  
        <script type="text/javascript">
           // var selectedJournal = 0;
            var selectedId = 0;
            //initally set to false, after the first search the flag is set to true
            var isPageLoaded = false;

            $(function(){

                $("#circulationTable").jqGrid({
                    url:"<%=request.getContextPath() + "/reports?action=listCirculationFigure"%>",
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
                    colNames:['Journal Code','Journal Name', 'Inst. India','Inst. Abroad','Indi. India','Indi. Abroad','Comp','Auth','Total Copies','Print Order','Balance Copies'],
                    colModel :[
                        
                          {name:'journalCode', index:'journalCode', width:80, align:'center', xmlmap:'journalCode'},
                          {name:'journalName', index:'journalName', width:80, align:'center', xmlmap:'journalName'},
                          {name:'instIndia', index:'subscriber_id', width:50, align:'center', xmlmap:'inst_india'},
                          {name:'instAbroad', index:'subscriber_id', width:50, align:'center', xmlmap:'inst_abroad'},
                          {name:'indiIndia', index:'subscriber_id', width:50, align:'center', xmlmap:'indi_india'},
                          {name:'IndiAbroad', index:'subscriber_id', width:50, align:'center', xmlmap:'indi_abroad'},
                          {name:'Comp', index:'subscriber_id', width:50, align:'center', xmlmap:'comp'},
                          {name:'Auth', index:'subscriber_id', width:50, align:'center', xmlmap:'auth'},
                          {name:'TotalCopies', index:'subscriber_id', width:50, align:'center', xmlmap:'total_copies'},
                          {name:'PrintOrder', index:'subscriber_id', width:50, align:'center', xmlmap:'print_order'},
                          {name:'BalanceCopies', index:'subscriber_id', width:50, align:'center', xmlmap:'balance_copies'}
                        
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
                    gridComplete: function() {
                        var ids = jQuery("#circulationTable").jqGrid('getDataIDs');
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
            function searchReport(){
                if(validateSearchJournal() == true)
                    {
                        isPageLoaded = true;

                        jQuery("#circulationTable").setGridParam({postData:
                                {year          : $("#year").val()
                                }});
                        jQuery("#circulationTable").setGridParam({ datatype: "xml" });
                        jQuery("#circulationTable").trigger("clearGridData");
                        jQuery("#circulationTable").trigger("reloadGrid");
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
                                        <label>Year</label>
                                    </span>
                                    <span class="IASFormDivSpanInputBox">
                                     <select class="IASComboBox" TABINDEX="6" name="year" id="year">
                                     </select>
                                    </span>
                                </div>
                            </div>
 
                            <div class="IASFormFieldDiv">
                                <div id="searchBtnDiv">
                                    <input class="IASButton" TABINDEX="3" type="button" onclick="searchReport()" value="Search"/>
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

                            <table class="datatable" id="circulationTable"></table>
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