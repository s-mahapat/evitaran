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

function validateNewInward(){

    var isInwardValid = true;

    // called from common.js
    //isInwardValid = checkMandatoryFields();

    // check the inward purpose field
    var InwardPurpose = document.getElementById("inwardPurpose").value.toLowerCase();

    if(checkMandatoryFields() == false){
        isInwardValid = false;
    }
    else if(InwardPurpose == 0){
        alert("Please select an Inward Purpose");
        isInwardValid = false;
    }
    else if(InwardPurpose == 'others' && isEmpty(document.getElementById("remarks"))){

        alert("Since you have created a miscellaneous inward, please fill in the remarks section");
        isInwardValid = false;
    }
    else if(document.getElementById("paymentMode").value == 0){

        alert("Please select payment mode");
        isInwardValid = false;

    }
    else if(document.getElementById("currency").value == 0){
        alert("Please select Currency");
        isInwardValid = false;
    }

    return isInwardValid;




}
