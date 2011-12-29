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
    selectedInward = inwardId;
    selectedSubscriberId = subscriberId || 0;
}

function validateNewInward(){

    var isInwardValid = true;

    // called from common.js
    //isInwardValid = checkMandatoryFields();

    // check the inward purpose field
    var InwardPurpose = document.getElementById("inwardPurpose").value.toLowerCase();

    if(checkMandatoryFields() == false){
        isInwardValid = false;
    }
    else if(InwardPurpose == 0){
        alert("Please select an Inward Purpose");
        isInwardValid = false;
    }
    else if(InwardPurpose == 'others' && isEmpty(document.getElementById("remarks"))){

        alert("Since you have created a miscellaneous inward, please fill in the remarks section");
        isInwardValid = false;
    }
    if(!isEmpty(document.getElementById("paymentMode")) && isEmpty(document.getElementById("currency"))){
        alert("Please select a currency");
        isInwardValid = false;
    }

    return isInwardValid;
}