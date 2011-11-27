function makeEditSubscriberReadOnly(){

    document.getElementById("btnEditSubscriber").disabled = true;
    document.getElementById('btnDisplaySubscriber').disabled = true;

    document.getElementById("subscriberAgent").options.length=0;
    document.getElementById("subscriberAgent").disabled = true;
}
