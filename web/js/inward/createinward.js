/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */


function makeReadOnly(){

    document.getElementById("btnEditInward").disabled = true;
    document.getElementById("btnSendAck").disabled = true;
    document.getElementById("btnSendReturn").disabled = true;
    document.getElementById("receiptNumber").disabled = true;
    document.getElementById("chequeDDReturn").disabled = true;
    document.getElementById("chequeDDReturnReason").disabled = true;
    document.getElementById("chequeDDReturnReasonOther").disabled = true;
}
