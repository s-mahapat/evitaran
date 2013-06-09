<%--
    Document   : Search Subscriber
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Search Subscriber</title>
        <%@include file="../templates/style.jsp" %>
        <link rel="stylesheet" type="text/css" href="<%=request.getContextPath() + "/css/subscriber.css"%>"/>
        <script type="text/javascript" src="<%=request.getContextPath() + "/js/city.js"%>"></script>
        <script type="text/javascript" src="<%=request.getContextPath() + "/js/subscriber/searchsubscriber.js"%>"></script>
        <script type="text/javascript">
            //initally set to false, after the first search the flag is set to true

            var isPageLoaded = false;
            //var isCitySelected = false;

            $(document).ready(function (){

                //load city autocomplete
                loadCities();

                // search subscriber when ENTER key is pressed
                setEnterKeyAction(searchSubscriber);

                //});
                $("#subscriberNumber").focus()

                $("#subscriberTable").jqGrid({
                    url:"subscriber?action=search",
                    datatype: 'xml',
                    mtype: 'GET',
                    width: '100%',
                    height: Constants.jqgrid.HEIGHT,
                    autowidth: true,
                    shrinkToFit: true,
                    forceFit: true,
                    sortable: true,
                    sortname: 'subscriberNumber',
                    loadonce: false,
                    rownumbers: true,
                    scrollOffset: 20,
                    emptyrecords: "No subscribers to view",
                    loadtext: "Loading...",
                    colNames:['Subscriber ID','Subscriber Number','Subscriber Name', 'Department','City','Pin Code','Country', 'Action'],
                    colModel :[
                        {name:'Subscriber ID', index:'subscriberID', width:20, align:'center', xmlmap:'subscriberID'},
                        {name:'Subscriber Number', index:'subscriberNumber', width:30, align:'center', xmlmap:'subscriberNumber', search:true, stype:'text'},
                        {name:'Subscriber Name', index:'subscriberName', width:60, align:'center', xmlmap:'subscriberName'},
                        {name:'Department', index:'department', width:50, align:'center', xmlmap:'department'},
                        {name:'City', index:'city', width:20, align:'center', sortable: true, sorttype: 'int',xmlmap:'city'},
                        {name:'Pin Code', index:'pincode', width:15, align:'center', xmlmap:'pincode'},
                        {name:'Country', index:'country', width:20, align:'center', xmlmap:'country'},
                        {name:'Action', index:'action', width:40, align:'center',formatter:'showlink'}
                    ],
                    xmlReader : {
                        root: "results",
                        row: "row",
                        page: "results>page",
                        total: "results>total",
                        records : "results>records",
                        repeatitems: false,
                        id: "subscriberNumber"
                    },
                    pager: '#pager',
                    pginput: true,
                    rowNum: 20,
                    rowList:[20,50,100, -1],
                    viewrecords: true,
                    gridview: true,
                    caption: '&nbsp;',
                    loadComplete: function(xml){
                        $("option[value=-1]").text('All');
                        //sessionStorage.searchinwards = xml.toString();
                        //console.log(sessionStorage.searchinwards.toString());
                    },
                    gridComplete: function() {
                        var ids = jQuery("#subscriberTable").jqGrid('getDataIDs');
                        for (var i = 0; i < ids.length; i++) {
                            var subscriberId = ids[i];
                            action = "<a style='color:blue;' href='subscriber?action=display&subscriberNumber=" + subscriberId + "'>View</a>" +
                                "<a style='color:blue;' href='subscriber?action=edit&subscriberNumber=" + subscriberId + "'>Edit</a>" +
                                "<a style='color:blue;' href='subscriber?action=display&subscriberNumber=" + subscriberId + "&detail=2" + "'>Subscription</a>";
                            jQuery("#subscriberTable").jqGrid('setRowData', ids[i], { Action: action });
                        }
                        sessionStorage['searchsubscriber'] = JSON.stringify({
                            page: jQuery("#subscriberTable").jqGrid('getGridParam','page'),
                            rowNum: jQuery("#subscriberTable").jqGrid('getGridParam','rowNum'),
                            totalpages: jQuery("#subscriberTable").jqGrid('getGridParam','lastpage'),
                            city: $("#city").val(),
                            subscriberNumber    : $("#subscriberNumber").val(),
                            subscriberName      : $("#subscriberName").val(),
                            email               : $("#email").val(),
                            pincode             : $("#pincode").val(),
                            institute           : $("#institute").val(),
                            department          : $("#department").val()
                        });

                    },
                    beforeRequest: function(){
                        return isPageLoaded;
                    },
                    loadError: function(xhr,status,error){
                        alert("Failed getting data from server " + status);
                    },
                    onPaging: function(btn){
                        //updateCookie();
                    },
                    onSelectRow: function(rowid, status, e){
                        window.location.href = "subscriber?action=display&subscriberNumber=" + rowid;
                    }
                });
                if(sessionStorage.searchsubscriber != "false"){
                    var json = JSON.parse(sessionStorage.searchsubscriber);
                    $("#city").val(json.city);
                    $("#subscriberNumber").val(json.subscriberNumber);
                    $("#subscriberName").val(json.subscriberName);
                    $("#email").val(json.email);
                    $("#pincode").val(json.pincode);
                    $("#institute").val(json.institute);
                    $("#department").val(json.department);
                    isPageLoaded = true;
                    jQuery("#subscriberTable").setGridParam({
                        'rowNum': json.rowNum,
                        'page': json.page

                    });
                    searchSubscriber();
                }

            });



            // called when the search button is clicked
            function searchSubscriber(){
                if(validateSearchSubscriber()){

                    isPageLoaded = true;
                    jQuery("#subscriberTable").setGridParam({mtype: 'POST',postData:
                            {city               : $("#city").val(),
                            subscriberNumber    : $("#subscriberNumber").val(),
                            subscriberName      : $("#subscriberName").val(),
                            email               : $("#email").val(),
                            pincode             : $("#pincode").val(),
                            institution         : $("#institute").val(),
                            department          : $("#department").val(),
                            exact               : 'true'
                        }});
                    jQuery("#subscriberTable").trigger("clearGridData");
                    jQuery("#subscriberTable").trigger("reloadGrid");
                    //$('#searchSubscriberForm')[0].reset();
                }

            }

            function updateCookie(){
                var rowNum = jQuery("#subscriberTable").jqGrid('getGridParam','rowNum');
                var page = jQuery("#subscriberTable").jqGrid('getGridParam','page');

                var json = {"rowNum": rowNum,
                    "page": page,
                    "totalpages": jQuery("#subscriberTable").jqGrid('getGridParam','lastpage'),
                    "sidx": "subscriberNumber",
                    "subscriberNumber":$("#subscriberNumber").val(),
                    "sord": "asc",
                    "city": $("#city").val(),
                    "subscriberName": $("#subscriberName").val(),
                    "email": $("#email").val(),
                    "pincode": $("#pincode").val(),
                    "institute": $("#institute").val(),
                    "department": $("#department").val()

                };
                //set the cookie
                $.cookie("search_subscriber", JSON.stringify(json));
            }

            function resetForm(){
                sessionStorage.searchsubscriber = false;
                $('#searchSubscriberForm')[0].reset();
            }
        </script>
    </head>
    <body>
        <%@include file="../templates/layout.jsp" %>

        <div id="bodyContainer">
            <form method="post" action="" name="searchSubscriberForm" id="searchSubscriberForm">
                <div class="MainDiv">
                    <fieldset class="MainFieldset">
                        <legend>Search Subscriber</legend>

                        <%-----------------------------------------------------------------------------------------------------%>
                        <%-- Search Criteria Field Set --%>
                        <%-----------------------------------------------------------------------------------------------------%>
                        <fieldset class="subMainFieldSet">
                            <%--<legend>Search Criteria</legend>--%>

                            <%-- Search Criteria left div --%>
                            <div class="IASFormLeftDiv">


                                <div class="IASFormFieldDiv">
                                    <span class="IASFormDivSpanLabel">
                                        <label>Subscriber No:</label>
                                    </span>
                                    <span class="IASFormDivSpanInputBox">
                                        <input class="IASTextBox allusers" TABINDEX="1" type="text" name="subscriberNumber" id="subscriberNumber" value=""/>
                                    </span>
                                </div>

                                <div class="IASFormFieldDiv">
                                    <span class="IASFormDivSpanLabel">
                                        <label>Subscriber Name:</label>
                                    </span>
                                    <span class="IASFormDivSpanInputBox">
                                        <input class="IASTextBoxWide allusers" TABINDEX="2" type="text" name="subscriberName" id="subscriberName" value=""/>
                                    </span>
                                </div>

                                <div class="IASFormFieldDiv">
                                    <span class="IASFormDivSpanLabel">
                                        <label>Department:</label>
                                    </span>
                                    <span class="IASFormDivSpanInputBox">
                                        <input class="IASTextBoxWide allusers" TABINDEX="3" type="text" name="department" id="department" value=""/>
                                    </span>
                                </div>

                                <div class="IASFormFieldDiv">
                                    <span class="IASFormDivSpanLabel">
                                        <label>Institute:</label>
                                    </span>
                                    <span class="IASFormDivSpanInputBox">
                                        <input class="IASTextBoxWide allusers" TABINDEX="4" type="text" name="institute" id="institute" value=""/>
                                    </span>
                                </div>


                            </div>


                            <%-- Search Criteria right div --%>
                            <div class="IASFormRightDiv">

                                <div class="IASFormFieldDiv">
                                    <span class="IASFormDivSpanLabel">
                                        <label>Email:</label>
                                    </span>
                                    <span class="IASFormDivSpanInputBox">
                                        <input class="IASTextBoxWide allusers" TABINDEX="5" type="text" name="email" id="email" value=""/>
                                    </span>
                                </div>

                                <div class="IASFormFieldDiv">
                                    <span class="IASFormDivSpanLabel">
                                        <label>City:</label>
                                    </span>
                                    <span class="IASFormDivSpanInputBox">
                                        <input class="IASTextBox allusers" TABINDEX="6" name="city" id="city" value=""/>
                                    </span>
                                </div>

                                <div class="IASFormFieldDiv">
                                    <span class="IASFormDivSpanLabel">
                                        <label>Pin Code:</label>
                                    </span>
                                    <span class="IASFormDivSpanInputBox">
                                        <input class="IASTextBox allusers" maxlength="6" TABINDEX="7" type="text" name="pincode" id="pincode" value=""/>
                                    </span>
                                </div>
                            </div>

                            <div class="actionBtnDiv">
                                <button class="IASButton SearchButton allusers" TABINDEX=8" type="button" value="Search" onclick="searchSubscriber()">Search</button>
                                <button class="IASButton allusers" TABINDEX="9" type="button" value="Reset" onclick="resetForm()">Reset</button>
                            </div>

                        </fieldset>

                        <fieldset class="subMainFieldSet">
                            <%--<legend>Subscriber List</legend>--%>
                            <table class="datatable" id="subscriberTable" TABINDEX="8"></table>
                            <div id="pager"></div>
                        </fieldset>
                    </fieldset>
                </div>
            </form>
        </div>
    </body>
</html>