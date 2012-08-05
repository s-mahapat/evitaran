<%--
    Document   : Display Print Order
    Author     : Deepali
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <jsp:include page="../templates/style.jsp"></jsp:include>
        <link rel="stylesheet" type="text/css" href="css/masterdata/printOrder.css"/>
        <title>Display Print Order</title>
        <script type="text/javascript" src="js/masterdata/displayPrintOrder.js"></script>
        <script type="text/javascript" src="js/masterdata/validatePrintOrder.js"></script>
        <script type="text/javascript" src="js/jquery/grid.common.js"></script>
        <script type="text/javascript" src="js/jquery/grid.inlinedit.js"></script>
        <script type="text/javascript" src="js/jquery/grid.celledit.js"></script>
        <script>
            addOnloadEvent(makePrintOrderReadOnly);
        </script>

        <script type="text/javascript">
            var selectedId = 0;
            //initally set to false, after the first search the flag is set to true
            var isPageLoaded = false;

            $(document).ready(function(){
                jQuery("#printOrderTable").jqGrid('navGrid',"#IASFormFieldDiv",{edit:false,add:false,del:false});
                jdsAppend("<%=request.getContextPath() + "/CMasterData?md=year"%>","year","year");
                jdsAppend("<%=request.getContextPath() + "/CMasterData?md=journals"%>", "journalName", "journalName");
                jQuery("#btnEdit,#btnSave,#btnCancel").attr("disabled",true);
             });

            $(function(){

                $("#printOrderTable").jqGrid({
                    url:"<%=request.getContextPath()%>/printOrder",
                    datatype: 'xml',
                    mtype: 'GET',
                    width: '100%',
                    height: 240,
                    autowidth: true,
                    forceFit: true,
                    sortable: true,
                    loadonce: true,
                    rownumbers: true,
                    emptyrecords: "No Print Order for selected Year",
                    loadtext: "Loading...",
                    colNames:['Issue No','Print Order'],
                    colModel :[
                        {name:'issues', index:'issues', width:80, align:'center', xmlmap:'issues'},
                        {name:'printOrder', index:'printOrder', width:80, align:'center',xmlmap:'printOrder', editable: true, edittype: 'text', editoptions: {rows:"1"}, editrules: {integer:true, minValue:0 }}
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
                    editurl:"<%=request.getContextPath()%>/printOrder?action=save",
                    gridComplete: function() {
                        var ids = jQuery("#printOrderTable").jqGrid('getDataIDs');

                        for (var i = 0; i < ids.length; i++) {
                            jQuery("#printOrderTable").jqGrid('setRowData', ids[i]);
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

            function editPrintOrder(){
                var ids = jQuery("#printOrderTable").jqGrid('getDataIDs');

                for (var i = 0; i < ids.length; i++) {
                    jQuery("#printOrderTable").jqGrid('editRow',ids[i]);
                }
                this.disabled = 'true';
                jQuery("#btnSave,#btnCancel").attr("disabled",false);
            }

            function savePrintOrder(){
                var ids = jQuery("#printOrderTable").jqGrid('getDataIDs');

                for (var i = 0; i < ids.length; i++) {
                    jQuery("#printOrderTable").setGridParam({editurl: "<%=request.getContextPath()%>/printOrder?action=save" +
                                                                        "&year=" + $("#year").val() +
                                                                "&journalName=" + $("#journalName").val() +
                                                                "&issueNo=" + $("#printOrderTable").getCell(ids[i], 'issues')
                                                                });

                    //var aPO = $("#printOrderTable").getCell(ids[i], 'issues') * $("#printOrderTable").getCell(ids[i], 'printOrder');

                    jQuery("#printOrderTable").jqGrid('saveRow',ids[i]);
                    //setGridParam requires a reload for value to reflect in the cell. Hence using setCell instead
                    //jQuery("#printOrderTable").setGridParam({annualPrintOrder: aPO});
                }
                jQuery("#btnSave,#btnCancel").attr("disabled",true);
                jQuery("#btnEdit").attr("disabled",false);

                // The annual print order gets calculated on the server. To get that value we initiate a reloadgrid.
                jQuery("#printOrderTable").setGridParam({postData:
                        {year       : $("#year").val(),
                        action       : "searchPrintOrder"
                    }});

                jQuery("#printOrderTable").setGridParam({ datatype: "xml" });
                jQuery("#printOrderTable").trigger("clearGridData");
                jQuery("#printOrderTable").trigger("reloadGrid");
            }

            function cancelPrintOrder(){
                var ids = jQuery("#printOrderTable").jqGrid('getDataIDs');

                for (var i = 0; i < ids.length; i++) {
                    jQuery("#printOrderTable").jqGrid('restoreRow',ids[i]);
                }
                jQuery("#btnSave,#btnCancel").attr("disabled",true);
                jQuery("#btnEdit").attr("disabled",false);
            }

            // called when the search button is clicked
            function searchPrintOrder(){
                if($("#year").val() == 0)
                {
                    alert("Select year");
                }
                else
                {
                if(validatePrintOrder() == true)
                    {
                        isPageLoaded = true;
                        jQuery("#printOrderTable").setGridParam({postData:
                                {year       : $("#year").val(),
                                action       : "searchPrintOrder"
                            }});

                        jQuery("#printOrderTable").setGridParam({ datatype: "xml" });
                        jQuery("#printOrderTable").trigger("clearGridData");
                        jQuery("#printOrderTable").trigger("reloadGrid");

                    }
                    jQuery("#btnEdit").attr("disabled",false);
                }
            }

            function getPrintOrderDetails()
            {
                if($("#year").val() == 0){
                    alert("Select year");
                } else if($("#journalName").val() == 0) {
                    alert("Select journal");
                }else {
                    isPageLoaded = true;
                    jQuery("#printOrderTable").setGridParam({postData:
                                    {year       : $("#year").val(),
                                    journalName : $("#journalName").val(),
                                    action       : "searchPrintOrder"
                                }});
                    jQuery("#printOrderTable").setGridParam({ datatype: "xml" });
                    jQuery("#printOrderTable").trigger("clearGridData");
                    jQuery("#printOrderTable").trigger("reloadGrid");
                    jQuery("#btnEdit").attr("disabled",false);
                }
            }

            /*
            function addNewPrintOrder(){
                if($("#year").val() == 0)
                {
                    alert("Select year");
                }
                else
                {
                if(validatePrintOrder() == true)
                    {
                        isPageLoaded = true;
                        jQuery("#printOrderTable").setGridParam({postData:
                                {year       : $("#year").val(),
                                action       : "add"
                            }});

                        jQuery("#printOrderTable").setGridParam({ datatype: "xml" });
                        jQuery("#printOrderTable").trigger("clearGridData");
                        jQuery("#printOrderTable").trigger("reloadGrid");

                    }
                }
                }
                */

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
                                        <div class="IASFormFieldDiv">
                                            <span class="IASFormDivSpanInputBox">
                                                <span class="IASFormDivSpanLabel">
                                                    <label>Journal:</label>
                                                </span>
                                                <select class="IASComboBox" TABINDEX="2" name="journalName" id="journalName">
                                                    <option value="0">Select</option>
                                                </select>
                                            </span>
                                        </div>
                                    </div>
                            </fieldset>
                            <fieldset class="subMainFieldSet">
                                <legend>Actions: Search/ Add</legend>
                                <div class="IASFormFieldDiv">
                                   <div id="searchBtnDiv">
                                        <input class="IASButton" TABINDEX="2" type="button" value="Search Print Orders" id="btnSearch" name="btnSearch" onclick="getPrintOrderDetails()"/>
                                   </div>
                                </div>
                            </fieldset>
                            <%-----------------------------------------------------------------------------------------------------%>
                            <%-- Search Result Field Set --%>
                            <%-----------------------------------------------------------------------------------------------------%>
                            <fieldset class="subMainFieldSet">
                                <legend>Print Order Details</legend>

                                <table class="datatable" id="printOrderTable"></table>
                                <div id="pager"></div>
                            </fieldset>

                            <%-----------------------------------------------------------------------------------------------------%>
                            <%-- Journal Actions Field Set --%>
                            <%-----------------------------------------------------------------------------------------------------%>

                            <fieldset class="subMainFieldSet">
                                <div class="IASFormFieldDiv">
                                    <div id="editBtnDiv">
                                        <input class="IASButton" TABINDEX="3" type="button" value="Edit" onclick="editPrintOrder()" id="btnEdit" name="btnEditAction"/>
                                    </div>
                                    <div id="saveBtnDiv">
                                        <input class="IASButton" TABINDEX="4" type="button" value="Save" onclick="savePrintOrder()" id="btnSave" name="btnSaveAction"/>
                                    </div>
                                    <div id="cancelBtnDiv">
                                        <input class="IASButton" TABINDEX="5" type="button" value="Cancel" onclick="cancelPrintOrder()" id="btnCancel" name="btnCancelAction"/>
                                    </div>
                                </div>
                            </fieldset>
                    </fieldset>
                </div>
            </form>
        </div>
    </body>
</html>
