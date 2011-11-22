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
        <script>
            $(function(){
                $(".datatable").jqGrid({
                    url:'/JDS/jsp/subscriber/subscriberlistXML.jsp',
                    datatype: 'xml',
                    mtype: 'GET',
                    width: '100%',
                    autowidth: true,
                    forceFit: true,
                    sortable: true,
                    loadonce: true,
                    rownumbers: true,
                    emptyrecords: "No subscribers to view",
                    loadtext: "Loading...",
                    colNames:['Select','Subscriber Id','Subscriber Name', 'Department','City','Pin Code','Country', 'Email', 'Action'],
                    colModel :[
                        {name:'Select', index:'select', width:50, align:'center',xmlmap:'subscriber_id',
                            formatter:function (cellvalue, options, rowObject) {
                                return '<input onclick="javascript:selectedSubscriber=this.value" type="radio" id="selectedSubscriberRadio" name="selectedSubscriberRadio" value="' + cellvalue + '"/>';
                            }
                        },
                        {name:'Subscriber Id', index:'subscriber_id', width:40, align:'center', xmlmap:'subscriber_id'},
                        {name:'Subscriber Name', index:'subscriber_name', width:40, align:'center', xmlmap:'subscriber_name'},
                        {name:'Department', index:'dept', width:40, align:'center', xmlmap:'dept'},
                        {name:'City', index:'city', width:30, align:'center', sortable: true, sorttype: 'int',xmlmap:'city'},
                        {name:'Pin Code', index:'pincode', width:30, align:'center', sortable:false, xmlmap:'pincode'},
                        {name:'Country', index:'country', width:30, align:'center', xmlmap:'country'},
                        {name:'Email', index:'email', width:60, align:'center', xmlmap:'email'},
                        {name:'Action', index:'action', width:50, align:'center', xmlmap:'action'},
                    ],
                    xmlReader : {
                        root: "result",
                        row: "subscriberlist",
                        page: "subscriberlistXML>page",
                        total: "subscriberlist>total",
                        records : "subscriberlist>records",
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
                        var ids = jQuery(".datatable").jqGrid('getDataIDs');
                        for (var i = 0; i < ids.length; i++) {
                            var cl = ids[i];
                        
                            action = "<a style='color:blue;' href=\"" + "<%=request.getContextPath()%>" + "/subscriber?action=display" + "\">View</a>" + 
                                "<a style='color:blue;' href=\"" + "<%=request.getContextPath()%>" + "/subscriber?action=edit" + "\">Edit</a>";
                            jQuery(".datatable").jqGrid('setRowData', ids[i], { Action: action });
                        }}
                });
            });
        </script>    
    </head>
    <body>
        <%@include file="../templates/layout.jsp" %>

        <div id="bodyContainer">
            <form method="post" action="<%=request.getContextPath() + "/subscriber"%>" name="searchInwardForm">
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
                                        <label>Subscriber Id:</label>
                                    </span>
                                    <span class="IASFormDivSpanInputBox">
                                        <input class="IASTextBox" TABINDEX="1" type="text" name="subscriberId" id="subscriberId" value=""/>
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
                                        <input class="IASEmailTextBox" TABINDEX="2" type="text" name="eMail" id="eMail" value=""/>
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
                                        <input class="IASTextBox" TABINDEX="3" type="text" name="city" id="city" value=""/>
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

                            <div class="IASFormFieldDiv">                              
                                <div id="searchBtnDiv">
                                    <input class="IASButton" TABINDEX="6" type="button" value="Search" onclick="validateSearchSubscriber()"/>
                                </div>
                            </div>

                        </fieldset>

                        <fieldset class="subMainFieldSet">
                            <legend>Subscriber List</legend>
                            <table class="datatable" id="subscriberList"></table>
                            <div id="pager"></div>
                        </fieldset>
                    </fieldset>
                </div>
            </form>
        </div>
    </body>
</html>