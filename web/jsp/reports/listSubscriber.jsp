<%--
    Document   : Search Subscriber
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <%@include file="../templates/style.jsp" %>

        <link rel="stylesheet" type="text/css" href="<%=request.getContextPath() + "/css/subscriber.css"%>"/>
        <script type="text/javascript" src="<%=request.getContextPath() + "/js/subscriber/searchsubscriber.js"%>"></script>
        <script type="text/javascript" src="js/jquery/grid.common.js"></script>
        <script type="text/javascript" src="js/jquery/grid.formedit.js"></script>
        <!--<script type="text/javascript" src="js/jquery/jquery.jqGrid.src.js"></script>-->
        <script type="text/javascript" src="js/jquery/jquery.jqGrid.min.js"></script>
        <title>Search Subscriber</title>
        <script type="text/javascript">
            $(document).ready(function() {
                jdsAppend("<%=request.getContextPath() + "/CMasterData?md=country"%>","country","country");
                jdsAppend("<%=request.getContextPath() + "/CMasterData?md=state"%>","state","state");
                jdsAppend("<%=request.getContextPath() + "/CMasterData?md=city"%>","city","city");
                jdsAppend("<%=request.getContextPath() + "/CMasterData?md=journalName"%>","journalName","journalName");
                jdsAppend("<%=request.getContextPath() + "/CMasterData?md=subscriberType"%>","subscriberType","subscriberType");
                jdsAppend("<%=request.getContextPath() + "/CMasterData?md=agent"%>","agentName","agentName");
            });
        </script>
        <script type="text/javascript">
            //initally set to false, after the first search the flag is set to true
            var isPageLoaded = false;
            $(document).ready(function (){
                $(function(){
                        $("#subscriberTable").jqGrid({
                        url:"<%=request.getContextPath() + "/reports?action=listSubscribers"%>",
                        datatype: 'xml',
                        mtype: 'GET',
                        width: '100%',
                        height: 250,
                        autowidth: true,
                        forceFit: true,
                        sortable: true,
                        loadonce: true,
                        rownumbers: true,
                        emptyrecords: "No subscribers to view",
                        loadtext: "Loading...",
                        colNames:['Subscriber Number','Subscriber Name', 'Subscriber Type', 'City','State','Country'],
                        colModel :[
                            {name:'subscriberNumber', index:'subscriberNumber', width:40, align:'center', xmlmap:'subscriberNumber', search: true},
                            {name:'subscriberName', index:'subscriberName', width:40, align:'center', xmlmap:'subscriberName', search: true},
                            {name:'subtypecode', index:'subtypecode', width:40, align:'center', xmlmap:'subtypecode'},
                            {name:'city', index:'city', width:30, align:'center', xmlmap:'city', search: true},
                            {name:'state', index:'state', width:30, align:'center', xmlmap:'state', search: true},
                            {name:'country', index:'country', width:30, align:'center', xmlmap:'country', search: true},
                          ],
                        xmlReader : {
                            root: "results",
                            row: "row",
                            page: "results>page",
                            total: "results>total",
                            records : "results>records",
                            repeatitems: false,
                            id: "subscriberNumber"
                        },
                        pager: '#pager',
                        pginput: true,
                        rowNum:10,
                        rowList:[10,20,30],
                        viewrecords: true,
                        gridview: true,
                        caption: '&nbsp;',

                        gridComplete: function() {
                            var ids = jQuery("#subscriberTable").jqGrid('getDataIDs');
                            if(ids.length > 0){
                                $("#printReportBtn").button("enable");
                                $("#btnPrintLabel").button("enable");
                                $("#btnPrintSticker").button("enable");
                            }
                        },
                        beforeRequest: function(){
                            return isPageLoaded;
                        },
                        loadError: function(xhr,status,error){
                            alert("Failed getting data from server " + status);
                        }
                    });
                });
            });

            jQuery("#subscriberTable").jqGrid('navGrid','#pager',
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

            // called when the search button is clicked
            function searchSubscriber(){
                //if(validateSearchSubscriber() == true)
                if(($("#subtype").val() == 0 && $("#nationality").val() == 0 && $("#institutional").val() == 0
                    && $("#subscriberType").val() == 0 && $("#journalGroupName").val() == 0
                    && $("#country").val() == 0) && $("#city").val() == 0 && $("#state").val() == 0)
                    alert("Atleast one search parameter should be selected");
                else
                {
                    isPageLoaded = true;
                    jQuery("#subscriberTable").setGridParam({postData:
                            {subtype            : $("#subtype").val(),
                            nationality         : $("#nationality").val(),
                            institutional       : $("#institutional").val(),
                            subscriberType      : $("#subscriberType").val(),
                            journalName         : $("#journalName").val(),
                            agentName           : $("#agentName").val(),
                            country             : $("#country").val(),
                            state               : $("#state").val(),
                            city                : $("#city").val(),
                            from                : $("#from").val(),
                            to                  : $("#to").val(),
                            selall              : $("#selall:checked").length
                        }});
                    jQuery("#subscriberTable").setGridParam({ datatype: "xml" });
                    jQuery("#subscriberTable").trigger("clearGridData");
                    jQuery("#subscriberTable").trigger("reloadGrid");

                    jQuery("#subscriberTable").jqGrid('navGrid','#pager',
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

            function printLabel()
            {
                var x = "printSubscribersLabel";
                $('#action').val(x);
            }

            function printSticker()
            {
                var x = "printSubscribersSticker";
                $('#action').val(x);
            }

            function print()
            {
                var x = "printSubscribersReport";
                $('#action').val(x);
            }
        </script>
    </head>
    <body>
        <%@include file="../templates/layout.jsp" %>

        <div id="bodyContainer">
            <form method="get" action="<%=request.getContextPath() + "/reports"%>" name="searchSubscriberForm">
                <div class="MainDiv">
                    <fieldset class="MainFieldset">
                        <legend>Search Subscriber</legend>

                        <%-----------------------------------------------------------------------------------------------------%>
                        <%-- Search Criteria Field Set --%>
                        <%-----------------------------------------------------------------------------------------------------%>
                        <fieldset class="subMainFieldSet">
                            <legend>Search Criteria</legend>

                            <%-- Search Criteria left div --%>
                            <div class="IASFormLeftDiv">


                                <div class="IASFormFieldDiv">
                                    <span class="IASFormDivSpanLabel">
                                        <label>Free/ Paid</label>
                                    </span>
                                    <span class="IASFormDivSpanInputBox">

                                        <select class="IASComboBox allusers" TABINDEX="1" name="subtype" id="subtype">
                                            <option value ="0">Select</option>
                                            <option value ="Paid">Paid</option>
                                            <option value ="Free">Free</option>
                                        </select>
                                    </span>
                                </div>

                                <div class="IASFormFieldDiv">
                                    <span class="IASFormDivSpanLabel">
                                        <label>Nationality</label>
                                    </span>
                                    <span class="IASFormDivSpanInputBox">
                                        <select class="IASComboBox allusers" TABINDEX="2" name="nationality" id="nationality">
                                            <option value ="0">Select</option>
                                            <option value ="I">Indian</option>
                                            <option value ="F">Foreign</option>
                                        </select>
                                    </span>
                                </div>

                                <div class="IASFormFieldDiv">
                                    <span class="IASFormDivSpanLabel">
                                        <label>Institutional</label>
                                    </span>
                                    <span class="IASFormDivSpanInputBox">
                                        <select class="IASComboBox allusers" TABINDEX="3" name="institutional" id="institutional">
                                            <option value ="0">Select</option>
                                            <option value ="I">Institute</option>
                                            <option value ="P">Personal</option>
                                        </select>
                                    </span>
                                </div>

                               <div class="IASFormFieldDiv">
                                    <span class="IASFormDivSpanLabel">
                                        <label>Subscriber Type</label>
                                    </span>
                                    <span class="IASFormDivSpanInputBox">
                                        <select class="IASComboBox allusers" TABINDEX="4" name="subscriberType" id="subscriberType">
                                            <option value="0" selected>Select</option>
                                        </select>
                                    </span>
                                </div>

                                <div class="IASFormFieldDiv">
                                    <span class="IASFormDivSpanLabel">
                                        <label>Journal Name:</label>
                                    </span>
                                    <span class="IASFormDivSpanInputBox">
                                        <select class="IASComboBox allusers" TABINDEX="5" name="journalName" id="journalName">
                                            <option value="0" selected>Select</option>
                                        </select>
                                    </span>
                                </div>
                                <div class="IASFormFieldDiv">
                                    <span class="IASFormDivSpanLabel">
                                        <label>Agent:</label>
                                    </span>
                                    <span class="IASFormDivSpanInputBox">
                                        <select class="IASComboBoxWide allusers" TABINDEX="10" name="agentName" id="agentName">
                                            <option value="0" selected >Select</option>
                                        </select>
                                    </span>
                                </div>
                            </div>


                            <%-- Search Criteria right div --%>
                            <div class="IASFormRightDiv">

                                <div class="IASFormFieldDiv">
                                    <span class="IASFormDivSpanLabel">
                                        <label>Country:</label>
                                    </span>
                                    <span class="IASFormDivSpanInputBox">
                                        <select class="IASComboBox allusers" TABINDEX="6" name="country" id="country">
                                            <option value="0" selected >Select</option>
                                        </select>
                                    </span>
                                </div>
                                <div class="IASFormFieldDiv">
                                    <span class="IASFormDivSpanLabel">
                                        <label>State:</label>
                                    </span>
                                    <span class="IASFormDivSpanInputBox">
                                        <select class="IASComboBox allusers" TABINDEX="7" name="state" id="state">
                                            <option value="0" selected >Select</option>
                                        </select>
                                        <%--<input class="IASTextBoxMandatory" TABINDEX="3" name="state" id="state" value="<jsp:getProperty name="inwardFormBean" property="state"/>"--%>
                                    </span>
                                </div>
                                <div class="IASFormFieldDiv">
                                    <span class="IASFormDivSpanLabel">
                                        <label>City:</label>
                                    </span>
                                    <span class="IASFormDivSpanInputBox">
                                        <select class="IASComboBox allusers" TABINDEX="8" name="city" id="city">
                                            <option value="0">Select</option>
                                        </select>
                                    </span>
                                </div>
                                <div class="IASFormFieldDiv">
                                    <span class="IASFormDivSpanLabel">
                                        <label>Date Range:</label>
                                    </span>
                                    <div class="dateDiv"></div>
                                    <span class="IASFormDivSpanInputBox">
                                        <input class="IASDateTextBox allusers" TABINDEX="9" readonly size="10" type="text" id="from" name="from"/>
                                        <label> to </label>
                                        <input class="IASDateTextBox allusers" TABINDEX="10" readonly size="10" type="text" id="to" name="to"/>
                                    </span>
                                </div>
                                <div class="IASFormFieldDiv">
                                    <span class="IASFormDivSpanLabel">
                                        <label>Only Active</label>
                                    </span>
                                    <span class="IASFormDivSpanInputBox">
                                        <input class="IASCheckBox allusers" TABINDEX="11" type="checkbox" name="selall" id="selall" onclick="getChecked()"/>
                                    </span>
                                </div>
                            </div>

                            <div class="actionBtnDiv">
                                <button class="IASButton SearchButton allusers" type="button" TABINDEX="12" onclick="searchSubscriber()"/>Search</button>
                                <input class="IASButton allusers" TABINDEX="13" type="reset" value="Reset"/>
                            </div>

                        </fieldset>

                        <fieldset class="subMainFieldSet">
                            <legend>Subscriber List</legend>
                            <table class="datatable" id="subscriberTable"></table>
                            <div id="pager"></div>
                        </fieldset>
                    </fieldset>

                        <%-----------------------------------------------------------------------------------------------------%>
                        <%-- SPrint Button Field Set --%>
                        <%-----------------------------------------------------------------------------------------------------%>
                        <input class="allusers" type="hidden" name="action" id="action"/>
                        <input class="allusers" type="hidden" name="noHeader" id="noHeader" value="on"/>
                        <input class="allusers" type="hidden" name="periodicals" id="periodicals" value="off"/>
                     <fieldset class="subMainFieldSet">
                        <div class="IASFormFieldDiv">
                            <div class="singleActionBtnDiv">
                                <%--<input class="IASButton" type="button" value="Print" onclick="javascript:window.print();"/>--%>
                                <input class="IASButton allusers" TABINDEX="14" type="submit" value="Print" disabled id="printReportBtn" onclick="print()"/>
                                <input class="IASButton" TABINDEX="15" type="submit" value="Print Label" disabled id="btnPrintLabel" name="btnPrintLabel" onclick="printLabel()"/>
                                <input class="IASButton" TABINDEX="16" type="submit" value="Print Sticker" disabled id="btnPrintSticker" name="btnPrintSticker" onclick="printSticker()"/>
                            </div>
                        </div>
                    </fieldset>
                </div>
            </form>
        </div>
    </body>
</html>