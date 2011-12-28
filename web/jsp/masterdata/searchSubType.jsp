<%--
    Document   : Search Subscriber Type
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="../templates/style.jsp" %>
        <link rel="stylesheet" type="text/css" href="css/masterdata/journal.css" />
        <title>Search Journal</title>

        <script type="text/javascript">
            var selectedSubTypeName = 0;
            var selectedSubTypeId = 0;
            //initally set to false, after the first search the flag is set to true
            var isPageLoaded = false;

            $(function(){

                $("#subTypeTable").jqGrid({
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
                    emptyrecords: "No Subscriber Type",
                    loadtext: "Loading...",
                    colNames:['Subscriber Type Id','Subscriber Type Code','Subscriber Type','Free/Paid', 'Indian/Foreign','Inst/Pers','Action'],
                    colModel :[
                        {name:'subTypeId', index:'subTypeId', width:50, align:'center', xmlmap:'subTypeId'},
                        {name:'subTypeCode', index:'subTypeCode', width:80, align:'center', xmlmap:'subTypeCode'},
                        {name:'subType', index:'subType', width:80, align:'center', xmlmap:'subType'},
                        {name:'freePaid', index:'freePaid', width:80, align:'center', xmlmap:'freePaid'},
                        {name:'indFrn', index:'indFrn', width:80, align:'center', xmlmap:'indFrn'},
                        {name:'instPers', index:'instPers', width:80, align:'center', xmlmap:'instPers'},
                        {name:'Action', index:'action', width:80, align:'center',formatter:'showlink'}
                    ],
                    xmlReader : {
                        root: "result",
                        row: "subType",
                        page: "subType>page",
                        total: "subType>total",
                        records : "subType>records",
                        repeatitems: false,
                        id: "subTypeId"
                    },
                    pager: '#pager',
                    rowNum:10,
                    rowList:[10,20,30],
                    viewrecords: true,
                    gridview: true,
                    caption: '&nbsp;',
                    gridComplete: function() {
                        var ids = jQuery("#subTypeTable").jqGrid('getDataIDs');
                        if(ids.length > 0){
                            $("#btnNext").removeAttr("disabled");
                        }
                        for (var i = 0; i < ids.length; i++) {
                            var cl = ids[i];
                            var rowData = jQuery("#subTypeTable").jqGrid('getLocalRow',cl);
                            var subTypeId = rowData['subTypeId'] || 0;
                            action = "<a style='color:blue;' href='subType?action=view'>View</a><a style='color:blue;' href='subType?action=edit&subTypeId=" + subTypeId + "'>Edit</a>";
                            jQuery("#subTypeTable").jqGrid('setRowData', ids[i], { Action: action });
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
            function searchSubtype(){
                isPageLoaded = true;
                jQuery("#subTypeTable").trigger("reloadGrid");
            }

            // draw the date picker.
            jQueryDatePicker("from","to");

        </script>        

    </head>
    <body>
        <%@include file="../templates/layout.jsp" %>

        <div id="bodyContainer">
            <form method="post" action="<%=request.getContextPath() + "/subType"%>" name="subTypeForm">
                <div class="MainDiv">
                    <fieldset class="MainFieldset">
                        <legend>Search Journal</legend>

                        <%-----------------------------------------------------------------------------------------------------%>
                        <%-- Search Criteria Field Set --%>
                        <%-----------------------------------------------------------------------------------------------------%>
                        <fieldset class="subMainFieldSet">
                            <legend>Search Criteria</legend>

                            <%-- Search Criteria left div --%>
                            <div class="IASFormLeftDiv">


                                <div class="IASFormFieldDiv">
                                    <span class="IASFormDivSpanLabel">
                                        <label>Sub type Code:</label>
                                    </span>
                                    <span class="IASFormDivSpanInputBox">
                                        <input class="IASTextBox" TABINDEX="1" type="text" name="subTypeCode" id="subTypeCode" value=""/>
                                    </span>
                                </div>
                           </div>
                           <div class="IASFormRightDiv">
                                <div class="IASFormFieldDiv">
                                    <span class="IASFormDivSpanLabel">
                                        <label>Subscriber Type</label>
                                    </span>
                                    <span class="IASFormDivSpanInputBox">
                                        <input class="IASTextBox" TABINDEX="2" type="text" name="subTypeName" id="subTypeName" value=""/>
                                    </span>
                                </div>
                            </div>

                            <div class="IASFormFieldDiv">
                                <div id="searchBtnDiv">
                                    <input class="IASButton" TABINDEX="6" type="submit" value="Search"/>
                                </div>

                                <div id="resetBtnDiv">
                                    <input class="IASButton" TABINDEX="7" type="reset" value="Reset"/>
                                </div>
                            </div>

                        </fieldset>


                        <%-----------------------------------------------------------------------------------------------------%>
                        <%-- Search Result Field Set --%>
                        <%-----------------------------------------------------------------------------------------------------%>
                        <fieldset class="subMainFieldSet">
                            <legend>Search Result</legend>

                            <table class="datatable" id="subTypeTable"></table>
                            <div id="pager"></div>
                        </fieldset>

                        <fieldset class="subMainFieldSet">
                            <div class="IASFormFieldDiv">
                                <div class="singleActionBtnDiv">
                                    <input class="IASButton" type="button" value="Print" onclick="javascript:window.print();"/>
                                </div>
                            </div>
                        </fieldset>

                    </fieldset>
                </div>
            </form>
        </div>
    </body>
</html>