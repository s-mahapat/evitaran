<%--
    Document   : Print Profarma Invoice
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="../templates/style.jsp" %>
        <link rel="stylesheet" type="text/css" href="css/report/listProfarma.css" />
        <title>List Profarma Invoice</title>
        <%-- <script type="text/javascript" src="<%=request.getContextPath() + "/js/reports/searchSubType.js"%>"></script> --%>
        <script type="text/javascript" src="<%=request.getContextPath() + "/js/reports/listSubType.js"%>"></script>
        <script type="text/javascript">
            //var selectedSubTypeName = 0;
            var selectedId = 0;
            //initally set to false, after the first search the flag is set to true
            var isPageLoaded = false;

            $(document).ready(function(){
                jdsAppend("<%=request.getContextPath() + "/CMasterData?md=invoicetype"%>","invoiceType","invoiceType");
                jdsAppend("<%=request.getContextPath() + "/CMasterData?md=journalname"%>","journalName","journalName");
            });

            $(function(){

                $("#subTypeTable").jqGrid({
                    url:"<%=request.getContextPath() + "/reports?action=listInvoice"%>",
                    datatype: 'xml',
                    mtype: 'GET',
                    width: '100%',
                    height: 240,
                    autowidth: true,
                    forceFit: true,
                    sortable: true,
                    loadonce: true,
                    rownumbers: true,
                    emptyrecords: "No Subscriber Type",
                    loadtext: "Loading...",
                    colNames:['invoiceNumber','invoiceCreationDate','subscriberNumber','journalCode','Period','Amount'],
                    colModel :[
                        {name:'proInvNo', index:'proInvNo', width:80, align:'center', xmlmap:'proInvNo'},
                        {name:'proInvDate', index:'proInvDate', width:80, align:'center', xmlmap:'proInvDate'},
                        {name:'subscriberNumber', index:'subscriberNumber', width:80, align:'center', xmlmap:'subscriberNumber'},
                        {name:'journalCode', index:'journalCode', width:80, align:'center', xmlmap:'journalCode'},
                        {name:'period', index:'period', width:80, align:'center', xmlmap:'period'},
                        {name:'amount', index:'amount', width:80, align:'center', xmlmap:'amount'}
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
                    gridComplete: function() {
                        var ids = jQuery("#subTypeTable").jqGrid('getDataIDs');
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

            jQuery("#subTypeTable").jqGrid('navGrid','#pager',
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

            // called when the search button is clicked
            function getList(){
                isPageLoaded = true;

                jQuery("#subTypeTable").setGridParam({postData:
                        {invoiceType        : $("#invoiceType").val(),
                        from                : $("#from").val(),
                        to                  : $("#to").val(),
                        action              : "listInvoice"
                    }});
                jQuery("#subTypeTable").setGridParam({ datatype: "xml" });
                jQuery("#subTypeTable").trigger("clearGridData");
                jQuery("#subTypeTable").trigger("reloadGrid");

                jQuery("#subTypeTable").jqGrid('navGrid','#pager',
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


            // draw the date picker.
            jQueryDatePicker("from","to");
        </script>
    </head>
    <body>
        <%@include file="../templates/layout.jsp" %>

        <div id="bodyContainer">
            <form method="post" action="<%=request.getContextPath() + "/reports?action=printlistInvoice"%>" name="searchSubTypeForm">
                <div class="MainDiv">
                    <fieldset class="MainFieldset">
                        <legend>List Invoice</legend>

                        <%-----------------------------------------------------------------------------------------------------%>
                        <%-- Search Criteria Field Set --%>
                        <%-----------------------------------------------------------------------------------------------------%>
                        <fieldset class="subMainFieldSet">
                            <legend>Search Criteria</legend>

                            <%-- Search Criteria left div --%>
                            <div class="IASFormLeftDiv">
                                <div class="IASFormFieldDiv">
                                    <span class="IASFormDivSpanLabel">
                                        <label>Invoice Type</label>
                                    </span>
                                    <span class="IASFormDivSpanInputBox">
                                        <select class="IASCombobox allusers" TABINDEX="1" name="invoicerType" id="invoiceType">
                                            <option value="0" selected>Select</option>
                                        </select>
                                    </span>
                                </div>
                            </div>
                            <div class="IASFormRightDiv">
                                <div class="IASFormFieldDiv">
                                    <span class="IASFormDivSpanLabel">
                                        <label>Date Range:</label>
                                    </span>
                                    <div class="dateDiv"></div>
                                    <span class="IASFormDivSpanInputBox">
                                        <input class="IASDateTextBox allusers" TABINDEX="5" readonly size="10" type="text" id="from" name="from"/>
                                        <label> to </label>
                                        <input class="IASDateTextBox allusers" TABINDEX="6" readonly size="10" type="text" id="to" name="to"/>
                                    </span>
                                </div>
                            </div>
                            <div class="actionBtnDiv">
                                <button class="IASButton SearchButton allusers" type="button" TABINDEX="3" onclick="getList()" value="Search"/>Search</button>
                                <input class="IASButton allusers" TABINDEX="4" type="reset" value="Reset"/>
                            </div>
                        </fieldset>
                        <%-----------------------------------------------------------------------------------------------------%>
                        <%-- Search Result Field Set --%>
                        <%-----------------------------------------------------------------------------------------------------%>
                        <fieldset class="subMainFieldSet">
                            <legend>Search Result</legend>
                            <table class="datatable" id="subTypeTable"></table>
                            <div id="pager"></div>
                        </fieldset>
                        <fieldset class="subMainFieldSet">
                            <div class="IASFormFieldDiv">
                                <div class="singleActionBtnDiv">
                                    <%--<input class="IASButton" type="button" value="Print" disabled id="printReportBtn" onclick="printReport();"/>--%>
                                    <input class="IASButton allusers" type="submit" value="Print" disabled id="printReportBtn"/>
                                </div>
                            </div>
                        </fieldset>
                    </fieldset>
                </div>
            </form>
        </div>
    </body>
</html>