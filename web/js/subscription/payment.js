/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

function drawPaymentTable(inward_amount){
    $("#paymentTable").jqGrid({
        url:'subscription?oper=getsubscription&subscriberNumber=' + $("#subscriberNumber").val(),
        datatype: 'xml',
        mtype: 'GET',
        width: '100%',
        height: 280,
        autowidth: true,
        forceFit: true,
        sortable: false,
        loadonce: true,
        rownumbers: true,
        cellEdit: true,
        cellsubmit: 'clientArray',
        emptyrecords: "No Records to view",
        loadtext: "Loading...",
        subGrid: true,
        subGridWidth: 20,
        subgridtype: 'xml',
        subGridUrl: 'subscription?oper=detail&subtypeid=' + $("#subtypeid").val(),
        colNames:['Subscription ID','Subscription Date','Subscription Total','Amount Paid','Balance','Payment'],
        colModel :[
        {
            name:'subscriptionid',
            index:'subscriptionid',
            width:50,
            align:'center',
            xmlmap:'id',
            key: true
        },

        {
            name:'subscriptionDate',
            index:'subscriptionDate',
            width:50,
            align:'center',
            xmlmap:'subscriptionDate'
        },

        {
            name:'subscriptiontotal',
            index:'subscriptiontotal',
            width:80,
            align:'center',
            xmlmap:'subscriptionTotal'
        },

        {
            name:'amountPaid',
            index:'amountPaid',
            width:40,
            align:'center',
            xmlmap:'amount'
        },

        {
            name:'balance',
            index:'balance',
            width:40,
            align:'center',
            xmlmap:'balance'
        },
        {
            name:'payment',
            index:'payment',
            width:60,
            align:'center',
            xmlmap:'payment',
            editable: true,
            edittype: 'text',
            editrules: {
                number: true,
                minValue: 0,
                maxValue: inward_amount
            }
        }
        ],
        xmlReader : {
            root: "results",
            row: "row",
            page: "results>page",
            total: "results>total",
            records : "results>records",
            repeatitems: false,
            id: "subscriptionid",
            subgrid: {
                root: "results",
                row: "row",
                repeatitems: false
            }
        },
        pager: '#pager',
        rowNum: 5,
        rowList:[5,10,20],
        viewrecords: true,
        gridview: true,
        caption: '&nbsp;',
        loadError: function(xhr,status,error){
            alert("Failed getting data from server " + status);
        },
        afterSaveCell: function(rowid, cellname, value, iRow, iCol){
            var changed_cells = $("#paymentTable").jqGrid('getChangedCells', 'dirty');
            var current_total = 0;
            for(var i=0; i<changed_cells.length; i++){
                var payment_value = parseInt(changed_cells[i].payment);
                current_total = current_total + payment_value;
            }
            if(current_total > inward_amount){
                alert("The total payment " + current_total + " amount exceeds the inward amount " + inward_amount);
                $("#paymentTable").jqGrid('restoreCell', iRow, iCol);
            }
        },
        subGridModel: [
        {
            name:['Journal Name', 'Start Year', 'End Year', 'Start Month', 'Copies', 'Active'],
            width: [120, 30, 30, 30, 30, 30],
            align: ['center','center','center'],
            mapping: ['journalGroupName','startYear','endYear','startMonth','copies','active']
            //params: ['subscriptionid'],

        }
        ]
    });

    $("#paymentTable").jqGrid('setLabel','payment','','',{
        'title':'Click on cell to edit'
    });
}
