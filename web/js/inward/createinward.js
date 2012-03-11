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

function loadData(){
    jdsAppend("CMasterData?md=country","country","country","India");
    jdsAppend("CMasterData?md=state","state","state");
    jdsAppend("CMasterData?md=district","district","district");
    jdsAppend("CMasterData?md=city","city","city");
    jdsAppend("CMasterData?md=purpose","purpose","inwardPurpose");
    jdsAppend("CMasterData?md=payment_mode","payment_mode","paymentMode");
    jdsAppend("CMasterData?md=currency","currency","currency","INR");

}