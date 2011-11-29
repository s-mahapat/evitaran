/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */


function validateSearchSubscriber(){

    /*if(isNaN(document.getElementById("pincode").value)){
        alert("Invalid Pin Code");
        return;
    }*/
    if( document.getElementById("from").value.length == 0
        && document.getElementById("city").value.length ==0
        && document.getElementById("pincode").value.length == 0
    ){
            alert("Please fill in the From,City and Pincode to search for subscriber");
            return;
    }else{
        openModalPopUp("jsp/subscriber/subscriberlist.jsp", 'Select Subscriber');
    }
}


function setInwardSubscriber(inwardId,subscriberId){
    alert(subscriberId);
    selectedInward = inwardId;
    selectedSubscriberId = subscriberId || 0;
}