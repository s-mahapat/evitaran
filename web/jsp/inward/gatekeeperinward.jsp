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

            var isPageLoaded = true;

            $(document).ready(function(){
                //set the enter key action to search
                setEnterKeyAction(searchInwards);

                // draw the date picker.
                jQueryDatePicker("from","to");
                jdsAppend("<%=request.getContextPath() + "/CMasterData?md=city"%>","city","city");

                $("#inwardTable").jqGrid({
                    url:"<%=request.getContextPath() + "/inward?action=search"%>",
                    postData:{"inwardPurpose": $("#inwardPurpose").val(),"completed": false},
                    datatype: 'xml',
                    mtype: 'GET',
                    width: '100%',
                    height: Constants.jqgrid.HEIGHT,
                    autowidth: true,
                    forceFit: true,
                    sortable: true,
                    sortorder: 'desc',
                    sortname: 'inwardCreationDate',
                    loadonce: false,
                    rownumbers: true,
                    scrollOffset: 20,
                    emptyrecords: "No inwards to view",
                    loadtext: "Loading...",
                    colNames:['Inward No','Subscriber Id', 'From','Received Date','City','Cheque#','Purpose','PurposeID','Action'],
                    colModel :[
                        /*{
                            name:'Select',
                            index:'select',
                            width:50,
                            align:'center',
                            xmlmap:'inwardNumber',
                            formatter: selectInwardFormatter
                        },*/
                        {name:'InwardNo', index:'inward_id', sortable: false,key: true, width:50, align:'center', xmlmap:'inwardNumber'},
                        {name:'SubscriberId', index:'subscriber_id', sortable: false, width:50, align:'center', xmlmap:'subscriberId'},
                        {name:'From', index:'from', sortable: false, width:80, align:'center', xmlmap:'from'},
                        {name:'ReceivedDate', index:'inwardCreationDate', sortable: true, width:80, align:'center', xmlmap:'inwardCreationDate'},
                        {name:'City', index:'city', sortable: false, width:80, align:'center', xmlmap:'city'},
                        {name:'Cheque', index:'chqddNumber', sortable: false, width:40, align:'center', xmlmap:'chqddNumber'},
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
                    rowNum:10,
                    rowList:[10,20,30],
                    viewrecords: true,
                    gridview: true,
                    caption:'&nbsp;',
                    scrollrows: true,
                    gridComplete: function() {
                        var ids = jQuery("#inwardTable").jqGrid('getDataIDs');
                        if(ids.length > 0){
                            $("#btnNext").button("enable");
                        }
                    },
                    beforeRequest: function(){
                        return isPageLoaded;
                    },
                    loadError: function(xhr,status,error){
                        alert("Failed getting data from server" + status);
                    },
                    onSelectRow: function(rowid, status, e){
                        //selectedSubscriberId = rowid;
                        var purposeId = jQuery("#inwardTable").jqGrid('getCell', rowid, "PurposeID");
                        setInwardSubscriber(rowid, purposeId);
                    }
                });
            });


            function searchInwards(){
                if(validateSearch() == true){
                    isPageLoaded = true;
                    jQuery("#inwardTable").setGridParam({ datatype: "xml" });
                    jQuery("#inwardTable").setGridParam({postData:
                            {city           : $("#city").val(),
                            inwardNumber    : $("#_inwardNumber").val(),
                            chequeNumber    : $("#chequeNumber").val(),
                            fromDate        : $("#from").val(),
                            toDate          : $("#to").val(),
                            inwardPurpose   : $("#inwardPurpose").val(),
                            completed       : false
                        }});
                    jQuery("#inwardTable").trigger("clearGridData");
                    jQuery("#inwardTable").trigger("reloadGrid");
                }else{
                    $("#btnNext").button("disable");
                }

            }

        </script>

    </head>
    <body>
        <%@include file="../templates/layout.jsp" %>
        <div id="bodyContainer">
            <%--<form method="post" action="<%=request.getParameter("next")%>" name="searchInwardForm" onsubmit="return isInwardSelected()">--%>
            <form method="post" action="inward?action=processinward" name="processInwardForm" id="processInwardForm" onsubmit="return isInwardSelected()">
                <%--<input type="hidden" id="nextAction" name ="nextAction" value="<%=request.getParameter("nextAction")%>"/>
                <input type="hidden" id="inwardPurpose" name ="inwardPurpose" value="<%=request.getParameter("inwardPurpose")%>"/>


                <input type="hidden" id="" name ="action" value="processinward"/>
                --%>
                <input type="hidden" id="inwardNumber" name ="inwardNumber" value=""/>
                <input type="hidden" id="subscriberNumber" name="subscriberNumber" value=""/>
                <input type="hidden" id="inwardPurpose" name ="inwardPurpose" value="<%=request.getParameter("inwardPurpose")%>"/>
                <input type="hidden" id="purpose" name ="purpose" value="<%=request.getParameter("purpose") != null ? request.getParameter("purpose") : ""%>"/>
                <input type="hidden" id="asf" name ="asf" value="<%=request.getParameter("asf") != null ? request.getParameter("asf") : 0%>"/>
                <input type="hidden" id="afs" name ="afs" value="<%=request.getParameter("afs") != null ? request.getParameter("afs") : 0%>"/>
                <div class="MainDiv">
                    <fieldset class="MainFieldset">
                        <legend>Search Inward</legend>

                        <%-----------------------------------------------------------------------------------------------------%>
                        <%-- Search Criteria Field Set --%>
                        <%-----------------------------------------------------------------------------------------------------%>
                        <fieldset class="subMainFieldSet">
                            <%--<legend>Search Criteria</legend>--%>

                            <%-- Search Criteria left div --%>
                            <div class="IASFormLeftDiv">


                                <div class="IASFormFieldDiv">
                                    <span class="IASFormDivSpanLabel">
                                        <label>Inward Number:</label>
                                    </span>
                                    <span class="IASFormDivSpanInputBox">
                                        <input class="IASTextBox" TABINDEX="1" type="text" id="_inwardNumber" name="_inwardNumber" value=""/>
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
                                    <button class="IASButton SearchButton" TABINDEX="6" type="button" value="Search" onclick="searchInwards()">Search</button>
                                    <input class="IASButton" TABINDEX="7" type="reset" value="Reset"/>
                                </div>
                            </div>

                        </fieldset>



                        <%-----------------------------------------------------------------------------------------------------%>
                        <%-- Search Result Field Set --%>
                        <%-----------------------------------------------------------------------------------------------------%>
                        <fieldset class="subMainFieldSet">
                            <%--<legend>Search Result</legend>--%>

                            <table class="datatable" id="inwardTable"></table>
                            <div id="pager"></div>
                        </fieldset>
                        <fieldset class="subMainFieldSet">
                            <div class="IASFormFieldDiv">
                                <div class="singleActionBtnDiv">
                                    <input class="IASButton" TABINDEX="8" type="submit" disabled value="Next" id="btnNext" name="btnNext"/>
                                </div>
                            </div>
                        </fieldset>
                    </fieldset>
                </div>
            </form>
        </div>

    </body>
</html>