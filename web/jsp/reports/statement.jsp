<%--
    Document   : List Journal - Statement
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="../templates/style.jsp" %>
        <link rel="stylesheet" type="text/css" href="css/report/statement.css" />
        <script>
            var isPageLoaded = false;

            // draw the date picker.
            jQueryDatePicker("from","to");

            $(function(){

                      $("#statementTable").jqGrid({
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
                        colNames:['Journal Code','Journal Name', 'Subscriber Type','Subscriber Count','No. Of Copies'],
                        colModel :[
                          {name:'JournalCode', index:'inward_id', width:50, align:'center', xmlmap:'journal_code'},
                          {name:'JournalName', index:'subscriber_id', width:80, align:'center', xmlmap:'journal_name'},
                          {name:'SubscriberType', index:'from', width:80, align:'center', xmlmap:'subscriber_type'},
                          {name:'SubscriberCount', index:'date', width:80, align:'center', sortable: true, sorttype: 'int',xmlmap:'subscriber_count'},
                          {name:'Copies', index:'city', width:80, align:'center', sortable:false, xmlmap:'copies'},
                        ],
                        xmlReader : {
                          root: "result",
                          row: "row",
                          page: "data>page",
                          total: "data>total",
                          records : "data>records",
                          repeatitems: false,
                          id: "journal_code"
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
                            alert("Failed getting data from server" + status);
                        }

               });

            });

            function getStatements(){
                isPageLoaded = true;
                jQuery("#statementTable").trigger("reloadGrid");
            }


        </script>
        <title>Statement</title>
    </head>
    <body>
        <%@include file="../templates/layout.jsp" %>

        <div id="bodyContainer">
            <form method="post" action="" name="statement">
                <div class="MainDiv">
                    <fieldset class="MainFieldset">
                        <legend>Statement</legend>

                        <%-----------------------------------------------------------------------------------------------------%>
                        <%-- Search Criteria Field Set --%>
                        <%-----------------------------------------------------------------------------------------------------%>
                        <fieldset class="subMainFieldSet">
                            <legend>Statement of Label for Journal</legend>

                            <%-- Search Criteria left div --%>
                            <div class="IASFormLeftDiv">

                                <div class="IASFormFieldDiv">
                                    <span class="IASFormDivSpanLabel">
                                        <label>Journal Name</label>
                                    </span>
                                    <span class="IASFormDivSpanInputBox">
                                     <select class="IASComboBox" TABINDEX="1" name="journalName" id="journalName">
                                        <option value ="P">Pramanna</option>
                                        <option value ="CS">Current Science</option>
                                        <option value ="RES">Resonance</option>
                                    </select>
                                    </span>
                                </div>

                                <div class="IASFormFieldDiv">
                                    <span class="IASFormDivSpanLabel">
                                        <label>Year</label>
                                    </span>
                                    <span class="IASFormDivSpanInputBox">
                                     <select class="IASComboBox" TABINDEX="2" name="year" id="year">
                                        <option value ="yr">2011</option>
                                    </select>
                                    </span>
                                </div>
                            </div>

                            <%-- Search Criteria Right div --%>
                            <div class="IASFormRightDiv">

                                <div class="IASFormFieldDiv">
                                    <span class="IASFormDivSpanLabel">
                                        <label>Subscriber Type</label>
                                    </span>
                                    <span class="IASFormDivSpanInputBox">
                                     <select class="IASComboBox" TABINDEX="1" name="subType" id="subType">
                                        <option value ="IP">Indian Personnel</option>
                                        <option value ="ISC">Indian Institution</option>
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
                                <div id="searchBtnDiv">
                                    <input class="IASButton" TABINDEX="3" type="button" value="Search" onclick="getStatements()"/>
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
                            <legend>Statement Result</legend>
                            <table class="datatable" id="statementTable"></table>
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