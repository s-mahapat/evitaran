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
    $("#subtypedesc").append('<option value="" selected>Select</option>');
    var subType = $("#subtype").val();
    requestURL = "CMasterData?md=subtype_desc&mdvalue=" + subType;
    jdsAppend(requestURL,"subtypedesc","subtypedesc", "Select");

}
