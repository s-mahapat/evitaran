<%--
    Document   : Search Inward
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="../templates/style.jsp" %>
        <link rel="stylesheet" type="text/css" href="css/reports/listInward.css" />
        <title>List and Print Inward</title>
        <script type="text/javascript" src="<%=request.getContextPath() + "/js/reports/listInward.js"%>"></script>
        <script type="text/javascript">
            $(document).ready(function() {
                jdsAppend("<%=request.getContextPath() + "/CMasterData?md=country"%>","country","country");
                jdsAppend("<%=request.getContextPath() + "/CMasterData?md=state"%>","state","state");
                jdsAppend("<%=request.getContextPath() + "/CMasterData?md=city"%>","city","city");
                jdsAppend("<%=request.getContextPath() + "/CMasterData?md=purpose"%>","purpose","inwardPurpose");
                jdsAppend("<%=request.getContextPath() + "/CMasterData?md=currency"%>","currency","currency");
                jdsAppend("<%=request.getContextPath() + "/CMasterData?md=payment_mode"%>","payment_mode","paymentMode");
                jdsAppend("<%=request.getContextPath() + "/CMasterData?md=language"%>","language","language");
            });

        </script>
        <script type="text/javascript">
            var selectedInward = 0;
            var selectedSubscriberId = 0;
            //initally set to false, after the first search the flag is set to true
            var isPageLoaded = false;

            $(document).ready(function(){

                $(function(){

                    // set the default focus to inward text box.
                    $("#inwardPurpose").focus();

                    $("#inwardTable").jqGrid({
                        url:"<%=request.getContextPath() + "/reports?action=listInwards"%>",
                        datatype: 'xml',
                        mtype: 'GET',
                        width: '100%',
                        height: 240,
                        autowidth: true,
                        forceFit: true,
                        sortable: true,
                        loadonce: true,
                        //sortname: 'inwardNumber',
                        //loadonce: false,
                        rownumbers: true,
                        emptyrecords: "No inwards to view",
                        loadtext: "Loading...",
                        colNames:['Inward No','Subscriber Id', 'From','Received Date','City','Cheque#','Purpose'],
                        colModel :[
                            {name:'InwardNo', index:'inwardNumber', width:50, align:'center', xmlmap:'inwardNumber'},
                            {name:'SubscriberId', index:'subscriberId', width:50, align:'center', xmlmap:'subscriberId'},
                            {name:'From', index:'from', sortable: false, width:80, align:'center', xmlmap:'from'},
                            {name:'ReceivedDate', index:'inwardCreationDate', width:80, align:'center', xmlmap:'inwardCreationDate'},
                            {name:'City', index:'city', width:80, align:'center', xmlmap:'city'},
                            {name:'Cheque', index:'chqddNumber', width:40, align:'center', xmlmap:'chqddNumber'},
                            {name:'Purpose', index:'inwardPurpose', width:80, align:'center', xmlmap:'inwardPurpose'},
                        ],
                        xmlReader : {
                            root: "results",
                            row: "row",
                            page: "results>page",
                            total: "results>total",
                            records : "results>records",
                            repeatitems: false,
                            id: "inwardNumber"
                        },
                        pager: '#pager',
                        rowNum:10,
                        rowList:[10,20,30],
                        viewrecords: true,
                        gridview: true,
                        caption: '&nbsp;',
                        gridComplete: function() {
                            var ids = jQuery("#inwardTable").jqGrid('getDataIDs');
                            if(ids.length > 0){
                                $("#printReportBtn").button("enable");
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

            // called when the search button is clicked
            function searchInwards(){
                jQuery("#inwardTable").setGridParam({ datatype: "xml" });
                if(validateSearch() == true){
                    isPageLoaded = true;
                    jQuery("#inwardTable").setGridParam({postData:
                            {city           : $("#city").val(),
                            country         : $("#country").val(),
                            state           : $("#state").val(),
                            fromDate        : $("#from").val(),
                            toDate          : $("#to").val(),
                            inwardPurpose   : $("#inwardPurpose").val(),
                            paymentMode     : $("#paymentMode").val(),
                            currency        : $("#currency").val(),
                            language        : $("#language").val()
                        }});
                    jQuery("#inwardTable").trigger("clearGridData");
                    jQuery("#inwardTable").trigger("reloadGrid");

                }

            }

            // draw the date picker.
            jQueryDatePicker("from","to");

        </script>

    </head>
    <body>
        <%@include file="../templates/layout.jsp" %>

        <div id="bodyContainer">
            <form method="post" action="<%=request.getContextPath() + "/reports?action=printInwardsList"%>" name="listInwardForm">
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
                                        <label>Purpose:</label>
                                    </span>
                                    <span class="IASFormDivSpanInputBox">
                                        <select class="IASComboBox" TABINDEX="1" name="inwardPurpose" id="inwardPurpose">
                                            <option value="0">Select</option>
                                        </select>
                                    </span>
                                </div>
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
                                        <select class="IASComboBox" TABINDEX="4" name="city" id="city">
                                            <option value="0">Select</option>
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
                                        <label>Mode Of Payment:</label>
                                    </span>
                                    <span class="IASFormDivSpanInputBox">
                                        <select class="IASComboBox" TABINDEX="7" name="paymentMode" id="paymentMode">
                                            <option value="0">Select</option>
                                        </select>
                                    </span>
                                </div>
                                <div class="IASFormFieldDiv">
                                    <span class="IASFormDivSpanLabel">
                                        <label>Currency:</label>
                                    </span>
                                    <span class="IASFormDivSpanInputBox">
                                        <select class="IASComboBox" TABINDEX="8" name="currency" id="currency">
                                            <option value="">Select</option>
                                        </select>
                                    </span>
                                </div>
                                <div class="IASFormFieldDiv">
                                    <span class="IASFormDivSpanLabel">
                                        <label>Language:</label>
                                    </span>
                                    <span class="IASFormDivSpanInputBox">
                                        <select class="IASComboBox" TABINDEX="9" name="language" id="language">
                                            <option value="">Select</option>
                                        </select>
                                    </span>
                                </div>
                            </div>
                            <div class="actionBtnDiv">
                                <input class="IASButton" TABINDEX="10" type="button" value="Search" onclick="searchInwards()"/>
                                <input class="IASButton" TABINDEX="11" type="reset" value="Reset"/>
                            </div>

                        </fieldset>



                        <%-----------------------------------------------------------------------------------------------------%>
                        <%-- Search Result Field Set --%>
                        <%-----------------------------------------------------------------------------------------------------%>
                        <fieldset class="subMainFieldSet">
                            <legend>Search Result</legend>

                            <table class="datatable" id="inwardTable"></table>
                            <div id="pager"></div>
                        </fieldset>
                    </fieldset>

                        <%-----------------------------------------------------------------------------------------------------%>
                        <%-- SPrint Button Field Set --%>
                        <%-----------------------------------------------------------------------------------------------------%>

                     <fieldset class="subMainFieldSet">
                        <div class="IASFormFieldDiv">
                            <div class="singleActionBtnDiv">
                                <%--<input class="IASButton" type="button" value="Print" onclick="javascript:window.print();"/>--%>
                                <input class="IASButton" type="submit" value="Print" disabled id="printReportBtn"/>
                            </div>
                        </div>
                    </fieldset>
                </div>
            </form>
        </div>
    </body>
</html>