<%--
    Document   : Circulation Figure for Journal
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="../templates/style.jsp" %>
        <link rel="stylesheet" type="text/css" href="css/report/circulationFigures.css" />
        <title>Circulation Figures</title>
        <script>
            var isPageLoaded = false;
            $(function(){

                      $("#datatable").jqGrid({
                        url:'',
                        datatype: 'xml',
                        mtype: 'GET',
                        width: '100%',
                        height: 240,
                        autowidth: true,
                        forceFit: true,
                        sortable: true,
                        loadonce: true,
                        rownumbers: true,
                        emptyrecords: "No records to view",
                        loadtext: "Loading...",
                        colNames:['Journal Code','Journal Name', 'Inst. India','Inst. Abroad','Indi. India','Indi. Abroad','Comp','Auth','Total Copies','Print Order','Balance Copies'],
                        colModel :[
                          {name:'JournalCode', index:'inward_id', width:50, align:'center', xmlmap:'journal_code'},
                          {name:'JournalName', index:'subscriber_id', width:50, align:'center', xmlmap:'journal_name'},
                          {name:'InstIndia', index:'subscriber_id', width:50, align:'center', xmlmap:'inst_india'},
                          {name:'InstAbroad', index:'subscriber_id', width:50, align:'center', xmlmap:'inst_abroad'},
                          {name:'IndiIndia', index:'subscriber_id', width:50, align:'center', xmlmap:'indi_india'},
                          {name:'IndiAbroad', index:'subscriber_id', width:50, align:'center', xmlmap:'indi_abroad'},
                          {name:'Comp', index:'subscriber_id', width:50, align:'center', xmlmap:'comp'},
                          {name:'Auth', index:'subscriber_id', width:50, align:'center', xmlmap:'auth'},
                          {name:'TotalCopies', index:'subscriber_id', width:50, align:'center', xmlmap:'total_copies'},
                          {name:'PrintOrder', index:'subscriber_id', width:50, align:'center', xmlmap:'print_order'},
                          {name:'BalanceCopies', index:'subscriber_id', width:50, align:'center', xmlmap:'balance_copies'}

                        ],
                        xmlReader : {
                          root: "result",
                          row: "row",
                          page: "data>page",
                          total: "data>total",
                          records : "data>records",
                          repeatitems: false,
                          id: "journal_id"
                       },
                        pager: '#pager',
                        rowNum:10,
                        rowList:[10,20,30],
                        viewrecords: true,
                        gridview: true,
                        caption: '&nbsp;',
                        beforeRequest: function(){
                          return isPageLoaded;
                        },
                        loadError: function(xhr,status,error){
                            alert("Failed getting data from server: " + status);
                        }
               });

            });

            function getReport(){
                isPageLoaded = true;
                jQuery("#datatable").trigger("reloadGrid");
            }
        </script>
    </head>
    <body>
        <%@include file="../templates/layout.jsp" %>

        <div id="bodyContainer">
            <form method="post" action="" name="circulationFigures">
                <div class="MainDiv">
                    <fieldset class="MainFieldset">
                        <legend>Statement of Label for Journal</legend>

                        <%-----------------------------------------------------------------------------------------------------%>
                        <%-- Search Criteria Field Set --%>
                        <%-----------------------------------------------------------------------------------------------------%>
                        <fieldset class="subMainFieldSet">
                            <legend>Select Year</legend>

                            <%-- Search Criteria left div --%>
                            <div class="IASFormLeftDiv">


                                <div class="IASFormFieldDiv">
                                    <span class="IASFormDivSpanLabel">
                                        <label>Year</label>
                                    </span>
                                    <span class="IASFormDivSpanInputBox">
                                     <select class="IASComboBox" TABINDEX="6" name="year" id="year">
                                        <option value ="test1">2011</option>
                                    </select>
                                    </span>
                                </div>
                            </div>

                            <div class="IASFormFieldDiv">
                                <div id="searchBtnDiv">
                                    <input class="IASButton" TABINDEX="3" type="button" onclick="getReport()" value="Search"/>
                                </div>

                                <div id="resetBtnDiv">
                                    <input class="IASButton" TABINDEX="4" type="reset" value="Reset"/>
                                </div>
                            </div>

                        </fieldset>



                        <%-----------------------------------------------------------------------------------------------------%>
                        <%-- Search Result Field Set --%>
                        <%-----------------------------------------------------------------------------------------------------%>
                        <fieldset class="subMainFieldSet">
                            <legend>Result</legend>

                            <table class="datatable" id="datatable"></table>
                            <div id="pager"></div>
                        </fieldset>
                        <fieldset class="subMainFieldSet">
                            <div class="IASFormFieldDiv">
                                <div class="singleActionBtnDiv">
                                    <input class="IASButton" type="button" value="Print" onclick="javascript:window.print();"/>
                                </div>
                            </div>
                        </fieldset>
                    </fieldset>
                </div>
            </form>
        </div>
    </body>
</html>