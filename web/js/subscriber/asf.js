function makeCreateSubscriberReadOnly(){

    $("#btnEditSubscriber").button("disable");
    $("#btnDisplaySubscriber").button("disable");
    $("#agent").attr("disabled", true);
}

function subtypeAppend(){
    $("#subtypedesc").empty();
    $("#subtypecode").text("");
    var newOption = new Option("Select", "value");
    $(newOption).html("Select");
    $("#subtypedesc").append(newOption);
    requestURL = "CMasterData?md=subtype_desc_asf"
    jdsAppend(requestURL,"subtypedesc","subtypedesc");
}
