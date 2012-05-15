<%--
    Document   : Generate and Print - Back Issue List
    Author     : Deepali
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <jsp:include page="../templates/style.jsp"></jsp:include>
        <link rel="stylesheet" type="text/css" href="css/ml/generatebil.css"/>
        <title>Generate and Print Back Issue List</title>
        <script type="text/javascript" src="<%=request.getContextPath() + "/js/ml/generatebil.js"%>"></script>
        <script type="text/javascript" src="<%=request.getContextPath() + "/js/common.js"%>"></script>
        <script type="text/javascript" src="js/jquery/grid.common.js"></script>


        <script type="text/javascript">
            var selectedId = 0;
            //initally set to false, after the first search the flag is set to true
            var isPageLoaded = false;

            $(document).ready(function(){
                jQuery("#btnSearch,#btnPrint").attr("disabled",true);
                jdsAppend("<%=request.getContextPath() + "/CMasterData?md=subscriberNumber"%>","subscriberNumber","subscriberNumber");

             });

            $(function(){

                $("#bilTable").jqGrid({
                    url:"<%=request.getContextPath()%>/generatebil",
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
                    colNames:['id', 'journalCode', 'subtypecode', 'subscriberNumber', 'subscriberName', 'department', 'institution', 'address', 'city', 'district',
                                'state', 'country', 'pincode', 'copies', 'issue', 'month', '`year`', 'startYear', 'startMonth', 'endYear', 'endMonth'],
                    colModel :[
                        {name:'id', index:'id', width:80, align:'center', xmlmap:'id'},
                        {name:'journalCode', index:'journalCode', width:80, align:'center', xmlmap:'journalCode'},
                        {name:'subtypecode', index:'subtypecode', width:80, align:'center', xmlmap:'subtypecode'},
                        {name:'subscriberNumber', index:'subscriberNumber', width:80, align:'center', xmlmap:'subscriberNumber'},
                        {name:'subscriberName', index:'subscriberName', width:80, align:'center', xmlmap:'subscriberName'},
                        {name:'department', index:'department', width:80, align:'center', xmlmap:'department'},
                        {name:'institution', index:'institution', width:80, align:'center', xmlmap:'institution'},
                        {name:'address', index:'address', width:80, align:'center', xmlmap:'address'},
                        {name:'city', index:'city', width:80, align:'center', xmlmap:'city'},
                        {name:'district', index:'district', width:80, align:'center', xmlmap:'district'},
                        {name:'state', index:'state', width:80, align:'center', xmlmap:'state'},
                        {name:'country', index:'country', width:80, align:'center', xmlmap:'country'},
                        {name:'pincode', index:'pincode', width:80, align:'center', xmlmap:'pincode'},
                        {name:'copies', index:'copies', width:80, align:'copies', xmlmap:'copies'},
                        {name:'issue', index:'issue', width:80, align:'center', xmlmap:'issue'},
                        {name:'month', index:'month', width:80, align:'center', xmlmap:'month'},
                        {name:'year', index:'year', width:80, align:'center', xmlmap:'year'},
                        {name:'startYear', index:'startYear', width:80, align:'center', xmlmap:'startYear'},
                        {name:'startMonth', index:'startMonth', width:80, align:'center', xmlmap:'startMonth'},
                        {name:'endYear', index:'endYear', width:80, align:'center', xmlmap:'endYear'},
                        {name:'endMonth', index:'endMonth', width:80, align:'center', xmlmap:'endMonth'},
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
                    editurl:"<%=request.getContextPath()%>/generatebil?action=search",
                    gridComplete: function() {
                        var ids = jQuery("#bilTable").jqGrid('getDataIDs');
                        for (var i = 0; i < ids.length; i++) {
                            action = "<a style='color:blue;' href='generatebil?action=print&id=" + ids[i] + "'>Print</a>";
                            jQuery("#generatebil").jqGrid('setRowData', ids[i], { Action: action });
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

                if (($("#subscriberNumber").val() == 0) || ($("#selall:checked").val()) == 0 ){
                    alert("Select Subscriber Number or All pending Back isuses");
                }

                else {
                        isPageLoaded = true;
                        jQuery("#bilTable").setGridParam({postData:
                                {
                                subscriberNumber        : $("#subscriberNumber").val(),
                                selall                  : $("#selall:checked").length,
                                bilCreationDate          : $("#bilCreationDate").val(),
                                action                  : "generate"
                            }});
                        jQuery("#bilTable").setGridParam({ datatype: "xml" });
                        jQuery("#bilTable").trigger("clearGridData");
                        jQuery("#bilTable").trigger("reloadGrid");
                    }
                jQuery("#btnPrint").attr("disabled",false);
            }


            function search(){
                //check if search criteria is initial, raise alert else enable search for Records
                if (($("#subscriberNumber").val() == 0) || ($("#selall:checked").val()) == 0 ){
                    alert("Select Subscriber Number or All pending Back isuses");
                }
                else {
                        isPageLoaded = true;
                        jQuery("#bilTable").setGridParam({postData:
                                {subscriberNumber       : $("#subscriberNumber").val(),
                                year                    : $("#year").val(),
                                month                   : $("#month").val(),
                                bilCreationDate         : $("#bilCreationDate").val(),
                                action                  : "search"
                            }});

                        jQuery("#bilTable").setGridParam({ datatype: "xml" });
                        jQuery("#bilTable").trigger("clearGridData");
                        jQuery("#bilTable").trigger("reloadGrid");

                    }
                jQuery("#btnPrint").attr("disabled",false);
            }

            function searchEnable(){
                jQuery("#btnSearch, #btnPrint").attr("disabled",false);
                jQuery("#btnGenerate, #btnPrint").attr("disabled",true);
                reloadSubscriberNumber('s')
            }

            function generateEnable(){
                jQuery("#btnSearch, #btnPrint").attr("disabled",true);
                jQuery("#btnGenerate, #btnPrint").attr("disabled",false);
                reloadSubscriberNumber('g')
            }

            function reloadSubscriberNumber( mode ){

                $("#subscriberNumber").empty();
                $("#subscriberNumber").text("");

                var newOption = new Option("Select", "value");
                $(newOption).html("Select");
                $("#subscriberNumber").append(newOption);
                if (mode == 'g')
                    requestURL = "/JDS/CMasterData?md=subscribernumber";
                else
                    requestURL = "/JDS/CMasterData?md=subscribernumberbil";

                jdsAppend(requestURL,"subscriberNumber","subscriberNumber");

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
        </script>
    </head>
    <body>

        <%@include file="../templates/layout.jsp" %>
        <div id="bodyContainer">
            <form method="get" action="<%=request.getContextPath() + "/generatebil"%>" name="mlForm">
                <div class="MainDiv">
                    <fieldset class="MainFieldset">
                        <legend>Generate and Print Back Issue List</legend>
                        <jsp:useBean class="IAS.Bean.MailingList.bilFormBean" id="bilFormBean" scope="request"></jsp:useBean>
                            <fieldset class="subMainFieldSet">
                                <legend>Actions - Search / Generate Back Issue list</legend>
                                    <div class="IASFormFieldDiv">
                                        <div id="searchEnableBtnDiv">
                                             <input class="IASButton" TABINDEX="1" type="button" value="Display/ Print Back Issue List" id="btnSearchEnable" name="btnSearchEnable" onclick="searchEnable()"/>
                                        </div>
                                        <div id="generateEnableBtnDiv">
                                             <input class="IASButton" TABINDEX="2" type="button" value="Generate/ Print Back Issue List" id="btnGenerateEnable" name="btnGenerateEnable" onclick="generateEnable()"/>
                                        </div>
                                     </div>
                            </fieldset>
                            <fieldset class="subMainFieldSet">
                                <legend>Selection Criteria</legend>
                                    <%-- Search Criteria left div --%>
                                    <div class="IASFormLeftDiv">
                                            <div class="IASFormFieldDiv">
                                                <span class="IASFormDivSpanLabel">
                                                    <label>Subscriber Number</label>
                                                </span>
                                                <span class="IASFormDivSpanInputBox">
                                                    <select class="IASComboBox" TABINDEX="3" name="subscriberNumber" id="subscriberNumber">
                                                        <option value="0">Select</option>
                                                    </select>
                                                </span>
                                            </div>
                                    </div>
                                    <%-- Search Criteria right div --%>
                                    <div class="IASFormRightDiv">
                                        <div class="IASFormFieldDiv">
                                            <div class="IASFormFieldDiv">
                                                <span class="IASFormDivSpanLabel">
                                                    <label>Creation Date:</label>
                                                </span>
                                                <span class="IASFormDivSpanInputBox">
                                                    <input class="IASDateTextBox" TABINDEX="-1" readonly type="text" name="bilCreationDate" id="bilCreationDate" value="<jsp:getProperty name="bilFormBean" property="bilCreationDate"/>"/>
                                                </span>
                                            </div>
                                        </div>
                                    </div>
                            </fieldset>
                            <fieldset class="subMainFieldSet">
                                <legend>Actions - Search / Generate</legend>
                                    <div class="IASFormFieldDiv">
                                        <div id="searchBtnDiv">
                                             <input class="IASButton" TABINDEX="4" type="button" value="Display" id="btnSearch" name="btnSearch" onclick="search()"/>
                                        </div>
                                        <div id="addBtnDiv">
                                             <input class="IASButton" TABINDEX="5" type="button" value="Generate" id="btnGenerate" name="btnGenerate" onclick="generate()"/>
                                        </div>
                                     </div>
                            </fieldset>
                            <%-----------------------------------------------------------------------------------------------------%>
                            <%-- Search Result Field Set --%>
                            <%-----------------------------------------------------------------------------------------------------%>
                            <fieldset class="subMainFieldSet">
                                <legend>Mailing List Table</legend>

                                <table class="datatable" id="bilTable"></table>
                                <div id="pager"></div>
                            </fieldset>

                            <%-----------------------------------------------------------------------------------------------------%>
                            <%-- Journal Actions Field Set --%>
                            <%-----------------------------------------------------------------------------------------------------%>

                            <input type="hidden" name="action" id="action"/>

                            <fieldset class="subMainFieldSet">
                                <div class="IASFormFieldDiv">
                                    <div id="printLabelBtnDiv">
                                        <input class="IASButton" TABINDEX="6" type="submit" value="Print Label" id="btnPrintLabel" name="btnPrintLabel" onclick="printLabel()"/>
                                    </div>
                                    <div id="printStickerBtnDiv">
                                        <input class="IASButton" TABINDEX="7" type="submit" value="Print Sticker" id="btnPrintSticker" name="btnPrintSticker" onclick="printSticker()"/>
                                    </div>
                                    <div id="cancelBtnDiv">
                                        <input class="IASButton" TABINDEX="8" type="reset" value="Reset"/>
                                    </div>
                                </div>
                            </fieldset>
                    </fieldset>
                </div>
            </form>
        </div>
    </body>
</html>
