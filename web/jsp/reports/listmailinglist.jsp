<%--
    Document   : Print Mailing List report
    Author     : Deepali
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <jsp:include page="../templates/style.jsp"></jsp:include>
        <link rel="stylesheet" type="text/css" href="css/report/listmailinglist.css"/>
        <title>Report: Mailing List</title>
        <script type="text/javascript" src="<%=request.getContextPath() + "/js/reports/listmailinglist.js"%>"></script>
        <script type="text/javascript" src="<%=request.getContextPath() + "/js/common.js"%>"></script>
        <script type="text/javascript" src="js/jquery/grid.common.js"></script>


        <script type="text/javascript">
            var selectedId = 0;
            //initally set to false, after the first search the flag is set to true
            var isPageLoaded = false;

            $(document).ready(function(){
                jdsAppend("<%=request.getContextPath() + "/CMasterData?md=year"%>","year","year");
                jdsAppend("<%=request.getContextPath() + "/CMasterData?md=journalname"%>","journalName","journalName");
                jQuery("#btnPrint").button("disable");
             });

            $(function(){

                $("#mlTable").jqGrid({
                    url:"<%=request.getContextPath() + "/reports?action=listMl"%>",
                    datatype: 'xml',
                    mtype: 'GET',
                    width: '100%',
                    height: 240,
                    autowidth: true,
                    forceFit: true,
                    sortable: true,
                    loadonce: true,
                    rownumbers: true,
                    emptyrecords: "No Mailing List Found or Generated",
                    loadtext: "Loading...",
                    colNames:['Journal Code', 'Subtypecode', 'Subscriber Number', 'Subscriber Name', 'Address', 'City', 'District',
                                'State', 'Country', 'Pincode', 'Copies', 'Issue', 'Month', 'Year', 'Sub Start', 'Sub End'],
                    colModel :[
                        {name:'journalCode', index:'journalCode', width:80, align:'center', xmlmap:'journalCode'},
                        {name:'subtypecode', index:'subtypecode', width:20, align:'center', xmlmap:'subtypecode'},
                        {name:'subscriberNumber', index:'subscriberNumber', width:80, align:'center', xmlmap:'subscriberNumber'},
                        {name:'subscriberName', index:'subscriberName', width:100, align:'center', xmlmap:'subscriberName'},
                        {name:'address', index:'address', width:200, align:'center', xmlmap:'address'},
                        {name:'city', index:'city', width:80, align:'center', xmlmap:'city'},
                        {name:'district', index:'district', width:80, align:'center', xmlmap:'district'},
                        {name:'state', index:'state', width:80, align:'center', xmlmap:'state'},
                        {name:'country', index:'country', width:80, align:'center', xmlmap:'country'},
                        {name:'pincode', index:'pincode', width:80, align:'center', xmlmap:'pincode'},
                        {name:'copies', index:'copies', width:10, align:'copies', xmlmap:'copies'},
                        {name:'issue', index:'issue', width:10, align:'center', xmlmap:'issue'},
                        {name:'month', index:'month', width:80, align:'center', xmlmap:'month'},
                        {name:'year', index:'year', width:20, align:'center', xmlmap:'year'},
                        {name:'start', index:'start', width:25, align:'center', xmlmap:'start'},
                        {name:'end', index:'end', width:25, align:'center', xmlmap:'end'},
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
                    editurl:"<%=request.getContextPath() + "/reports?action=listMl"%>",
                    loadComplete: function(xml){
                        //sessionStorage.searchinwards = xml.toString();
                        //console.log(sessionStorage.searchinwards.toString());

                    },
                    gridComplete: function() {
                    },
                    beforeRequest: function(){
                        return isPageLoaded;
                    },
                    loadError: function(xhr,status,error){
                        alert("Failed getting data from server" + status);
                    }

                });

            });


            function search(){
                //check if search criteria is initial, raise alert else enable search for Records
                if ($("#year").val() == 0) {
                    alert("Select Year");
                }

                else if ($("#journalName").val() == 0){
                    alert("Select Journal");
                }

                else if ($("#issue").val() == 'value'){
                    alert("Select Issue");
                }

                else {
                        isPageLoaded = true;
                        jQuery("#mlTable").setGridParam({postData:
                                {year                   : $("#year").val(),
                                journalName             : $("#journalName").val(),
                                mlCreationDate          : $("#mlCreationDate").val(),
                                issue                   : $("#issue").val(),
                                action                  : "listMl"
                            }});

                        jQuery("#mlTable").setGridParam({ datatype: "xml" });
                        jQuery("#mlTable").trigger("clearGridData");
                        jQuery("#mlTable").trigger("reloadGrid");
                        jQuery("#btnPrint").button("enable");
                    }
                }


            function loadIssues(){
                $("#issue").empty();
                //text("");

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
            <form method="post" action="<%=request.getContextPath() + "/reports?action=printlistMl"%>" name="bilForm">
                <div class="MainDiv">
                    <fieldset class="MainFieldset">
                        <legend>Report - Mailing List</legend>
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
                                    </div>
                                    <%-- Search Criteria right div --%>
                                    <div class="IASFormRightDiv">
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
                                    </div>
                                    <div class="actionBtnDiv">
                                        <input class="IASButton" TABINDEX="4" type="button" value="Search" id="btnSearch" name="btnSearch" onclick="search()"/>
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
                            <%-- Actions Field Set --%>
                            <%-----------------------------------------------------------------------------------------------------%>

                            <fieldset class="subMainFieldSet">
                                <%--
                                <div class="IASFormFieldDiv">
                                    <div class="printBtnDiv">
                                        <input class="IASButton" TABINDEX="5" type="submit" value="Print" disabled id="printReportBtn"/>
                                    </div>
                                    <div id="resetBtnDiv">
                                        <input class="IASButton" TABINDEX="6" type="reset" value="Reset"/>
                                    </div>
                                </div>
                                --%>
                                <div class="actionBtnDiv">
                                    <input class="IASButton" TABINDEX="5" type="submit" value="Print" id="btnPrint" name="btnPrint"/>
                                    <input class="IASButton" TABINDEX="6" type="reset" value="Reset" id="btnReset" name="btnReset"/>
                                </div>
                            </fieldset>
                    </fieldset>
                </div>
            </form>
        </div>
    </body>
</html>
