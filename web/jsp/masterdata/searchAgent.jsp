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
            //var selectedAgentName = 0;
            var selectedAgentId = 0;
            //initally set to false, after the first search the flag is set to true
            var isPageLoaded = false;

            $(function(){

                $("#agentTable").jqGrid({
                    url:"<%=request.getContextPath() + "/agent?action=search"%>",
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
                    colNames:['Agent Id','Agent Name','Registriation Date','emailId', 'Address','City','View/Edit'],
                    colModel :[
                        {name:'id', index:'id', width:50, align:'center', xmlmap:'id'},
                        {name:'agentName', index:'agentName', width:80, align:'center', xmlmap:'agentName'},
                        {name:'regDate', index:'regDate', width:80, align:'center', xmlmap:'regDate'},
                        {name:'emailId', index:'emailId', width:80, align:'center', xmlmap:'emailId'},
                        {name:'address', index:'address', width:80, align:'center', xmlmap:'address'},
                        {name:'city', index:'city', width:80, align:'center', xmlmap:'city'},
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
                        var ids = jQuery("#agentTable").jqGrid('getDataIDs');
                        if(ids.length > 0){
                            $("#btnNext").removeAttr("disabled");
                        }

                        for (var i = 0; i < ids.length; i++) {
                            action = "<a style='color:blue;' href='agent?action=view&id=" + ids[i] + "'>View</a><a style='color:blue;' href='agent?action=edit&id=" + ids[i] + "'>/ Edit</a>";
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

                jQuery("#agentTable").setGridParam({postData:
                        {agentName       : $("#agentName").val(),
                        city          : $("#city").val()
                    }});
                jQuery("#agentTable").setGridParam({ datatype: "xml" });
                jQuery("#agentTable").trigger("clearGridData");
                jQuery("#agentTable").trigger("reloadGrid");
            }

            // draw the date picker.
            //jQueryDatePicker("from","to");

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
                             </div>
                            <%-- Search Criteria right div --%>
                            <div class="IASFormRightDiv">
                                <div class="IASFormFieldDiv">
                                    <span class="IASFormDivSpanLabel">
                                        <label>City:</label>
                                    </span>
                                    <span class="IASFormDivSpanInputBox">
                                        <input class="IASTextBox" TABINDEX="2" type="text" name="city" id="city" value=""/>
                                    </span>
                                </div>
                            </div>

                            <div class="IASFormFieldDiv">
                                <div id="searchBtnDiv">
                                    <input class="IASButton" TABINDEX="3" type="button" value="search" onclick="searchAgent()"/>
                                </div>

                                <div id="resetBtnDiv">
                                    <input class="IASButton" TABINDEX="4" type="reset" value="reset"/>
                                </div>
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
                </div>
            </form>
        </div>
    </body>
</html>