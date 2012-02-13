function makeCreateSubscriberReadOnly(){

    document.getElementById("btnEditSubscriber").disabled = true;
    document.getElementById("btnDisplaySubscriber").disabled = true;
    document.getElementById("btnViewSubscription").disabled = true;
    document.getElementById("btnAddSubscription").disabled = true;
    //document.getElementById("subscriberAgent").options.length=0;
    //document.getElementById("subscriberAgent").disabled = true;
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
