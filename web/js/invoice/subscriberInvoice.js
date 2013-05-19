function drawInvoiceTable() {

    $("#invoiceTable").jqGrid({
        url: "subscriber?action=subscriberInvoice&subscriberNumber=" + $("#subscriberNumber").val(),
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
        colNames: ['Invoice ID', 'Invoice No', 'Invoice Type', 'Invoice Type ID', 'Invoice Date', 'Subscription Number', 'Invoice Amount', 'Amount Paid', 'Balance', 'Action', 'Inward No'],
        colModel: [{
            name: 'invoiceid',
            index: 'invoiceid',
            width: 50,
            align: 'center',
            xmlmap: 'invoiceID',
            hidden: true,
            key: true
        }, {
            name: 'InvoiceNo',
            index: 'invoiceNumber',
            width: 50,
            align: 'center',
            xmlmap: 'invoiceNumber'
        },

        {
            name: 'invoice_type',
            index: 'invoice_type',
            width: 60,
            align: 'center',
            xmlmap: 'invoice_type'
        },

        {
            name: 'invoice_type_id',
            index: 'invoice_type_id',
            width: 50,
            align: 'center',
            xmlmap: 'invoice_type_id',
            hidden: true
        },

        {
            name: 'InvoiceDate',
            index: 'invoiceCreationDate',
            width: 60,
            align: 'center',
            xmlmap: 'invoiceCreationDate'
        },

        {
            name: 'SubscriptionID',
            index: 'subscriptionID',
            width: 80,
            align: 'center',
            xmlmap: 'subscriptionID'
        },

        {
            name: 'InvoiceAmount',
            index: 'invoiceAmount',
            width: 40,
            align: 'center',
            xmlmap: 'invoiceAmount'
        },

        {
            name: 'AmountPaid',
            index: 'AmountPaid',
            width: 40,
            align: 'center',
            xmlmap: 'amountPaid'
        },

        {
            name: 'balance',
            index: 'balance',
            width: 40,
            align: 'center',
            xmlmap: 'balance',
            hidden: false
        }, {
            name: 'Action',
            index: 'action',
            sortable: false,
            width: 40,
            align: 'center',
            formatter: 'showlink'
        }, {
            name: 'inwardNumber',
            index: 'inwardNumber',
            width: 0,
            align: 'center',
            xmlmap: 'inwardNumber',
            hidden: true
        }, ],
        subGridModel: [{
            name: ['Payment Date', 'Payment Amount', 'Inward No', 'Inward Amount', 'Remarks'],
            width: [30, 20, 20, 20, 30],
            align: ['center', 'center', 'center', 'center', 'center'],
            mapping: ['paymentDate', 'paymentAmount', 'inwardNumber', 'inwardAmount', 'remarks'],
            params: ['invoiceid']
        }],
        xmlReader: {
            root: "results",
            row: "row",
            page: "results>page",
            total: "results>total",
            records: "results>records",
            repeatitems: false,
            id: 'invoiceid',
            subgrid: {
                root: "results",
                row: "row",
                repeatitems: false
            }
        },
        pager: '#pager_invoice',
        rowNum: 15,
        rowList: [15, 30, 50],
        viewrecords: true,
        gridview: true,
        //caption: '&nbsp;',
        gridComplete: function() {
            var ids = jQuery("#invoiceTable").jqGrid('getDataIDs');
            jdsconstants = new JDSConstants();
            for (var i = 0; i < ids.length; i++) {
                //var invoice_no = jQuery("#invoiceTable").jqGrid('getCell', ids[i], 'InvoiceNo');
                var invoice_type_id = jQuery("#invoiceTable").jqGrid('getCell', ids[i], 'invoice_type_id');
                var inward_no = jQuery("#invoiceTable").jqGrid('getCell', ids[i], 'inwardNumber');
                var inwardNumber = jQuery("#invoiceTable").jqGrid('getCell', ids[i], 'inwardNumber');
                var action = null;

                // disable the view link for Please refer list invoices and if there are no payments made
                if (invoice_type_id != jdsconstants.INVOICE_UPCOMING_YEAR_INVOICE && inwardNumber) {
                    action = '<a style="color:blue;" href="#" onclick="showInvoice(\'' + inward_no + '\',' + invoice_type_id + ')">Print</a>';
                }
                jQuery("#invoiceTable").jqGrid('setRowData', ids[i], {
                    Action: action
                });
            }
        },
        loadError: function(xhr, status, error) {
            alert("Failed getting data from server " + status);
        }
    });
}

function showInvoice(inward_no, invoice_type_id) {
    jdsconstants = new JDSConstants();
    var src = 'print/inward/' + inward_no + '/rfi';

    if (invoice_type_id == jdsconstants.INVOICE_OUTSTANDING_PAYMENT_INVOICE) {
        src = 'print/inward/' + inward_no + '/opb';
    }

    $("#iframe_invoice").attr("src", src);
    $('#invoice_dialog').dialog({
        autoOpen: true,
        draggable: true,
        resizable: true,
        title: 'Invoice',
        modal: true,
        stack: true,
        height: ($(window).height() * 0.95),
        width: ($(window).width() * 0.85),
        buttons: {

            'Close': function() {
                $(this).dialog('close');
            },
            'Email': function(){
                jdsEmail('email/inward/' + inward_no + '/opb');
            }
        // not working in FF
        /*'Print': function() {
                $(this).dialog('close');
                $("#iframe_invoice").get(0).contentWindow.print();
            }*/

        },
        open: function(){
            if($("#email").val().length == 0){
                $(":button:contains('Email')").prop("disabled", true).addClass("ui-state-disabled");
            }

        }

    });

}