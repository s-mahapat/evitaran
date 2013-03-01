/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
function drawPaymentTable(inward_amount){
    $("#paymentTable").jqGrid({
        url:'subscriber?action=subscriberInvoice',
        postData: {
            'pending': true,
            'subscriberNumber': $("#subscriberNumber").val()
        },
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
        cellurl: 'payment',
        colNames:['Invoice No','Invoice ID','Invoice Date','Invoice Amount','Amount Paid','Payment','Balance','Remarks','Subscription ID'],
        colModel :[
        {
            name:'invoiceno',
            index:'invoiceno',
            width:50,
            align:'center',
            xmlmap:'invoiceNumber'
        },
        {
            name:'invoiceid',
            index:'invoiceid',
            width:50,
            align:'center',
            xmlmap:'invoiceID',
            key: true,
            hidden: true
        },
        {
            name:'invoiceCreationDate',
            index:'invoiceCreationDate',
            width:50,
            align:'center',
            xmlmap:'invoiceCreationDate'
        },
        {
            name:'invoiceAmount',
            index:'invoiceAmount',
            width:80,
            align:'center',
            xmlmap:'invoiceAmount',
            formatter: "currency",
            formatoptions: {
                decimalPlaces: 1,
                thousandsSeparator: ""
            }
        },
        {
            name:'amountPaid',
            index:'amountPaid',
            width:60,
            align:'center',
            xmlmap:'amountPaid',
            formatter: "currency",
            formatoptions: {
                decimalPlaces: 1,
                thousandsSeparator: ""
            }
        },
        {
            name:'payment',
            index:'payment',
            width:60,
            align:'center',
            xmlmap:'payment',
            editable: true,
            editrules: {
                custom: true,
                custom_func: function(value, colname){
                    value = parseFloat(value);
                    var rc = validateCell(value, colname, inward_amount);
                    if(rc[0] == true){
                        var rowid = $("#paymentTable").jqGrid('getGridParam', 'selrow');
                        var balance = parseFloat($("#paymentTable").jqGrid('getCell', rowid, 'balance'));
                        if(balance == value){
                            $("#paymentTable").jqGrid('setCell', rowid, 'remarks', 'Full Payment');
                        }else{
                            $("#paymentTable").jqGrid('setCell', rowid, 'remarks', 'Part Payment');
                        }
                    }
                    return rc;

                }
            }

        },
        {
            name:'balance',
            index:'balance',
            width:40,
            align:'center',
            xmlmap:'balance',
            formatter: "currency",
            formatoptions: {
                decimalPlaces: 1,
                thousandsSeparator: ""
            }
        },
        {
            name:'remarks',
            index:'remarks',
            width:80,
            align:'center',
            xmlmap:'remarks'
        },
        {
            name:'subscriptionID',
            index:'subscriptionID',
            width:50,
            align:'center',
            xmlmap:'subscriptionID',
            key: true
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
        beforeEditCell: function(){
            $("#savepayments").button("disable");
        },
        afterSaveCell: function(rowid, cellname, value, iRow, iCol){
            $("#savepayments").button("enable");
            if(isNaN(value)){
                $("#paymentTable").jqGrid('setCell', rowid, "payment", "0");
            }
        },
        beforeSaveCell: function(rowid, cellname, value, iRow, iCol){
            if(isNaN(value)){
                return 0;
            }
            return value;
        }
    });

    $("#paymentTable").jqGrid('setLabel','payment','','',{
        'title':'Click on cell to edit'
    });
}

function validateCell(value, colname, inward_amount){

    var success = true;
    var msg = "";
    //var changed_cells = $("#paymentTable").jqGrid('getChangedCells', 'dirty');
    var rowid = $("#paymentTable").jqGrid('getGridParam', 'selrow');
    var balance = parseInt($("#paymentTable").jqGrid('getCell', rowid, 'balance'));

    // check that a valid number is entered
    if(isNaN(value)){
        success = false;
        msg = "Please enter a valid number";
    }else{
        value = parseInt(value);
    }


    // the value entered should not be greater than inward amount, i.e that amount that
    // the subscriber pays
    if(value > inward_amount){
        success = false;
        msg = 'The amount entered is greater than inward amount';
    }else if(value > balance){
        // value cannot be greater than invoice balance
        msg = "The payment amount " + value + " exceeds the balance " + balance;
        success = false;
    }
    else{
        // check that sum of all amounts entered by the user does not exceed the inward amount
        var current_total = getCurrentTotal(value);
        if(current_total > inward_amount){
            restoreRow(rowid);
            success = false;
            msg = "The total payment " + current_total + " amount exceeds the inward amount " + inward_amount;
        }
    }

    return [success, msg];
}

function getCurrentTotal(paymentAmount){
    var row_ids = $("#paymentTable").jqGrid('getDataIDs');
    var currentrowid = $("#paymentTable").jqGrid('getGridParam', 'selrow');
    var total_payment_amount = 0;
    var payment_amount = 0;
    for(var i=0;i<row_ids.length; i++){
        var rowid = row_ids[i];
        if(rowid == currentrowid){
            continue;
        }
        var cellcontent = $("#paymentTable").jqGrid('getCell', rowid, "payment");
        if(isNaN(parseFloat(cellcontent))){
            payment_amount = 0;
        }else{
            payment_amount = parseFloat(cellcontent);
        }
        total_payment_amount += payment_amount;
    }
    total_payment_amount += paymentAmount;
    return total_payment_amount;
}

function restoreRow(rowid){
    $("#paymentTable").jqGrid('restoreRow', rowid);
    $("#savepayments").button("enable");
}

function SavePayments(){
    var paymentRows = $("#paymentTable").jqGrid('getChangedCells', 'all');
    var inwardid = $("#inwardID").val();
    var paymentdata = [];
    var changedRowCount = paymentRows.length;

    for (payment in paymentRows){
        var rowid = payment.id;
        var payment_made = payment.payment;
        var remarks = payment.remarks;
        paymentdata.push({
            name: "id",
            value: rowid
        });
        paymentdata.push({
            name: "remarks",
            value: remarks
        });
        paymentdata.push({
            name: "payment",
            value: payment_made
        });

    }
    if(changedRowCount > 0){
        $.ajax({
            type: 'POST',
            url: "payment?inwardid=" + inwardid,
            data: $.param(paymentdata),
            success: function(xmlResponse, textStatus, jqXHR){
                if($(xmlResponse.responseText).find("success").text() == "false"){
                    alert("Failed to save payment data");
                    restoreRow(rowid);
                }else{
                    alert("All Payments saved successfully");
                    $("#paymentForm").submit();
                }
            }
        });
    }


}