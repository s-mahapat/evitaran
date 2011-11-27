<%--
    Document   : Print Subscriber Type
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="../templates/style.jsp" %>
        <link rel="stylesheet" type="text/css" href="css/report/subType.css" />
        <title>List subscriber type</title>
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
                        colNames:['Subscriber Code','Subscriber Type','Free/Paid', 'No. Of Copies','Discount(%)'],
                        colModel :[
                          {name:'SubscriberCode', index:'inward_id', width:50, align:'center', xmlmap:'subscriber_code'},
                          {name:'SubscriberType', index:'inward_id', width:50, align:'center', xmlmap:'subscriber_type'},
                          {name:'FreePaid', index:'subscriber_id', width:80, align:'center', xmlmap:'free_paid'},
                          {name:'CopiesCount', index:'from', width:80, align:'center', xmlmap:'no_of_copies'},
                          {name:'Discount', index:'date', width:80, align:'center',xmlmap:'discount'}
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
                            alert("Failed getting data from server" + status);
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
            <form method="post" action="" name="searchSubTypeForm">
                <div class="MainDiv">
                    <fieldset class="MainFieldset">
                        <legend>List and Print Subscriber Type</legend>

                        <%-----------------------------------------------------------------------------------------------------%>
                        <%-- Search Criteria Field Set --%>
                        <%-----------------------------------------------------------------------------------------------------%>
                        <fieldset class="subMainFieldSet">
                            <legend>Search Criteria</legend>

                            <%-- Search Criteria left div --%>
                            <div class="IASFormLeftDiv">


                                <div class="IASFormFieldDiv">
                                    <span class="IASFormDivSpanLabel">
                                        <label>Sub type Code:</label>
                                    </span>
                                    <span class="IASFormDivSpanInputBox">
                                        <input class="IASTextBox" TABINDEX="1" type="text" name="subTypeCode" id="subTypeCode" value=""/>
                                    </span>
                                </div>
                            </div>
                            <div class="IASFormRightDiv">
                                <div class="IASFormFieldDiv">
                                    <span class="IASFormDivSpanLabel">
                                        <label>Subscriber Type</label>
                                    </span>
                                    <span class="IASFormDivSpanInputBox">
                                        <input class="IASTextBox" TABINDEX="2" type="text" name="subType" id="subType" value=""/>
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
                            <legend>Search Result</legend>
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