<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <jsp:include page="../templates/style.jsp"></jsp:include>
        <title>Search Subscriber</title>
        <script>
            window.returnValue=0;
            var subscriber = window.dialogArguments;
            var selectedSubscriberId = 0;

            $(function(){
                $("#subscriberList").jqGrid({
                    url:"<%=request.getContextPath() + "/subscriber?action=search"%>",
                    postData:{
                        city            : subscriber.city,
                        subscriberName  : subscriber.name,
                        country         : subscriber.country,
                        state           : subscriber.state
                    },
                    datatype: 'xml',
                    mtype: 'GET',
                    width: '100%',
                    height: 240,
                    autowidth: true,
                    forceFit: true,
                    sortable: true,
                    loadonce: true,
                    rownumbers: true,
                    emptyrecords: "No subscribers to view",
                    loadtext: "Loading...",
                    colNames:['Select','Subscriber Id','Subscriber Name', 'Department','City','Pin Code','Country', 'Email'],
                    colModel :[
                        {name:'Select', index:'select', width:15, align:'center',xmlmap:'subscriberNumber'
                            /*formatter:function (cellvalue, options, rowObject) {
                                return '<input onclick="selectedSubscriberId=this.value" type="radio" id="selectedSubscriberRadio" name="selectedSubscriberRadio" value="' + cellvalue + '"/>';
                            }*/
                        },
                        {name:'Subscriber Number', index:'subscriberNumber', width:40, align:'center', xmlmap:'subscriberNumber'},
                        {name:'Subscriber Name', index:'subscriberName', width:40, align:'center', xmlmap:'subscriberName'},
                        {name:'Department', index:'department', width:40, align:'center', xmlmap:'department'},
                        {name:'City', index:'city', width:30, align:'center', sortable: true, sorttype: 'int',xmlmap:'city'},
                        {name:'Pin Code', index:'pincode', width:30, align:'center', sortable:false, xmlmap:'pincode'},
                        {name:'Country', index:'country', width:30, align:'center', xmlmap:'country'},
                        {name:'Action', index:'action', width:40, align:'center',formatter:'showlink'}
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
                    rowNum:10,
                    rowList:[10,20,30],
                    viewrecords: true,
                    gridview: true,
                    caption: '&nbsp;',

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
                if(!window.returnValue){
                    alert("Please select a subscriber");
                    return false;
                }
            }
        </script>

    </head>
    <body onunload="return CheckReturnValue()">
            <div class="MainDiv">
                <div class="subMainDiv">
                    <fieldset class="MainFieldset">
                        <legend>Search Subscriber Result</legend>
                        <fieldset class="subMainFieldSet">
                            <legend>Subscriber List</legend>
                            <table class="datatable" id="subscriberList"></table>
                            <div id="pager"></div>
                        </fieldset>

                        <fieldset class="subMainFieldSet">
                            <div class="actionBtnDiv">
                                    <input class="IASButton" TABINDEX="6" type="button" onclick="window.returnValue=selectedSubscriberId;window.close()" value="OK" name="btnOk"/>
                                    <input class="IASButton" TABINDEX="8" type="submit" value="Cancel" name="btnCancel" onclick="window.close()"/>
                            </div>
                        </fieldset>
                    </fieldset>
                </div>
            </div>
    </body>
</html>