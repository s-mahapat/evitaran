<%--
    Document   : Search Subscriber
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="../templates/style.jsp" %>
        <link rel="stylesheet" type="text/css" href="<%=request.getContextPath() + "/css/subscriber.css"%>"/>
        <script type="text/javascript" src="<%=request.getContextPath() + "/js/subscriber/searchsubscriber.js"%>"></script>
        <title>Search Subscriber</title>
        <script type="text/javascript">
            //initally set to false, after the first search the flag is set to true

            var isPageLoaded = false;
            $(document).ready(function (){

                jdsAppend("CMasterData?md=city","city","city");
                $("#subscriberNumber").focus()

                $("#subscriberTable").jqGrid({
                    url:"subscriber?action=search",
                    datatype: 'xml',
                    mtype: 'GET',
                    width: '100%',
                    height: 230,
                    autowidth: true,
                    forceFit: true,
                    sortable: true,
                    sortname: 'subscriberNumber',
                    loadonce: false,
                    rownumbers: true,
                    scrollOffset: 20,
                    emptyrecords: "No subscribers to view",
                    loadtext: "Loading...",
                    colNames:['Subscriber Number','Subscriber Name', 'Department','City','Pin Code','Country', 'Action'],
                    colModel :[
                        {name:'Subscriber Number', index:'subscriberNumber', width:30, align:'center', xmlmap:'subscriberNumber'},
                        {name:'Subscriber Name', index:'subscriberName', width:60, align:'center', xmlmap:'subscriberName'},
                        {name:'Department', index:'department', width:40, align:'center', xmlmap:'department'},
                        {name:'City', index:'city', width:30, align:'center', sortable: true, sorttype: 'int',xmlmap:'city'},
                        {name:'Pin Code', index:'pincode', width:20, align:'center', xmlmap:'pincode'},
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
                    rowNum:10,
                    rowList:[10,30,50,100],
                    viewrecords: true,
                    gridview: true,
                    caption: '&nbsp;',

                    gridComplete: function() {
                        var ids = jQuery("#subscriberTable").jqGrid('getDataIDs');
                        for (var i = 0; i < ids.length; i++) {
                            var subscriberId = ids[i];
                            action = "<a style='color:blue;' href='subscriber?action=display&subscriberNumber=" + subscriberId + "'>View</a>" +
                                "<a style='color:blue;' href='subscriber?action=edit&subscriberNumber=" + subscriberId + "'>Edit</a>" +
                                "<a style='color:blue;' href='subscriber?action=editsubscription&subscriberNumber=" + subscriberId + "'>Subscription</a>";
                            jQuery("#subscriberTable").jqGrid('setRowData', ids[i], { Action: action });
                        }
                        updateCookie();

                    },
                    beforeRequest: function(){
                        if($.cookie("search_subscriber") != null && isPageLoaded == false){
                            page = GetCookieValue("search_subscriber","page");
                            totalpages = GetCookieValue("search_subscriber","totalpages");
                            rowNum = GetCookieValue("search_subscriber","rowNum");
                            sidx = GetCookieValue("search_subscriber","sidx");
                            subscriberNumber = GetCookieValue("search_subscriber","subscriberNumber");
                            subscriberName = GetCookieValue("search_subscriber","subscriberName");
                            sord = GetCookieValue("search_subscriber","sord");
                            city = GetCookieValue("search_subscriber","city");
                            email = GetCookieValue("search_subscriber","email");
                            pincode = GetCookieValue("search_subscriber","pincode");
                            //alert(totalpages);

                            //jQuery("#subscriberTable").jqGrid('prmNames',{'page':page});

                            jQuery("#subscriberTable").jqGrid('setColProp','index',sidx);
                            jQuery("#subscriberTable").jqGrid('setGridParam','pgtext',parseInt(page), totalpages);

                            //alert(jQuery("#subscriberTable").jqGrid('getGridParam','page'));
                            jQuery("#subscriberTable").jqGrid('setGridParam','rowNum',rowNum);
                            jQuery("#subscriberTable").jqGrid('setGridParam','sortorder',sord);

                            $("#subscriberNumber").val(subscriberNumber);
                            $("#subscriberName").val(subscriberName);
                            $("#city").append("<option value=" + city + " selected>" + city + "</option>");
                            $("#email").val(email);
                            $("#pincode").val(pincode);

                            searchSubscriber();
                            isPageLoaded = true;

                        }
                        return isPageLoaded;
                    },
                    loadError: function(xhr,status,error){
                        alert("Failed getting data from server " + status);
                    },
                    onPaging: function(btn){
                        //updateCookie();
                    }
                });
            });



            // called when the search button is clicked
            function searchSubscriber(){
                jQuery("#subscriberTable").setGridParam({ datatype: "xml" });
                if(validateSearchSubscriber() == true){
                    isPageLoaded = true;
                    jQuery("#subscriberTable").setGridParam({postData:
                            {city               : $("#city").val(),
                            subscriberNumber    : $("#subscriberNumber").val(),
                            subscriberName      : $("#subscriberName").val(),
                            email               : $("#email").val(),
                            pincode             : $("#pincode").val()
                        }});
                    jQuery("#subscriberTable").trigger("clearGridData");
                    jQuery("#subscriberTable").trigger("reloadGrid");
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
                    "pincode": $("#pincode").val()

                };
                //set the cookie
                $.cookie("search_subscriber", JSON.stringify(json));
            }
        </script>
    </head>
    <body>
        <%@include file="../templates/layout.jsp" %>

        <div id="bodyContainer">
            <form method="post" action="" name="searchSubscriberForm">
                <div class="MainDiv">
                    <fieldset class="MainFieldset">
                        <legend>Search Subscriber</legend>

                        <%-----------------------------------------------------------------------------------------------------%>
                        <%-- Search Criteria Field Set --%>
                        <%-----------------------------------------------------------------------------------------------------%>
                        <fieldset class="subMainFieldSet">
                            <legend>Search Criteria</legend>

                            <%-- Search Criteria left div --%>
                            <div class="IASFormLeftDiv">


                                <div class="IASFormFieldDiv">
                                    <span class="IASFormDivSpanLabel">
                                        <label>Subscriber Number:</label>
                                    </span>
                                    <span class="IASFormDivSpanInputBox">
                                        <input class="IASTextBox" TABINDEX="1" type="text" name="subscriberNumber" id="subscriberNumber" value=""/>
                                    </span>
                                </div>

                                <div class="IASFormFieldDiv">
                                    <span class="IASFormDivSpanLabel">
                                        <label>Subscriber Name:</label>
                                    </span>
                                    <span class="IASFormDivSpanInputBox">
                                        <input class="IASTextBox" TABINDEX="3" type="text" name="subscriberName" id="subscriberName" value=""/>
                                    </span>
                                </div>

                                <div class="IASFormFieldDiv">
                                    <span class="IASFormDivSpanLabel">
                                        <label>Email:</label>
                                    </span>
                                    <span class="IASFormDivSpanInputBox">
                                        <input class="IASEmailTextBox" TABINDEX="2" type="text" name="email" id="email" value=""/>
                                    </span>
                                </div>
                            </div>


                            <%-- Search Criteria right div --%>
                            <div class="IASFormRightDiv">

                                <div class="IASFormFieldDiv">
                                    <span class="IASFormDivSpanLabel">
                                        <label>City:</label>
                                    </span>
                                    <span class="IASFormDivSpanInputBox">
                                        <select class="IASComboBox" TABINDEX="4" name="city" id="city">
                                            <option value="NULL">Select</option>
                                        </select>
                                    </span>
                                </div>

                                <div class="IASFormFieldDiv">
                                    <span class="IASFormDivSpanLabel">
                                        <label>Pin Code:</label>
                                    </span>
                                    <span class="IASFormDivSpanInputBox">
                                        <input class="IASTextBox" TABINDEX="3" type="text" name="pincode" id="pincode" value=""/>
                                    </span>
                                </div>

                            </div>

                            <div class="actionBtnDiv">
                                <input class="IASButton" TABINDEX="6" type="button" value="Search" onclick="searchSubscriber()"/>
                                <input class="IASButton" TABINDEX="7" type="reset" value="Reset"/>
                            </div>

                        </fieldset>

                        <fieldset class="subMainFieldSet">
                            <legend>Subscriber List</legend>
                            <table class="datatable" id="subscriberTable"></table>
                            <div id="pager"></div>
                        </fieldset>
                    </fieldset>
                </div>
            </form>
        </div>
    </body>
</html>