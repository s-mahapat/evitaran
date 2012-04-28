var bSearchSubscriberOnce = false;
function validateSearch(){

    if(document.getElementById("inwardPurpose").value == "NULL"
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

