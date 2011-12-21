<%--
    Document   : Search District
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="../templates/style.jsp" %>
        <link rel="stylesheet" type="text/css" href="css/masterdata/district.css" />

        <title>Search District</title>
        <script type="text/javascript">
            var selectedDistrict = 0;
            var selectedDistrictId = 0;
            //initally set to false, after the first search the flag is set to true
            var isPageLoaded = false;

            $(function(){

                $("#districtTable").jqGrid({
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
                    emptyrecords: "No District",
                    loadtext: "Loading...",
                    colNames:['District Id','District','View/Edit'],
                    colModel :[
                        {name:'DistrictId', index:'districtId', width:50, align:'center', xmlmap:'districtId'},
                        {name:'District', index:'district', width:80, align:'center', xmlmap:'district'},
                        {name:'Action', index:'action', width:80, align:'center',formatter:'showlink'}
                    ],
                    xmlReader : {
                        root: "result",
                        row: "district",
                        page: "district>page",
                        total: "district>total",
                        records : "district>records",
                        repeatitems: false,
                        id: "districtId"
                    },
                    pager: '#pager',
                    rowNum:10,
                    rowList:[10,20,30],
                    viewrecords: true,
                    gridview: true,
                    caption: '&nbsp;',
                    gridComplete: function() {
                        var ids = jQuery("#districtTable").jqGrid('getDataIDs');
                        if(ids.length > 0){
                            $("#btnNext").removeAttr("disabled");
                        }
                        for (var i = 0; i < ids.length; i++) {
                            var cl = ids[i];
                            var rowData = jQuery("#districtTable").jqGrid('getLocalRow',cl);
                            var cityId = rowData['District Id'] || 0;
                            action = "<a style='color:blue;' href='district?action=view'>View</a><a style='color:blue;' href='district?action=edit&district=" + districtId + "'>Edit</a>";
                            jQuery("#districtTable").jqGrid('setRowData', ids[i], { Action: action });
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
            function searchDistrict(){
                isPageLoaded = true;
                jQuery("#districtTable").trigger("reloadGrid");
            }

            // draw the date picker.
            jQueryDatePicker("from","to");

        </script>
    </head>
    <body>
        <%@include file="../templates/layout.jsp" %>

        <div id="bodyContainer">
            <form method="post" action="" name="searchdistrictForm">
                <div class="MainDiv">
                    <fieldset class="MainFieldset">
                        <legend>Search District</legend>

                        <%-----------------------------------------------------------------------------------------------------%>
                        <%-- Search Criteria Field Set --%>
                        <%-----------------------------------------------------------------------------------------------------%>
                        <fieldset class="subMainFieldSet">
                            <legend>Search Criteria</legend>

                            <%-- Search Criteria left div --%>
                            <div class="IASFormLeftDiv">


                                <div class="IASFormFieldDiv">
                                    <span class="IASFormDivSpanLabel">
                                        <label>District:</label>
                                    </span>
                                    <span class="IASFormDivSpanInputBox">
                                        <input class="IASTextBox" TABINDEX="1" type="text" name="district" id="district" value=""/>
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

                            <table class="datatable" id="districtTable"></table>
                            <div id="pager"></div>
                        </fieldset>
                    </fieldset>
                </div>
            </form>
        </div>
    </body>
</html>