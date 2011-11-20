/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */


function makeReadOnly(){

    document.getElementById("btnEditInward").disabled = true;
    document.getElementById("btnSendAck").disabled = true;
    document.getElementById("btnSendReturn").disabled = true;
    document.getElementById("receiptNumber").disabled = true;
    document.getElementById("checkReturn").disabled = true;
    document.getElementById("checkReturnReason").disabled = true;
    document.getElementById("checkReturnReasonOther").disabled = true;



    //document.getElementById("paymentDate").setAttribute('readonly', 'true');




}
