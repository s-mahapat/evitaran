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

            var isPageLoaded = false;
            $(document).ready(function(){
                $("#btnNext").button("disable");

                // fill in the inward purpose
                jdsAppend("CMasterData?md=purpose","purpose","inwardPurpose");

                $("#inwardTable").jqGrid({
                    url:"inward?action=pendinginwards",
                    datatype: 'xml',
                    mtype: 'GET',
                    width: '100%',
                    autowidth: true,
                    height: 240,
                    forceFit: true,
                    sortable: true,
                    loadonce: false,
                    rownumbers: true,
                    sortname: 'inwardCreationDate',
                    sortorder: 'desc',
                    emptyrecords: "No inwards to view",
                    loadtext: "Loading...",
                    colNames:['Select','Inward No','Subscriber Id', 'From','Received Date','City','Cheque#','Purpose','PurposeID','Action'],
                    colModel :[
                        {
                            name:'Select',
                            index:'select',
                            width:50,
                            align:'center',
                            xmlmap:'inwardNumber',
                            sortable: false,
                            formatter: selectInwardFormatter
                        },
                        {name:'InwardNo', sortable: false, index:'inward_id', width:50, align:'center', xmlmap:'inwardNumber'},
                        {name:'SubscriberId'
                            , index:'subscriber_id'
                            , width:50
                            , align:'center'
                            , sortable: false
                            , xmlmap:'subscriberId'
                            //,formatter: subscriberlink
                        },
                        {name:'From', index:'from', width:80, align:'center', xmlmap:'from'},
                        {
                            name:'ReceivedDate',
                            index:'inwardCreationDate',
                            width:80,
                            align:'center',
                            xmlmap:'inwardCreationDate'
                            //formatter:'date',

                        },
                        {name:'City', index:'city', sortable: false, width:80, align:'center', xmlmap:'city'},
                        {name:'Cheque', index:'cheque', sortable: false, width:40, align:'center', xmlmap:'chqddNumber'},
                        {name:'Purpose', index:'purpose', sortable: false, width:80, align:'center', xmlmap:'inwardPurpose'},
                        {name:'PurposeID', index:'purposeid', sortable: false, width:80, align:'center', hidden:true, xmlmap:'inwardPurposeID'},
                        {
                            name:'action',
                            index:'',
                            width:80,
                            align:'center',
                            xmlmap:'',
                            formatter: subscriberlink
                        }
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
                            $("#btnNext").button("enable");
                        }
                        /*for (var i = 0; i < ids.length; i++) {
                            var cl = ids[i];
                            var purpose = jQuery("#inwardTable").jqGrid('getCell',cl,'PurposeID').toString();
                            var inwardId = jQuery("#inwardTable").jqGrid('getCell',cl,'InwardNo').toString();
                            var subscriberId = jQuery("#inwardTable").jqGrid('getCell',cl,'SubscriberId').toString();
                            //action = "<a onclick='alert(123)' style='color:blue;' href='inward?action=processinward&inwardNumber=" + inwardId + "&subscriberNumber=" + subscriberId + "&purpose=" + purpose + "'>" + purpose + "</a>";
                            //jQuery("#inwardTable").jqGrid('setRowData', ids[i], { Purpose: action });
                            action = "<input type='radio' name='selectedInwardRadio'" + " value=" + "\"" + cl + "\"" + " onclick=" + "\"" + "setInwardSubscriber('" + inwardId + "','" + subscriberId + "','" + purpose + "')" + "\"" + "/>";
                            jQuery("#inwardTable").jqGrid('setRowData', ids[i], { Select: action });
                        }*/
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

            /*function subscriberlink(cellvalue, options, rowObject){
                rowid = options.rowId;
                var subscriberId = rowObject.childNodes[1].textContent;
                var subscriberName = rowObject.childNodes[2].textContent;
                var city = rowObject.childNodes[4].textContent;
                var inwardid = rowObject.childNodes[0].textContent
                if(isEmptyValue(subscriberId)){
                    var link = "<a href=\"#\" onclick=" + "\"" + "selectSubscriber('" + city + "','" + subscriberName + "','" + inwardid + "')" + "\"" + ">Select Subscriber</a>";
                    return link;
                }
                return "";
            }

            function selectInwardFormatter(cellvalue, options, rowObject){
                rowid = options.rowId;
                //console.log(rowObject);
                var purpose = rowObject.childNodes[7].textContent;
                var inwardId = rowObject.childNodes[0].textContent;
                var subscriberId = rowObject.childNodes[1].textContent;
                action = "<input type='radio' name='selectedInwardRadio'" + " value=" + "\"" + rowid + "\"" + " onclick=" + "\"" + "setInwardSubscriber('" + inwardId + "','" + subscriberId + "','" + purpose + "')" + "\"" + "/>";
                return action;
            }*/

        </script>

    </head>
    <body>
        <%@include file="../templates/layout.jsp" %>

        <div id="bodyContainer">
            <form method="post" action="inward?action=processinward" name="processInwardForm" onsubmit="return isInwardSelected()">
                <input type="hidden" id="inwardNumber" name ="inwardNumber" value=""/>
                <input type="hidden" id="subscriberNumber" name ="subscriberNumber" value=""/>
                <input type="hidden" id="purpose" name ="purpose" value=""/>
                <input type="hidden" id="asf" name ="asf" value="<%=request.getParameter("asf") != null ? request.getParameter("asf") : 0%>"/>
                <input type="hidden" id="afs" name ="afs" value="<%=request.getParameter("afs") != null ? request.getParameter("afs") : 0%>"/>
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