<%--
    Document   : Generate and Print - Missing Issue List
    Author     : Deepali
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <jsp:include page="../templates/style.jsp"></jsp:include>
            <link rel="stylesheet" type="text/css" href="css/ml/generatebil.css"/>
            <title>Generate and Print Missing Issue List</title>
            <script type="text/javascript" src="<%=request.getContextPath() + "/js/missingissue/mil.js"%>"></script>
        <script type="text/javascript" src="<%=request.getContextPath() + "/js/common.js"%>"></script>
        <script type="text/javascript" src="js/jquery/grid.common.js"></script>


        <script type="text/javascript">
            var selectedId = 0;
            //initally set to false, after the first search the flag is set to true
            var isPageLoaded = false;

            $(document).ready(function(){
                jQuery("#btnSearch,#btnPrint").attr("disabled",true);
                reloadSubscriberNumber('g');
            });

            $(function(){

                $("#milTable").jqGrid({
                    url:"<%=request.getContextPath()%>/generatemil",
                    datatype: 'xml',
                    mtype: 'GET',
                    width: '100%',
                    height: Constants.jqgrid.HEIGHT,
                    autowidth: true,
                    forceFit: true,
                    sortable: true,
                    loadonce: true,
                    rownumbers: true,
                    emptyrecords: "No Mailing List Found",
                    loadtext: "Loading...",
                    colNames:['missing Issue Id','mailinglist id', 'Subscriber Number', 'Subscriber Name', 'Journal Code', 'Journal Name',
                        'Year', 'Volume','Issue', 'Copies'],
                    colModel :[
                        {name:'id', index:'id', width:10, align:'center', xmlmap:'id'},
                        {name:'mailinglistid', index:'mailinglistid', width:10, align:'center', xmlmap:'mailinglistid'},
                        {name:'subscriberNumber', index:'subscriberNumber', width:80, align:'center', xmlmap:'subscriberNumber'},
                        {name:'subscriberName', index:'subscriberName', width:80, align:'center', xmlmap:'subscriberName'},
                        {name:'journalCode', index:'journalCode', width:80, align:'center', xmlmap:'journalCode'},
                        {name:'journalName', index:'journalName', width:80, align:'center', xmlmap:'journalName'},
                        {name:'year', index:'year', width:80, align:'center', xmlmap:'year'},
                        {name:'volumeNo', index:'volumeNo', width:80, align:'center', xmlmap:'volumeNo'},
                        {name:'issue', index:'issue', width:80, align:'center', xmlmap:'issue'},
                        {name:'missingCopies', index:'missingCopies', width:80, align:'center', xmlmap:'missingCopies'},
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
                    editurl:"<%=request.getContextPath()%>/generatemil?action=generate",
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

            function generate(){

                if (($("#subscriberNumber").val() == 0) && (($("#to").val()) == 0 && ($("#from").val()) == 0)){
                    alert("Select Subscriber Number or Date Range");
                }

                else {
                    isPageLoaded = true;
                    jQuery("#milTable").setGridParam({postData:
                            {
                            subscriberNumber        : $("#subscriberNumber").val(),
                            to                      : $("#to").val(),
                            from                      : $("#from").val(),
                            milCreationDate          : $("#milCreationDate").val(),
                            periodicals             : $("#periodicals").length,
                            separateLabel           : $("#separateLabel").length,
                            action                  : "generate"
                        }});
                    jQuery("#milTable").setGridParam({ datatype: "xml" });
                    jQuery("#milTable").trigger("clearGridData");
                    jQuery("#milTable").trigger("reloadGrid");
                }
                jQuery("#btnPrint").attr("disabled",false);
            }

            function reloadSubscriberNumber( mode ){

                $("#subscriberNumber").empty();
                $("#subscriberNumber").text("");

                var newOption = new Option("Select", "0");
                $(newOption).html("Select");
                $("#subscriberNumber").append(newOption);
                if (mode == 'g')
                    requestURL = "CMasterData?md=subscribernumbermil";
                else
                    requestURL = "CMasterData?md=subscribernumberbil";

                jdsAppend(requestURL,"subscriberNumber","subscriberNumber");

            }

            function printLabel()
            {
                var x = "printLabel";
                $('#printType').val(x);
                printMissingInfo();
                
            }

            function printSticker()
            {
                var x = "printSticker";
                $('#printType').val(x);
                printMissingInfo();
            }

            // draw the date picker.
            jQueryDatePicker("from","to");

        </script>
    </head>
    <body>

        <%@include file="../templates/layout.jsp" %>
        <div id="bodyContainer">
            <form method="post" action="<%=request.getContextPath() + "/generatemil?action=printLabel"%>" name="milForm">
                <div class="MainDiv">
                    <fieldset class="MainFieldset">
                        <legend>Generate and Print Missing Issue List</legend>
                        <jsp:useBean class="IAS.Bean.missingissue.milFormBean" id="milFormBean" scope="request"></jsp:useBean>
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
                                <div class="IASFormFieldDiv">
                                    <div class="IASFormFieldDiv">
                                        <span class="IASFormDivSpanLabel">
                                            <label>Creation Date:</label>
                                        </span>
                                        <span class="IASFormDivSpanInputBox">
                                            <input class="IASDateTextBox" TABINDEX="-1" readonly type="text" name="milCreationDate" id="milCreationDate" value="<jsp:getProperty name="milFormBean" property="milCreationDate"/>"/>
                                        </span>
                                    </div>
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
                                        <label> to </label>
                                        <input class="IASDateTextBox" TABINDEX="6" readonly size="10" type="text" id="to" name="to"/>
                                    </span>
                                </div>
                            </div>
                            <div class="actionBtnDiv">
                                <input class="IASButton" TABINDEX="5" type="button" value="Generate" id="btnGenerate" name="btnGenerate" onclick="generate()"/>
                            </div>
                        </fieldset>

                        <%-----------------------------------------------------------------------------------------------------%>
                        <%-- Search Result Field Set --%>
                        <%-----------------------------------------------------------------------------------------------------%>
                        <fieldset class="subMainFieldSet">
                            <legend>Missing issue Table</legend>

                            <table class="datatable" id="milTable"></table>
                            <div id="pager"></div>
                        </fieldset>

                        <%-----------------------------------------------------------------------------------------------------%>
                        <%-- Journal Actions Field Set --%>
                        <%-----------------------------------------------------------------------------------------------------%>

                        <input type="hidden" name="printType" id="printType"/>
                        <input type="hidden" name="mailingids" id="mailingids"/>
                        <fieldset class="subMainFieldSet">
                            <div class="actionBtnDiv">
                                <input class="IASButton" TABINDEX="7" type="button" value="Print Label" id="btnPrintLabel" name="btnPrintLabel" onclick="printLabel()"/>
                                <input class="IASButton" TABINDEX="8" type="button" value="Print Sticker" id="btnPrintSticker" name="btnPrintSticker" onclick="printSticker()"/>
                                <input class="IASButton" TABINDEX="9" type="reset" value="Reset"/>
                            </div>
                        </fieldset>
                    </fieldset>
                </div>
            </form>
        </div>
    </body>
</html>
