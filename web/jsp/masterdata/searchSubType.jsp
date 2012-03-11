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

        <title>Search Subscriber Type</title>
        <script type="text/javascript" src="<%=request.getContextPath() + "/js/masterdata/searchSubType.js"%>"></script>
        <script type="text/javascript" src="<%=request.getContextPath() + "/js/masterdata/validateSubType.js"%>"></script>
        <script type="text/javascript">
            //var selectedSubTypeName = 0;
            var selectedId = 0;
            //initally set to false, after the first search the flag is set to true
            var isPageLoaded = false;

            $(function(){

                $("#subTypeTable").jqGrid({
                    url:"<%=request.getContextPath() + "/subType?action=search"%>",
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
                    colNames:['Id','Subscriber Type Code','Subscriber Type','Free/Paid', 'Indian/Foreign','Inst/Pers','View/Edit'],
                    colModel :[
                        {name:'id', index:'id', width:50, align:'center', xmlmap:'id'},
                        {name:'subtypecode', index:'subtypecode', width:80, align:'center', xmlmap:'subtypecode'},
                        {name:'subtypedesc', index:'subtypedesc', width:80, align:'center', xmlmap:'subtypedesc'},
                        {name:'subtype', index:'subtype', width:80, align:'center', xmlmap:'subtype'},
                        {name:'nationality', index:'nationality', width:80, align:'center', xmlmap:'nationality'},
                        {name:'institutional', index:'institutional', width:80, align:'center', xmlmap:'institutional'},
                        {name:'Action', index:'action', width:80, align:'center',formatter:'showlink'}
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
                    gridComplete: function() {
                        var ids = jQuery("#subTypeTable").jqGrid('getDataIDs');

                        for (var i = 0; i < ids.length; i++) {
                            action = "<a style='color:blue;' href='subType?action=view&id=" + ids[i] + "'>View</a><a style='color:blue;' href='subType?action=edit&id=" + ids[i] + "'>/ Edit</a>";
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
            function searchSubType(){
                if(validateSearchSubType() == true)
                    {
                        isPageLoaded = true;

                        jQuery("#subTypeTable").setGridParam({postData:
                                {subtypecode       : $("#subtypecode").val(),
                                subtype          : $("#subtype").val()
                            }});
                        jQuery("#subTypeTable").setGridParam({ datatype: "xml" });
                        jQuery("#subTypeTable").trigger("clearGridData");
                        jQuery("#subTypeTable").trigger("reloadGrid");
                    }
            }

            // draw the date picker.
            //jQueryDatePicker("from","to");

        </script>

    </head>
    <body>
        <%@include file="../templates/layout.jsp" %>

        <div id="bodyContainer">
            <form method="post" action="" name="searchSubTypeForm">
                <div class="MainDiv">
                    <fieldset class="MainFieldset">
                        <legend>Search Sub Type</legend>

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
                                        <input class="IASTextBox" TABINDEX="1" type="text" name="subtypecode" id="subtypecode" value=""/>
                                    </span>
                                </div>
                           </div>
                           <div class="IASFormRightDiv">
                                <div class="IASFormFieldDiv">
                                    <span class="IASFormDivSpanLabel">
                                        <label>Subscriber Type</label>
                                    </span>
                                    <span class="IASFormDivSpanInputBox">
                                        <input class="IASTextBox" TABINDEX="2" type="text" name="subtype" id="subtype" value=""/>
                                    </span>
                                </div>
                            </div>

                            <div class="IASFormFieldDiv">
                                <div id="searchBtnDiv">
                                    <input class="IASButton" TABINDEX="3" type="button" value="search" onclick="searchSubType()"/>
                                </div>

                                <div id="resetBtnDiv">
                                    <input class="IASButton" TABINDEX="4" type="reset" value="Reset"/>
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
                    </fieldset>
                </div>
            </form>
        </div>
    </body>
</html>