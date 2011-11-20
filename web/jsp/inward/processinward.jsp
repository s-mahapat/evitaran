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

        <title>Search Inward</title>

        <%--------------------------------------------------------------%>
        <%-- Calendar --%>
        <%--------------------------------------------------------------%>
        <script src="js/CalendarPopup.js" type="text/javascript"></script>
        <script type="text/javascript">
            //var calPopup = new CalendarPopup("dateDiv");
            //calPopup.showNavigationDropdowns();
            var selectedInward = 0;
            var selectedSubscriberId = 0;
            var isPageLoaded = false;
            $(function(){

                      $("#inwardTable").jqGrid({
                        url:'/JDS/jsp/inward/inwards.jsp',
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
                        colNames:['Inward No','Subscriber Id', 'From','Received Date','City','Cheque#','Purpose'],
                        colModel :[
                          {name:'Inward No', index:'inward_id', width:50, align:'center', xmlmap:'inward_id'},
                          {name:'Subscriber Id', index:'subscriber_id', width:50, align:'center', xmlmap:'subscriber_id'},
                          {name:'From', index:'from', width:80, align:'center', xmlmap:'from'},
                          {name:'Received Date', index:'date', width:80, align:'center', sortable: true, sorttype: 'int',xmlmap:'date'},
                          {name:'City', index:'city', width:80, align:'center', sortable:false, xmlmap:'city'},
                          {name:'Cheque', index:'cheque', width:40, align:'center', xmlmap:'cheque'},
                          {name:'Purpose', index:'purpose', width:80, align:'center', xmlmap:'purpose',formatter:'showlink'},
                        ],
                        xmlReader : {
                          root: "result",
                          row: "inward",
                          page: "inwards>page",
                          total: "inwards>total",
                          records : "inwards>records",
                          repeatitems: false,
                          id: "id"
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
                                var rowData = jQuery("#inwardTable").jqGrid('getRowData',cl);
                                var inwardId = rowData['Inward No'];
                                var subscriberId = rowData['Subscriber Id'] || 0;
                                action = "<a style='color:blue;' href='inward?action=view'>View</a><a style='color:blue;' href='inward?action=edit&inward=" + inwardId + "'>Edit</a>";
                                jQuery("#inwardTable").jqGrid('setRowData', ids[i], { Purpose: action });
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

            $(function() {
                    var dates = $( "#from, #to" ).datepicker({
                            defaultDate: "+1w",
                            changeMonth: true,
                            dateFormat: 'dd/mm/yy',
                            numberOfMonths: 3,
                            onSelect: function( selectedDate ) {
                                    var option = this.id == "from" ? "minDate" : "maxDate",
                                            instance = $( this ).data( "datepicker" ),
                                            date = $.datepicker.parseDate(
                                                    instance.settings.dateFormat ||
                                                    $.datepicker._defaults.dateFormat,
                                                    selectedDate, instance.settings );
                                    dates.not( this ).datepicker( "option", option, date );
                            }
                    });
            });

            function searchInwards(){
                isPageLoaded = true;
                jQuery("#inwardTable").trigger("reloadGrid");
            }

        </script>

    </head>
    <body>
        <%@include file="../templates/layout.jsp" %>

        <div id="bodyContainer">
            <form method="post" action="" name="processInwardForm">
                <div class="MainDiv">
                    <fieldset class="MainFieldset">
                        <legend>Process Inward</legend>

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
                                        <select class="IASComboBox" TABINDEX="1" name="purpose" id="purpose">
                                            <option value ="IASAgent"> </option>
                                            <option value ="IASAgent">Create New Subscription</option>
                                            <option value ="IASAgent">Renew Subscription</option>
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
                                <div id="filterBtnDiv">
                                    <input class="IASButton" type="button" onclick="searchInwards()" value="Filter"  TABINDEX="4"/>
                                </div>

                                <div id="resetBtnDiv">
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
                    </fieldset>
                </div>
            </form>
        </div>
    </body>
</html>