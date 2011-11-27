<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <jsp:include page="../templates/styleforpopup.jsp"></jsp:include>
        <title>Search Subscriber</title>
        <script>
            window.returnValue=0;
            var windowShouldReturnValue = dialogArguments[0];
            var selectedSubscriberId = 0;

            $(function(){
                $(".datatable").jqGrid({
                    url:'/JDS/jsp/subscriber/subscriberlist.xml',
                    datatype: 'xml',
                    mtype: 'GET',
                    width: '100%',
                    autowidth: true,
                    forceFit: true,
                    sortable: true,
                    loadonce: true,
                    rownumbers: true,
                    emptyrecords: "No subscribers to view",
                    loadtext: "Loading...",
                    colNames:['Select','Subscriber Id','Subscriber Name', 'Department','City','Pin Code','Country', 'Email'],
                    colModel :[
                        {name:'Select', index:'select', width:15, align:'center',xmlmap:'subscriber_id',
                            formatter:function (cellvalue, options, rowObject) {
                                return '<input onclick="selectedSubscriberId=this.value" type="radio" id="selectedSubscriberRadio" name="selectedSubscriberRadio" value="' + cellvalue + '"/>';
                            }
                        },
                        {name:'Subscriber Id', index:'subscriber_id', width:20, align:'center', xmlmap:'subscriber_id'},
                        {name:'Subscriber Name', index:'subscriber_name', width:40, align:'center', xmlmap:'subscriber_name'},
                        {name:'Department', index:'dept', width:40, align:'center', xmlmap:'dept'},
                        {name:'City', index:'city', width:35, align:'center', sortable: true, sorttype: 'int',xmlmap:'city'},
                        {name:'Pin Code', index:'pincode', width:25, align:'center', sortable:false, xmlmap:'pincode'},
                        {name:'Country', index:'country', width:30, align:'center', xmlmap:'country'},
                        {name:'Email', index:'email', width:50, align:'center', xmlmap:'email'},
                    ],
                    xmlReader : {
                        root: "result",
                        row: "subscriberlist",
                        page: "subscriberlistXML>page",
                        total: "subscriberlist>total",
                        records : "subscriberlist>records",
                        repeatitems: false,
                        id: "id"
                    },
                    pager: '#pager',
                    rowNum:10,
                    rowList:[10,20,30],
                    viewrecords: true,
                    gridview: true,
                    caption: '&nbsp;',

                    gridComplete: function() {
                        //var ids = jQuery(".datatable").jqGrid('getDataIDs');
                        //for (var i = 0; i < ids.length; i++) {
                        //var cl = ids[i];
                        //action = "<input type='Button' name='addToMailList' value=\"Add to Mailing List\" onclick=''/>";
                        //jQuery(".datatable").jqGrid('setRowData', ids[i], { btnAML: action });
                    }
                });
            });

            function CheckReturnValue(){
                if(windowShouldReturnValue && !window.returnValue){
                    alert("Please select a subscriber");
                    return false;
                }
            }
        </script>

    </head>
    <body onunload="return CheckReturnValue()">
        <div id="bodyContainer">
            <div class="MainDiv">
                <fieldset class="MainFieldset">
                    <legend>Search Subscriber Result</legend>

                    <fieldset class="subMainFieldSet">
                        <legend>Subscriber List</legend>
                        <table class="datatable" id="subscriberList"></table>
                        <div id="pager"></div>
                    </fieldset>


                    <%--Actions--%>

                    <fieldset class="subMainFieldSet">
                        <div class="IASFormFieldDiv">
                            <div id="okBtnDiv">
                                <input class="IASButton" TABINDEX="6" type="button" onclick="window.returnValue=selectedSubscriberId;window.close()" value="OK" name="btnOk"/>
                            </div>
                            <div id="cancelBtnDiv">
                                <input class="IASButton" TABINDEX="8" type="submit" value="Cancel" name="btnCancel" onclick="window.close()"/>
                            </div>
                        </div>
                    </fieldset>
                </fieldset>
            </div>
        </div>
    </body>
</html>