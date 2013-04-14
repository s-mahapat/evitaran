function makeInwardReadOnly() {

    //$("#btnEditInward").button("disable");
    $("#btnEditInward").hide();
    $("#btnSendAck").hide();
    $("#btnNewInward").hide();
    if (Number($("#amount").val()) <= 0) {
        $("#btnSendReturn").button("disable");
    }
}

function enablePayment() {
    if ($("#inwardPurpose").val().toLowerCase() == "payment") {
        enableSubscriptionID(true);
    } else {
        enableSubscriptionID(false);
    }
}

function loadData() {
    jdsAppend("CMasterData?md=country", "country", "country");
    jdsAppend("CMasterData?md=state", "state", "state");
    jdsAppend("CMasterData?md=payment_mode", "payment_mode", "paymentMode");
    jdsAppend("CMasterData?md=currency", "currency", "currency");
    jdsAppend("CMasterData?md=language", "language", "language");
    jdsAutoComplete("subscriber?action=subscriberNames", "subscriberName", "from");
    jdsAutoComplete("subscriber?action=depts", "department", "department");
    jdsAutoComplete("subscriber?action=inst", "institution", "institution");
    jdsAutoComplete("main2/bank/search", "bank_name", "bankName");
    jdsAutoComplete("main2/agent/search", "agentName", "agentName");
    loadCities();
    loadDistricts();
}