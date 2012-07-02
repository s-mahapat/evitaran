function validateSearchSubscriber(){

    /*if(isNaN(document.getElementById("pincode").value)){
        alert("Invalid Pin Code");
        return;
    }*/
    if( isEmpty(document.getElementById("subscriberType"))
        && isEmpty(document.getElementById("journalGroupName"))
        //&& isEmpty(document.getElementById("institutional"))
        //&& document.getElementById("city").value == "NULL"
        //&& document.getElementById("state").value.length == 0
        ){
        alert("Please fill in at least one field to search for subscriber");
        return false;
    }
    return true;
}