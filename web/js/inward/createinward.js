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
}

function validateNewInward(){

    var InwardPurpose = document.getElementById("purpose").value.toLowerCase();
    if(InwardPurpose == 'others' && isEmpty(document.getElementById("remarks"))){

        alert("Since you have created a miscellaneous inward, please fill in the remarks section");
        return false;
    }
    return true;
}
