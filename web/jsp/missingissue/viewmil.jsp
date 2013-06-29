<%--
    Document   : View and Reprint - Missing Issue List
    Author     : Deepali
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <jsp:include page="../templates/style.jsp"></jsp:include>
            <link rel="stylesheet" type="text/css" href="css/ml/generatebil.css"/>
            <title>View and Reprint Missing Issue List</title>
            <script type="text/javascript" src="<%=request.getContextPath() + "/js/missingissue/generatemil.js"%>"></script>
        <script type="text/javascript" src="<%=request.getContextPath() + "/js/common.js"%>"></script>
        <script type="text/javascript" src="js/jquery/grid.common.js"></script>
        <script type="text/javascript" src="js/jquery/grid.formedit.js"></script>
        <script type="text/javascript" src="js/jquery/jquery.jqGrid.src.js"></script>
        <script type="text/javascript" src="js/jquery/jquery.jqGrid.min.js"></script>


        <script type="text/javascript">
            var selectedId = 0;
            //initally set to false, after the first search the flag is set to true
            var isPageLoaded = false;

            $(document).ready(function(){
                jQuery("#btnPrint").attr("disabled",true);
                //reloadSubscriberNumber('s');
            });

            $(function(){

                $("#milTable").jqGrid({
                    url:"<%=request.getContextPath()%>/generatemil",
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
                    colNames:['Journal Code', 'Sub. Type', 'Subscriber Number', 'Subscriber Name', 'City',
                        'State', 'Country', 'PIN code', 'Copies', 'Volume','Issue', 'Year', 'Date', 'Page Size'],
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
                        {name:'year', index:'year', width:80, align:'center', xmlmap:'year'},
                        {name:'bildate', index:'bildate', width:80, align:'center', xmlmap:'bildate'},
                        {name:'page_size', index:'page_size', width:80, align:'center', xmlmap:'page_size'},
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
                    editurl:"<%=request.getContextPath()%>/generatemil?action=search",
                    gridComplete: function() {
                        var ids = jQuery("#milTable").jqGrid('getDataIDs');
                        for (var i = 0; i < ids.length; i++) {
                            action = "<a style='color:blue;' href='generatemil?action=print&id=" + ids[i] + "'>Print</a>";
                            jQuery("#generatemil").jqGrid('setRowData', ids[i], { Action: action });
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

            //jQuery("#mlTable").jqGrid('searchGrid', {multipleSearch:true} );


            jQuery("#milTable").jqGrid('navGrid','#pager',
            // Which buttons to show
            {edit:false,add:false,del:false,search:true},
            // Edit options
            {},
            // Add options
            {},
            // Delete options
            {},
            // Search options
            {multipleGroup:true, multipleSearch:true}
        );

            function search(){

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
                            bilCreationDate          : $("#bilCreationDate").val(),
                            periodicals             : $("#periodicals").length,
                            separateLabel           : $("#separateLabel").length,
                            action                  : "search"
                        }});
                    jQuery("#milTable").setGridParam({ datatype: "xml" });
                    jQuery("#milTable").trigger("clearGridData");
                    jQuery("#milTable").trigger("reloadGrid");

                    //jQuery("#mlTable").jqGrid('searchGrid', {multipleSearch:true} );

                    jQuery("#milTable").jqGrid('navGrid','#pager',
                    // Which buttons to show
                    {edit:false,add:false,del:false,search:true},
                    // Edit options
                    {},
                    // Add options
                    {},
                    // Delete options
                    {},
                    // Search options
                    {multipleGroup:true, multipleSearch:true}
                );

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
                    requestURL = "CMasterData?md=subscribernumber";
                else
                    requestURL = "CMasterData?md=subscribernumberbil";

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

            // draw the date picker.
            jQueryDatePicker("from","to");

        </script>
    </head>
    <body>

        <%@include file="../templates/layout.jsp" %>
        <div id="bodyContainer">
            <form method="get" action="<%=request.getContextPath() + "/generatemil"%>" name="milForm">
                <div class="MainDiv">
                    <fieldset class="MainFieldset">
                        <legend>View and Reprint Missing Issue List</legend>
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
                                        <input class="IASTextBox" TABINDEX="-1" type="text" name="subscriberNumber" id="subscriberNumber"/>
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
                                <button class="IASButton SearchButton" TABINDEX="5" type="button" value="Search" id="btnSearch" name="btnSearch" onclick="search()"/>Search</button>
                            </div>
                        </fieldset>

                        <%-----------------------------------------------------------------------------------------------------%>
                        <%-- Search Result Field Set --%>
                        <%-----------------------------------------------------------------------------------------------------%>
                        <fieldset class="subMainFieldSet">
                            <legend>Missing Issue List Table</legend>

                            <table class="datatable" id="milTable"></table>
                            <div id="pager"></div>
                        </fieldset>

                        <%-----------------------------------------------------------------------------------------------------%>
                        <%-- Journal Actions Field Set --%>
                        <%-----------------------------------------------------------------------------------------------------%>

                        <input type="hidden" name="action" id="action"/>
                        <fieldset class="subMainFieldSet">
                            <div class="actionBtnDiv">
                                <input class="IASButton" TABINDEX="7" type="submit" value="Print Label" id="btnPrintLabel" name="btnPrintLabel" onclick="printLabel()"/>
                                <input class="IASButton" TABINDEX="8" type="submit" value="Print Sticker" id="btnPrintSticker" name="btnPrintSticker" onclick="printSticker()"/>
                                <input class="IASButton" TABINDEX="9" type="reset" value="Reset"/>
                            </div>
                        </fieldset>
                    </fieldset>
                </div>
            </form>
        </div>
    </body>
</html>
