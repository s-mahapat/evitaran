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
        && document.getElementById("city").value ==0
        && document.getElementById("pincode").value == 0
        && document.getElementById("country").value == 0
    ){
            alert("Please fill in the From,City and Pincode to search for subscriber");
            return;
    }else{
        var selectedSubscriberFromDialog = openModalPopUp("jsp/subscriber/subscriberlist.jsp?"
            + "city=" + document.getElementById("city").value + "&"
            + "subscriberName=" + document.getElementById("from").value + "&"
            + "pincode=" + document.getElementById("pincode").value, 'Select Subscriber');
        
        if(!isEmptyValue(selectedSubscriberFromDialog) && selectedSubscriberFromDialog != 0){
            document.getElementById("subscriberId").value = selectedSubscriberFromDialog;
        }
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

    // if the payment mode is selected then ensure that the payment date and currency is also filled in
    else if(!isEmpty(document.getElementById("paymentMode")) && (isEmpty(document.getElementById("currency")) || isEmpty(document.getElementById("paymentDate")))){
        alert("Please select a currency and payment date");
        isInwardValid = false;
    }

    //if the payment mode is cheque/dd/mo ensure that the instrument number is filled in
    else if((!isEmpty(document.getElementById("paymentMode")) && document.getElementById("paymentMode").value != "Cash") && (isEmpty(document.getElementById("chqddNumber")))){
        alert("Please enter the " + document.getElementById("paymentMode").value + " number");
        isInwardValid = false;
    }

    return isInwardValid;
}