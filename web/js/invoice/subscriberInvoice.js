function drawInvoiceTable(){

    $("#invoiceTable").jqGrid({
            url:"subscriber?action=subscriberInvoice&subscriberNumber=" + $("#subscriberNumber").val(),
            datatype: 'xml',
            mtype: 'GET',
            width: '100%',
            height: 300,
            autowidth: true,
            forceFit: true,
            sortable: true,
            sortname: 'invoiceCreationDate',
            loadonce: false,
            rownumbers: true,
            //scrollOffset: 20,
            
            emptyrecords: "No invoice to view",
            loadtext: "Loading...",
            colNames:['Invoice No','Invoice Date','Subscription Number','Invoice Amount','Action'],
            colModel :[
                {name:'InvoiceNo', index:'invoiceNumber', width:50, align:'center', xmlmap:'invoiceNumber'},
                {name:'InvoiceDate', index:'invoiceCreationDate', width:60, align:'center', xmlmap:'invoiceCreationDate'},
                {name:'SubscriptionID', index:'subscriptionID', width:80, align:'center', xmlmap:'subscriptionID'},
                {name:'InvoiceAmount', index:'invoiceAmount', width:40, align:'center', xmlmap:'invoiceAmount'},
                {name:'Action', index:'action', sortable: false, width:60, align:'center',formatter:'showlink'}
            ],
            xmlReader : {
                root: "results",
                row: "row",
                page: "results>page",
                total: "results>total",
                records : "results>records",
                repeatitems: false,
                id: "invoiceNumber"
            },
            pager: '#pager_invoice',
            rowNum:15,
            rowList:[15,30,50],
            viewrecords: true,
            gridview: true,
            //caption: '&nbsp;',
            gridComplete: function() {
                var ids = jQuery("#invoiceTable").jqGrid('getDataIDs');
                for (var i = 0; i < ids.length; i++) {
                    var invoiceId = ids[i];
                    action = "<a style='color:blue;' href='subscriber?action=printInvoice&invoiceNo=" + invoiceId + "'>Print</a>";
                    jQuery("#invoiceTable").jqGrid('setRowData', ids[i], { Action: action });
                }
            },            
            loadError: function(xhr,status,error){
                alert("Failed getting data from server " + status);
            }
        });
}