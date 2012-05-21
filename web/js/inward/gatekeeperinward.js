var isSubscriberMandatory = true;
var resetpurposeID = true;
 
function validateSearch(){

    if(isEmpty(document.getElementById("_inwardNumber"))
        && isEmpty(document.getElementById("chequeNumber"))
        && document.getElementById("city").value == "NULL"
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