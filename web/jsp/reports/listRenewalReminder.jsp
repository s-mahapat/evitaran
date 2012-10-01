 <%--
    Document   : Print Reminder Renewal List
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="../templates/style.jsp" %>
        <link rel="stylesheet" type="text/css" href="css/report/listRenReminder.css" />

        <title>Print Reminder Renewal List</title>
        <%--------------------------------------------------------------%>
        <%-- Calendar --%>
        <%--------------------------------------------------------------%>
        <script>
            var isPageLoaded = false;
            $(function(){

                      $("#renewRemindTbl").jqGrid({
                        url:"<%=request.getContextPath() + "/reports?action=listReminder"%>",
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
                        colNames:['Subscription Id','Subscriber Type','Subscriber Number','Subscriber Name',
                            'Balance','reminder Type','Reminder date','Email'],
                        colModel :[
                          {name:'subId', index:'subId', width:10, align:'center', xmlmap:'subId'},
                          {name:'subtypecode', index:'subtypecode', width:80, align:'center', xmlmap:'subtypecode'},
                          {name:'subscriberNumber', index:'subscriberNumber', width:80, align:'center', xmlmap:'subscriberNumber'},
                          {name:'subscriberName', index:'subscriberName', width:80, align:'center', xmlmap:'subscriberName'},
                          {name:'balance', index:'balance', width:80, align:'center', xmlmap:'balance'},                       
                          {name:'reminderType', index:'subscriber_id', width:50, align:'center', xmlmap:'reminderType'},
                          {name:'reminderDate', index:'subscriber_id', width:50, align:'center', xmlmap:'reminderDate'},   
                          {name:'emailId', index:'emailId', width:50, align:'center', xmlmap:'emailId'}
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

            // called when the search button is clicked
            function getList(){
                        isPageLoaded = true;

                        jQuery("#subTypeTable").setGridParam({postData:
                                {remType             : $("#remType").val(),
                                from                : $("#from").val(),
                                to                  : $("#to").val(),
                                action              : "listReminder"
                            }});
                        jQuery("#subTypeTable").setGridParam({ datatype: "xml" });
                        jQuery("#subTypeTable").trigger("clearGridData");
                        jQuery("#subTypeTable").trigger("reloadGrid");
                   
            }
            
            // draw the date picker.
            jQueryDatePicker("from","to");
        </script>

    </head>
    <body>
        <%@include file="../templates/layout.jsp" %>

        <div id="bodyContainer">
            <form method="post" action="<%=request.getContextPath() + "/reports?action=printlistInvoice"%>" name="searchSubTypeForm">
                <div class="MainDiv">
                    <fieldset class="MainFieldset">
                        <legend>Print Reminder Renewal List</legend>

                        <%-----------------------------------------------------------------------------------------------------%>
                        <%-- Search Criteria Field Set --%>
                        <%-----------------------------------------------------------------------------------------------------%>
                     <fieldset class="subMainFieldSet">
                        <div class="IASFormLeftDiv">
                            <div class="IASFormFieldDiv">
                                <span class="IASFormDivSpanLabel">
                                    <label>Reminder Type</label>
                                </span>
                                <span class="IASFormDivSpanInputBox">
                                 <select class="IASComboBox" TABINDEX="6" name="remType" id="remType">
                                    <option value ="G">Gentle Reminder</option>
                                    <option value ="S">Strong Reminder</option>
                                    <option value ="S">Harsh Reminder</option>
                                 </select>
                                </span>
                            </div>
                        </div>

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
                        </div>  
                        <div class="IASFormFieldDiv">
                            <div id="searchBtnDiv">
                                <input class="IASButton" TABINDEX="3" type="button" onclick="getList()" value="Search"/>
                            </div>

                            <div id="resetBtnDiv">
                                <input class="IASButton" TABINDEX="7" type="reset" value="Reset"/>
                            </div>
                         </div>

                      </fieldset>



                        <%-----------------------------------------------------------------------------------------------------%>
                        <%-- Search Result Field Set --%>
                        <%-----------------------------------------------------------------------------------------------------%>
                       <fieldset class="subMainFieldSet">
                            <legend>Result</legend>

                            <table class="renewRemindTbl" id="renewRemindTbl"></table>
                            <div id="pager"></div>
                        </fieldset>
                        <%-----------------------------------------------------------------------------------------------------%>
                        <%-- Print Button Field Set --%>
                        <%-----------------------------------------------------------------------------------------------------%>
                         <fieldset class="subMainFieldSet">
                            <div class="IASFormFieldDiv">
                                <div class="singleActionBtnDiv">
                                    <input class="IASButton" type="submit" value="Print" disabled id="printReportBtn"/>
                                </div>
                            </div>
                        </fieldset>

                    </fieldset>
                </div>
            </form>
        </div>
    </body>
</html>