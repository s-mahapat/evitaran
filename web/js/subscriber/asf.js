function makeCreateSubscriberReadOnly(){

    document.getElementById("btnEditSubscriber").disabled = true;
    document.getElementById("btnDisplaySubscriber").disabled = true;
    document.getElementById("btnViewSubscription").disabled = true;
    document.getElementById("btnAddSubscription").disabled = true;

    //Remove all the options and option group in case of summer fellows
    /*document.getElementById("subtype").options.length=0;

    //Add only the Summer Fellow in the subscriber type
    var newOption = document.createElement('<option value="Summer Fellow">');
    document.getElementById("subtypedesc").add(newOption);
    newOption.innerText = "Summer Fellow";*/

    // Agent should be there or not???
    document.getElementById("subscriberAgent").options.length=0;
    document.getElementById("subscriberAgent").disabled = true;
}

function subtypeAppend(){
    $("#subtypedesc").empty();
    $("#subtypecode").text("");
    var newOption = new Option("Select", "value");
    $(newOption).html("Select");
    $("#subtypedesc").append(newOption);
    requestURL = "/JDS/CMasterData?md=subtype_desc_asf"
    jdsAppend(requestURL,"subtypedesc","subtypedesc");
}
