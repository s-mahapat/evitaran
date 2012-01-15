<%--
    Document   : Process Inward
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="../templates/style.jsp" %>
        <link rel="stylesheet" type="text/css" href="css/inward/inward.css" />
        <script type="text/javascript" src="<%=request.getContextPath() + "/js/inward/processinward.js"%>"></script>
        <script type="text/javascript" src="<%=request.getContextPath() + "/js/inward/inward.js"%>"></script>
        <title>Pending Inwards</title>
        <script type="text/javascript">
            //var calPopup = new CalendarPopup("dateDiv");
            //calPopup.showNavigationDropdowns();
            var selectedInward = 0;
            var selectedSubscriberId = "";
            var selectedInwardPurpose = "";
            var isPageLoaded = false;
            $(function(){
                $("#btnNext").attr("disabled","disabled");

                // fill in the inward purpose
                jdsAppend("<%=request.getContextPath() + "/CMasterData?md=purpose"%>","purpose","inwardPurpose");

                $("#inwardTable").jqGrid({
                    url:"<%=request.getContextPath() + "/inward?action=pendinginwards"%>",
                    datatype: 'xml',
                    mtype: 'GET',
                    width: '100%',
                    autowidth: true,
                    height: 240,
                    forceFit: true,
                    sortable: true,
                    loadonce: true,
                    rownumbers: true,
                    emptyrecords: "No inwards to view",
                    loadtext: "Loading...",
                    colNames:['Select','Inward No','Subscriber Id', 'From','Received Date','City','Cheque#','Purpose','PurposeID'],
                    colModel :[
                        {name:'Select', index:'select', width:50, align:'center',xmlmap:'inwardNumber'},
                        {name:'InwardNo', index:'inward_id', width:50, align:'center', xmlmap:'inwardNumber'},
                        {name:'SubscriberId', index:'subscriber_id', width:50, align:'center', xmlmap:'subscriberId'},
                        {name:'From', index:'from', width:80, align:'center', xmlmap:'from'},
                        {name:'ReceivedDate', index:'date', width:80, align:'center', xmlmap:'inwardCreationDate'},
                        {name:'City', index:'city', width:80, align:'center', xmlmap:'city'},
                        {name:'Cheque', index:'cheque', width:40, align:'center', xmlmap:'chqddNumber'},
                        {name:'Purpose', index:'purpose', width:80, align:'center', xmlmap:'inwardPurpose'},
                        {name:'PurposeID', index:'purposeid', width:80, align:'center', hidden:true, xmlmap:'inwardPurposeID'}
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
                    rowNum: 10,
                    rowList:[10,30,50,100],
                    viewrecords: true,
                    gridview: true,
                    caption: '&nbsp;',
                    gridComplete: function() {
                        var ids = jQuery("#inwardTable").jqGrid('getDataIDs');
                        if(ids.length > 0){
                            $("#btnNext").removeAttr("disabled");
                        }
                        for (var i = 0; i < ids.length; i++) {
                            var cl = ids[i];
                            var purpose = jQuery("#inwardTable").jqGrid('getCell',cl,'PurposeID').toString();
                            var inwardId = jQuery("#inwardTable").jqGrid('getCell',cl,'InwardNo').toString();
                            var subscriberId = jQuery("#inwardTable").jqGrid('getCell',cl,'SubscriberId').toString();
                            //action = "<a onclick='alert(123)' style='color:blue;' href='inward?action=processinward&inwardNumber=" + inwardId + "&subscriberNumber=" + subscriberId + "&purpose=" + purpose + "'>" + purpose + "</a>";
                            //jQuery("#inwardTable").jqGrid('setRowData', ids[i], { Purpose: action });
                            action = "<input type='radio' name='selectedInwardRadio'" + " value=" + "\"" + cl + "\"" + " onclick=" + "\"" + "setInwardSubscriber('" + inwardId + "','" + subscriberId + "','" + purpose + "')" + "\"" + "/>";
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

            // jquery date picker
            jQueryDatePicker("from", "to");

            // called when the search button is clicked
            function searchInwards(){
                if(validateSearch() == true){
                    isPageLoaded = true;
                    jQuery("#inwardTable").setGridParam({ datatype: "xml" });
                    jQuery("#inwardTable").setGridParam({postData:
                            {inwardPurpose  : $("#inwardPurpose").val(),
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
            <form method="post" action="" name="processInwardForm" onsubmit="return isInwardSelected()">
                <div class="MainDiv">
                    <fieldset class="MainFieldset">
                        <legend>Pending Inwards</legend>

                        <%-----------------------------------------------------------------------------------------------------%>
                        <%-- Search Criteria Field Set --%>
                        <%-----------------------------------------------------------------------------------------------------%>
                        <fieldset class="subMainFieldSet">
                            <legend>Filter Criteria</legend>

                            <%-- Search Criteria left div --%>
                            <div class="IASFormLeftDiv">

                                <div class="IASFormFieldDiv">
                                    <span class="IASFormDivSpanLabel">
                                        <label>Purpose:</label>
                                    </span>
                                    <span class="IASFormDivSpanInputBox">
                                        <select class="IASComboBoxWide" TABINDEX="1" name="inwardPurpose" id="inwardPurpose">
                                            <option value ="NULL">Select</option>
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
                                    <input class="IASButton" type="button" onclick="searchInwards()" value="Filter"  TABINDEX="4"/>
                                    <input class="IASButton" type="reset" value="Reset"  TABINDEX="5"/>
                                </div>
                            </div>
                        </fieldset>



                        <%-----------------------------------------------------------------------------------------------------%>
                        <%-- Search Result Field Set --%>
                        <%-----------------------------------------------------------------------------------------------------%>
                        <fieldset class="subMainFieldSet">
                            <legend>Inwards</legend>

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