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
                $.ajax(
                {
                    type: "POST",
                    url: "<%=request.getContextPath()%>/reports?action=printOrderTableDetails",
                    data: "",
                    dataType: "xml",
                    success: function(xmlResponse, textStatus, jqXHR)
                    {
                        /*
                        colD = results.colData;
                        colN = results.colNames;
                        colM = results.colModel;
                        */

                        $(xmlResponse).find("results").each(function(){
                            colD = $(this).find("colData").text();
                            colN = $(this).find('colNames').text();
                            colM = $(this).find('colModel').text();
                        });

                       /*
                       colD = ['{<issues>10</issues>, <printOrder>10</printOrder>}'];
                       colN = ['Issue No', 'Print Order'];
                       colM = [{name:'issues', index:'issues', xmlmap:'issues'}, {name:'printOrder', index:'printOrder', xmlmap:'printOrder'}];
                       */

                        jQuery("#printOrderTable").jqGrid({
                            url: "<%=request.getContextPath()%>/reports?action=printOrderTableDetails",
                            dataType: "xml",
                            mtype: 'GET',
                            width: '100%',
                            height: 240,
                            autowidth: true,
                            forceFit: true,
                            sortable: true,
                            loadonce: true,
                            rownumbers: true,
                            emptyrecords: "No Print Order",
                            loadtext: "Loading...",
                            colNames:colN,
                            colModel:colM,
                            datastr:colD,
                            xmlReader : {
                                root: "results",
                                row: "row",
                                page: "results>page",
                                total: "results>total",
                                records : "results>records",
                                repeatitems: false,
                                id: "id"
                            },
                            pager: jQuery('#pager'),
                            rowNum: 15,
                            rowList: [15, 30, 45, 60],
                            viewrecords: true,
                            gridview: true,
                            caption: '&nbsp;'
                        })
                   },
                   error: function(x, e)
                   {
                        alert(x.readyState + " "+ x.status +" "+ e.msg);
                   }
                });
                setTimeout(function() {$("#printOrderTable").jqGrid('setGridParam',{datatype:'json'}); },50);
            });

             /*
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
                        {name:'printOrder', index:'printOrder', width:80, align:'center',xmlmap:'printOrder', editable: true, edittype: 'text', editoptions: {rows:"1"}, editrules: {integer:true, minValue:0 }},
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
                        <legend>Print Order Details</legend>
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
                            </fieldset>
                            <%-----------------------------------------------------------------------------------------------------%>
                            <%-- Search Result Field Set --%>
                            <%-----------------------------------------------------------------------------------------------------%>
                            <fieldset class="subMainFieldSet">
                                <legend>Print Order Details</legend>

                                <table class="datatable" id="printOrderTable"></table>
                                <div id="pager"></div>
                            </fieldset>
                    </fieldset>
                </div>
            </form>
        </div>
    </body>
</html>
