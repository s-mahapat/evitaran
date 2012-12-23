/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
var current_total = 0;
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
        cellsubmit: 'remote',
        emptyrecords: "No Records to view",
        loadtext: "Loading...",
        //subGrid: true,
        //subGridWidth: 20,
        //subgridtype: 'xml',
        //subGridUrl: 'subscription?oper=detail&subtypeid=' + $("#subtypeid").val(),
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
            formatoptions: {decimalPlaces: 1, thousandsSeparator: ""}
        },
        {
            name:'amountPaid',
            index:'amountPaid',
            width:60,
            align:'center',
            xmlmap:'amountPaid',
            formatter: "currency",
            formatoptions: {decimalPlaces: 1, thousandsSeparator: ""}
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
                        var payment = parseFloat($("#paymentTable").jqGrid('getCell', rowid, 'amountPaid'));

                        var new_balance = balance - value;
                        var new_payment = payment + value;

                        //set the balance since we are not refreshing the grid
                        $("#paymentTable").jqGrid('setCell', rowid, 'balance', new_balance)

                        //update the payment on the UI since we are not refreshing the UI
                        $("#paymentTable").jqGrid('setCell', rowid, 'amountPaid', new_payment)

                        // set the remarks as part/full payment
                        if(value == balance){
                            $("#paymentTable").jqGrid('setCell', rowid, 'remarks', 'Full Payment');
                        }else if(value < balance){
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
            formatoptions: {decimalPlaces: 1, thousandsSeparator: ""}
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
        beforeSubmitCell: function(rowid, cellname, value, iRow, iCol){
            var remarks = $("#paymentTable").jqGrid('getCell', rowid, 'remarks');
            var subscriptionid = $("#paymentTable").jqGrid('getCell', rowid, 'subscriptionID');
            var inwardid = $("#inwardID").val();
            return {
                subscriptionid: subscriptionid,
                remarks: remarks,
                inwardid: inwardid
            };

        },
        afterSubmitCell: function(serverresponse, rowid, cellname, value, iRow, iCol){
            if($(serverresponse.responseText).find("success").text() == "false"){
                return [false, "Failed to update payment"];
            }else{
                /*$("#paymentTable").setGridParam({
                    datatype: "xml"
                });
                $("#paymentTable").trigger('reloadGrid');*/
                return [true, ""];
            }

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
        //var payment_value = parseInt(c);
        current_total = current_total + value;
        if(current_total > inward_amount){
            restoreRow(rowid);
            success = false;
            msg = "The total payment " + current_total + " amount exceeds the inward amount " + inward_amount;
        }
    }

    return [success, msg];
}

function restoreRow(rowid){
    $("#paymentTable").jqGrid('restoreRow', rowid);
}