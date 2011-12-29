function makeCreateSubscriberReadOnly(){

    document.getElementById("btnEditSubscriber").disabled = true;
    document.getElementById("btnDisplaySubscriber").disabled = true;
    document.getElementById("btnViewSubscription").disabled = true;
    document.getElementById("btnAddSubscription").disabled = true;
    document.getElementById("subscriberAgent").options.length=0;
    document.getElementById("subscriberAgent").disabled = true;
}

function validateNewSubscriber(){
    return checkMandatoryFields();
}
