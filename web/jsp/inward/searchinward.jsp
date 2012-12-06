<%--
    Document   : Search Inward
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="../templates/style.jsp" %>
        <link rel="stylesheet" type="text/css" href="css/inward/inward.css" />
        <title>Search Inward</title>
        <script type="text/javascript" src="<%=request.getContextPath() + "/js/inward/searchinward.js"%>"></script>
        <script type="text/javascript" src="<%=request.getContextPath() + "/js/city.js"%>"></script>
        <script type="text/javascript">
            var selectedInward = 0;
            var selectedSubscriberId = 0;
            var isFirstTime = false;
            //initally set to false, after the first search the flag is set to true
            var isPageLoaded = false;

            $(document).ready(function(){

                //load city autocomplete
                loadCities();

                // set the default focus to inward text box.
                $("#inwardNumber").focus();

                // search subscriber when ENTER key is pressed
                setEnterKeyAction(searchInwards);

                $("#inwardTable").jqGrid({
                    url:"<%=request.getContextPath() + "/inward?action=search"%>",
                    datatype: 'xml',
                    mtype: 'GET',
                    width: '100%',
                    height: 240,
                    autowidth: true,
                    forceFit: true,
                    sortable: true,
                    sortname: 'inwardCreationDate',
                    sortorder: 'desc',
                    loadonce: false,
                    rownumbers: true,
                    scrollOffset: 20,
                    emptyrecords: "No inwards to view",
                    loadtext: "Loading...",
                    colNames:['Inward No','Subscriber Id', 'From','Received Date','City','Cheque#','Amount','Purpose','View/Edit'],
                    colModel :[
                        {name:'InwardNo', index:'inwardNumber', width:40, align:'center', xmlmap:'inwardNumber'},
                        {name:'SubscriberId', index:'subscriberId', width:40, align:'center', xmlmap:'subscriberId'},
                        {name:'From', index:'from', sortable: false, width:90, align:'center', xmlmap:'from'},
                        {name:'ReceivedDate', index:'inwardCreationDate', width:40, align:'center', xmlmap:'inwardCreationDate'},
                        {name:'City', index:'city', width:80, align:'center', xmlmap:'city'},
                        {name:'Cheque', index:'chqddNumber', width:40, align:'center', xmlmap:'chqddNumber'},
                        {name:'amount', index:'amount', width:25, align:'center', xmlmap:'amount'},
                        {name:'Purpose', index:'inwardPurpose', width:60, align:'center', xmlmap:'inwardPurpose'},
                        {name:'Action', index:'action', sortable: false, width:40, align:'center',formatter:'showlink'}
                    ],
                    xmlReader : {
                        root: "results",
                        row: "row",
                        page: "results>page",
                        total: "results>total",
                        records : "results>records",
                        repeatitems: false,
                        id: "inwardNumber"
                    },
                    pager: '#pager',
                    rowNum:10,
                    rowList:[10,20,30],
                    viewrecords: true,
                    gridview: true,
                    caption: '&nbsp;',
                    loadComplete: function(xml){
                        //sessionStorage.searchinwards = xml.toString();
                        //console.log(sessionStorage.searchinwards.toString());
                    },
                    gridComplete: function() {
                        var ids = jQuery("#inwardTable").jqGrid('getDataIDs');
                        if(ids.length > 0){
                            $("#btnNext").removeAttr("disabled");
                        }
                        for (var i = 0; i < ids.length; i++) {
                            var inwardId = ids[i];
                            action = "<a style='color:blue;' href='inward?action=view&inwardNumber=" + inwardId + "'>View</a><a style='color:blue;' href='inward?action=edit&inwardNumber=" + inwardId + "'>Edit</a>";
                            jQuery("#inwardTable").jqGrid('setRowData', ids[i], { Action: action });
                        }
                        sessionStorage['searchinwards'] = JSON.stringify({
                            page: jQuery("#inwardTable").jqGrid('getGridParam','page'),
                            rowNum: jQuery("#inwardTable").jqGrid('getGridParam','rowNum'),
                            totalpages: jQuery("#inwardTable").jqGrid('getGridParam','lastpage'),
                            city: $("#city").val(),
                            inwardNumber    : $("#inwardNumber").val(),
                            chequeNumber    : $("#chequeNumber").val(),
                            fromDate        : $("#from").val(),
                            toDate          : $("#to").val()
                        });
                        //console.log(sessionStorage.searchinwards);
                    },
                    beforeRequest: function(){
                        return isPageLoaded;
                    },
                    loadError: function(xhr,status,error){
                        alert("Failed getting data from server " + status);
                    }

                });

                if(sessionStorage.searchinwards){
                    var json = JSON.parse(sessionStorage.searchinwards);
                    jdsAppend("<%=request.getContextPath() + "/CMasterData?md=city"%>",
                    "city",
                    "city",
                    json.city,
                    function(){
                        $("#inwardNumber").val(json.inwardNumber);
                        $("#chequeNumber").val(json.chequeNumber);
                        $("#from").val(json.from);
                        $("#to").val(json.to);
                        jQuery("#inwardTable").setGridParam({
                            'rowNum': json.rowNum,
                            'page': json.page

                        });
                        searchInwards();
                    }

                );
                    isFirstTime = true;
                    isPageLoaded = true;



                }else{
                    jdsAppend("<%=request.getContextPath() + "/CMasterData?md=city"%>","city","city");
                }


            });


            // called when the search button is clicked
            function searchInwards(){
                jQuery("#inwardTable").setGridParam({ datatype: "xml" });
                if(validateSearch() == true){
                    isPageLoaded = true;
                    jQuery("#inwardTable").setGridParam({postData:
                            {city           : $("#city").val(),
                            inwardNumber    : $("#inwardNumber").val(),
                            chequeNumber    : $("#chequeNumber").val(),
                            fromDate        : $("#from").val(),
                            toDate          : $("#to").val()
                        }});
                    jQuery("#inwardTable").trigger("clearGridData");
                    jQuery("#inwardTable").trigger("reloadGrid");

                }

            }

            // draw the date picker.
            jQueryDatePicker("from","to");

        </script>

    </head>
    <body>
        <%@include file="../templates/layout.jsp" %>

        <div id="bodyContainer">
            <form method="post" action="" name="searchInwardForm">
                <div class="MainDiv">
                    <fieldset class="MainFieldset">
                        <legend>Search Inward</legend>

                        <%-----------------------------------------------------------------------------------------------------%>
                        <%-- Search Criteria Field Set --%>
                        <%-----------------------------------------------------------------------------------------------------%>
                        <fieldset class="subMainFieldSet">
                            <legend>Search Criteria</legend>

                            <%-- Search Criteria left div --%>
                            <div class="IASFormLeftDiv">


                                <div class="IASFormFieldDiv">
                                    <span class="IASFormDivSpanLabel">
                                        <label>Inward Number:</label>
                                    </span>
                                    <span class="IASFormDivSpanInputBox">
                                        <input class="IASTextBox" TABINDEX="1" type="text" name="inwardNumber" id="inwardNumber" value=""/>
                                    </span>
                                </div>


                                <div class="IASFormFieldDiv">
                                    <span class="IASFormDivSpanLabel">
                                        <label>Cheque Number:</label>
                                    </span>
                                    <span class="IASFormDivSpanInputBox">
                                        <input class="IASTextBox" TABINDEX="2" type="text" name="chequeNumber" id="chequeNumber" value=""/>
                                    </span>
                                </div>
                            </div>


                            <%-- Search Criteria right div --%>
                            <div class="IASFormRightDiv">


                                <!--<div class="IASFormFieldDiv">
                                    <span class="IASFormDivSpanLabel">
                                        <label>City:</label>
                                    </span>
                                    <span class="IASFormDivSpanInputBox">
                                        <select class="IASComboBox" TABINDEX="3" name="city" id="city">
                                            <option value="NULL">Select</option>
                                        </select>
                                    </span>
                                </div>-->
                                <div class="IASFormFieldDiv">
                                    <span class="IASFormDivSpanLabel">
                                        <label>City:</label>
                                    </span>
                                    <span class="IASFormDivSpanInputBox">
                                        <input class="IASTextBox" TABINDEX="4" name="city" id="city" value=""/>
                                    </span>
                                </div>


                                <div class="IASFormFieldDiv">
                                    <span class="IASFormDivSpanLabel">
                                        <label>Date Range:</label>
                                    </span>
                                    <div class="dateDiv"></div>
                                    <span class="IASFormDivSpanInputBox">
                                        <input class="IASDateTextBox" TABINDEX="4" readonly size="10" type="text" id="from" name="from"/>
                                    </span>
                                    <span class="IASFormDivSpanForHyphen">
                                        <label> to </label>
                                    </span>
                                    <span class="IASFormDivSpanInputBox">
                                        <input class="IASDateTextBox" TABINDEX="5" readonly size="10" type="text" id="to" name="to"/>
                                    </span>
                                </div>
                            </div>
                            <div class="actionBtnDiv">
                                <input class="IASButton" TABINDEX="6" type="button" value="Search" onclick="searchInwards()"/>
                                <input class="IASButton" TABINDEX="7" type="reset" value="Reset"/>
                            </div>

                        </fieldset>



                        <%-----------------------------------------------------------------------------------------------------%>
                        <%-- Search Result Field Set --%>
                        <%-----------------------------------------------------------------------------------------------------%>
                        <fieldset class="subMainFieldSet">
                            <legend>Search Result</legend>

                            <table class="datatable" id="inwardTable"></table>
                            <div id="pager"></div>
                        </fieldset>
                    </fieldset>
                </div>
            </form>
        </div>
    </body>
</html>