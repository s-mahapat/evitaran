/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */


function makeReadOnly() {

    $("#btnEditInward").hide();
    $("#btnSendAck").hide();
    $("#btnSendReturn").hide();
    $("#btnEditInward").hide();
    $("#btnNewInward").hide();
    $("#btnCancel").hide();
    $("#chequeDDReturn").attr("disabled", true);
    $("#chequeDDReturnReason").attr("disabled", true);
    $("#chequeDDReturnReasonOther").attr("disabled", true);
}

function loadData() {
    jdsAppend("CMasterData?md=country", "country", "country", "India");
    jdsAppend("CMasterData?md=state", "state", "state");
    //jdsAppend("CMasterData?md=district","district","district");
    //jdsAutoComplete("cities", "city", "city");
    //jdsAppend("CMasterData?md=city","city","city");
    jdsAppend("CMasterData?md=agent", "agentName", "agentName");
    jdsAppend("CMasterData?md=purpose", "purpose", "inwardPurpose", "Renew Subscription");
    jdsAppend("CMasterData?md=payment_mode", "payment_mode", "paymentMode", "Demand Draft");
    jdsAppend("CMasterData?md=currency", "currency", "currency", "INR");
    jdsAppend("CMasterData?md=language", "language", "language", "English");
    jdsAutoComplete("subscriber?action=subscriberNames", "subscriberName", "from");
    jdsAutoComplete("subscriber?action=depts", "department", "department");
    jdsAutoComplete("subscriber?action=inst", "institution", "institution");
    jdsAutoComplete("main2/bank/search", "bank_name", "bankName");
    loadCities();
    loadDistricts();
}