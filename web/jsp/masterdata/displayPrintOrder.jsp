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
        <script type="text/javascript" src="js/jquery/jquery.jqGrid.min.js"></script>
        <script type="text/javascript" src="js/jquery/grid.inlinedit.js"></script>
        <script type="text/javascript" src="js/jquery/grid.celledit.js"></script>
        <script>
            $(document).ready(function(){
                makePrintOrderReadOnly();
            });
        </script>

        <script type="text/javascript">
            var selectedId = 0;
            //initally set to false, after the first search the flag is set to true
            var isPageLoaded = false;

            $(document).ready(function(){
                //jQuery("#printOrderTable").jqGrid('navGrid',"#IASFormFieldDiv",{edit:false,add:false,del:false});
                jdsAppend("<%=request.getContextPath() + "/CMasterData?md=year"%>","year","year");
                jdsAppend("<%=request.getContextPath() + "/CMasterData?md=journals"%>", "journalName", "journalName");
                $("#btnEdit,#btnSave,#btnCancel").button("disable");

            });

            $(function(){

                $("#printOrderTable").jqGrid({
                    url:"<%=request.getContextPath()%>/printOrder",
                    datatype: 'xml',
                    mtype: 'GET',
                    width: '100%',
                    height: Constants.jqgrid.HEIGHT,
                    autowidth: true,
                    forceFit: true,
                    sortable: true,
                    loadonce: true,
                    rownumbers: true,
                    emptyrecords: "No Print Order for selected Year",
                    loadtext: "Loading...",
                    colNames:['Issue No','Print Order'],
                    colModel :[
                        {name:'issueNo', index:'issueNo', width:80, align:'center', xmlmap:'issueNo'},
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
                //this.disabled = 'true';
                jQuery("#btnSave,#btnCancel").button("enable");
            }

            function savePrintOrder(){
                var ids = jQuery("#printOrderTable").jqGrid('getDataIDs');

                for (var i = 0; i < ids.length; i++) {
                    jQuery("#printOrderTable").setGridParam({editurl: "<%=request.getContextPath()%>/printOrder?action=save" +
                            "&year=" + $("#year").val() +
                            "&journalName=" + $("#journalName").val() +
                            "&volume=" + $("#volume").val() +
                            "&issueNo=" + $("#printOrderTable").getCell(ids[i], 'issueNo')
                    });

                    jQuery("#printOrderTable").jqGrid('saveRow',ids[i]);
                }

                // The annual print order gets calculated on the server. To get that value we initiate a reloadgrid.
                jQuery("#printOrderTable").setGridParam({postData:
                        {year       : $("#year").val(),
                        action       : "searchPrintOrder"
                    }});

                jQuery("#printOrderTable").setGridParam({ datatype: "xml" });
                jQuery("#printOrderTable").trigger("clearGridData");
                jQuery("#printOrderTable").trigger("reloadGrid");

                jQuery("#btnSave,#btnCancel").button("disable");
                jQuery("#btnEdit").button("enable");
            }

            function cancelPrintOrder(){
                var ids = jQuery("#printOrderTable").jqGrid('getDataIDs');

                for (var i = 0; i < ids.length; i++) {
                    jQuery("#printOrderTable").jqGrid('restoreRow',ids[i]);
                }
                jQuery("#btnSave, #btnCancel").button("disable");
                jQuery("#btnEdit").button("enable");
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
                    $("#btnEdit").button("enable");
                }
            }

            function getPrintOrderDetails()
            {
                if($("#year").val() == 0){
                    alert("Select year");
                } else if($("#journalName").val() == 0) {
                    alert("Select journal");
                } else if ($("#volume").val() == 0){
                    alert("Select Volume Number");
                }else {
                    isPageLoaded = true;
                    jQuery("#printOrderTable").setGridParam({postData:
                            {year       : $("#year").val(),
                            journalName : $("#journalName").val(),
                            volume      : $("#volume").val(),
                            action      : "searchPrintOrder"
                        }});
                    jQuery("#printOrderTable").setGridParam({ datatype: "xml" });
                    jQuery("#printOrderTable").trigger("clearGridData");
                    jQuery("#printOrderTable").trigger("reloadGrid");
                    jQuery("#btnEdit").button("enable");
                }
            }

             function loadvolumes(){
                $("#volume").empty();
                //text("");

                var newOption = new Option("Select", "value");
                $(newOption).html("Select");
                $("#volume").append(newOption);

                requestURL = "CMasterData?md=getvolumes&mdvalue=" +  $("#journalName").val() + "&optionalParam=" +  $("#year").val();
                jdsAppend(requestURL,"volumeNumber","volume");
            }

            function clearGrid() {
                jQuery("#printOrderTable").trigger("clearGridData");
                jQuery("#printOrderTable").trigger("reloadGrid");
                $("#year").val(0);
                $("#volume").val(0);
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
                            <div class="IASFormLeftDiv reportsdiv">
                                <div class="IASFormFieldDiv">
                                    <span class="IASFormDivSpanLabel">
                                        <label>Journal:</label>
                                    </span>
                                    <span class="IASFormDivSpanInputBox">
                                        <select class="IASComboBoxWide allusers" TABINDEX="2" name="journalName" id="journalName" onchange="clearGrid()">
                                            <option value="0">Select</option>
                                        </select>
                                    </span>
                                </div>
                                <div class="IASFormFieldDiv">
                                    <span class="IASFormDivSpanLabel">
                                        <label>Year:</label>
                                    </span>
                                    <span class="IASFormDivSpanInputBox">
                                        <select class="IASComboBox allusers" TABINDEX="1" name="year" id="year" onchange="loadvolumes()">
                                            <option value="0">Select</option>
                                        </select>
                                    </span>
                                </div>
                            </div>
                            <div class="IASFormRightDiv">
                                <div class="IASFormFieldDiv">
                                    <span class="IASFormDivSpanLabel">
                                        <label>Volume Number:</label>
                                    </span>
                                    <span class="IASFormDivSpanInputBox">
                                        <select class="IASComboBox allusers" TABINDEX="4" name="volume" id="volume">
                                            <option value="0">Select</option>
                                        </select>
                                    </span>
                                </div>
                            </div>
                            <div class="actionBtnDiv">
                                <button class="IASButton SearchButton allusers" TABINDEX="2" type="button" id="btnSearch" name="btnSearch" onclick="getPrintOrderDetails()"/>Search Print Orders</button>
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
