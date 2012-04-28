function makeCreateSubscriberReadOnly(){

    $("#btnEditSubscriber").button("disable");
    $("#btnEditSubscriber").button("disable");
    $("#btnDisplaySubscriber").button("disable");
    $("#btnViewSubscription").button("disable");
    //$("#btnAddSubscription").button("disable");

}

function validateNewSubscriber(){
    return checkMandatoryFields();
}

function subtypeAppend(){
    $("#subtypedesc").empty();
    $("#subtypecode").text("");
    var newOption = new Option("Select", "value");
    $(newOption).html("Select");
    $("#subtypedesc").append(newOption);
    var subType = document.subscriberForm.subtype.options[document.subscriberForm.subtype.selectedIndex].text;
    requestURL = "/JDS/CMasterData?md=subtype_desc&mdvalue=" + subType;
    jdsAppend(requestURL,"subtypedesc","subtypedesc");
}
