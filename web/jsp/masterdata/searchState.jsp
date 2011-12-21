<%--
    Document   : Search State
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="../templates/style.jsp" %>
        <link rel="stylesheet" type="text/css" href="css/masterdata/state.css" />

        <title>Search State</title>
        <script type="text/javascript">
            var selectedState = 0;
            var selectedSateId = 0;
            //initally set to false, after the first search the flag is set to true
            var isPageLoaded = false;

            $(function(){

                $("#stateTable").jqGrid({
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
                    emptyrecords: "No Country",
                    loadtext: "Loading...",
                    colNames:['State Id','State','View/Edit'],
                    colModel :[
                        {name:'StateId', index:'stateId', width:50, align:'center', xmlmap:'stateId'},
                        {name:'state', index:'state', width:80, align:'center', xmlmap:'state'},
                        {name:'Action', index:'action', width:80, align:'center',formatter:'showlink'}
                    ],
                    xmlReader : {
                        root: "result",
                        row: "state",
                        page: "state>page",
                        total: "state>total",
                        records : "state>records",
                        repeatitems: false,
                        id: "stateId"
                    },
                    pager: '#pager',
                    rowNum:10,
                    rowList:[10,20,30],
                    viewrecords: true,
                    gridview: true,
                    caption: '&nbsp;',
                    gridComplete: function() {
                        var ids = jQuery("#stateTable").jqGrid('getDataIDs');
                        if(ids.length > 0){
                            $("#btnNext").removeAttr("disabled");
                        }
                        for (var i = 0; i < ids.length; i++) {
                            var cl = ids[i];
                            var rowData = jQuery("#stateTable").jqGrid('getLocalRow',cl);
                            var cityId = rowData['State Id'] || 0;
                            action = "<a style='color:blue;' href='state?action=view'>View</a><a style='color:blue;' href='state?action=edit&state=" + stateId + "'>Edit</a>";
                            jQuery("#stateTable").jqGrid('setRowData', ids[i], { Action: action });
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
            function searchState(){
                isPageLoaded = true;
                jQuery("#stateTable").trigger("reloadGrid");
            }

            // draw the date picker.
            jQueryDatePicker("from","to");

        </script>
    </head>
    <body>
        <%@include file="../templates/layout.jsp" %>

        <div id="bodyContainer">
            <form method="post" action="" name="searchstateForm">
                <div class="MainDiv">
                    <fieldset class="MainFieldset">
                        <legend>Search State</legend>

                        <%-----------------------------------------------------------------------------------------------------%>
                        <%-- Search Criteria Field Set --%>
                        <%-----------------------------------------------------------------------------------------------------%>
                        <fieldset class="subMainFieldSet">
                            <legend>Search Criteria</legend>

                            <%-- Search Criteria left div --%>
                            <div class="IASFormLeftDiv">


                                <div class="IASFormFieldDiv">
                                    <span class="IASFormDivSpanLabel">
                                        <label>State:</label>
                                    </span>
                                    <span class="IASFormDivSpanInputBox">
                                        <input class="IASTextBox" TABINDEX="1" type="text" name="state" id="state" value=""/>
                                    </span>
                                </div>

                            </div>

                            <div class="IASFormFieldDiv">
                                <div id="searchBtnDiv">
                                    <input class="IASButton" TABINDEX="2" type="submit" value="Search"/>
                                </div>

                                <div id="resetBtnDiv">
                                    <input class="IASButton" TABINDEX="3" type="reset" value="Reset"/>
                                </div>
                            </div>

                        </fieldset>

                        <%-----------------------------------------------------------------------------------------------------%>
                        <%-- Search Result Field Set --%>
                        <%-----------------------------------------------------------------------------------------------------%>
                        <fieldset class="subMainFieldSet">
                            <legend>Search Result</legend>

                            <table class="datatable" id="stateTable"></table>
                            <div id="pager"></div>
                        </fieldset>
                    </fieldset>
                </div>
            </form>
        </div>
    </body>
</html>