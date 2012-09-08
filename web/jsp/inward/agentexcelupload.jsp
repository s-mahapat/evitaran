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
            
            $(function(){ //Start of main function
                _fileuploader = new jdsfileuploader("uploader");
                _fileuploader.url = "fileupload?action=agentXLValidate";
                _fileuploader.filters = [{title : "XLS files", extensions : "xls"}];
                _fileuploader.success = function(up, file, info){ //Success block
                    
                    var xml = $(info.response);
                    var html = "<ol>";
                    if(xml.find("rows").size() == 0)
                    {html += "<hl>There are no errors found. Do you want to upload the excel?</hl>";}
                    else{
                        {html += "<hl>Resolve these errors to upload the Excel successfully</hl><br><br>";}
                        xml.find("rows").each(function(){
                            html += "<li>" + $(this).text() + "</li>";
                        });}
                    html += "</ol>";
                    
                    $("#ErrorPage").append(html);
                    
                    $("#ErrorPage").dialog({ //start of dialog block
                        modal: true,
                        height: 300,
                        width: 500,
                        buttons: { //start of buttons block
                            "Upload Excel": function() { //start of upload excel block
                                $.ajax({
                                    url: "fileupload?action=agentXLUpload",
                                    success:  function(xml){
                                        //console.log(xml);
                                        drawResultsGrid(xml);
                                        //function(xml){console.log(xml);}
                                    }
                                }); // end of ajax block
                                $( this ).dialog( "close" );
                            }, //end of upload excel block
                            Cancel: function() {
                                $( this ).dialog( "close" );
                            }
                        }//start of buttons block
                    }); //end of dialog block
                }; // end of Success block
                _fileuploader.error = function(up, args){
                    alert("Error" + args);
                }
                _fileuploader.draw();
            }); // end of main function
            
            function drawResultsGrid(xml){
                console.log(xml);
                $("#subsTable").jqGrid({
                    datastr: xml,
                    datatype: 'xmlstring',
                    //mtype: 'GET',
                    width: '100%',
                    height: 240,
                    autowidth: true,
                    viewrecords: true, 
                    forceFit: true,
                    sortable: true,
                    loadonce: true,
                    rownumbers: true,
                    emptyrecords: "No records to view",
                    loadtext: "Loading...",
                    colNames:['Id','Errors'],
                    colModel :[
                        {name:'Id', index:'id', align:'center', xmlmap:'id'},
                        {name:'Errors', index:'Errors', align:'center', xmlmap:'id'}
                ],
                    xmlReader : {
                        root: "results",
                        row: "row",
                        //page: "errors>page",
                        //total: "errors>total",
                        //records : "errors>records",
                        repeatitems: false,
                        id: "Id"
                    },
                    pager: '#pager',
                    rowNum:10,
                    rowList:[10,20,30],
                    viewrecords: true,
                    gridview: true,
                    caption: '&nbsp;',
                    //gridComplete: function() {},

                    loadError: function(xhr,status,error){
                        alert("Failed getting data from server" + status);
                    }
                });                         
            }
        </script>

    </head>
    <body>
        <%@include file="../templates/layout.jsp" %>
        <div id="bodyContainer">
            <form action="" method="POST" enctype="multipart/form-data">
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
                    <div id="ErrorPage" style="padding:20px; display: none" title="Agent Excel Upload">                       
                    </div>

                </div>
            </form>
        </div>
    </body>
</html>