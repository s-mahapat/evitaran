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
        <title>List Sent Reminders</title>
        <%-- <script type="text/javascript" src="<%=request.getContextPath() + "/js/reports/searchSubType.js"%>"></script> --%>
        <script type="text/javascript" src="<%=request.getContextPath() + "/js/reports/listSubType.js"%>"></script>
        <script type="text/javascript">
            //var selectedSubTypeName = 0;
            var selectedId = 0;
            //initally set to false, after the first search the flag is set to true
            var isPageLoaded = false;

            $(document).ready(function(){
                jdsAppend("<%=request.getContextPath() + "/CMasterData?md=subscriberType"%>","subscriberType","subscriberType");
                jdsAppend("<%=request.getContextPath() + "/CMasterData?md=journalname"%>","journalName","journalName");
             });

            $(function(){

                $("#remTable").jqGrid({
                    url:"<%=request.getContextPath() + "/reports?action=listReminder"%>",
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
                    colNames:['Subscription Id','Subscriber Type','Subscriber Number','Subscriber Name',
                        'Balance','reminder Type','Reminder date','Email'],
                    colModel :[
                      {name:'subId', index:'subId', width:10, align:'center', xmlmap:'subId'},
                      {name:'subtypecode', index:'subtypecode', width:80, align:'center', xmlmap:'subtypecode'},
                      {name:'subscriberNumber', index:'subscriberNumber', width:80, align:'center', xmlmap:'subscriberNumber'},
                      {name:'subscriberName', index:'subscriberName', width:80, align:'center', xmlmap:'subscriberName'},
                      {name:'balance', index:'balance', width:80, align:'center', xmlmap:'balance'},
                      {name:'reminderType', index:'subscriber_id', width:50, align:'center', xmlmap:'reminderType'},
                      {name:'reminderDate', index:'subscriber_id', width:50, align:'center', xmlmap:'reminderDate'},
                      {name:'emailId', index:'emailId', width:50, align:'center', xmlmap:'emailId'}
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
                        var ids = jQuery("#remTable").jqGrid('getDataIDs');
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
            function getList(){
                        isPageLoaded = true;

                        jQuery("#remTable").setGridParam({postData:
                                {remType             : $("#remType").val(),
                                from                : $("#from").val(),
                                to                  : $("#to").val(),
                                action              : "listReminder"
                            }});
                        jQuery("#remTable").setGridParam({ datatype: "xml" });
                        jQuery("#remTable").trigger("clearGridData");
                        jQuery("#remTable").trigger("reloadGrid");

            }


            // draw the date picker.
            jQueryDatePicker("from","to");
        </script>
    </head>
    <body>
        <%@include file="../templates/layout.jsp" %>

        <div id="bodyContainer">
            <form method="post" action="<%=request.getContextPath() + "/reports?action=printListReminder"%>" name="reminderReport">
                <div class="MainDiv">
                    <fieldset class="MainFieldset">
                        <legend>List Sent Reminders</legend>

                        <%-----------------------------------------------------------------------------------------------------%>
                        <%-- Search Criteria Field Set --%>
                        <%-----------------------------------------------------------------------------------------------------%>
                        <fieldset class="subMainFieldSet">
                            <legend>Search Criteria</legend>

                            <%-- Search Criteria left div --%>
                            <div class="IASFormLeftDiv">
                                <div class="IASFormFieldDiv">
                                    <span class="IASFormDivSpanLabel">
                                        <label>Reminder Type</label>
                                    </span>
                                    <span class="IASFormDivSpanInputBox">
                                     <select class="IASComboBoxWide" TABINDEX="6" name="remType" id="remType">
                                        <option value ="1">Gentle Reminder</option>
                                        <option value ="2">Strong Reminder</option>
                                        <option value ="3">Harsh Reminder</option>
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
                                        <input class="IASDateTextBox" TABINDEX="5" readonly size="10" type="text" id="from" name="from"/>
                                        <label> to </label>
                                        <input class="IASDateTextBox" TABINDEX="6" readonly size="10" type="text" id="to" name="to"/>
                                    </span>
                                </div>
                            </div>
                            <div class="actionBtnDiv">
                                <button class="IASButton SearchButton" type="button" TABINDEX="3" onclick="getList()" value="Search"/>Search</button>
                                <input class="IASButton" TABINDEX="4" type="reset" value="Reset"/>
                            </div>
                        </fieldset>
                        <%-----------------------------------------------------------------------------------------------------%>
                        <%-- Search Result Field Set --%>
                        <%-----------------------------------------------------------------------------------------------------%>
                        <fieldset class="subMainFieldSet">
                            <legend>Search Result</legend>
                            <table class="datatable" id="remTable"></table>
                            <div id="pager"></div>
                        </fieldset>
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