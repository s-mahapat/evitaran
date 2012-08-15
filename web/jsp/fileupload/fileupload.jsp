<!DOCTYPE HTML>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <title>Upload Excel</title>
        <%@include file="../templates/style.jsp"%>
        <script type="text/javascript">
            var isPageLoaded = true;
            $("#errorTable").jqGrid({
            url:"fileupload?action=fileupload",
                datatype: 'xml',
                mtype: 'GET',
                width: '100%',
                autowidth: true,
                height: 240,
                forceFit: true,
                sortable: true,
                loadonce: false,
                rownumbers: true,
                loadtext: "Loading...",
                colNames:['Errors'],
                colModel :[
                    {
                        name:'Errors',
                        index:'erors',
                        xmlmap:'errors',
                        sortable: false
                    },
                ],
                xmlReader : {
                    root: "results",
                    row: "row",
                    page: "results>page",
                    total: "results>total",
                    records : "results>records",
                    repeatitems: false,
                    id: "errors"
                },
                pager: '#pager',
                rowNum: 10,
                rowList:[10,30,50,100],
                viewrecords: true,
                gridview: true,
                caption: '&nbsp;',
                beforeRequest: function(){
                    return isPageLoaded;
                },
                loadError: function(xhr,status,error){
                    alert("Failed getting data from server" + status);
                }
            });

        </script>

    </head>
    <body>
        <%@include file="../templates/layout.jsp" %>
        <div id="bodyContainer">
            <form id="upload-form" method="post" action="fileupload?action=fileupload" name="uploadForm" enctype="multipart/form-data">
                <div class="MainDiv">
                    <fieldset class="MainFieldset">
                        <legend>File Upload</legend>
                        <fieldset class="subMainFieldSet">

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
                                        <li>Only .xls files (<strong>.xls</strong>) are allowed.</li>
                                        <li>The file will be validated first and then uploaded</li>
                                    </ul>
                                </div>
                            </div>
                        </fieldset>
                        <fieldset class="subMainFieldSet">
                            <legend>Errors</legend>
                            <table class="datatable" id="errorTable"></table>
                            <div id="pager"></div>
                        </fieldset>
                    </fieldset>
                </div>
            </form>
        </div>
    </body>
</html>