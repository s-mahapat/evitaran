<%--
    Document   : Journal Rate - Print
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="../templates/style.jsp" %>
        <link rel="stylesheet" type="text/css" href="css/report/journalRates.css" />

        <title>Annual Rates for Journal</title>
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
                        colNames:['Id','Journal Code','Journal Name','Subscriber SubType','1 Year','2 Year','3 Year','5 Year'],
                        colModel :[
                          {name:'journalRateId', index:'journalRate_Id', width:50, align:'center', xmlmap:'journalRate_Id'},
                          {name:'journalCode', index:'journalRate_Id', width:50, align:'center', xmlmap:'journal_code'},
                          {name:'journalName', index:'journalRate_Id', width:50, align:'center', xmlmap:'journal_name'},
                          {name:'subType', index:'journalRate_Id', width:50, align:'center', xmlmap:'subType'},
                          {name:'year1', index:'journalRate_Id', width:50, align:'center', xmlmap:'year1'},
                          {name:'year2', index:'journalRate_Id', width:50, align:'center', xmlmap:'year2'},
                          {name:'year3', index:'journalRate_Id', width:50, align:'center', xmlmap:'year3'},                          
                          {name:'year5', index:'journalRate_Id', width:50, align:'center', xmlmap:'year5'},                          
                        ],
                        xmlReader : {
                          root: "result",
                          row: "row",
                          page: "data>page",
                          total: "data>total",
                          records : "data>records",
                          repeatitems: false,
                          id: "subscriber_id"
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
            <form method="post" action="" name="listJournals">
                <div class="MainDiv">
                    <fieldset class="MainFieldset">
                        <legend>List and Print Annual Rates for Journal</legend>

                        <%-----------------------------------------------------------------------------------------------------%>
                        <%-- Search Criteria Field Set --%>
                        <%-----------------------------------------------------------------------------------------------------%>
                        <fieldset class="subMainFieldSet">
                            <legend>Search Criteria</legend>

                            <%-- Search Criteria left div --%>
                            <div class="IASFormLeftDiv">

                                <div class="IASFormFieldDiv">
                                    <span class="IASFormDivSpanLabel">
                                        <label>Journal Name</label>
                                    </span>
                                    <span class="IASFormDivSpanInputBox">
                                     <select class="IASComboBox" TABINDEX="6" name="journalName" id="journalName">
                                        <option value ="P">Pramanna</option>
                                        <option value ="JAA">Journal of astrophysics and Astronomy</option>
                                        <option value ="MS">Proceedings</option>
                                        <option value ="EPS">Journal of Earth System Science</option>
                                        <option value ="CS">Journal of Chemical Sciences</option>
                                        <option value ="BMS">Bulletin of Materials Science</option>
                                        <option value ="S">Sadhana</option>
                                        <option value ="JB">Journal of Biosciences</option>
                                        <option value ="JG">Journal of Genetics</option>
                                        <option value ="CURR">Current Science</option>
                                        <option value ="RES">Resonance</option>
                                    </select>
                                    </span>
                                </div>
                                <div class="IASFormFieldDiv">
                                    <span class="IASFormDivSpanLabel">
                                        <label>Year</label>
                                    </span>
                                    <span class="IASFormDivSpanInputBox">
                                     <select class="IASComboBox" TABINDEX="6" name="year" id="year">
                                        <option value ="test1">2009</option>
                                        <option value ="test1">2010</option>
                                        <option value ="test1">2011</option>
                                        <option value ="test1">2012</option>
                                    </select>
                                    </span>
                                </div>
                            </div>

                           <%-- Search Criteria Right div --%>
                            <div class="IASFormLeftDiv">

                                <div class="IASFormFieldDiv">
                                    <span class="IASFormDivSpanLabel">
                                        <label>Subscriber Type</label>
                                    </span>
                                    <span class="IASFormDivSpanInputBox">
                                     <select class="IASComboBox" TABINDEX="6" name="subType" id="subType">
                                        <option value ="IC">Indian Schools and colleges</option>
                                        <option value ="II">Indian institutes</option>
                                        <option value ="IP">Indian Personnel</option>
                                        <option value ="IN">Indian Industry Corporate</option>
                                        <option value ="FI">Foreign Institute</option>
                                        <option value ="FP">Foreign Personnel</option>
                                     </select>
                                    </span>
                                </div>
                            </div>

                            <div class="IASFormFieldDiv">
                                <div id="searchBtnDiv">
                                    <input class="IASButton" TABINDEX="3" type="submit" value="Search"/>
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
                        <%-----------------------------------------------------------------------------------------------------%>
                        <%-- Print Button Field Set --%>
                        <%-----------------------------------------------------------------------------------------------------%>
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