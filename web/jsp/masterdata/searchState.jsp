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
        <script type="text/javascript" src="<%=request.getContextPath() + "/js/masterdata/searchState.js"%>"></script>
        <script type="text/javascript" src="<%=request.getContextPath() + "/js/masterdata/validateState.js"%>"></script>
        <script type="text/javascript">
           // var selectedState = 0;
            var selectedId = 0;
            //initally set to false, after the first search the flag is set to true
            var isPageLoaded = false;

            $(function(){

                $("#stateTable").jqGrid({
                    url:"<%=request.getContextPath() + "/state?action=search"%>",
                    datatype: 'xml',
                    mtype: 'GET',
                    width: '100%',
                    height: 240,
                    autowidth: true,
                    forceFit: true,
                    sortable: true,
                    loadonce: true,
                    rownumbers: true,
                    emptyrecords: "No State",
                    loadtext: "Loading...",
                    colNames:['State Id','State','View/Edit'],
                    colModel :[
                        {name:'id', index:'id', width:50, align:'center', xmlmap:'id'},
                        {name:'state', index:'state', width:80, align:'center', xmlmap:'state'},
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
                        var ids = jQuery("#stateTable").jqGrid('getDataIDs');

                        for (var i = 0; i < ids.length; i++) {
                            action = "<a style='color:blue;' href='state?action=view&id=" + ids[i] + "'>View</a><a style='color:blue;' href='state?action=edit&id=" + ids[i] + "'>/ Edit</a>";
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



            // called when the search button is clicked
// called when the search button is clicked
            function searchState(){
                if(validateState() == true)
                    {
                        isPageLoaded = true;

                        jQuery("#stateTable").setGridParam({postData:
                                {//stateId       : $("#stateId").val(),
                                state          : $("#state").val()
                            }});
                        jQuery("#stateTable").setGridParam({ datatype: "xml" });
                        jQuery("#stateTable").trigger("clearGridData");
                        jQuery("#stateTable").trigger("reloadGrid");
                    }

                }

            // draw the date picker.
            //jQueryDatePicker("from","to");

        </script>

    </head>
    <body>
        <%@include file="../templates/layout.jsp" %>

        <div id="bodyContainer">
            <form method="post" action="<%=request.getContextPath() + "/state"%>" name="searchStateForm">
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
                                    <input class="IASButton" TABINDEX="2" type="button" value="search" onclick="searchState()"/>
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