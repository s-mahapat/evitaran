<%-- 
    Document   : sendReminders.jsp
    Created on : Nov 15, 2011, 8:24:51 AM
    Author     : aloko
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="../templates/style.jsp" %>
        <link rel="stylesheet" type="text/css" href="css/reminder/reminder.css" />

        <title>Send Reminders</title>


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
                        colNames:['Subscriber Id','Subscriber Name','Subscriber Type','Journal/s','No. Of Copies','Reminder date','Reminder Type','City','Pin Code','Country','Email'],
                        colModel :[
                          {name:'subscriberId', index:'subscriber_id', width:50, align:'center', xmlmap:'subscriber_Id'},
                          {name:'subscriberName', index:'subscriber_id', width:50, align:'center', xmlmap:'subscriber_name'},
                          {name:'SubType', index:'subscriber_id', width:50, align:'center', xmlmap:'sub_type'},
                          {name:'journal', index:'subscriber_id', width:50, align:'center', xmlmap:'journal'},
                          {name:'noOfCopies', index:'subscriber_id', width:50, align:'center', xmlmap:'no_of_copies'},
                          {name:'reminderDate', index:'subscriber_id', width:50, align:'center', xmlmap:'reminder_date'},                          
                          {name:'reminderType', index:'subscriber_id', width:50, align:'center', xmlmap:'reminder_type'},
                          {name:'city', index:'subscriber_id', width:50, align:'center', xmlmap:'city'},
                          {name:'country', index:'subscriber_id', width:50, align:'center', xmlmap:'country'},
                          {name:'pinCode', index:'subscriber_id', width:50, align:'center', xmlmap:'pin_code'},
                          {name:'emailId', index:'subscriber_id', width:50, align:'center', xmlmap:'email_id'}

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
            <form method="post" action="<%=request.getContextPath() + "/reminders"%>" name="reminderForm">
                <div class="MainDiv">
                    <fieldset class="MainFieldset">
                        <legend>Selection Criteria - Reminders</legend>

                        <%-----------------------------------------------------------------------------------------------------%>
                        <%-- Search Criteria Field Set --%>
                        <%-----------------------------------------------------------------------------------------------------%>
                     <fieldset class="subMainFieldSet">
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
                                    <option value ="AGE">Agent</option>
                                    <option value ="KVPY">Kishore Vaigyanik Pariyojana</option>
                                 </select>
                                </span>
                            </div>
                        </div>

                        <div class="IASFormRightDiv">

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

                        <div class="IASFormFieldDiv">
                            <div id="searchBtnDiv">
                                <input class="IASButton" TABINDEX="6" type="submit" value="Search"/>
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

                            <table class="datatable" id="datatable"></table>
                            <div id="pager"></div>
                        </fieldset>
                       
                        <fieldset class="subMainFieldSet">
                            <div class="IASFormFieldDiv">
                                <input type="hidden" name="action" id="action"/>
                                <div class="singleActionBtnDiv">
                                    <input onclick="setActionValue('next')"  class="IASButton" TABINDEX="101" type="submit" value="next" id="btnNext" name="btnSubmitAction"/>
                                </div>
                            </div>
                        </fieldset>


                    </fieldset>
                </div>
            </form>
        </div>
    </body>
</html>