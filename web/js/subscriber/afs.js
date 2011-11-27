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


    //Add only the Free Subscribers in the subscriber type combo
    var subTypeCombo = document.getElementById("subscriberType");
    var newOptionGrp = document.createElement('optgroup');
    newOptionGrp.label = "Free Subscriber";
    newOptionGrp.appendChild(new Option("Option 1")).innerHTML = "FELJM - Fellows";
    newOptionGrp.appendChild(new Option("Option 2")).innerHTML = "XXX - Summer Fellows";
    newOptionGrp.appendChild(new Option("Option 2")).innerHTML = "AS - Associates";
    newOptionGrp.appendChild(new Option("Option 2")).innerHTML = "EBALL - Editorial Board Members";
    newOptionGrp.appendChild(new Option("Option 2")).innerHTML = "EI - Indian Exchange";
    newOptionGrp.appendChild(new Option("Option 2")).innerHTML = "EF - Foreign Exchange";
    newOptionGrp.appendChild(new Option("Option 2")).innerHTML = "JGrant - Grant";
    newOptionGrp.appendChild(new Option("Option 2")).innerHTML = "XXX - Authors";
    newOptionGrp.appendChild(new Option("Option 2")).innerHTML = "IC - Indian Schools and Colleges";
    subTypeCombo.appendChild(newOptionGrp);


    // Agent should be there or not???
    document.getElementById("subscriberAgent").options.length=0;
    document.getElementById("subscriberAgent").disabled = true;
}


