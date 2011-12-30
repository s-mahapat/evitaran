<%--
    Document   : Search Inward
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="../templates/style.jsp" %>
        <link rel="stylesheet" type="text/css" href="css/inward/inward.css" />
        <title>Select Inward</title>
        <script src="js/inward/gatekeeperinward.js" type="text/javascript"></script>
        <script src="js/inward/inward.js" type="text/javascript"></script>
        <script type="text/javascript">
            //var calPopup = new CalendarPopup("dateDiv");
            //calPopup.showNavigationDropdowns();
            var selectedInward = 0;
            var selectedSubscriberId = 0;
            var selectedInwardRowIndex = -1;
            var isPageLoaded = false;

            $(document).ready(function(){
                $("#btnNext").attr("disabled","disabled");
                // draw the date picker.
                jQueryDatePicker("from","to");
                jdsAppend("<%=request.getContextPath() + "/CMasterData?md=city"%>","city","city");
            })

            $(function(){

                $("#inwardTable").jqGrid({
                    url:"<%=request.getContextPath() + "/inward?action=search"%>",
                    datatype: 'xml',
                    mtype: 'GET',
                    width: '100%',
                    height: 240,
                    autowidth: true,
                    forceFit: true,
                    sortable: true,
                    loadonce: false,
                    rownumbers: true,
                    emptyrecords: "No inwards to view",
                    loadtext: "Loading...",
                    colNames:['Select','Inward No','Subscriber Id', 'From','Received Date','City','Cheque#','Purpose'],
                    colModel :[
                        {name:'Select', index:'select', width:50, align:'center',xmlmap:'inwardNumber'},
                        {name:'InwardNo', index:'inward_id', width:50, align:'center', xmlmap:'inwardNumber'},
                        {name:'SubscriberId', index:'subscriber_id', width:50, align:'center', xmlmap:'subscriberId'},
                        {name:'From', index:'from', width:80, align:'center', xmlmap:'from'},
                        {name:'ReceivedDate', index:'date', width:80, align:'center', xmlmap:'inwardCreationDate'},
                        {name:'City', index:'city', width:80, align:'center', xmlmap:'city'},
                        {name:'Cheque', index:'cheque', width:40, align:'center', xmlmap:'chqddNumber'},
                        {name:'Purpose', index:'purpose', width:80, align:'center', xmlmap:'inwardPurpose'},
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
                    pginput: false,
                    rowNum:10,
                    rowList:[10,20,30],
                    viewrecords: true,
                    gridview: true,
                    caption:'&nbsp;',
                    gridComplete: function() {
                        var ids = jQuery("#inwardTable").jqGrid('getDataIDs');
                        if(ids.length > 0){
                            $("#btnNext").removeAttr("disabled");
                            //$("#btnNext").
                        }
                        for (var i = 0; i < ids.length; i++) {
                            var cl = ids[i];
                            var inwardId = jQuery("#inwardTable").jqGrid('getCell',cl,'InwardNo').toString();
                            var subscriberId = jQuery("#inwardTable").jqGrid('getCell',cl,'SubscriberId').toString();
                            action = "<input type='radio' name='selectedInwardRadio'" + " value=" + "\"" + cl + "\"" + " onclick=" + "\"" + "setInwardSubscriber('" + inwardId + "','" + subscriberId + "')" + "\"" + "/>";
                            jQuery("#inwardTable").jqGrid('setRowData', ids[i], { Select: action });
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


            function searchInwards(){
                if(validateSearch() == true){
                    isPageLoaded = true;
                    jQuery("#inwardTable").setGridParam({postData:
                            {city           : $("#city").val(),
                            inwardNumber    : $("#inwardNumber").val(),
                            chequeNumber    : $("#chequeNumber").val(),
                            fromDate        : $("#from").val(),
                            toDate          : $("#to").val()
                        }});
                    jQuery("#inwardTable").trigger("clearGridData");
                    jQuery("#inwardTable").trigger("reloadGrid");
                }

            }



        </script>

    </head>
    <body>
        <%@include file="../templates/layout.jsp" %>
        <div id="bodyContainer">
            <form method="post" action="<%=request.getParameter("next")%>" name="searchInwardForm" onsubmit="return isInwardSelected()">
                <input type="hidden" id="nextAction" name ="nextAction" value="<%=request.getParameter("nextAction")%>"/>
                <div class="MainDiv">
                    <fieldset class="MainFieldset">
                        <legend>Search Inward</legend>

                        <%-----------------------------------------------------------------------------------------------------%>
                        <%-- Search Criteria Field Set --%>
                        <%-----------------------------------------------------------------------------------------------------%>
                        <fieldset class="subMainFieldSet">
                            <legend>Search Criteria</legend>

                            <%-- Search Criteria left div --%>
                            <div class="IASFormLeftDiv">


                                <div class="IASFormFieldDiv">
                                    <span class="IASFormDivSpanLabel">
                                        <label>Inward Number:</label>
                                    </span>
                                    <span class="IASFormDivSpanInputBox">
                                        <input class="IASTextBox" TABINDEX="1" type="text" name="inwardNumber" id="inwardNumber" value=""/>
                                    </span>
                                </div>


                                <div class="IASFormFieldDiv">
                                    <span class="IASFormDivSpanLabel">
                                        <label>Cheque Number:</label>
                                    </span>
                                    <span class="IASFormDivSpanInputBox">
                                        <input class="IASTextBox" TABINDEX="2" type="text" name="chequeNumber" id="chequeNumber" value=""/>
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
                                        <select class="IASComboBox" TABINDEX="4" name="city" id="city">
                                            <option value="NULL">Select</option>
                                        </select>
                                    </span>
                                </div>


                                <div class="IASFormFieldDiv">
                                    <span class="IASFormDivSpanLabel">
                                        <label>Date Range:</label>
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
                                <div class="actionBtnDiv">
                                    <input class="IASButton" TABINDEX="6" type="button" value="Search" onclick="searchInwards()"/>
                                    <input class="IASButton" TABINDEX="7" type="reset" value="Reset"/>
                                </div>
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
                        <fieldset class="subMainFieldSet">
                            <div class="IASFormFieldDiv">
                                <div class="singleActionBtnDiv">
                                    <input class="IASButton" TABINDEX="8" type="submit" value="Next" id="btnNext" name="btnNext"/>
                                </div>
                            </div>
                        </fieldset>
                    </fieldset>
                </div>
            </form>
        </div>

    </body>
</html>