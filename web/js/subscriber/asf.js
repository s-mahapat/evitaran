function makeCreateSubscriberReadOnly(){

    document.getElementById("btnEditSubscriber").disabled = true;
    document.getElementById("btnDisplaySubscriber").disabled = true;
    document.getElementById("btnViewSubscription").disabled = true;
    document.getElementById("btnAddSubscription").disabled = true;
    document.getElementById("btnGenerateProformaInvoice").disabled = true;
    document.getElementById("btnMissingIssueList").disabled = true;

    //Remove all the options and option group in case of summer fellows
    document.getElementById("subscriberType").options.length=0;

    TheOpt=document.getElementById("optGrp1");
    TheParent=TheOpt.parentNode;
    TheParent.removeChild(TheOpt);

    TheOpt=document.getElementById("optGrp2");
    TheParent=TheOpt.parentNode;
    TheParent.removeChild(TheOpt);


    //Add only the Summer Fellow in the subscriber type
    var newOption = document.createElement('<option value="Summer Fellow">');
    document.getElementById("subscriberType").add(newOption);
    newOption.innerText = "Summer Fellow";

    // Agent should be there or not???
    document.getElementById("subscriberAgent").options.length=0;
    document.getElementById("subscriberAgent").disabled = true;
}


