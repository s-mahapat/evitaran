/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */


function validateSearchSubscriber(){

    var isValidSearch = false;
    if(!isEmptyValue($("#from").val())){
        isValidSearch = true;
    }
    else if(!isEmptyValue($("#country").val()) && !isEmptyValue($("#state").val())){
        isValidSearch = true;
    }
    else if(!isEmptyValue($("#country").val()) && !isEmptyValue($("#city").val())){
        isValidSearch = true;
    }

    if(!isValidSearch){
        alert("Please fill in Country along with City/State to search for subscriber");
        return;
    }else{
        var selectedSubscriberFromDialog = searchSubscriber(document.getElementById("country").value
            ,document.getElementById("state").value
            ,document.getElementById("city").value
            ,document.getElementById("from").value);

        if(!isEmptyValue(selectedSubscriberFromDialog) && selectedSubscriberFromDialog != 0){
            document.getElementById("subscriberId").value = selectedSubscriberFromDialog;
        }
    }
}

function searchSubscriber(country, state, city, subscriberName){
    var subscriber = new Object();
    windowParams = "dialogHeight:500px; dialogWidth:800px; center:yes; resizeable:no; status:no; menubar:no;\n\
                    scrollbars:yes; toolbar: no;";
    subscriber.country = country;
    subscriber.city = city;
    subscriber.name = subscriberName;
    var selectedSubscriberFromDialog = openModalPopUp("jsp/subscriber/subscriberlist.jsp"
                                                    , subscriber
                                                    , windowParams);
    return selectedSubscriberFromDialog;
}


function setInwardSubscriber(inwardId,subscriberId, purpose){
    selectedInward = inwardId;
    selectedSubscriberId = subscriberId || null;
    selectedInwardPurpose = purpose;
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