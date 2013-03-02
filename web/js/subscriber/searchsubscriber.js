function validateSearchSubscriber(){

    if( isEmpty(document.getElementById("subscriberNumber"))
        && isEmpty(document.getElementById("subscriberName"))
        && isEmpty(document.getElementById("email"))
        && isEmpty(document.getElementById("city"))
        && isEmpty(document.getElementById("pincode"))
        && isEmpty(document.getElementById("institute"))
        && isEmpty(document.getElementById("department"))
        ){
        alert("Please fill in at least one field to search for subscriber");
        return false;
    }
    return true;
}