<%--
    Document   : Print Order
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="../templates/style.jsp" %>
        <link rel="stylesheet" type="text/css" href="css/masterdata/printOrder.css" />

        <title>Print Order</title>
        <script type="text/javascript" src="<%=request.getContextPath() + "/js/masterdata/printOrder.js"%>"></script>
        <script type="text/javascript" src="<%=request.getContextPath() + "/js/masterdata/validatePrintOrder.js"%>"></script>
        <script type="text/javascript">
           // var selectedJournal = 0;
            var selectedId = 0;
            //initally set to false, after the first search the flag is set to true
            var isPageLoaded = false;

            $(function(){

                $("#printOrderTable").jqGrid({
                    url:"<%=request.getContextPath() + "/printOrder?action=search"%>",
                    datatype: 'xml',
                    mtype: 'GET',
                    width: '100%',
                    height: 240,
                    autowidth: true,
                    forceFit: true,
                    sortable: true,
                    loadonce: false,
                    rownumbers: true,
                    emptyrecords: "No Print Order for selected Year",
                    loadtext: "Loading...",
                    colNames:['Print Order Id','Journal Code','Journal Name','year','Isses per Yer', 'Print Order', 'Annual Print Order'],
                    colModel :[
                        {name:'id', index:'id', width:50, align:'center', xmlmap:'id'},
                        {name:'journalCode', index:'journalCode', width:80, align:'center', xmlmap:'journalCode'},
                        {name:'journalName', index:'journalName', width:80, align:'center', xmlmap:'journalName'},
                        {name:'issues', index:'issues', width:80, align:'center', xmlmap:'issues'},
                        {name:'year', index:'year', width:80, align:'center', xmlmap:'year'},
                        {name:'printOrder', index:'printOrder', width:80, align:'center',formatter:'printOrder'},
                        {name:'annualPrintorder', index:'annualPrintorder', width:80, align:'center',formatter:'annualPrintOrder'}
                    ],
                    xmlReader : {
                        root: "results",
                        row: "row",
                        page: "printorder>page",
                        total: "printOrder>total",
                        records : "printOrder>records",
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
                        var ids = jQuery("#printOrderTable").jqGrid('getDataIDs');

                        for (var i = 0; i < ids.length; i++) {
                            action = "<a style='color:blue;' href='journal?action=edit&id=" + ids[i] + "'>Edit</a>";
                            jQuery("#printOrderTable").jqGrid('setRowData', ids[i], { Action: action });
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
                                {journalCode       : $("#journalCode").val(),
                                journalName          : $("#journalName").val()
                            }});
                        jQuery("#journalTable").setGridParam({ datatype: "xml" });
                        jQuery("#journalTable").trigger("clearGridData");
                        jQuery("#journalTable").trigger("reloadGrid");
                    }
                }

            // draw the date picker.
            //jQueryDatePicker("from","to");

        </script>
    </head>
    <body>
        <%@include file="../templates/layout.jsp" %>

        <div id="bodyContainer">
            <form method="post" action="" name="searchJournalForm">
                <div class="MainDiv">
                    <fieldset class="MainFieldset">
                        <legend>Search Journal</legend>

                        <%-----------------------------------------------------------------------------------------------------%>
                        <%-- Search Criteria Field Set --%>
                        <%-----------------------------------------------------------------------------------------------------%>
                        <fieldset class="subMainFieldSet">
                            <legend>Search Criteria</legend>

                            <%-- Search Criteria left div --%>
                            <div class="IASFormLeftDiv">


                                <div class="IASFormFieldDiv">
                                    <span class="IASFormDivSpanLabel">
                                        <label>Journal Code:</label>
                                    </span>
                                    <span class="IASFormDivSpanInputBox">
                                        <input class="IASTextBox" TABINDEX="1" type="text" name="journalCode" id="journalCode" value=""/>
                                    </span>
                                </div>
                            </div>
                            <div class="IASFormRightDiv">

                                <div class="IASFormFieldDiv">
                                    <span class="IASFormDivSpanLabel">
                                        <label>Journal Name</label>
                                    </span>
                                    <span class="IASFormDivSpanInputBox">
                                        <input class="IASTextBox" TABINDEX="2" type="text" name="journalName" id="journalName" value=""/>
                                    </span>
                                </div>
                            </div>

                            <div class="IASFormFieldDiv">
                                <div id="searchBtnDiv">
                                    <input class="IASButton" TABINDEX="3" type="button" value="search" onclick="searchJournal()"/>
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

                            <table class="datatable" id="printOrderTable"></table>
                            <div id="pager"></div>
                        </fieldset>
                    </fieldset>
                </div>
            </form>
        </div>
    </body>
</html>