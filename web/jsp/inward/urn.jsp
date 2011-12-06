<!DOCTYPE HTML>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <title>Update Receipt Numbers</title>
        <%@include file="../templates/style.jsp"%>
        <link rel="stylesheet" type="text/css" href="<%=request.getContextPath() + "/css/inward/inward.css"%>" />

        <script type="text/javascript">
            //var calPopup = new CalendarPopup("dateDiv");
            //calPopup.showNavigationDropdowns();
            var selectedInward = 0;
            var selectedSubscriberId = 0;
            var isPageLoaded = false;
            $(function(){

                $("#urnTable").jqGrid({
                    url:'/JDS/jsp/inward/urnXML.jsp',
                    datatype: 'xml',
                    mtype: 'GET',
                    width: '100%',
                    height: 240,
                    autowidth: true,
                    forceFit: true,
                    sortable: true,
                    loadonce: true,
                    rownumbers: true,
                    emptyrecords: "No records to view",
                    loadtext: "Loading...",
                    colNames:['Inward#','Subscriber#', 'Reciept#','Cheque#','Date'],
                    colModel :[
                        {name:'Inward#', index:'inward_id', width:50, align:'center', xmlmap:'inward_id'},
                        {name:'Subscriber#', index:'subscriber_id', width:50, align:'center', xmlmap:'subscriber_id'},
                        {name:'Reciept#', index:'reciept_no', width:50, align:'center', xmlmap:'reciept_no'},
                        {name:'Cheque#', index:'cheque_no', width:50, align:'center', xmlmap:'cheque_no'},
                        {name:'Date', index:'date', width:30, align:'center', sortable: true, sorttype: 'int',xmlmap:'date'},
                    ],
                    xmlReader : {
                        root: "result",
                        row: "urn",
                        page: "urns>page",
                        total: "urns>total",
                        records : "urns>records",
                        repeatitems: false,
                        id: "id"
                    },
                    pager: '#pager',
                    rowNum:10,
                    rowList:[10,20,30],
                    viewrecords: true,
                    gridview: true,
                    caption: '&nbsp;',
                    gridComplete: function() {},

                    loadError: function(xhr,status,error){
                        alert("Failed getting data from server" + status);
                    }
                });
            })
        </script>

    </head>
    <body>
        <%@include file="../templates/layout.jsp" %>
        <div id="bodyContainer">
            <form action="" method="POST" enctype="multipart/form-data">
                <div class="MainDiv">
                    <fieldset class="MainFieldset">
                        <legend>Update Receipt Numbers</legend>
                        <fieldset class="subMainFieldSet">
                            <legend>File Upload</legend>
                            <div class="IASFormLeftDiv">
                                <div class="IASFormFieldDiv">
                                    <span class="IASFormDivSpanLabel">
                                        Add files...
                                    </span>
                                    <span class="IASFormDivSpanInputBox">
                                        <input class="JDSFileInput" type="file" maxlength="512" name="files[]" multiple>
                                    </span>
                                </div>
                                <div class="IASFormFieldDiv">
                                    <span class="IASFormDivSpanLabel">&nbsp;</span>
                                    <span class="IASFormDivSpanInputBox">
                                        <button class="IASButton" type="submit">Start Upload</button>
                                    </span>
                                    <span class="IASFormDivSpanInputBox">
                                        <button class="IASButton" type="reset">Cancel Upload</button>
                                    </span>
                                </div>
                            </div>
                            <div class="IASFormRightDiv">
                                <div class="IASFormFieldDiv">
                                    <b>Note:</b>
                                    <ul style="margin-top: 0">
                                        <li>The maximum file size for uploads is unlimited.</li>
                                        <li>Only xml files (<strong>.XML</strong>) are allowed.</li>
                                        <li>The receipt numbers will be updated in the respective inwards.</li>
                                    </ul>
                                </div>
                            </div>
                        </fieldset>

                        <fieldset class="subMainFieldSet">
                            <legend>Results</legend>
                            <div class="IASFormFieldDiv">
                            <table class="datatable" id="urnTable"></table>
                            <div id="pager"></div>
                            </div>
                        </fieldset>
                    </fieldset>
                </div>
            </form>
        </div>
    </body>
</html>