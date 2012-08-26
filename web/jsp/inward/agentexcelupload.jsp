<!DOCTYPE HTML>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <title>Upload Agent Excel</title>
        <%@include file="../templates/style.jsp"%>
        <%@include file="../fileupload/fileupload.jsp"%>
        <link rel="stylesheet" type="text/css" href="<%=request.getContextPath() + "/css/inward/inward.css"%>" />
        <script type="text/javascript">
            var selectedInward = 0;
            var selectedSubscriberId = 0;
            var isPageLoaded = false;
            
            $(function(){
                
                _fileuploader = new jdsfileuploader("uploader");
                _fileuploader.url = "fileupload?action=agentXLUpload";
                _fileuploader.filters = [{title : "XLS files", extensions : "xls"}];
                _fileuploader.success = function(up, file, info){
                    
                    var xml = $(info.response);
                    var html = "<ol>";

                    xml.find("errors").each(function(){
                        html += "<li>" + $(this).text() + "</li>";
                    });
                    html += "</ol>";
                    
                    $("#ErrorPage").append(html);
                    
                    $("#ErrorPage").dialog({
                        modal: true,
                        height: 300,
                        width: 500
                    });
                };
                _fileuploader.error = function(up, args){
                    alert("Error" + args);
                }
                _fileuploader.draw();

            });
            
            
            /*$(function(){

                $("#subsTable").jqGrid({
                    url:'',
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
                                
            });*/

        </script>

    </head>
    <body>
        <%@include file="../templates/layout.jsp" %>
        <div id="bodyContainer">
            <form action="" method="GET" enctype="multipart/form-data">
                <div class="MainDiv">
                    <fieldset class="MainFieldset">
                        <legend>Upload Agent Excel</legend>
                        <fieldset class="subMainFieldSet">
                            <legend>File Upload</legend>
                            <div class="IASFormLeftDiv">
                                <div id="uploader">
                                    <p>You browser doesn't have Flash, Silverlight, Gears, BrowserPlus or HTML5 support.</p>
                                </div>
                            </div>
                            <div class="IASFormRightDiv">
                                <div class="IASFormFieldDiv">
                                    <b>Note:</b>
                                    <ul style="margin-top: 0">
                                        <li>The maximum file size for uploads is unlimited.</li>
                                        <li>Only xls files (<strong>.XLS</strong>) are allowed.</li>
                                        <li>The xls file will be validated and then subscriber and subscription will be created.</li>
                                    </ul>
                                </div>
                            </div>
                        </fieldset>

                        <fieldset class="subMainFieldSet">
                            <legend>Results</legend>
                            <div class="IASFormFieldDiv">
                                <table class="datatable" id="subsTable"></table>
                                <div id="pager"></div>
                            </div>
                        </fieldset>
                    </fieldset>
                    <div id="ErrorPage" style="padding:20px; display: none" title="Agent Excel Errors">
                        Resolve these errors to upload the Excel successfully
                    </div>
                </div>
            </form>
        </div>
    </body>
</html>