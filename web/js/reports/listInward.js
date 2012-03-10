function setInwardSubscriber(inwardId,subscriberId){
    selectedInward = inwardId;
    selectedSubscriberId = subscriberId || 0;

}

function validateSearch(){

    if( document.getElementById("city").value == "0"
        && document.getElementById("state").value == "0"
        && document.getElementById("country").value == "0"
        && document.getElementById("currency").value == "0"
        && document.getElementById("language").value == "0"
        && document.getElementById("paymentMode").value == "0"
        && document.getElementById("inwardPurpose").value == "0"
        && isEmpty(document.getElementById("from"))
        && isEmpty(document.getElementById("to"))
        ){
        alert("Please select atleast one search criteria");
        return false;
    }else if(isEmpty(document.getElementById("from")) == false && isEmpty(document.getElementById("to"))){
        alert("Please select both from and to dates in the range");
        return false;
    }else if(isEmpty(document.getElementById("to")) == false && isEmpty(document.getElementById("from"))){
        alert("Please select both from and to dates in the range");
        return false;
    }

    return true;
}