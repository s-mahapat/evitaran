function validateSearchSubscriber(){

    /*if(isNaN(document.getElementById("pincode").value)){
        alert("Invalid Pin Code");
        return;
    }*/
    if( isEmpty(document.getElementById("subscriberNumber"))
        && isEmpty(document.getElementById("subscriberName"))
        && isEmpty(document.getElementById("email"))
        && document.getElementById("city").value == "Select"
        && isEmpty(document.getElementById("pincode"))
        ){
        alert("Please fill in at least one field to search for subscriber");
        return false;
    }
    return true;
}