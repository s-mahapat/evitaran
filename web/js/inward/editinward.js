function makeInwardReadOnly(){

    document.getElementById("btnEditInward").disabled = true;
}

function loadData(){
    jdsAppend("CMasterData?md=country","country","country");
    jdsAppend("CMasterData?md=state","state","state");
    jdsAppend("CMasterData?md=district","district","district");
    jdsAppend("CMasterData?md=city","city","city");
    jdsAppend("CMasterData?md=purpose","purpose","inwardPurpose");
    jdsAppend("CMasterData?md=payment_mode","payment_mode","paymentMode");
    jdsAppend("CMasterData?md=currency","currency","currency");
    jdsAppend("CMasterData?md=language","language","language");

}