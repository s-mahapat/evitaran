<%--
    Document   : Generate Mailing List
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String listType = request.getParameter("list");
    String list = null;
    if (listType.equalsIgnoreCase("ml")) {
        list = "Mailing";
    } else if (listType.equalsIgnoreCase("bil")) {
        list = "Back Issue";
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="../templates/style.jsp"%>
        <title>Generate <%=list%> List</title>
        <script type="text/javascript" src="js/ml/ml.js"></script>
        <script type="text/javascript" src="js/jquery/jquery.print-preview.js"></script>
        <link rel="stylesheet"  media="screen" type="text/css" href="<%=request.getContextPath() + "/css/jquery/print-preview.css"%>"/>
        <link rel="stylesheet"  media="print" type="text/css" href="<%=request.getContextPath() + "/css/ml/printml.css"%>"/>
        <link rel="stylesheet"  media="screen" type="text/css" href="<%=request.getContextPath() + "/css/ml/viewml.css"%>"/>
        <script>
            //disabled the print on load
            $(document).ready(function(){
                $("#btnPrintml").attr("disabled",true);
                $("#btnPrintPreview").attr("disabled",true);
            })
            var isPageLoaded = false;

            $(function(){

                $("#datatable").jqGrid({
                    url:'jsp/ml/ml.xml',
                    datatype: 'xml',
                    mtype: 'GET',
                    width: '100%',
                    height: 240,
                    autowidth: true,
                    forceFit: true,
                    sortable: true,
                    loadonce: true,
                    rownumbers: true,
                    emptyrecords: "No records to view",
                    loadtext: "Loading...",
                    colNames:['Subscriber Id','Subscriber Name','Journal Name', 'Journal Code','Subscription Period','#Copies','Address'],
                    colModel :[
                        {name:'SubscriberID', index:'SubscriberID', width:40, align:'center',xmlmap:'subscriber_id'},
                        {name:'SubscriberName', index:'SubscriberName', width:50, align:'center', xmlmap:'subscriber_name'},
                        {name:'JournalName', index:'JournalName', width:50, align:'center', xmlmap:'journal_name'},
                        {name:'JournalCode', index:'JournalCode', width:40, align:'center', xmlmap:'journal_code'},
                        {name:'SubscriptionPeriod', index:'SubscriptionPeriod', width:50, align:'center', xmlmap:'subscription_period'},
                        {name:'CopiesCount', index:'CopiesCount', width:30, align:'center',xmlmap:'copies'},
                        {name:'Address', index:'Address', width:80, align:'center', xmlmap:'address'},
                    ],
                    xmlReader : {
                        root: "result",
                        row: "item",
                        page: "jds>page",
                        total: "jds>total",
                        records : "jds>records",
                        repeatitems: false,
                        id: "subscription_id"
                    },
                    pager: '#pager',
                    rowNum:10,
                    rowList:[10,20,30],
                    viewrecords: true,
                    gridview: false,
                    beforeRequest: function(){
                        return isPageLoaded;
                    },
                    gridComplete: function() {
                        var ids = jQuery("#datatable").jqGrid('getDataIDs');
                        if(ids.length > 0){

                            $("#btnPrintml").removeAttr("disabled");
                            $("#btnPrintPreview").removeAttr("disabled");
                        }


                        for (var i = 0; i < ids.length; i++) {
                            action = '<a href="#" onclick="showPrintPreview(' + ids[i] + ')" style="color:blue">View</a>';
                            jQuery("#datatable").jqGrid('setRowData', ids[i], { Preview: action });
                        }

                    },
                    loadError: function(xhr,status,error){
                        alert("Failed getting data from server" + status);
                    }

                });

            });



        </script>
    </head>
    <body>

        <%@include file="../templates/layout.jsp" %>
        <div id="bodyContainer">
            <form method="GET" action="" name="mlForm">
                <div class="MainDiv">
                    <fieldset class="MainFieldset">
                        <legend>Generate <%=list%> List</legend>
                        <fieldset class="subMainFieldSet">
                            <legend>Mailing List Criteria</legend>
                            <div class="IASFormLeftDiv">
                                <div class="IASFormFieldDiv">
                                    <span class="IASFormDivSpanLabel">
                                        <label>Journal Name:</label>
                                    </span>
                                    <span class="IASFormDivSpanInputBox">
                                        <select class="IASComboBox" TABINDEX="1" name="journalName" id="journalName">
                                            <option value ="0">Select</option>
                                            <option value ="">Pramana</option>
                                            <option value ="">Resonance</option>
                                        </select>
                                    </span>
                                </div>

                                <div class="IASFormFieldDiv">
                                    <span class="IASFormDivSpanLabel">
                                        <label>Subscriber Type:</label>
                                    </span>
                                    <span class="IASFormDivSpanInputBox">
                                        <select class="IASComboBox" TABINDEX="2" name="subscriberType" id="subscriberType">
                                            <option value ="0">Select</option>
                                            <option value ="">Summer Fellow</option>
                                            <option value ="">FI</option>
                                        </select>
                                    </span>
                                </div>
                                <div class="IASFormFieldDiv">
                                    <span class="IASFormDivSpanLabel">
                                        <label>No. of Copies:</label>
                                    </span>
                                    <span class="IASFormDivSpanInputBox">
                                        <select class="IASComboBox" TABINDEX="2" name="numOfCopies" id="numOfCopies">
                                            <option selected value ="1">1</option>
                                            <option value ="2">More than 1</option>
                                        </select>
                                    </span>
                                </div>
                            </div>

                            <div class="IASFormRightDiv">


                                <div class="IASFormFieldDiv">
                                    <span class="IASFormDivSpanLabel">
                                        <label>Month:</label>
                                    </span>
                                    <span class="IASFormDivSpanInputBox">
                                        <select class="IASComboBox" TABINDEX="4" name="mlMonth" id="mlMonth">
                                            <option value ="0">November</option>
                                        </select>
                                    </span>
                                </div>

                                <div class="IASFormFieldDiv">
                                    <span class="IASFormDivSpanLabel">
                                        <label>Year:</label>
                                    </span>
                                    <span class="IASFormDivSpanInputBox">
                                        <select class="IASComboBox" TABINDEX="5" name="mlYear" id="mlYear">
                                            <option value ="0">2011</option>
                                        </select>
                                    </span>
                                </div>

                                <div class="IASFormFieldDiv">
                                    <span class="IASFormDivSpanLabel">
                                        <label>Type:</label>
                                    </span>
                                    <span class="IASFormDivSpanInputBox">
                                        <label class="IASActionLabel">Sticker</label>
                                        <input checked type="radio" class="IASRadioButton" TABINDEX="6" name="mlType" id="mlTypeSticker" value="sticker"/>
                                        <label class="IASActionLabel">Label</label>
                                        <input type="radio" class="IASRadioButton" TABINDEX="7" name="mlType" id="mlTypeLabel" value="label"/>
                                    </span>
                                </div>
                            </div>
                            <div class="actionBtnDiv">
                                <input class="IASButton" TABINDEX="6" type="button" value="Generate Mailing List" id="btnGenerateML" name="btnGenerateML" onclick="getMailingList()"/>
                            </div>
                        </fieldset>
                        <%-- Start of result table --%>
                        <fieldset class="subMainFieldSet">
                            <table class="datatable" id="datatable"></table>
                            <div id="pager"></div>
                        </fieldset>
                        <fieldset class="subMainFieldSet">
                            <div class="actionBtnDiv">
                                <input type="button" id="btnPrintPreview" class="IASButton" value="Print" onclick="showPrintPreview()"/>
                                <!--<input type="button" id="btnPrintml" class="IASButton" value="Print" onclick="Print()"/>-->
                            </div>
                        </fieldset>
                    </fieldset>
                </div>

            </form>
        </div>
                        <div id="printPreview"></div>
    </body>
</html>