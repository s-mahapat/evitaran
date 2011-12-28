<%--
    Document   : Search Agent
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="../templates/style.jsp" %>
        <link rel="stylesheet" type="text/css" href="css/masterdata/agent.css" />

        <title>Search Agent</title>

        <script type="text/javascript">
            var selectedAgentName = 0;
            var selectedAgentId = 0;
            //initally set to false, after the first search the flag is set to true
            var isPageLoaded = false;

            $(function(){

                $("#AgentTable").jqGrid({
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
                    emptyrecords: "No Agent",
                    loadtext: "Loading...",
                    colNames:['Agent Id','Agent Name','Registriation Date','emailId', 'Address','City','Action'],
                    colModel :[
                        {name:'AgentId', index:'agentId', width:50, align:'center', xmlmap:'agentId'},
                        {name:'AgentName', index:'agentName', width:80, align:'center', xmlmap:'agentName'},
                        {name:'Registration Date', index:'regDate', width:80, align:'center', xmlmap:'regDate'},
                        {name:'emailId', index:'emailId', width:80, align:'center', xmlmap:'emailId'},
                        {name:'Address', index:'address', width:80, align:'center', xmlmap:'address'},
                        {name:'City', index:'city', width:80, align:'center', xmlmap:'city'},
                        {name:'Action', index:'action', width:80, align:'center',formatter:'showlink'}
                    ],
                    xmlReader : {
                        root: "result",
                        row: "AgentName",
                        page: "agentName>page",
                        total: "agentName>total",
                        records : "agentName>records",
                        repeatitems: false,
                        id: "agentId"
                    },
                    pager: '#pager',
                    rowNum:10,
                    rowList:[10,20,30],
                    viewrecords: true,
                    gridview: true,
                    caption: '&nbsp;',
                    gridComplete: function() {
                        var ids = jQuery("#agentTable").jqGrid('getDataIDs');
                        if(ids.length > 0){
                            $("#btnNext").removeAttr("disabled");
                        }
                        for (var i = 0; i < ids.length; i++) {
                            var cl = ids[i];
                            var rowData = jQuery("#agentTable").jqGrid('getLocalRow',cl);
                            var cityId = rowData['Agent Id'] || 0;
                            action = "<a style='color:blue;' href='agent1?action=view'>View</a><a style='color:blue;' href='agent1?action=edit&agent=" + agentId + "'>Edit</a>";
                            jQuery("#agentTable").jqGrid('setRowData', ids[i], { Action: action });
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
            function searchAgent(){
                isPageLoaded = true;
                jQuery("#agentTable").trigger("reloadGrid");
            }

            // draw the date picker.
            jQueryDatePicker("from","to");

        </script>
        
        <%--------------------------------------------------------------%>
        <%-- Calendar --%>
        <%--------------------------------------------------------------%>
        <script src="js/CalendarPopup.js" type="text/javascript"></script>
        <script type="text/javascript">
            var calPopup = new CalendarPopup("dateDiv");
            calPopup.showNavigationDropdowns();
        </script>    
    
    </head>
    <body>
        <%@include file="../templates/layout.jsp" %>

        <div id="bodyContainer">
            <form method="post" action="" name="searchAgentForm">
                <div class="MainDiv">
                    <fieldset class="MainFieldset">
                        <legend>Search Agent</legend>

                        <%-----------------------------------------------------------------------------------------------------%>
                        <%-- Search Criteria Field Set --%>
                        <%-----------------------------------------------------------------------------------------------------%>
                        <fieldset class="subMainFieldSet">
                            <legend>Search Criteria</legend>

                            <%-- Search Criteria left div --%>
                            <div class="IASFormLeftDiv">


                                <div class="IASFormFieldDiv">
                                    <span class="IASFormDivSpanLabel">
                                        <label>Agent Name:</label>
                                    </span>
                                    <span class="IASFormDivSpanInputBox">
                                        <input class="IASTextBox" TABINDEX="1" type="text" name="agentName" id="agentName" value=""/>
                                    </span>
                                </div>


                                <div class="IASFormFieldDiv">
                                    <span class="IASFormDivSpanLabel">
                                        <label>address:</label>
                                    </span>
                                    <span class="IASFormDivSpanInputBox">
                                        <input class="IASTextBox" TABINDEX="2" type="text" name="address" id="address" value=""/>
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
                                    <%------ Date Range Label ------%>
                                    <span class="IASFormDivSpanLabel">
                                        <label>Reg. Date Range:</label>
                                    </span>

                                    <%---------- Date Division -----------%>
                                    <div class="dateDiv" id="dateDiv"></div>

                                    <%------ From Date Input Box ------%>
                                    <span class="IASFormDivSpanInputBox">
                                        <input class="IASDateTextBox" readonly size="10" value="" id="fromDate"/>
                                           <a href="#" onClick="calPopup.select(document.searchAgentForm.fromDate,'anchor1','dd/MM/yyyy');
                                               return false;" NAME="anchor1" ID="anchor1">
                                            <img class="calendarIcon" alt="select" src="" TABINDEX="4"/>
                                        </a>
                                    </span>

                                    <%-- Hyphen between From date and To Date --%>
                                    <span class="IASFormDivSpanForHyphen">
                                        <label> - </label>
                                    </span>

                                    <%--------------- To Date Input Box --------------%>
                                    <span class="IASFormDivSpanInputBoxForSearchInward">
                                        <input class="IASDateTextBox" readonly size="10" value="" id="toDate"/>
                                           <a href="#" onClick="calPopup.select(document.searchAgentForm.toDate,'anchor2','dd/MM/yyyy');
                                               return false;" NAME="anchor2" ID="anchor2">
                                            <img class="calendarIcon" alt="select" src="" TABINDEX="5"/>
                                        </a>
                                    </span>
                                </div>
                            </div>

                            <div class="IASFormFieldDiv">
                                <div id="searchBtnDiv">
                                    <input class="IASButton" TABINDEX="6" type="submit" value="Search"/>
                                </div>

                                <div id="resetBtnDiv">
                                    <input class="IASButton" TABINDEX="7" type="reset" value="Reset"/>
                                </div>
                            </div>

                        </fieldset>

                        <%-----------------------------------------------------------------------------------------------------%>
                        <%-- Search Result Field Set --%>
                        <%-----------------------------------------------------------------------------------------------------%>
                        <fieldset class="subMainFieldSet">
                            <legend>Search Result</legend>

                            <table class="datatable" id="AgentTable"></table>
                            <div id="pager"></div>
                        </fieldset>
                    </fieldset>
                </div>
            </form>
        </div>
    </body>
</html>