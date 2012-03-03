<%--
    Document   : Search Print Order
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="../templates/style.jsp" %>
        <link rel="stylesheet" type="text/css" href="css/masterdata/printOrder.css" />

        <title>Print Order</title>
        <script type="text/javascript" src="<%=request.getContextPath() + "/js/masterdata/searchPrintOrder.js"%>"></script>
        <script type="text/javascript" src="<%=request.getContextPath() + "/js/masterdata/validatePrintOrder.js"%>"></script>
        <script type="text/javascript">

            var selectedId = 0;
            //initally set to false, after the first search the flag is set to true
            var isPageLoaded = false;

            $(function(){

                $("#yearTable").jqGrid({
                    url:"<%=request.getContextPath() + "/printOrder?action=searchYear"%>",
                    datatype: 'xml',
                    mtype: 'GET',
                    width: '100%',
                    height: 240,
                    autowidth: true,
                    forceFit: true,
                    sortable: true,
                    loadonce: false,
                    rownumbers: true,
                    emptyrecords: "No Data",
                    loadtext: "Loading...",
                    colNames:['Year','View/Edit/Add'],
                    colModel :[
                        {name:'year', index:'year', width:80, align:'center', xmlmap:'year'},
                        {name:'Action', index:'action', width:80, align:'center',formatter:'showlink'}
                    ],
                    xmlReader : {
                        root: "results",
                        row: "row",
                        page: "year>page",
                        total: "year>total",
                        records : "year>records",
                        repeatitems: false,
                        id: "year"
                    },
                    pager: '#pager',
                    rowNum:10,
                    rowList:[10,20,30],
                    viewrecords: true,
                    gridview: true,
                    caption: '&nbsp;',
                    gridComplete: function() {
                        var ids = jQuery("yearTable").jqGrid('getDataIDs');

                        for (var i = 0; i < ids.length; i++) {
                            action = "<a style='color:blue;' href='printOrder?action=view&id=" + ids[i] + "'>View</a> <a style='color:blue;' href='printOrder?action=edit&id=" + ids[i] + "'>Edit</a> <a style='color:blue;' href='printOrder?action=add&id=" + ids[i] + "'>Add</a>";
                            jQuery("#yearTable").jqGrid('setRowData', ids[i], { Action: action });
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
            function searchYear(){
                if(validateYear() == true)
                    {
                        isPageLoaded = true;

                        jQuery("#yearTable").setGridParam({postData:
                                {year         : $("#year").val()
                            }});
                        jQuery("#yearTable").setGridParam({ datatype: "xml" });
                        jQuery("#yearTable").trigger("clearGridData");
                        jQuery("#yearTable").trigger("reloadGrid");
                    }

                }

            // draw the date picker.
            //jQueryDatePicker("from","to");

        </script>

    </head>
    <body>
        <%@include file="../templates/layout.jsp" %>

        <div id="bodyContainer">
            <form method="post" action="<%=request.getContextPath() + "/printOder"%>" name="yearlyPrintOderForm">
                <div class="MainDiv">
                    <fieldset class="MainFieldset">
                        <legend>Print Order For Years</legend>
                            <fieldset class="subMainFieldSet">
                            <div class="IASFormFieldDiv">
                                    <div id="searchBtnDiv">
                                        <input class="IASButton" TABINDEX="1" type="button" value="search" onclick="searchYear()"/>
                                    </div>

                                    <div id="resetBtnDiv">
                                        <input class="IASButton" TABINDEX="2" type="reset" value="Reset"/>
                                    </div>
                             </div>
                             </fieldset>
                        <%-----------------------------------------------------------------------------------------------------%>
                        <%-- Search Result Field Set --%>
                        <%-----------------------------------------------------------------------------------------------------%>
                        <fieldset class="subMainFieldSet">
                            <legend>Year List</legend>

                            <table class="datatable" id="yearTable"></table>
                            <div id="pager"></div>
                        </fieldset>
                      </fieldset>
                  </div>
            </form>
        </div>
    </body>
</html>