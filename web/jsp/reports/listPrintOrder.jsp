<%--
    Document   : Display Print Order
    Author     : Alok
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <jsp:include page="../templates/style.jsp"></jsp:include>
            <link rel="stylesheet" type="text/css" href="css/masterdata/printOrder.css"/>
            <title>Print Order Details</title>
            <script type="text/javascript" src="js/masterdata/displayPrintOrder.js"></script>
            <script type="text/javascript" src="js/masterdata/validatePrintOrder.js"></script>
            <script type="text/javascript" src="js/jquery/grid.common.js"></script>
            <script type="text/javascript" src="js/jquery/grid.inlinedit.js"></script>
            <script type="text/javascript" src="js/jquery/grid.celledit.js"></script>
            <script>
                //addOnloadEvent(makePrintOrderReadOnly);
            </script>

            <script type="text/javascript">
                var selectedId = 0;
                //initally set to false, after the first search the flag is set to true
                var isPageLoaded = false;

                $(document).ready(function(){
                    jdsAppend("<%=request.getContextPath() + "/CMasterData?md=year"%>","year","year");
                    $("#printReportBtn").button("disable");
                });

                $(function(){

                    $("#printOrderTable").jqGrid({
                        url:"<%=request.getContextPath()%>/reports?action=printOrderTableDetailsList",
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
                        //colNames:['Issue No','Print Order'],
                        colNames: <jsp:getProperty name="printOrderFormBeanReport" property="colN"/>,
                        colModel: <jsp:getProperty name="printOrderFormBeanReport" property="colM"/>,
                        /*
                        colModel :[
                            {name:'issues', index:'issues', width:80, align:'center', xmlmap:'issues'},
                            {name:'printOrder', index:'printOrder', width:80, align:'center',xmlmap:'printOrder', editable: true, edittype: 'text', editoptions: {rows:"1"}, editrules: {integer:true, minValue:0 }},
                        ],*/
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

                function getPrintOrderDetailsList()
                {
                    isPageLoaded = true;
                    jQuery("#printOrderTable").setGridParam({postData:
                            {year       : $("#year").val(),
                            action       : "printOrderTableDetailsList"
                        }});
                    jQuery("#printOrderTable").setGridParam({ datatype: "xml" });
                    jQuery("#printOrderTable").trigger("clearGridData");
                    jQuery("#printOrderTable").trigger("reloadGrid");
                    $("#printReportBtn").button("enable");
                }

        </script>
    </head>
    <body>

        <%@include file="../templates/layout.jsp" %>
        <div id="bodyContainer">
            <jsp:useBean class="IAS.Bean.Reports.printOrderFormBeanReport" id="printOrderFormBeanReport" scope="request"></jsp:useBean>
            <form method="post" action="<%=request.getContextPath() + "/reports?action=printPOT"%>" name="printOrderForm">
                <div class="MainDiv">
                    <fieldset class="MainFieldset">
                        <legend>Print Order Details</legend>
                        <fieldset class="subMainFieldSet">
                            <legend>Search Criterion</legend>
                            <%-- Search Criteria left div --%>
                            <div class="IASFormLeftDiv">
                                <div class="IASFormFieldDiv">
                                        <span class="IASFormDivSpanLabel">
                                            <label>Year:</label>
                                        </span>
                                        <span class="IASFormDivSpanInputBox">
                                            <select class="IASComboBox allusers" TABINDEX="1" name="year" id="year" onchange="getPrintOrderDetailsList()">
                                                <option value="0">Select</option>
                                            </select>
                                        </span>
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
                        <%-- Print Action Field Set --%>
                        <%-----------------------------------------------------------------------------------------------------%>


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
