function drawReminderTable(){
    $("#remindersTable").jqGrid({
            url:"subscriber?action=reminders&subscriberNumber=" + $("#subscriberNumber").val(),
            datatype: 'xml',
            mtype: 'GET',
            width: '100%',
            height: $("#subscriberDtlsTabs").height() * 0.8,
            autowidth: true,
            forceFit: true,
            sortable: true,
            sortname: '',
            loadonce: false,
            rownumbers: true,
            emptyrecords: "No Reminders to view",
            loadtext: "Loading...",
            colNames:['Subscription ID','Balance','Reminder Type','Reminder Date','Sent Date','Medium'],
            colModel :[
                {name:'subscriptionid', index:'subscriptionid', width:50, align:'center', xmlmap:'subscriptionid'},
                {name:'balance', index:'balance', width:80, align:'center', xmlmap:'balance'},
                {name:'reminder_type', index:'rtype', width:40, align:'center', xmlmap:'rtype'},
                {name:'reminder_date', index:'rdate', sortable: false, width:60, align:'center',xmlmap:'rdate'},
                {name:'sent_date', index:'sdate', sortable: false, width:60, align:'center',xmlmap:'sdate'},
                {name:'medium', index:'medium', sortable: false, width:60, align:'center',xmlmap:'medium'}
            ],
            xmlReader : {
                root: "results",
                row: "row",
                page: "results>page",
                total: "results>total",
                records : "results>records",
                repeatitems: false,
                id: "subscriptionid"
            },
            pager: '#pager_reminders',
            rowNum:15,
            rowList:[15,30,50],
            viewrecords: true,
            gridview: true,                   
            loadError: function(xhr,status,error){
                alert("Failed getting data from server " + status);
            }
        });
}