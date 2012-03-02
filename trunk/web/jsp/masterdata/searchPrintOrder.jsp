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

        <title>Search City</title>
        <script type="text/javascript" src="<%=request.getContextPath() + "/js/masterdata/searchPrintOrder.js"%>"></script>
        <script type="text/javascript" src="<%=request.getContextPath() + "/js/masterdata/validatePrintOrder.js"%>"></script>
        <script type="text/javascript">
           // var selectedCity = 0;
            var selectedId = 0;
            //initally set to false, after the first search the flag is set to true
            var isPageLoaded = false;

            $(function(){

                $("#cityTable").jqGrid({
                    url:"<%=request.getContextPath() + "/city?action=search"%>",
                    datatype: 'xml',
                    mtype: 'GET',
                    width: '100%',
                    height: 240,
                    autowidth: true,
                    forceFit: true,
                    sortable: true,
                    loadonce: false,
                    rownumbers: true,
                    emptyrecords: "No City",
                    loadtext: "Loading...",
                    colNames:['City Id','City','View/Edit'],
                    colModel :[
                        {name:'id', index:'id', width:50, align:'center', xmlmap:'id'},
                        {name:'city', index:'city', width:80, align:'center', xmlmap:'city'},
                        {name:'Action', index:'action', width:80, align:'center',formatter:'showlink'}
                    ],
                    xmlReader : {
                        root: "results",
                        row: "row",
                        page: "city>page",
                        total: "city>total",
                        records : "city>records",
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
                        var ids = jQuery("#cityTable").jqGrid('getDataIDs');

                        for (var i = 0; i < ids.length; i++) {
                            action = "<a style='color:blue;' href='city?action=edit&id=" + ids[i] + "'>Edit</a>";
                            jQuery("#cityTable").jqGrid('setRowData', ids[i], { Action: action });
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
            function searchCity(){
                if(validateCity() == true)
                    {
                        isPageLoaded = true;

                        jQuery("#cityTable").setGridParam({postData:
                                {//cityId       : $("#cityId").val(),
                                city          : $("#city").val()
                            }});
                        jQuery("#cityTable").setGridParam({ datatype: "xml" });
                        jQuery("#cityTable").trigger("clearGridData");
                        jQuery("#cityTable").trigger("reloadGrid");
                    }

                }

            // draw the date picker.
            //jQueryDatePicker("from","to");

        </script>

    </head>
    <body>
        <%@include file="../templates/layout.jsp" %>

        <div id="bodyContainer">
            <form method="post" action="<%=request.getContextPath() + "/city"%>" name="searchCityForm">
                <div class="MainDiv">
                        <%-----------------------------------------------------------------------------------------------------%>
                        <%-- Search Result Field Set --%>
                        <%-----------------------------------------------------------------------------------------------------%>
                        <fieldset class="subMainFieldSet">
                            <legend>Search Result</legend>

                            <table class="datatable" id="cityTable"></table>
                            <div id="pager"></div>
                        </fieldset>
                  </div>
            </form>
        </div>
    </body>
</html>