function setSubmitButtonValue(button,value){
    button.value = value;
}

function listSubscription(mode){
    var lastSel;
    var editable = false;
    if (mode=="Display"){
        hrefText = "View";
        editable = false;
    }else{
        hrefText = "Edit";
        editable = true;
    }
    $(function(){
        //$("#subscriptionDetailDiv").hide();
        $("#subscriptionList").jqGrid({
            url:'/JDS/subscription?oper=getsubscription&subscriberNumber=' + $("#subscriberNumber").val(),
            //data: "subscriberNumber=" + $("#subscriberNumber").val(),
            datatype: 'xml',
            mtype: 'GET',
            height: 240,
            autowidth: true,
            forceFit: true,
            sortable: true,
            loadonce: true,
            rownumbers: true,
            sortname:'subscriptionID',
            emptyrecords: "No subscription(s) to view",
            loadtext: "Loading...",
            colNames:['Subscription Id','Inward No','Subscription Date','Subscription Value','Amount Paid', 'Balance','Refund','Currency','Details'],
            colModel :[
            {
                name:'subscriptionID',
                index:'id',
                width:25,
                align:'center',
                xmlmap:'id'
            },
            {
                name:'inwardNumber',
                index:'inwardNumber',
                width:20,
                align:'center',
                xmlmap:'inwardNumber'
            },

            {
                name:'subscriptionDate',
                index:'subscriptionDate',
                width:30,
                align:'center',
                xmlmap:'subscriptionDate'
            },
            {
                name:'subscriptionValue',
                index:'subscriptionValue',
                width:40,
                align:'center',
                xmlmap:'subscriptionTotal'
            },
            {
                name:'amountPaid',
                index:'amountPaid',
                width:20,
                align:'center',
                xmlmap:'amount'
            },

            {
                name:'balance',
                index:'balance',
                width:20,
                align:'center',
                xmlmap:'balance'
            },

            {
                name:'refund',
                index:'refund',
                width:20,
                align:'center',
                xmlmap:'refund'
            },
            {
                name:'currency',
                index:'currency',
                width:15,
                align:'center',
                xmlmap:'currency'
            },
            {
                name:'details',
                index:'details',
                width:15,
                align:'center'
            }],
            xmlReader : {
                root: "results",
                row: "row",
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

                var ids = jQuery("#subscriptionList").jqGrid('getDataIDs');
                for (var i = 0; i < ids.length; i++) {
                    action = "<a style=\"color:blue\" href=\"#subdetails\" onclick=\"getSubscriptionDetails(" + ids[i] + ")\">" + hrefText + "</a>";
                    jQuery("#subscriptionList").jqGrid('setRowData', ids[i], {
                        "details": action
                    });
                }

            //To hide the column - Delete
            /*var myGrid = $('#subscriptionList');
                var colPos = 6;
                var cm = myGrid.getGridParam("colModel");

                if (mode=="Display") {
                    myGrid.jqGrid('hideCol', cm[colPos].name);
                }*/
            }
        });

        $("#subscriptionDetail").jqGrid({

            url : '',
            datatype: 'xml',
            mtype: 'GET',
            height: 180,
            altRows: false,
            autowidth: true,
            //width: '100%',
            //shrinkToFit: true,
            forceFit: true,
            sortable: true,
            loadonce: true,
            rownumbers: true,
            viewrecords: true,
            gridview: true,
            caption: '&nbsp;',
            emptyrecords: "No subscription details",
            loadtext: "Loading...",
            colNames:['Journal Code','Journal Name','Journal Cost','Start Year','End Year','Copies','Discount','Total'],
            colModel: [
            {
                name:"journalCode",
                index:"journalCode",
                align:"center",
                width:60,
                key:true
            },
            {
                name:"journalName",
                index:"journalName",
                width:140,
                align:"center",
                xmlmap: 'journalName'
            },
            {
                name:"journalCost",
                index:"journalCost",
                align:"center",
                width:60
            },
            {
                name:'startYear',
                index:'startYear',
                width:60,
                align:'center',
                xmlmap:'startYear'
            },

            {
                name:'endYear',
                index:'endYear',
                width:60,
                align:'center',
                xmlmap:'endYear'
            },
            {
                name:"Copies",
                index:"Copies",
                width:60,
                align:"center",
                xmlmap: 'copies',
                editable:editable,
                edittype:'text',
                editrules:{
                    required: true,
                    integer: true,
                    minValue: 1
                }
            },
            {
                name:"Discount",
                index:"Discount",
                width:60,
                align:"center"
            },
            {
                name:"Total",
                index:"Total",
                width:60,
                align:"center"
            }],
            xmlReader : {
                root: "results",
                row: "row",
                repeatitems: false,
                id: "id"
            },
            pager: '#pager2',
            rowNum:15,
            rowList:[15,30,60],
            onSelectRow: function(id){
                if(id && id!==lastSel){
                    jQuery('#subscriptionDetail').restoreRow(lastSel);
                    lastSel=id;
                }
                jQuery('#subscriptionDetail').editRow(id,{
                    keys: true,
                    url: '',
                    succesfunc: function(){},
                    oneditfunc: function() {
                    //alert ("edited");
                    },
                    errorfunc: function(id,response){
                        alert("Error is saving subscription details");
                    }
                });
            }
        });
    });

}

function getSubscriptionDetails(subscriptionId){
    //$("#subscriptionDetailDiv").show();

    jQuery("#subscriptionDetail").setGridParam({
        datatype: 'xml',
        url: 'subscription?oper=detail&id=' + subscriptionId
    });

    jQuery("#subscriptionDetail").trigger("reloadGrid");
//alert(subscriptionId);
}