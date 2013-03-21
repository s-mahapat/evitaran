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
        scrollOffset: 20,
        emptyrecords: "No invoice to view",
        loadtext: "Loading...",
        subGrid: true,
        subGridWidth: 20,
        subgridtype: 'xml',
        subGridUrl: 'Invoice?action=paymentinfo',
        colNames:['Invoice ID','Invoice No','Invoice Type','Invoice Type ID','Invoice Date','Subscription Number','Invoice Amount','Amount Paid','Balance','Action'],
        colModel :[
        {
            name:'invoiceid',
            index:'invoiceid',
            width:50,
            align:'center',
            xmlmap:'invoiceID',
            hidden: true,
            key: true
        },
        {
            name:'InvoiceNo',
            index:'invoiceNumber',
            width:50,
            align:'center',
            xmlmap:'invoiceNumber'
        },

        {
            name:'invoice_type',
            index:'invoice_type',
            width:60,
            align:'center',
            xmlmap:'invoice_type'
        },

        {
            name:'invoice_type_id',
            index:'invoice_type_id',
            width:50,
            align:'center',
            xmlmap:'invoice_type_id',
            hidden: true
        },

        {
            name:'InvoiceDate',
            index:'invoiceCreationDate',
            width:60,
            align:'center',
            xmlmap:'invoiceCreationDate'
        },

        {
            name:'SubscriptionID',
            index:'subscriptionID',
            width:80,
            align:'center',
            xmlmap:'subscriptionID'
        },

        {
            name:'InvoiceAmount',
            index:'invoiceAmount',
            width:40,
            align:'center',
            xmlmap:'invoiceAmount'
        },

        {
            name:'AmountPaid',
            index:'AmountPaid',
            width:40,
            align:'center',
            xmlmap:'amountPaid'
        },

        {
            name:'balance',
            index:'balance',
            width:40,
            align:'center',
            xmlmap:'balance',
            hidden: false
        },

        {
            name:'Action',
            index:'action',
            sortable: false,
            width:40,
            align:'center',
            formatter:'showlink'
        }
        ],
        subGridModel:[
        {
            name: ['Payment Date', 'Payment Amount', 'Inward No', 'Inward Amount', 'Remarks'],
            width: [30, 20, 20, 20, 30],
            align: ['center', 'center', 'center', 'center', 'center'],
            mapping: ['paymentDate', 'paymentAmount', 'inwardNumber', 'inwardAmount', 'remarks'],
            params: ['invoiceid']
        }],
        xmlReader : {
            root: "results",
            row: "row",
            page: "results>page",
            total: "results>total",
            records : "results>records",
            repeatitems: false,
            id: 'invoiceid',
            subgrid: {
                root: "results",
                row: "row",
                repeatitems: false
            }
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
                var invoice_no = jQuery("#invoiceTable").jqGrid('getCell', ids[i], 'InvoiceNo');
                var invoice_type_id = jQuery("#invoiceTable").jqGrid('getCell', ids[i], 'invoice_type_id');
                var action = null;

                // disable the view link for Please refer list invoices
                if(invoice_type_id != 3){
                    action = '<a style="color:blue;" href="subscriber?action=printInvoice&invoiceNo=' + invoice_no + '">View</a>';
                }
                jQuery("#invoiceTable").jqGrid('setRowData', ids[i], {
                    Action: action
                });
            }
        },
        loadError: function(xhr,status,error){
            alert("Failed getting data from server " + status);
        }
    });
}
