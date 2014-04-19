/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

function drawPaymenDetailstInfo(subscription_id){
    $("#paymentDetailsTable").jqGrid({
        url:'subscription',
        postData: {
            'action': 'payments',
            'id': subscription_id
        },
        datatype: 'xml',
        mtype: 'GET',
        width: '100%',
        height: Constants.jqgrid.HEIGHT,
        autowidth: true,
        forceFit: true,
        //shrinkToFit: true,
        sortable: false,
        loadonce: false,
        rownumbers: true,
        emptyrecords: "No Records to view",
        loadtext: "Loading...",
        colNames:['Invoice No','Invoice Amount','Inward Number','Inward Amount', 'Payment Amount', 'Payment Date', 'Remarks'],
        colModel :[
        {
            name:'invoiceno',
            index:'invoiceno',
            width:50,
            align:'center',
            xmlmap:'invoiceNumber'
        },
        {
            name:'invoiceAmount',
            index:'invoiceAmount',
            width:50,
            align:'center',
            xmlmap:'invoiceAmount'
        },
        {
            name:'inwardNumber',
            index:'inwardNumber',
            width:50,
            align:'center',
            xmlmap:'inwardNumber'
        },
        {
            name:'inwardAmount',
            index:'inwardAmount',
            width:50,
            align:'center',
            xmlmap:'inwardAmount',
            formatter: "currency",
            formatoptions: {
                decimalPlaces: 1,
                thousandsSeparator: ""
            }
        },
        {
            name:'paymentAmount',
            index:'paymentAmount',
            width:50,
            align:'center',
            xmlmap:'paymentAmount',
            formatter: "currency",
            formatoptions: {
                decimalPlaces: 1,
                thousandsSeparator: ""
            }
        },
        {
            name:'paymentDate',
            index:'paymentDate',
            width:40,
            align:'center',
            xmlmap:'paymentDate'
        },
        {
            name:'remarks',
            index:'remarks',
            width:40,
            align:'center',
            xmlmap:'remarks'
        }
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
        viewrecords: true,
        gridview: true,
        //caption: '&nbsp;',
        loadError: function(xhr,status,error){
            alert("Failed getting data from server " + status);
        }
    });
}