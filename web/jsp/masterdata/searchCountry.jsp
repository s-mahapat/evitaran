<%--
    Document   : Search Country
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="../templates/style.jsp" %>
        <link rel="stylesheet" type="text/css" href="css/masterdata/country.css" />

        <title>Search Country</title>
        <script type="text/javascript" src="<%=request.getContextPath() + "/js/masterdata/searchCountry.js"%>"></script>
        <script type="text/javascript" src="<%=request.getContextPath() + "/js/masterdata/validateCountry.js"%>"></script>
        <script type="text/javascript">
           // var selectedCountry = 0;
            var selectedId = 0;
            //initally set to false, after the first search the flag is set to true
            var isPageLoaded = false;

            $(function(){

                $("#countryTable").jqGrid({
                    url:"<%=request.getContextPath() + "/country?action=search"%>",
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
                    colNames:['Country Id','Country','View/ Edit'],
                    colModel :[
                        {name:'id', index:'id', width:50, align:'center', xmlmap:'id'},
                        {name:'country', index:'country', width:80, align:'center', xmlmap:'country'},
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
                        var ids = jQuery("#countryTable").jqGrid('getDataIDs');

                        for (var i = 0; i < ids.length; i++) {
                            action = "<a style='color:blue;' href='country?action=view&id=" + ids[i] + "'>View</a><a style='color:blue;' href='country?action=edit&id=" + ids[i] + "'>/ Edit</a>";
                            jQuery("#countryTable").jqGrid('setRowData', ids[i], { Action: action });
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
            function searchCountry(){
                if(validateCountry() == true)
                    {
                        isPageLoaded = true;

                        jQuery("#countryTable").setGridParam({postData:
                                {//countryId       : $("#countryId").val(),
                                country          : $("#country").val()
                            }});
                        jQuery("#countryTable").setGridParam({ datatype: "xml" });
                        jQuery("#countryTable").trigger("clearGridData");
                        jQuery("#countryTable").trigger("reloadGrid");
                    }
                }

            // draw the date picker.
            //jQueryDatePicker("from","to");

        </script>

    </head>
    <body>
        <%@include file="../templates/layout.jsp" %>

        <div id="bodyContainer">
            <form method="post" action="<%=request.getContextPath() + "/country"%>" name="searchCountryForm">
                <div class="MainDiv">
                    <fieldset class="MainFieldset">
                        <legend>Search Country</legend>

                        <%-----------------------------------------------------------------------------------------------------%>
                        <%-- Search Criteria Field Set --%>
                        <%-----------------------------------------------------------------------------------------------------%>
                        <fieldset class="subMainFieldSet">
                            <legend>Search Criteria</legend>

                            <%-- Search Criteria left div --%>
                            <div class="IASFormLeftDiv">


                                <div class="IASFormFieldDiv">
                                    <span class="IASFormDivSpanLabel">
                                        <label>Country:</label>
                                    </span>
                                    <span class="IASFormDivSpanInputBox">
                                        <input class="IASTextBox allusers" TABINDEX="1" type="text" name="country" id="country" value=""/>
                                    </span>
                                </div>

                            </div>

                            <div class="IASFormFieldDiv">
                                <div id="searchBtnDiv">
                                    <input class="IASButton allusers" TABINDEX="2" type="button" value="search" onclick="searchCountry()"/>
                                </div>

                                <div id="resetBtnDiv">
                                    <input class="IASButton allusers" TABINDEX="3" type="reset" value="Reset"/>
                                </div>
                            </div>

                        </fieldset>

                        <%-----------------------------------------------------------------------------------------------------%>
                        <%-- Search Result Field Set --%>
                        <%-----------------------------------------------------------------------------------------------------%>
                        <fieldset class="subMainFieldSet">
                            <legend>Search Result</legend>

                            <table class="datatable" id="countryTable"></table>
                            <div id="pager"></div>
                        </fieldset>
                    </fieldset>
                </div>
            </form>
        </div>
    </body>
</html>