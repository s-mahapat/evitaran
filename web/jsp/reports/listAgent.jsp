<%--
    Document   : List and Print Agents
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="../templates/style.jsp" %>
        <link rel="stylesheet" type="text/css" href="css/report/agent.css" />
        <title>List And Print Agent</title>
        <script type="text/javascript">
            var isPageLoaded = false;
            // draw the date picker.
            jQueryDatePicker("from","to");

            $(function(){

                      $("#datatable").jqGrid({
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
                        emptyrecords: "No records to view",
                        loadtext: "Loading...",
                        colNames:['Agent ID','Agent Name','Registration Date', 'Address','City','Pin Code','Email'],
                        colModel :[
                          {name:'AgentId', index:'inward_id', width:50, align:'center', xmlmap:'agent_id'},
                          {name:'AgentName', index:'inward_id', width:50, align:'center', xmlmap:'agent_name'},
                          {name:'RegistrationDate', index:'subscriber_id', width:80, align:'center', xmlmap:'registration_date'},
                          {name:'Address', index:'from', width:80, align:'center', xmlmap:'address'},
                          {name:'City', index:'date', width:80, align:'center',xmlmap:'city'},
                          {name:'PinCode', index:'city', width:80, align:'center', sortable:false, xmlmap:'pincode'},
                          {name:'Email', index:'city', width:80, align:'center', sortable:false, xmlmap:'email'}
                        ],
                        xmlReader : {
                          root: "result",
                          row: "row",
                          page: "data>page",
                          total: "data>total",
                          records : "data>records",
                          repeatitems: false,
                          id: "agent_id"
                       },
                        pager: '#pager',
                        rowNum:10,
                        rowList:[10,20,30],
                        viewrecords: true,
                        gridview: true,
                        caption: '&nbsp;',
                        beforeRequest: function(){
                          return isPageLoaded;
                        },
                        loadError: function(xhr,status,error){
                            alert("Failed getting data from server" + status);
                        }
               });

            });

            function getReport(){
                isPageLoaded = true;
                jQuery("#datatable").trigger("reloadGrid");
            }
        </script>

    </head>
    <body>
        <%@include file="../templates/layout.jsp" %>

        <div id="bodyContainer">
            <form method="post" action="" name="listAgentForm">
                <script>
                    $(document).ready(function() {
                        jdsAppend("/JDS/CMasterData?md=city","city","city");
                        jdsAppend("/JDS/CMasterData?md=country","country","country");
                        jdsAppend("/JDS/CMasterData?md=state","state","state");
                        jdsAppend("/JDS/CMasterData?md=district","district","district");
                        jdsAppend("/JDS/CMasterData?md=sub_type","subtype","subtype");
                    });   
                </script>
                <div class="MainDiv">
                    <fieldset class="MainFieldset">
                        <legend>List And Print Agent</legend>

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
                                    <span class="IASFormDivSpanLabel">
                                        <label>Reg. Date Range:</label>
                                    </span>
                                    <div class="dateDiv"></div>
                                    <span class="IASFormDivSpanInputBox">
                                        <input class="IASDateTextBox" readonly size="10" type="text" id="from" name="from"/>
                                    </span>
                                    <span class="IASFormDivSpanForHyphen">
                                        <label> to </label>
                                    </span>
                                    <span class="IASFormDivSpanInputBox">
                                        <input class="IASDateTextBox" readonly size="10" type="text" id="to" name="to"/>
                                    </span>
                                </div>
                            </div>

                            <div class="IASFormFieldDiv">
                                <div id="searchBtnDiv">
                                    <input class="IASButton" TABINDEX="6" type="button" onclick="getReport()" value="Search"/>
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
                            <legend>Result</legend>
                            <table class="datatable" id="datatable"></table>
                            <div id="pager"></div>

                        </fieldset>

                        <fieldset class="subMainFieldSet">
                            <div class="IASFormFieldDiv">
                                <div class="singleActionBtnDiv">
                                    <input class="IASButton" type="button" value="Print" onclick="javascript:window.print();"/>
                                </div>
                            </div>
                        </fieldset>
                    </fieldset>
                </div>
            </form>
        </div>
    </body>
</html>