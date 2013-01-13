<%--
    Document   : Search and Print Mailing List
    Author     : Deepali
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <jsp:include page="../templates/style.jsp"></jsp:include>
        <link rel="stylesheet" type="text/css" href="css/ml/generateml.css"/>
        <title>View and Print mailing List</title>
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
                jQuery("#btnSearch,#btnPrintLabel,#btnPrintSticker").button("disable");

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
                    emptyrecords: "No Mailing List Found or Generated",
                    loadtext: "Loading...",
                    colNames:['journalCode', 'subtypecode', 'subscriberNumber', 'subscriberName', 'city',
                                'state', 'country', 'pincode', 'copies', 'Volume Number','issue', 'month', 'year'],
                    colModel :[
                        {name:'journalCode', index:'journalCode', width:80, align:'center', xmlmap:'journalCode'},
                        {name:'subtypecode', index:'subtypecode', width:80, align:'center', xmlmap:'subtypecode'},
                        {name:'subscriberNumber', index:'subscriberNumber', width:80, align:'center', xmlmap:'subscriberNumber'},
                        {name:'subscriberName', index:'subscriberName', width:80, align:'center', xmlmap:'subscriberName'},
                        {name:'city', index:'city', width:80, align:'center', xmlmap:'city'},
                        {name:'state', index:'state', width:80, align:'center', xmlmap:'state'},
                        {name:'country', index:'country', width:80, align:'center', xmlmap:'country'},
                        {name:'pincode', index:'pincode', width:80, align:'center', xmlmap:'pincode'},
                        {name:'copies', index:'copies', width:80, align:'copies', xmlmap:'copies'},
                        {name:'volumeNumber', index:'volumeNumber', width:80, align:'center', xmlmap:'volumeNumber'},
                        {name:'issue', index:'issue', width:80, align:'center', xmlmap:'issue'},
                        {name:'month', index:'month', width:80, align:'center', xmlmap:'month'},
                        {name:'year', index:'year', width:80, align:'center', xmlmap:'year'},
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
                    editurl:"<%=request.getContextPath()%>/generateml?action=generate",
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


            function search(){

                if ($("#year").val() == 0) {
                    alert("Select Year");
                }

                else if ($("#journalName").val() == 0){
                    alert("Select Journal");
                }

                else if ($("#month").val() == 0){
                    alert("Select Month");
                }
                else if ($("#volume").val() == 0){
                    alert("Select Volume Number");
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
                                volume                  : $("#volume").val(),
                                mlCreationDate          : $("#mlCreationDate").val(),
                                issue                   : $("#issue").val(),
                                action                  : "search"
                            }});
                        jQuery("#mlTable").setGridParam({ datatype: "xml" });
                        jQuery("#mlTable").trigger("clearGridData");
                        jQuery("#mlTable").trigger("reloadGrid");
                        //jQuery("#btnPrintLabel,#btnPrintSticker").attr("disabled",false);
                        jQuery("#btnPrintLabel,#btnPrintSticker").button("enable");
                        jQuery("#btnSearch").button("disable");
                    }
            }



            function print(){

                $.ajax({
                   type:    'GET',
                   url:     "<%=request.getContextPath()%>/generateml",
                   data:
                       {year                   : $("#year").val(),
                        month                   : $("#month").val(),
                        journalName             : $("#journalName").val(),
                        volume                   : $("#volume").val(),
                        mlCreationDate          : $("#mlCreationDate").val(),
                        issue                   : $("#issue").val(),
                        printOption             : $("#printOption").val(),
                        noHeader                : $("#noHeader").length,
                        periodicals             : $("#periodicals").length,
                        action                  : "print"
                    },
                    success : function(data) {
                        var WinId = window.open('', 'newwin', 'width=400,height=500');
                        WinId.document.open();
                        WinId.document.write(data);
                        WinId.document.close();
                    }
                });

            }


            function loadIssues(){
                $("#issue").empty();
                //text("");

                var newOption = new Option("Select", "value");
                $(newOption).html("Select");
                $("#issue").append(newOption);

                requestURL = "/JDS/CMasterData?md=getissues&mdvalue=" +  $("#journalName").val() + "&optionalParam=" +  $("#volume").val();
                jdsAppend(requestURL,"issueNumber","issue");
            }
            
             function loadvolumes(){
                $("#volume").empty();
                //text("");

                var newOption = new Option("Select", "value");
                $(newOption).html("Select");
                $("#volume").append(newOption);

                requestURL = "/JDS/CMasterData?md=getvolumes&mdvalue=" +  $("#journalName").val() + "&optionalParam=" +  $("#year").val();
                jdsAppend(requestURL,"volumeNumber","volume");
            }

            function printLabel()
            {
                var x = "printLabel";
                $('#action').val(x);
            }

            function printSticker()
            {
                var x = "printSticker";
                $('#action').val(x);
            }

                        function getNoHeaderChecked(){
                if (document.getElementById("noHeader").value == 1 ){
                    document.getElementById("noHeader").value = 0;
                }else {
                    document.getElementById("noHeader").value = 1;
                }
            }

            function getPeriodicalChecked(){
                if (document.getElementById("periodicals").value == 1 ){
                    document.getElementById("periodicals").value = 0;
                }else {
                    document.getElementById("periodicals").value = 1;
                }
            }

        </script>
    </head>
    <body>

        <%@include file="../templates/layout.jsp" %>
        <div id="bodyContainer">
            <form method="get" action="<%=request.getContextPath() + "/generateml"%>" name="mlForm">
                <div class="MainDiv">
                    <fieldset class="MainFieldset">
                        <legend>View and Print Mailing List</legend>
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
                                                    <select class="IASComboBoxWide" TABINDEX="1" name="journalName" id="journalName" onchange="loadvolumes()">
                                                        <option value="0">Select</option>
                                                    </select>
                                                </span>
                                            </div>
                                            <div class="IASFormFieldDiv">
                                                <span class="IASFormDivSpanLabel">
                                                    <label>Year:</label>
                                                </span>
                                                <span class="IASFormDivSpanInputBox">
                                                    <select class="IASComboBox" TABINDEX="3" name="year" id="year" onchange="loadvolumes()">                                                
                                                    </select>
                                                </span>
                                            </div>  
                                            <div class="IASFormFieldDiv">
                                                <span class="IASFormDivSpanLabel">
                                                    <label>Month:</label>
                                                </span>
                                                <span class="IASFormDivSpanInputBox">
                                                    <select class="IASComboBox" TABINDEX="3" name="month" id="month">                                                
                                                    </select>
                                                </span>
                                            </div>          
                                         </div>
                                    </div>
                                    <%-- Search Criteria right div --%>
                                    <div class="IASFormRightDiv">
                                        <div class="IASFormFieldDiv">
                                            <div class="IASFormFieldDiv">
                                                <span class="IASFormDivSpanLabel">
                                                    <label>Volume Number:</label>
                                                </span>
                                                <span class="IASFormDivSpanInputBox">
                                                    <select class="IASComboBox" TABINDEX="4" name="volume" id="volume" onchange="loadIssues()">
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
                                            <div class="IASFormFieldDiv">
                                                <span class="IASFormDivSpanLabel">
                                                    <label>Regeneration Date:</label>
                                                </span>
                                                <span class="IASFormDivSpanInputBox">
                                                    <input class="IASDateTextBox" TABINDEX="-1" readonly type="text" name="mlCreationDate" id="mlCreationDate" value="<jsp:getProperty name="mlFormBean" property="mlCreationDate"/>"/>
                                                </span>
                                            </div>                                            
                                        </div>
                                    </div>
                                    <div class="actionBtnDiv">
                                        <input class="IASButton" TABINDEX="5" type="button" value="Check" id="btnCheck" name="btnCheck" onclick="checkViewMl()"/>
                                        <input class="IASButton" TABINDEX="5" type="button" value="View Mailing List" id="btnSearch" name="btnSearchRate" onclick="search()"/>
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

                            <fieldset class="subMainFieldSet">
                                <div class="IASFormFieldDiv">
                                    <div class="IASFormLeftDiv">
                                        <div class="IASFormFieldDiv">
                                            <span class="IASFormDivSpanLabel">
                                                <label>No Header</label>
                                            </span>
                                            <span class="IASFormDivSpanInputBox">
                                                <input class="IASCheckBox" TABINDEX="9" type="checkbox" name="noHeader" id="noHeader"/>
                                            </span>
                                        </div>
                                    </div>
                                    <div class="IASFormRightDiv">
                                        <div class="IASFormFieldDiv">
                                            <span class="IASFormDivSpanLabel">
                                                <label>Periodicals</label>
                                            </span>
                                            <span class="IASFormDivSpanInputBox">
                                                <input class="IASCheckBox" TABINDEX="9" type="checkbox" name="periodicals" id="periodicals"/>
                                            </span>
                                        </div>
                                    </div>
                                </div>
                            </fieldset>

                            <%-----------------------------------------------------------------------------------------------------%>
                            <%-- Journal Actions Field Set --%>
                            <%-----------------------------------------------------------------------------------------------------%>

                            <input type="hidden" name="action" id="action"/>
                            <fieldset class="subMainFieldSet">
                                <div class="actionBtnDiv">
                                   <div id="printMedium">
                                        <span class="IASFormDivSpanLabel">
                                            <label>Print option</label>
                                        </span>
                                        <span class="IASFormDivSpanInputBox">
                                         <select class="IASComboBox" TABINDEX="6" name="printOption" id="printOption">
                                            <option value ="O">India 1 Copy</option>
                                            <option value ="E">India Extra</option>
                                            <option value ="F">Foreign</option>
                                         </select>
                                        </span>
                                    </div>
                                    <input class="IASButton" TABINDEX="6" type="submit" value="Print Label" id="btnPrintLabel" name="btnPrintLabel" onclick="printLabel()"/>
                                    <input class="IASButton" TABINDEX="7" type="submit" value="Print Sticker" id="btnPrintSticker" name="btnPrintSticker" onclick="printSticker()"/>
                                    <input class="IASButton" TABINDEX="8" type="reset" value="Reset"/>
                                </div>
                            </fieldset>
                    </fieldset>
                </div>
            </form>
        </div>
    </body>
</html>
