<%--
    Document   : Print Back Issue List
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="../templates/style.jsp" %>
        <link rel="stylesheet" type="text/css" href="css/report/listBackIssue.css" />

        <title>Print Back Issue List</title>
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
                        colNames:['Subscriber Id','Subscriber Name','Subscriber Type','Journal/s','No. Of Copies','Month','Year','City','Pin Code','Country','Email'],
                        colModel :[
                          {name:'subscriberId', index:'subscriber_id', width:50, align:'center', xmlmap:'subscriber_Id'},
                          {name:'subscriberName', index:'subscriber_id', width:50, align:'center', xmlmap:'subscriber_name'},
                          {name:'SubType', index:'subscriber_id', width:50, align:'center', xmlmap:'sub_type'},
                          {name:'journal', index:'subscriber_id', width:50, align:'center', xmlmap:'journal'},
                          {name:'noOfCopies', index:'subscriber_id', width:50, align:'center', xmlmap:'no_of_copies'},
                          {name:'month', index:'subscriber_id', width:50, align:'center', xmlmap:'month'},                          
                          {name:'year', index:'subscriber_id', width:50, align:'center', xmlmap:'year'},
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
            <form method="post" action="" name="listBackIssueForm">
                <div class="MainDiv">
                    <fieldset class="MainFieldset">
                        <legend>Print Back Issue List</legend>

                        <%-----------------------------------------------------------------------------------------------------%>
                        <%-- Search Criteria Field Set --%>
                        <%-----------------------------------------------------------------------------------------------------%>
                     <fieldset class="subMainFieldSet">
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
                                    <label>Month</label>
                                </span>
                                <span class="IASFormDivSpanInputBox">
                                 <select class="IASComboBox" TABINDEX="6" name="month" id="month">
                                    <option value ="1">Jan</option>
                                    <option value ="2">Feb</option>
                                    <option value ="3">Mar</option>
                                    <option value ="4">Apr</option>
                                    <option value ="5">May</option>
                                    <option value ="6">Jun</option>
                                    <option value ="7">Jul</option>
                                    <option value ="8">Aug</option>
                                    <option value ="9">Sep</option>
                                    <option value ="10">Oct</option>
                                    <option value ="11">Nov</option>
                                    <option value ="12">Dec</option>
                                 </select>
                                </span>
                            </div>
                            <div class="IASFormFieldDiv">
                                <span class="IASFormDivSpanLabel">
                                    <label>Year</label>
                                </span>
                                <span class="IASFormDivSpanInputBox">
                                 <select class="IASComboBox" TABINDEX="6" name="Year" id="Year">
                                    <option value ="1">2009</option>
                                    <option value ="2">2010</option>
                                    <option value ="3">2011</option>
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