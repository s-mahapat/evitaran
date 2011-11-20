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

function validateSearchSubscriber(){

    /*if(isNaN(document.getElementById("pincode").value)){
        alert("Invalid Pin Code");
        return;
    }*/
    if( document.getElementById("from").value.length == 0
        && document.getElementById("city").value.length ==0
        && document.getElementById("pincode").value.length == 0
    ){
            alert("Please fill in the From,City and Pincode to search for subscriber");
            return;
    }else{
        openModalPopUp("../subscriber/searchsubscriber.jsp", 'Select Subscriber');
    }
}