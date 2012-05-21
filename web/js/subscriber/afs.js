function makeCreateSubscriberReadOnly(){

    $("#btnEditSubscriber").button("disable");
    $("#btnDisplaySubscriber").button("disable");
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
