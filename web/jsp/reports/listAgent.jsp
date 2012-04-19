<%--
    Document   : Search Agent
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="../templates/style.jsp" %>
        <link rel="stylesheet" type="text/css" href="css/report/listAgent.css" />
        <title>List and Print Agent</title>
        <script type="text/javascript" src="<%=request.getContextPath() + "/js/reports/listAgent.js"%>"></script>
        <script type="text/javascript">
            $(document).ready(function() {
                jdsAppend("<%=request.getContextPath() + "/CMasterData?md=country"%>","country","country");
                jdsAppend("<%=request.getContextPath() + "/CMasterData?md=state"%>","state","state");
                jdsAppend("<%=request.getContextPath() + "/CMasterData?md=city"%>","city","city");
            });
        </script>
        
        <script type="text/javascript">
            //var selectedAgentName = 0;
            var selectedAgentId = 0;
            //initally set to false, after the first search the flag is set to true
            var isPageLoaded = false;

            $(function(){

                $("#agentTable").jqGrid({
                    url:"<%=request.getContextPath() + "/reports?action=listAgents"%>",
                    datatype: 'xml',
                    mtype: 'GET',
                    width: '100%',
                    height: 240,
                    autowidth: true,
                    forceFit: true,
                    sortable: true,
                    loadonce: false,
                    rownumbers: true,
                    emptyrecords: "No Agent",
                    loadtext: "Loading...",
                    colNames:['Agent Id','Agent Name','Registriation Date','emailId', 'Address','City'],
                    colModel :[
                        {name:'id', index:'id', width:50, align:'center', xmlmap:'id'},
                        {name:'agentName', index:'agentName', width:80, align:'center', xmlmap:'agentName'},
                        {name:'regDate', index:'regDate', width:80, align:'center', xmlmap:'regDate'},
                        {name:'emailId', index:'emailId', width:80, align:'center', xmlmap:'emailId'},
                        {name:'address', index:'address', width:80, align:'center', xmlmap:'address'},
                        {name:'city', index:'city', width:80, align:'center', xmlmap:'city'}
                    ],
                    xmlReader : {
                        root: "results",
                        row: "row",
                        page: "agent>page",
                        total: "agent>total",
                        records : "agent>records",
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
                        var ids = jQuery("#agentTable").jqGrid('getDataIDs');
                        if(ids.length > 0){
                            $("#btnNext").removeAttr("disabled");
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
            function searchAgents(){
                isPageLoaded = true;

                jQuery("#agentTable").setGridParam({postData:
                        {country       : $("#country").val(),
                        state          : $("#state").val(),
                        city           : $("#city").val(),
                        from           : $("#from").val(),
                        to             : $("#to").val(),
                        selall         : $("#selall:checked").length
                    }});
                jQuery("#agentTable").setGridParam({ datatype: "xml" });
                jQuery("#agentTable").trigger("clearGridData");
                jQuery("#agentTable").trigger("reloadGrid");
            }

            function getChecked(){
                if (document.getElementById("selall").value == 1 ){
                    document.getElementById("selall").value = 0;
                }else {
                    document.getElementById("selall").value = 1;
                }
            }
            
            // draw the date picker.
            jQueryDatePicker("from","to");

        </script>


    </head>
    <body>
        <%@include file="../templates/layout.jsp" %>

        <div id="bodyContainer">
            <form method="post" action="" name="listAgentForm">
                <div class="MainDiv">
                    <fieldset class="MainFieldset">
                        <legend>List and Print Inwards</legend>

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
                                        <select class="IASComboBox" TABINDEX="2" name="country" id="country">
                                            <option value="0" selected >Select</option>
                                        </select>                                        
                                    </span>
                                </div>
                                <div class="IASFormFieldDiv">
                                    <span class="IASFormDivSpanLabel">
                                        <label>State:</label>
                                    </span>
                                    <span class="IASFormDivSpanInputBox">
                                        <select class="IASComboBox" TABINDEX="3" name="state" id="state">
                                            <option value="" selected >Select</option>
                                        </select>
                                        <%--<input class="IASTextBoxMandatory" TABINDEX="3" name="state" id="state" value="<jsp:getProperty name="inwardFormBean" property="state"/>"--%>
                                    </span>
                                </div>                                     
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

                            </div>

                            <%-- Search Criteria right div --%>
                            <div class="IASFormRightDiv">

                                <div class="IASFormFieldDiv">
                                    <span class="IASFormDivSpanLabel">
                                        <label>Date Range:</label>
                                    </span>
                                    <div class="dateDiv"></div>
                                    <span class="IASFormDivSpanInputBox">
                                        <input class="IASDateTextBox" TABINDEX="5" readonly size="10" type="text" id="from" name="from"/>
                                    </span>
                                    <span class="IASFormDivSpanForHyphen">
                                        <label> to </label>
                                    </span>
                                    <span class="IASFormDivSpanInputBox">
                                        <input class="IASDateTextBox" TABINDEX="6" readonly size="10" type="text" id="to" name="to"/>
                                    </span>
                                </div>
                                <div class="IASFormFieldDiv">
                                    <span class="IASFormDivSpanLabel">
                                        <label>All Agents</label>
                                    </span>
                                    <span class="IASFormDivSpanInputBox">
                                        <input class="IASCheckBox" TABINDEX="2" type="checkbox" name="selall" id="selall" onclick="getChecked()"/>
                                    </span>
                                </div>                                
                                      
                            </div>
                            <div class="actionBtnDiv">
                                <input class="IASButton" TABINDEX="10" type="button" value="Search" onclick="searchAgents()"/>
                                <input class="IASButton" TABINDEX="11" type="reset" value="Reset"/>
                            </div>

                        </fieldset>



                        <%-----------------------------------------------------------------------------------------------------%>
                        <%-- Search Result Field Set --%>
                        <%-----------------------------------------------------------------------------------------------------%>
                        <fieldset class="subMainFieldSet">
                            <legend>Search Result</legend>

                            <table class="datatable" id="agentTable"></table>
                            <div id="pager"></div>
                        </fieldset>
                    </fieldset>

                        <%-----------------------------------------------------------------------------------------------------%>
                        <%-- SPrint Button Field Set --%>
                        <%-----------------------------------------------------------------------------------------------------%>
                        
                     <fieldset class="subMainFieldSet">
                        <div class="IASFormFieldDiv">
                            <div class="singleActionBtnDiv">
                                <input class="IASButton" type="button" value="Print" disabled id="printReportBtn" onclick="printReport();"/>
                            </div>
                        </div>
                    </fieldset>                        
                </div>
            </form>
        </div>
    </body>
</html>