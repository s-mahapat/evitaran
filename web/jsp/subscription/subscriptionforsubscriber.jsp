<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <jsp:include page="../templates/style.jsp"></jsp:include>
        <title>Search Subscription</title>
        <script>
            var subscriber = window.dialogArguments;
            var subscriberNumber = subscriber.Number;
            var selectedSubscriptionid = null;
            $(document).ready(function(){
                $("#subscriptionList").jqGrid({
                    url:'<%=request.getContextPath()%>/subscription?oper=getsubscription&subscriberNumber=' + subscriberNumber,
                    datatype: 'xml',
                    mtype: 'GET',
                    height: Constants.jqgrid.HEIGHT,
                    autowidth: true,
                    forceFit: true,
                    sortable: false,
                    loadonce: true,
                    rownumbers: true,
                    //sortname:'subscriptionID',
                    emptyrecords: "No subscription(s) to view",
                    loadtext: "Loading...",
                    colNames:['Select','Subscription Id','Subscription Date','Amount Paid','Subscription Value', 'Balance', 'Currency'],
                    colModel :[
                        {
                            name:'Select', 
                            index:'select', 
                            width:15, 
                            align:'center',
                            xmlmap:'id',
                            formatter: selectSubscriptionFormatter
                        },
                        {
                            name:'subscriptionID',
                            index:'id',
                            width:25,
                            align:'center',
                            xmlmap:'id',
                            sortable: false,
                            sorttype:'integer',
                            key: true
                        },
                        {
                            name:'subscriptionDate',
                            index:'subscriptionDate',
                            width:30,
                            align:'center',
                            sortable: true,
                            xmlmap:'subscriptionDate'
                        },
                        {
                            name:'amountPaid',
                            index:'amountPaid',
                            width:20,
                            align:'center',
                            sortable: false,
                            xmlmap:'amount'
                        },
                        {
                            name:'subscriptionValue',
                            index:'subscriptionValue',
                            width:30,
                            align:'center',
                            sortable: false,
                            xmlmap:'subscriptionTotal'
                        },
                        {
                            name:'balance',
                            index:'balance',
                            width:20,
                            align:'center',
                            sortable: false,
                            xmlmap:'balance'
                        },
                        {
                            name:'currency',
                            index:'currency',
                            width:15,
                            align:'center',
                            sortable: false,
                            xmlmap:'currency'
                        }
                    ],
                    xmlReader : {
                        root: "results",
                        row: "row",
                        repeatitems: false,
                        id: "id"
                    },
                    pager: '#pager',
                    rowNum:10,
                    rowList:[10,30,50],
                    viewrecords: true,
                    gridview: true,
                    caption: '&nbsp;'
                });
            });
            
            function selectSubscriptionFormatter(cellvalue, options, rowObject){
                rowid = options.rowId;
                //console.log(rowObject);
                var tagnames = ["id"];
                var tagvalues = new Array();

                for(i=0; i<tagnames.length; i++){
                    var obj = rowObject.getElementsByTagName(tagnames[i])[0];
                    if(obj.hasChildNodes()){
                        tagvalues[i] = obj.childNodes[0].nodeValue;
                    }
                }
                //var subscriptionid = tagvalues[0];
 
                action = "<input type='radio' name='selectedSubscriptionRadio' value='" + rowid + "' onclick=\"SelectSubscription(this.value)\"/>";
                return action;
            }
            
            function SelectSubscription(selectedSubscription){
                selectedSubscriptionid = selectedSubscription                
            }
        </script>

    </head>
    <body>
        <div class="MainDiv">
            <div class="subMainDiv">
                <fieldset class="MainFieldset">
                    <fieldset class="subMainFieldSet">
                        <legend>Subscription List For Subscriber</legend>
                        <table class="datatable" id="subscriptionList"></table>
                        <div id="pager"></div>
                    </fieldset>

                    <fieldset class="subMainFieldSet">
                        <div class="actionBtnDiv">
                            <input class="IASButton" TABINDEX="6" type="button" onclick="window.returnValue=selectedSubscriptionid;window.close()" value="OK" name="btnOk"/>
                            <input class="IASButton" TABINDEX="8" type="submit" value="Cancel" name="btnCancel" onclick="window.close()"/>
                        </div>
                    </fieldset>
                </fieldset>
            </div>
        </div>
    </body>
</html>