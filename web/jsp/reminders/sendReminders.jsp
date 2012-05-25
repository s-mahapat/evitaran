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
            $(document).ready(function(){
                 jQuery("#btnSearch, #btnPrintSend").attr("disabled",true);            

             });
             
            $(function(){

                      $("#reminderTable").jqGrid({
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
                jQuery("#reminderTable").trigger("reloadGrid");
            }
            
            function searchEnable(){
                jQuery("#btnSearch, #btnPrintSend").attr("disabled",false);
                jQuery("#btnRemind,").attr("disabled",true);
            }                

            function remindEnable(){
                jQuery("#btnSearch").attr("disabled",true);
                jQuery("#btnRemind, #btnPrintSend").attr("disabled",false);             
            }
            
            function remind(){

                if ($("#reminderType").val() == 0) {
                    alert("Select Reminder Type");
                }

                else if($("reminderDate").val() == "") {
                    alert("Please try again after logging in again ");
                }

                else {
                        isPageLoaded = true;
                        jQuery("#reminderTable").setGridParam({postData:
                                {
                                reminderType            : $("#reminderType").val(),
                                reminderDate            : $("#reminderDate").val(),
                                action                  : "generate"
                            }});
                        jQuery("#reminderTable").setGridParam({ datatype: "xml" });
                        jQuery("#reminderTable").trigger("clearGridData");
                        jQuery("#reminderTable").trigger("reloadGrid");
                    }
            }
            
        </script>

    </head>
    <body>
        <%@include file="../templates/layout.jsp" %>

        <div id="bodyContainer">
            <form method="post" action="<%=request.getContextPath() + "/reminders"%>" name="reminderForm">
                <div class="MainDiv">                    
                    <fieldset class="MainFieldset">
                        <legend>Check and Send Reminders</legend>
                        <jsp:useBean class="IAS.Bean.reminder.reminderFormBean" id="reminderFormBean" scope="request"></jsp:useBean>
                        <fieldset class="subMainFieldSet">
                            <legend>Actions - Search / Send Reminders</legend>
                                <div class="IASFormFieldDiv">
                                    <div id="searchEnableBtnDiv">
                                         <input class="IASButton" TABINDEX="5" type="button" value="Display Sent Reminders" id="btnSearchEnable" name="btnSearchEnable" onclick="searchEnable()"/>
                                    </div>                                          
                                    <div id="reminderEnableBtnDiv">
                                         <input class="IASButton" TABINDEX="6" type="button" value="Send New Reminders" id="btnReminderEnable" name="btnReminderEnable" onclick="remindEnable()"/>
                                    </div>   
                                 </div>
                        </fieldset>                        
                        
                        <%-----------------------------------------------------------------------------------------------------%>
                        <%-- Search Criteria Field Set --%>
                        <%-----------------------------------------------------------------------------------------------------%>
                     <fieldset class="subMainFieldSet">
                         <legend>Selection Criteria - Reminders</legend>
                        <div class="IASFormLeftDiv">
                            <div class="IASFormFieldDiv">
                                <span class="IASFormDivSpanLabel">
                                    <label>Reminder Type</label>
                                </span>
                                <span class="IASFormDivSpanInputBox">
                                 <select class="IASComboBox" TABINDEX="6" name="reminderType" id="reminderType">
                                    <option value ="1">Type 1 Reminder - Gentle</option>
                                    <option value ="2">Type 2 Reminder - Strong</option>
                                    <option value ="3">Type 3 Reminder - Harsh</option>
                                 </select>
                                </span>                                
                            </div>     
                            <div class="IASFormFieldDiv">
                                <span class="IASFormDivSpanLabel">
                                    <label>Reminder Date:</label>
                                </span>
                                <span class="IASFormDivSpanInputBox">
                                    <input class="IASDateTextBox" TABINDEX="-1" readonly type="text" name="reminderDate" id="reminderDate" value="<jsp:getProperty name="reminderFormBean" property="reminderDate"/>"
                                </span>
                            </div>  
                        </div>
                        <div class="IASFormRightDiv">
                            <div class="IASFormFieldDiv">
                                <span class="IASFormDivSpanLabel">
                                    <label>Medium</label>
                                </span>
                                <span class="IASFormDivSpanInputBox">
                                 <select class="IASComboBox" TABINDEX="6" name="remType" id="remType">
                                    <option value ="E">Email Only</option>
                                    <option value ="P">Print Only</option>
                                    <option value ="A">Print All</option>
                                 </select>
                                </span>
                            </div>
                        </div>
                      </fieldset>
                        <fieldset class="subMainFieldSet">
                            <legend>Actions - Search / Send</legend>
                                <div class="IASFormFieldDiv">
                                    <div id="searchBtnDiv">
                                         <input class="IASButton" TABINDEX="5" type="button" value="Display" id="btnSearch" name="btnSearch" onclick="search()"/>
                                    </div>                                          
                                    <div id="remindBtnDiv">
                                         <input class="IASButton" TABINDEX="6" type="button" value="Generate" id="btnRemind" name="btnRemind" onclick="remind()"/>
                                    </div>   
                                 </div>
                        </fieldset> 

                        <%-----------------------------------------------------------------------------------------------------%>
                        <%-- Search Result Field Set --%>
                        <%-----------------------------------------------------------------------------------------------------%>
                       <fieldset class="subMainFieldSet">
                            <legend>Result</legend>

                            <table class="reminderTable" id="reminderTable"></table>
                            <div id="pager"></div>
                        </fieldset>
                       
                        <fieldset class="subMainFieldSet">
                            <div class="IASFormFieldDiv">
                                <div id="printSendBtnDiv">
                                    <input class="IASButton" TABINDEX="4" type="button" value="Sent/ Print Reminder" id="btnPrintSend" name="btnPrintSend" onclick="printLabel()"/>
                                </div>                                       
                                <div id="cancelBtnDiv">
                                    <input class="IASButton" TABINDEX="4" type="reset" value="Reset"/>
                                </div>
                            </div>
                        </fieldset>

                    </fieldset>
                </div>
            </form>
        </div>
    </body>
</html>