<%--
    Document   : Generate and Print Mailing List
    Author     : Deepali
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <jsp:include page="../templates/style.jsp"></jsp:include>
        <link rel="stylesheet" type="text/css" href="css/ml/generateml.css"/>
        <title>Generate and Print mailing List</title>
        <script type="text/javascript" src="<%=request.getContextPath() + "/js/ml/generateml.js"%>"></script>
        <script type="text/javascript" src="<%=request.getContextPath() + "/js/common.js"%>"></script>
        <script type="text/javascript" src="js/jquery/grid.common.js"></script>


        <script type="text/javascript">
            var selectedId = 0;
            //initally set to false, after the first search the flag is set to true
            var isPageLoaded = false;

            $(document).ready(function(){
                jdsAppend("<%=request.getContextPath() + "/CMasterData?md=year"%>","year","year");
                jdsAppend("<%=request.getContextPath() + "/CMasterData?md=month"%>","month","month");
                jdsAppend("<%=request.getContextPath() + "/CMasterData?md=journalname"%>","journalName","journalName");
                //jdsAppend("<%=request.getContextPath() + "/CMasterData?md=getissues"%>","issueNumber","issue");
             });

            $(function(){

                $("#mlTable").jqGrid({
                    url:"<%=request.getContextPath()%>/generateml",
                    datatype: 'xml',
                    mtype: 'GET',
                    width: '100%',
                    height: 240,
                    autowidth: true,
                    forceFit: true,
                    sortable: true,
                    loadonce: true,
                    rownumbers: true,
                    emptyrecords: "No Mailing List Found",
                    loadtext: "Loading...",
                    colNames:['Id','Journal Name','Month', 'Year', 'Issue','Print'],
                    colModel :[
                        {name:'id', index:'id', width:80, align:'center', xmlmap:'id'},
                        {name:'journalName', index:'journalName', width:80, align:'center', xmlmap:'journalName'},
                        {name:'month', index:'month', width:80, align:'center', xmlmap:'month'},
                        {name:'year', index:'year', width:80, align:'center', xmlmap:'year'},
                        {name:'issue', index:'issue', width:80, align:'center', xmlmap:'issue'},
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
                    rowNum:15,
                    rowList:[15,30,45],
                    viewrecords: true,
                    gridview: true,
                    caption: '&nbsp;',
                    editurl:"<%=request.getContextPath()%>/generateml?action=search",
                    gridComplete: function() {
                        var ids = jQuery("#mlTable").jqGrid('getDataIDs');
                        for (var i = 0; i < ids.length; i++) {
                            action = "<a style='color:blue;' href='generateml?action=print&id=" + ids[i] + "'>Print</a>";
                            jQuery("#generateml").jqGrid('setRowData', ids[i], { Action: action });
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

            function generate(){
            
                if ($("#year").val() == 0) {
                    alert("Select Year");
                }

                else if ($("#journalName").val() == 0){
                    alert("Select Journal");
                }

                else if ($("#month").val() == 0){
                    alert("Select Month");
                }
                
                else if ($("#issue").val() == 'value'){
                    alert("Select Issue");
                }

                else if($("#mlCreationDate").val() == "") {
                    alert("Please try again after logging in again ");
                }

                else {
                        isPageLoaded = true;
                        jQuery("#mlTable").setGridParam({postData:
                                {
                                year                    : $("#year").val(),
                                journalName             : $("#journalName").val(),
                                month                   : $("#month").val(),
                                mlCreationDate          : $("#mlCreationDate").val(),
                                issue                   : $("#issue").val(),
                                action                  : "generate"
                            }});
                        jQuery("#mlTable").setGridParam({ datatype: "xml" });
                        jQuery("#mlTable").trigger("clearGridData");
                        jQuery("#mlTable").trigger("reloadGrid");
                    }               
            }


            function search(){
                //check if search criteria is initial, raise alert else enable search for Records
                if ($("#year").val() == 0) {
                    alert("Select Year");
                }

                else if ($("#journalName").val() == 0){
                    alert("Select Journal");
                }

                else if ($("#month").val() == 0){
                    alert("Select Month");
                }
                
                else if ($("#issue").val() == 'value'){
                    alert("Select Issue");
                }

                else if($("#mlCreationDate").val() == "") {
                    alert("Please try again after logging in again ");
                }

                else {
                        isPageLoaded = true;
                        jQuery("#mlTable").setGridParam({postData:
                                {year                   : $("#year").val(),
                                journalName             : $("#journalName").val(),
                                month                   : $("#month").val(),
                                mlCreationDate          : $("#mlCreationDate").val(),
                                issue                   : $("#issue").val(),
                                action                  : "search"
                            }});

                        jQuery("#mlTable").setGridParam({ datatype: "xml" });
                        jQuery("#mlTable").trigger("clearGridData");
                        jQuery("#mlTable").trigger("reloadGrid");

                    }
                }
                
                
            function loadIssues(){
                $("#issue").empty();
                $("#issue").text("");

                var newOption = new Option("Select", "value");
                $(newOption).html("Select");
                $("#issue").append(newOption);

                requestURL = "/JDS/CMasterData?md=getissues&mdvalue=" +  $("#journalName").val();
                jdsAppend(requestURL,"issueNumber","issue");
            }
            
        </script>
    </head>
    <body>

        <%@include file="../templates/layout.jsp" %>
        <div id="bodyContainer">
            <form method="post" action="<%=request.getContextPath() + "/generateml"%>" name="mlForm">
                <div class="MainDiv">
                    <fieldset class="MainFieldset">
                        <legend>Generate and Print Mailing List</legend>
                        <jsp:useBean class="IAS.Bean.MailingList.mlFormBean" id="mlFormBean" scope="request"></jsp:useBean>
                            <fieldset class="subMainFieldSet">
                                <legend>Selection Criteria</legend>
                                    <%-- Search Criteria left div --%>
                                    <div class="IASFormLeftDiv">
                                        <div class="IASFormFieldDiv">
                                            <div class="IASFormFieldDiv">
                                                <span class="IASFormDivSpanLabel">
                                                    <label>Journal Name:</label>
                                                </span>
                                                <span class="IASFormDivSpanInputBox">
                                                    <select class="IASComboBox" TABINDEX="1" name="journalName" id="journalName" onchange="loadIssues()">
                                                        <option value="0">Select</option>
                                                    </select>
                                                </span>
                                            </div>
                                            <div class="IASFormFieldDiv">                                                
                                                <span class="IASFormDivSpanLabel">
                                                    <label>Issue:</label>
                                                </span>
                                                <span class="IASFormDivSpanInputBox">
                                                <select class="IASComboBox" TABINDEX="2" name="issue" id="issue">
                                                        <option value="0">Select</option>
                                                    </select>
                                                </span>
                                            </div>
                                        </div>
                                        <div class="IASFormFieldDiv">
                                            <span class="IASFormDivSpanLabel">
                                                <label>Creation Date:</label>
                                            </span>
                                            <span class="IASFormDivSpanInputBox">
                                                <input class="IASDateTextBox" TABINDEX="-1" readonly type="text" name="mlCreationDate" id="mlCreationDate" value="<jsp:getProperty name="mlFormBean" property="mlCreationDate"/>"
                                            </span>
                                        </div>                                        
                                    </div>
                                    <%-- Search Criteria right div --%>
                                    <div class="IASFormRightDiv">
                                        <div class="IASFormFieldDiv">
                                            <div class="IASFormFieldDiv">                                                
                                                <span class="IASFormDivSpanLabel">
                                                    <label>Year:</label>
                                                </span>
                                                <span class="IASFormDivSpanInputBox">
                                                <select class="IASComboBox" TABINDEX="3" name="year" id="year">
                                                        <option value="0">Select</option>
                                                    </select>
                                                </span>
                                            </div>
                                            <div class="IASFormFieldDiv">                                                
                                                <span class="IASFormDivSpanLabel">
                                                    <label>Month:</label>
                                                </span>
                                                <span class="IASFormDivSpanInputBox">   
                                                <select class="IASComboBox" TABINDEX="4" name="month" id="month">
                                                        <option value="0">Select</option>
                                                    </select>
                                                </span>
                                            </div>                                            
                                        </div>
                                    </div>

                            </fieldset>
                            <fieldset class="subMainFieldSet">
                                <legend>Actions - Search / Generate</legend>
                                    <div class="IASFormFieldDiv">
                                        <div id="searchBtnDiv">
                                             <input class="IASButton" TABINDEX="5" type="button" value="Display Mailing List" id="btnSearch" name="btnSearch" onclick="search()"/>
                                        </div>                                          
                                        <div id="addBtnDiv">
                                             <input class="IASButton" TABINDEX="6" type="button" value="Generate Mailing lis" id="btnAdd" name="btnAddRate" onclick="generate()"/>
                                        </div>   
                                     </div>
                            </fieldset>
                              
                            <%-----------------------------------------------------------------------------------------------------%>
                            <%-- Search Result Field Set --%>
                            <%-----------------------------------------------------------------------------------------------------%>
                            <fieldset class="subMainFieldSet">
                                <legend>Mailing List Table</legend>

                                <table class="datatable" id="mlTable"></table>
                                <div id="pager"></div>
                            </fieldset>

                            <%-----------------------------------------------------------------------------------------------------%>
                            <%-- Journal Actions Field Set --%>
                            <%-----------------------------------------------------------------------------------------------------%>

                            <fieldset class="subMainFieldSet">
                                <div class="IASFormFieldDiv">
                                    <div id="cancelBtnDiv">
                                        <input class="IASButton" TABINDEX="4" type="reset" value="Reset"/>
                                    </div>
                                </div>
                            </fieldset>
                    </fieldset>
                </div>
            </form>
        </div>
    </body>
</html>
