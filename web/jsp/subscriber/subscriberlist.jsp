<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <jsp:include page="../templates/style.jsp"></jsp:include>
        <script type="text/javascript" src="<%=request.getContextPath()%>/js/city.js"></script>
        <title>Search Subscriber</title>
        <script>
            window.returnValue=null;
            var subscriber = window.dialogArguments;
            var selectedSubscriberId = null;
            var selectedsubscriber;
            
            $(document).ready(function(){
                // search subscriber when ENTER key is pressed
                setEnterKeyAction(searchSubscriber);
                loadCities("<%=request.getContextPath() + "/cities"%>");
                jdsAutoComplete("<%=request.getContextPath() + "/subscriber?action=depts"%>", "department", "department"); 
            });                       
            
            $(function(){
                $("#subscriberList").jqGrid({
                    url:"<%=request.getContextPath() + "/subscriber?action=search"%>",
                    postData:{
                        city            : subscriber.city,
                        subscriberName  : subscriber.name,
                        country         : subscriber.country,
                        state           : subscriber.state,
                        pincode         : subscriber.pincode,
                        institution     : subscriber.institution,
                        department      : subscriber.department,
                        email           : subscriber.email
                    },
                    datatype: 'xml',
                    mtype: 'GET',
                    width: '100%',
                    height: 280,
                    autowidth: true,
                    forceFit: true,
                    sortable: true,
                    loadonce: false,
                    rownumbers: true,
                    emptyrecords: "No subscribers to view",
                    loadtext: "Loading...",
                    colNames:['Select','Subscriber Number','Subscriber Name', 'Department','Institute','City','Pin Code','Country', 'Email'],
                    colModel :[
                        {name:'Select', index:'select', width:15, align:'center',xmlmap:'subscriberNumber'
                            /*formatter:function (cellvalue, options, rowObject) {
                                return '<input onclick="selectedSubscriberId=this.value" type="radio" id="selectedSubscriberRadio" name="selectedSubscriberRadio" value="' + cellvalue + '"/>';
                            }*/
                        },
                        {name:'SubscriberNumber', index:'subscriberNumber', width:35, align:'center', sortable:false, xmlmap:'subscriberNumber'},
                        {name:'SubscriberName', index:'subscriberName', width:50, align:'center', sortable:false, xmlmap:'subscriberName'},
                        {name:'Department', index:'department', width:45, align:'center', sortable:false, xmlmap:'department'},
                        {name:'Instituttion', index:'institute', width:45, align:'center', sortable:false, xmlmap:'institution'},
                        {name:'City', index:'city', width:30, align:'center', sortable: true, sorttype: 'int',xmlmap:'city'},
                        {name:'PinCode', index:'pincode', width:20, align:'center', sortable:false, xmlmap:'pincode'},
                        {name:'Country', index:'country', width:20, align:'center', sortable:false, xmlmap:'country'},
                        {name:'Email', index:'email', width:50, align:'center',sortable:false, xmlmap:'email'}
                    ],
                    xmlReader : {
                        root: "results",
                        row: "row",
                        page: "results>page",
                        total: "results>total",
                        records : "results>records",
                        repeatitems: false,
                        id: "subscriberNumber"
                    },
                    pager: '#pager',
                    rowNum:15,
                    rowList:[15,30, 50],
                    viewrecords: true,
                    gridview: true,
                    caption: '&nbsp;',
                    onSelectRow: function(rowid, status, e){
                        selectedSubscriberId = rowid;
                    },

                    gridComplete: function() {
                        var ids = jQuery("#subscriberList").jqGrid('getDataIDs');
                        for (var i = 0; i < ids.length; i++) {
                            var cl = ids[i];
                            action = "<input type='radio' name='selectedSubscriberRadio' id='selectedSubscriberRadio'" + " value=" + "\"" + cl + "\"" + " onclick='selectedSubscriberId=this.value'" + "/>";
                            jQuery("#subscriberList").jqGrid('setRowData', ids[i], { Select: action });
                        }
                    }
                });
            });

            function CheckReturnValue(){
                selectedsubscriber = jQuery("#subscriberList").getRowData(selectedSubscriberId);
                window.returnValue = selectedsubscriber;
            }
            
            // called when the search button is clicked
            function searchSubscriber(){
                if(validateSearchSubscriber()){                    
                    jQuery("#subscriberList").setGridParam({mtype: 'POST',postData:
                            {city               : $("#city").val(),
                            department          : $("#department").val(),
                            subscriberNumber    : $("#subscriberNumber").val(),
                            subscriberName      : $("#subscriberName").val(),
                            pincode             : $("#pincode").val()
                        }});
                    jQuery("#subscriberList").trigger("clearGridData");
                    jQuery("#subscriberList").trigger("reloadGrid");
                }

            }
            
            function validateSearchSubscriber(){
                if(isEmptyValue($("#city").val()) && 
                    isEmptyValue($("#department").val()) &&
                    isEmptyValue($("#subscriberName").val()) &&
                    isEmptyValue($("#subscriberNumber").val()) &&                    
                    isEmptyValue($("#pincode").val())){
                    alert("Please fill in at least one field to search for subscriber");
                    return false;
                }
                return true;
            }
                        
        </script>

    </head>
    <body onunload="return CheckReturnValue()">
        <div class="MainDiv">
            <div class="subMainDiv">
                <fieldset class="MainFieldset">
                    <legend>Search Subscriber Result</legend>
                    <fieldset class="subMainFieldSet">
                        <legend>Search Criteria</legend>
                        <form method="post" action="" name="searchSubscriberForm">
                            <div class="IASFormLeftDiv">
                                <div class="IASFormFieldDiv">
                                    <span class="IASFormDivSpanLabel">
                                        <label>Subscriber Number:</label>
                                    </span>
                                    <span class="IASFormDivSpanInputBox">
                                        <input class="IASTextBox" maxlength="11" TABINDEX="1" type="text" name="subscriberNumber" id="subscriberNumber" value=""/>
                                    </span>
                                </div>
                                <div class="IASFormFieldDiv">
                                    <span class="IASFormDivSpanLabel">
                                        <label>Subscriber Name:</label>
                                    </span>
                                    <span class="IASFormDivSpanInputBox">
                                        <input class="IASTextBoxWide" TABINDEX="2" type="text" name="subscriberName" id="subscriberName" value=""/>
                                    </span>
                                </div>
                                <div class="IASFormFieldDiv">
                                    <span class="IASFormDivSpanLabel">
                                        <label>City:</label>
                                    </span>
                                    <span class="IASFormDivSpanInputBox">
                                        <input class="IASTextBox" TABINDEX="3" name="city" id="city" value=""/>        
                                    </span>
                                </div>

                            </div>
                            <div class="IASFormRightDiv">
                                <div class="IASFormFieldDiv">
                                    <span class="IASFormDivSpanLabel">
                                        <label>Department:</label>
                                    </span>
                                    <span class="IASFormDivSpanInputBox">
                                        <input class="IASTextBoxWide" TABINDEX="4" type="text" name="department" id="department" value=""/>
                                    </span>
                                </div>

                                <div class="IASFormFieldDiv">
                                    <span class="IASFormDivSpanLabel">
                                        <label>Pin Code:</label>
                                    </span>
                                    <span class="IASFormDivSpanInputBox">
                                        <input class="IASTextBox" maxlength="6" TABINDEX="5" type="text" name="pincode" id="pincode" value=""/>
                                    </span>
                                </div>
                            </div>
                            <div class="actionBtnDiv">
                                <input class="IASButton" TABINDEX="6" type="button" value="Search" onclick="searchSubscriber()" id="btnSearchSubscriber"/>
                                <input class="IASButton" TABINDEX="7" type="reset" value="Reset"/>
                            </div>
                    </fieldset>
                    </form>                    
                    <fieldset class="subMainFieldSet">
                        <legend>Subscriber List</legend>
                        <table class="datatable" id="subscriberList"></table>
                        <div id="pager"></div>
                    </fieldset>

                    <fieldset class="subMainFieldSet">
                        <div class="actionBtnDiv">
                            <input class="IASButton" TABINDEX="8" type="button" onclick="window.returnValue=selectedSubscriberId;window.close()" value="OK" name="btnOk"/>
                            <input class="IASButton" TABINDEX="9" type="button" value="Cancel" name="btnCancel" onclick="window.close()"/>
                        </div>
                    </fieldset>
                </fieldset>
            </div>
        </div>
    </body>
</html>