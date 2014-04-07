
function makeViewSubscriberReadOnly(){
    $("#btnDisplaySubscriber").button("disable");
    $("#btnSaveSubscriber").button("disable");
    $("#subscriberNumber").removeAttr("disabled");
    $("#subscriberNumber").removeAttr("readonly");
}