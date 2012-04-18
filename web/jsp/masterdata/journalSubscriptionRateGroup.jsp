<%--
    Document   : journalSubscriptionRateGroup
    Created on : Mar 12, 2012, 6:01:05 PM
    Author     : aloko
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <jsp:include page="../templates/style.jsp"></jsp:include>
        <%--<link rel="stylesheet" type="text/css" href="css/masterdata/journalSubscriptionRateGroup.css"/>--%>
        <title>Subscription Rates</title>
        <script type="text/javascript" src="js/masterdata/journalSubscriptionRateGroup.js"></script>
        <script type="text/javascript" src="js/masterdata/validateJournalSubscriptionRateGroup.js"></script>
        <script type="text/javascript" src="js/jquery/grid.common.js"></script>
        <script type="text/javascript" src="js/jquery/grid.inlinedit.js"></script>
        <script type="text/javascript" src="js/jquery/grid.celledit.js"></script>
        <script>
            addOnloadEvent(makeSubscriptionRateGroupReadOnly);
        </script>


        <script type="text/javascript">
            var selectedId = 0;
            //initally set to false, after the first search the flag is set to true
            var isPageLoaded = false;

            $(document).ready(function(){
                jQuery("#subscriptionRateTable").jqGrid('navGrid',"#IASFormFieldDiv",{edit:false,add:false,del:false});
             });

            $(function(){

                $("#subscriptionRateTable").jqGrid({
                    url:"<%=request.getContextPath()%>/journalSubscriptionRateGroup",
                    datatype: 'xml',
                    mtype: 'GET',
                    width: '100%',
                    height: 240,
                    autowidth: true,
                    forceFit: true,
                    sortable: true,
                    loadonce: true,
                    rownumbers: true,
                    emptyrecords: "No Subscription Rates found",
                    loadtext: "Loading...",
                    colNames:['Subscription Rates ID','Group Name','Year','Subscriber Type', 'Rate', 'Period'],
                    colModel :[
                        {name:'id', index:'id', width:50, align:'center', xmlmap:'id'},
                        {name:'journalGroupName', index:'journalGroupName', width:80, align:'center', xmlmap:'journalGroupName'},
                        {name:'year', index:'year', width:80, align:'center', xmlmap:'year'},
                        {name:'subtypedesc', index:'subtypedesc', width:80, align:'center', xmlmap:'subtypedesc'},
                        {name:'rate', index:'rate', width:80, align:'center',xmlmap:'rate', editable: true, edittype: 'text', editoptions: {rows:"1"}, editrules: {required: true, integer:true, minValue:0 }},
                        {name:'period', index:'period', width:80, align:'center',xmlmap:'period', editable: true, edittype: 'text', editoptions: {rows:"1"}, editrules: {required: true, integer:true, minValue:0 }}
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
                    editurl:"<%=request.getContextPath()%>/journalSubscriptionRateGroup?action=save",
                    gridComplete: function() {
                        var ids = jQuery("#subscriptionRateTable").jqGrid('getDataIDs');

                        for (var i = 0; i < ids.length; i++) {
                            jQuery("#subscriptionRateTable").jqGrid('setRowData', ids[i]);
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

            function edit(){
                var ids = jQuery("#subscriptionRateTable").jqGrid('getDataIDs');

                for (var i = 0; i < ids.length; i++) {
                    jQuery("#subscriptionRateTable").jqGrid('editRow',ids[i]);
                }
                this.disabled = 'true';
                jQuery("#btnSave,#btnCancel").attr("disabled",false);
            }

            function savePrintOrder(){
                var ids = jQuery("#subscriptionRateTable").jqGrid('getDataIDs');

                for (var i = 0; i < ids.length; i++) {
                    jQuery("#subscriptionRateTable").setGridParam({editurl: "<%=request.getContextPath()%>/journalSubscriptionRateGroup?action=save" +
                                                                        "&year=" + $("#subscriptionRateTable").getCell(ids[i], 'year') +
                                                                "&journalCode=" + $("#subscriptionRateTable").getCell(ids[i], 'journalCode')
                                                                });
                    jQuery("#subscriptionRateTable").jqGrid('saveRow',ids[i]);
                    var aPO = $("#subscriptionRateTable").getCell(ids[i], 'issues') * $("#subscriptionRateTable").getCell(ids[i], 'printOrder');
                    jQuery("#subscriptionRateTable").setCell(ids[i], 'annualPrintOrder', aPO);
                    //setGridParam requires a reload for value to reflect in the cell. Hence using setCell instead
                    //jQuery("#subscriptionRateTable").setGridParam({annualPrintOrder: aPO});
                }
                jQuery("#btnSave,#btnCancel").attr("disabled",true);
                jQuery("#btnEdit").attr("disabled",false);

            }

            function cancelPrintOrder(){
                var ids = jQuery("#subscriptionRateTable").jqGrid('getDataIDs');

                for (var i = 0; i < ids.length; i++) {
                    jQuery("#subscriptionRateTable").jqGrid('restoreRow',ids[i]);
                }
                jQuery("#btnSave,#btnCancel").attr("disabled",true);
                jQuery("#btnEdit").attr("disabled",false);
            }

            // called when the search button is clicked
            function searchPrintOrder(){
                if(validatePrintOrder() == true)
                    {
                        isPageLoaded = true;
                        jQuery("#subscriptionRateTable").setGridParam({postData:
                                {year       : $("#year").val(),
                                action       : "searchPrintOrder"
                            }});

                        jQuery("#subscriptionRateTable").setGridParam({ datatype: "xml" });
                        jQuery("#subscriptionRateTable").trigger("clearGridData");
                        jQuery("#subscriptionRateTable").trigger("reloadGrid");

                    }
                }

            function addNewPrintOrder(){
                var gridData = jQuery("#subscriptionRateTable").getRowData();

                if(validatePrintOrder() == true)
                    {
                        isPageLoaded = true;
                        jQuery("#subscriptionRateTable").setGridParam({postData:
                                {year       : $("#year").val(),
                                action       : "add"
                            }});

                        jQuery("#subscriptionRateTable").setGridParam({ datatype: "xml" });
                        jQuery("#subscriptionRateTable").trigger("clearGridData");
                        jQuery("#subscriptionRateTable").trigger("reloadGrid");

                    }
                }

        </script>
    </head>
    <body>

        <%@include file="../templates/layout.jsp" %>
        <div id="bodyContainer">
            <jsp:useBean class="IAS.Bean.masterdata.printOrderFormBean" id="printOrderFormBean" scope="request"></jsp:useBean>
            <form method="post" action="" name="printOrderForm" onsubmit="return validatePrintOrder()">
                <div class="MainDiv">
                    <fieldset class="MainFieldset">
                        <legend>Display Print Order</legend>
                            <fieldset class="subMainFieldSet">
                                <legend>Search Criterion</legend>
                                    <%-- Search Criteria left div --%>
                                    <div class="IASFormLeftDiv">
                                        <div class="IASFormFieldDiv">
                                            <span class="IASFormDivSpanLabel">
                                                <label>Year:</label>
                                            </span>
                                            <span class="IASFormDivSpanInputBox">
                                                <input class="IASTextBox" TABINDEX="1" type="text" name="year" id="year" value="<jsp:getProperty name="printOrderFormBean" property="year"/>"/>
                                            </span>
                                        </div>
                                        <div class="IASFormFieldDiv">
                                            <div id="searchBtnDiv">
                                                <input class="IASButton" TABINDEX="2" type="button" value="Search Print Orders" id="btnSearch" name="btnSearch" onclick="searchPrintOrder()"/>
                                            </div>
                                        </div>
                                    </div>
                                    <%-- Search Criteria right div --%>
                                    <div class="IASFormRightDiv">
                                        <div class="IASFormFieldDiv">
                                            <div id="addBtnDiv">
                                                <input class="IASButton" TABINDEX="3" type="button" value="Add New Print Orders" id="btnAdd" name="btnAdd" onclick="addNewPrintOrder()"/>
                                            </div>
                                        </div>
                                    </div>

                            </fieldset>

                            <%-----------------------------------------------------------------------------------------------------%>
                            <%-- Search Result Field Set --%>
                            <%-----------------------------------------------------------------------------------------------------%>
                            <fieldset class="subMainFieldSet">
                                <legend>Search Result</legend>

                                <table class="datatable" id="subscriptionRateTable"></table>
                                <div id="pager"></div>
                            </fieldset>

                            <%-----------------------------------------------------------------------------------------------------%>
                            <%-- Journal Actions Field Set --%>
                            <%-----------------------------------------------------------------------------------------------------%>

                            <fieldset class="subMainFieldSet">
                                <div class="IASFormFieldDiv">
                                        <input class="IASButton" TABINDEX="4" type="button" value="Edit" onclick="editPrintOrder()" id="btnEdit" name="btnEditAction"/>
                                        <input class="IASButton" TABINDEX="5" type="button" value="Save" onclick="savePrintOrder()" id="btnSave" name="btnSaveAction"/>
                                        <input class="IASButton" TABINDEX="6" type="button" value="Cancel" onclick="cancelPrintOrder()" id="btnCancel" name="btnCancelAction"/>
                                </div>
                            </fieldset>
                    </fieldset>
                </div>
            </form>
        </div>
    </body>
</html>


