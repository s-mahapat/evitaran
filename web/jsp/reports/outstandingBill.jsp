<%--
    Document   : List Outstanding Bill - Print
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="../templates/style.jsp" %>
        <link rel="stylesheet" type="text/css" href="css/report/outstandingBill.css" />

        <title>List and Print Outstanding Bill</title>

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

                $("#balanceTable").jqGrid({
                    url:"<%=request.getContextPath() + "/reports?action=listOutstandingBalance"%>",
                    datatype: 'xml',
                    mtype: 'GET',
                    width: '100%',
                    height: 240,
                    autowidth: true,
                    forceFit: true,
                    sortable: true,
                    loadonce: true,
                    rownumbers: true,
                    emptyrecords: "No Journal",
                    loadtext: "Loading...",
                    colNames:['Sub No','Journal Codes','Balance','Sub Start','Sub. End', 'Pro. Inv. No.', 'Inv Date'],
                    colModel :[
                        {name:'subscriberNumber', index:'subscriberNumber', width:50, align:'center', xmlmap:'subscriberNumber'},
                        {name:'journalCodes', index:'journalCodes', width:180, align:'center', xmlmap:'journalCodes'},
                        {name:'balance', index:'balance', width:80, align:'center', xmlmap:'balance'},
                        {name:'subStart', index:'subStart', width:80, align:'center', xmlmap:'subStart'},
                        {name:'subEnd', index:'subEnd', width:80, align:'center', xmlmap:'subEnd'},
                        {name:'proInvNo', index:'proInvNo', width:80, align:'center', xmlmap:'proInvNo'},
                        {name:'proInvDate', index:'proInvDate', width:80, align:'center', xmlmap:'proInvDate'}
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
                        var ids = jQuery("#balanceTable").jqGrid('getDataIDs');
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
            function searchJournal(){
                if(validateSearchJournal() == true)
                    {
                        isPageLoaded = true;

                        jQuery("#balanceTable").setGridParam({postData:
                                {journalGroupName          : $("#journalGroupName").val()
                            }});
                        jQuery("#balanceTable").setGridParam({ datatype: "xml" });
                        jQuery("#balanceTable").trigger("clearGridData");
                        jQuery("#balanceTable").trigger("reloadGrid");
                    }
                }
        </script>
    </head>
    <body>
        <%@include file="../templates/layout.jsp" %>

        <div id="bodyContainer">
            <form method="post" action="<%=request.getContextPath() + "/reports?action=printOutstaningBalance"%>" name="listOutstandingBill">
                <div class="MainDiv">
                    <fieldset class="MainFieldset">
                        <legend>List and Print Outstanding Bill</legend>

                        <%-----------------------------------------------------------------------------------------------------%>
                        <%-- Search Criteria Field Set --%>
                        <%-----------------------------------------------------------------------------------------------------%>
                        <fieldset class="subMainFieldSet">
                            <legend>Search Criteria</legend>

                            <%-- Search Criteria left div --%>
                            <div class="IASFormLeftDiv">
                                <div class="IASFormFieldDiv">
                                    <span class="IASFormDivSpanLabel">
                                        <label>Subscription Start:</label>
                                    </span>
                                    <span class="IASFormDivSpanInputBox">
                                        <select class="IASComboBoxWide" TABINDEX="1" name="subStart" id="subStart">
                                            <%
                                                for (int j = 1990; j <= 2050; j++) {
                                                    out.println("<option value =\"" + j + "\">" + j + "</option>");
                                                }
                                            %>
                                        </select>
                                    </span>
                                </div>
                            </div>

                            <div class="IASFormRightDiv">
                                <div class="IASFormFieldDiv">
                                    <span class="IASFormDivSpanLabel">
                                        <label>Subscription End:</label>
                                    </span>
                                    <span class="IASFormDivSpanInputBox">
                                        <select class="IASComboBoxWide" TABINDEX="1" name="subEnd" id="subEnd">
                                            <%
                                                for (int j = 1990; j <= 2050; j++) {
                                                    out.println("<option value =\"" + j + "\">" + j + "</option>");
                                                }
                                            %>
                                        </select>
                                    </span>
                                </div>
                                <div class="IASFormFieldDiv">
                                    <span class="IASFormDivSpanInputBox">
                                        <button class="IASButton SearchButton" TYPE="button" TABINDEX="3" onclick="searchJournal()" value="Search">Search</button>
                                    </span>
                                </div>
                            </div>
                        </fieldset>


                        <%-----------------------------------------------------------------------------------------------------%>
                        <%-- Search Result Field Set --%>
                        <%-----------------------------------------------------------------------------------------------------%>
                        <fieldset class="subMainFieldSet">
                            <table class="datatable" id="balanceTable"></table>
                            <div id="pager"></div>
                        </fieldset>

                        <%-----------------------------------------------------------------------------------------------------%>
                        <%-- Print Action Field Set --%>
                        <%-----------------------------------------------------------------------------------------------------%>


                        <fieldset class="subMainFieldSet">
                            <div class="IASFormFieldDiv">
                                <div class="singleActionBtnDiv">
                                    <%--<input class="IASButton" type="button" value="Print" disabled id="printReportBtn" onclick="printReport();"/>--%>
                                    <input class="IASButton" type="submit" value="Print" disabled id="printReportBtn"/>
                                </div>
                            </div>
                        </fieldset>
                    </fieldset>
                </div>
            </form>
        </div>
    </body>
</html>