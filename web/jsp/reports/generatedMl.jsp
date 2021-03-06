<%--
    Document   : List of mailing list generated for selected Year
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="../templates/style.jsp" %>
        <link rel="stylesheet" type="text/css" href="css/report/ml.css" />
        <title>Mailing List Report</title>
        <script type="text/javascript">
            $(document).ready(function() {
                jdsAppend("<%=request.getContextPath() + "/CMasterData?md=year"%>","year","year");
            });
        </script>

        <script>
            var isPageLoaded = false;

            $(function(){

                  $("#mlTable").jqGrid({
                    url:"<%=request.getContextPath() + "/reports?action=gml"%>",
                    datatype: 'xml',
                    mtype: 'GET',
                    width: '100%',
                    height: Constants.jqgrid.HEIGHT,
                    autowidth: true,
                    forceFit: true,
                    sortable: true,
                    loadonce: true,
                    rownumbers: true,
                    emptyrecords: "No records to view",
                    loadtext: "Loading...",
                    colNames:['Journal Code','Volume','Issue', 'Year','month','Generation Date'],
                    colModel :[
                      {name:'journalCode', index:'journalCode', width:30, align:'center', xmlmap:'journalCode'},
                      {name:'volume', index:'volume', width:30, align:'center', xmlmap:'volume'},
                      {name:'issue', index:'issue', width:30, align:'center', xmlmap:'issue'},
                      {name:'year', index:'year', width:25, align:'center', xmlmap:'year'},
                      {name:'months', index:'months', width:25, align:'center', xmlmap:'months'},
                      {name:'creationDate', index:'creationDate', width:30, align:'center', xmlmap:'creationDate'},
                    ],
                    xmlReader : {
                      root: "results",
                      row: "row",
                      page: "results>page",
                      total: "results>total",
                      records : "results>records",
                      repeatitems: false,
                      id: "journalCode"
                   },
                    pager: '#pager',
                    rowNum:15,
                    rowList:[15,30,50],
                    viewrecords: true,
                    gridview: true,
                    caption: '&nbsp;',
                    gridComplete: function() {
                        var ids = jQuery("#mlTable").jqGrid('getDataIDs');
                        if(ids.length > 0){
                            $("#printReportBtn").button("enable");
                            $("#printReportBtnExcel").button("enable");                               
                        }
                    },
                    beforeRequest: function(){
                      return isPageLoaded;
                    },
                    loadError: function(xhr,status,error){
                        alert("Failed getting data from server: " + status);
                    }
                });
            });

            jQuery("#mlTable").jqGrid('navGrid','#pager',
                // Which buttons to show
                {edit:false,add:false,del:false,search:true},
                // Edit options
                {},
                // Add options
                {},
                // Delete options
                {},
                // Search options
                {multipleGroup:true, multipleSearch:true}
            );

            function getReport(){
                if($("#year").val() == 0)
                {
                        alert("Select year for which report has to be generated");
                }
                else{
                    isPageLoaded = true;
                    jQuery("#mlTable").setGridParam({postData:
                            {year            : $("#year").val()

                        }});
                    jQuery("#mlTable").setGridParam({ datatype: "xml" });
                    jQuery("#mlTable").trigger("clearGridData");
                    jQuery("#mlTable").trigger("reloadGrid");

                    jQuery("#mlTable").jqGrid('navGrid','#pager',
                        // Which buttons to show
                        {edit:false,add:false,del:false,search:true},
                        // Edit options
                        {},
                        // Add options
                        {},
                        // Delete options
                        {},
                        // Search options
                        {multipleGroup:true, multipleSearch:true}
                    );
                }
            }
            
            function printReportPdf()
            {
                var x = "printgml";
                $('#action').val(x);
            }
            
            function printReportExcel()
            {
                var x = "exportToExcelgml";
                $('#action').val(x);
            }                 

        </script>
    </head>
    <body>
        <%@include file="../templates/layout.jsp" %>

        <div id="bodyContainer">
            <form method="post" action="<%=request.getContextPath() + "/reports"%>" name="gml">
                <div class="MainDiv">
                    <fieldset class="MainFieldset">
                        <legend>List of Mailing lists Generated</legend>

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
                                        <select class="IASComboBoxMandatory allusers" TABINDEX="1" name="year" id="year">
                                            <option value="0">Select</option>
                                        </select>
                                    </span>
                                </div>
                            </div>

                            <div class="actionBtnDiv">
                                <button class="IASButton SearchButton allusers" type="button" TABINDEX="2" onclick="getReport()"/>Search</button>
                                <input class="IASButton allusers" TABINDEX="3" type="reset" value="Reset"/>
                            </div>

                        </fieldset>


                        <%-----------------------------------------------------------------------------------------------------%>
                        <%-- Search Result Field Set --%>
                        <%-----------------------------------------------------------------------------------------------------%>
                        <fieldset class="subMainFieldSet">
                            <legend>Search Result</legend>

                            <table class="mlTable" id="mlTable"></table>
                            <div id="pager"></div>
                        </fieldset>

                        <%-----------------------------------------------------------------------------------------------------%>
                        <%-- Print Action Field Set --%>
                        <%-----------------------------------------------------------------------------------------------------%>

                        <input class="allusers" type="hidden" name="action" id="action"/>
                        <fieldset class="subMainFieldSet">
                            <div class="IASFormFieldDiv">
                                <div class="singleActionBtnDiv">
                                    <%--<input class="IASButton" type="button" value="Print" onclick="javascript:window.print();"/>--%>
                                    <input class="IASButton allusers" type="submit" TABINDEX="12" value="Print - PDF" disabled id="printReportBtn" onclick="printReportPdf()"/>
                                    <input class="IASButton allusers" type="submit" TABINDEX="13" value="Print - Excel" disabled id="printReportBtnExcel" onclick="printReportExcel()"/>                                                                                                        
                                </div>
                            </div>
                        </fieldset>
                    </fieldset>
                </div>
            </form>
        </div>
    </body>
</html>