function validateSearchSubscriber(){

    /*if(isNaN(document.getElementById("pincode").value)){
        alert("Invalid Pin Code");
        return;
    }*/
    if( document.getElementById("subscriberId").value.length == 0
        && document.getElementById("subscriberName").value.length == 0
        && document.getElementById("eMail").value.length == 0
        && document.getElementById("city").value.length == 0
        && document.getElementById("pincode").value.length == 0
        ){
        alert("Please fill in at least one field to search for subscriber");
        return;
    }
}