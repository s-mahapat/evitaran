/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
var selectedInward = 0;
var selectedSubscriberId = 0;
var selectedInwardRowIndex = -1;
var selectedInwardPurpose = "";

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

function subscriberlink(cellvalue, options, rowObject){
    rowid = options.rowId;
    var subscriberId = rowObject.childNodes[1].textContent;
    var subscriberName = rowObject.childNodes[2].textContent;
    var city = rowObject.childNodes[4].textContent;
    var inwardid = rowObject.childNodes[0].textContent
    if(isEmptyValue(subscriberId)){
        var link = "<a href=\"#\" onclick=" + "\"" + "selectSubscriber('" + city + "','" + subscriberName + "','" + inwardid + "')" + "\"" + ">Select Subscriber</a>";
        return link;
    }
    return "";
}

function selectInwardFormatter(cellvalue, options, rowObject){
    rowid = options.rowId;
    console.log(rowObject);
    var purpose = rowObject.childNodes[7].textContent;
    var inwardId = rowObject.childNodes[0].textContent;
    var subscriberId = rowObject.childNodes[1].textContent;
    action = "<input type='radio' name='selectedInwardRadio'" + " value=" + "\"" + rowid + "\"" + " onclick=" + "\"" + "setInwardSubscriber('" + inwardId + "','" + subscriberId + "','" + purpose + "')" + "\"" + "/>";
    return action;
}

function isInwardSelected(){
    var _JDSConstants = new JDSConstants();
    //var ids = jQuery("#inwardTable").jqGrid('getDataIDs');

    if(selectedInward == 0){
        alert("Please select an Inward");
        return false;

    }else if(selectedSubscriberId == null && selectedInwardPurpose == _JDSConstants.INWARD_PURPOSE_RENEW_SUBSCRIPTION){
        // if its not a new subscription then we need a subscriber id, search for the subscriber id
        city = jQuery("#inwardTable").jqGrid('getCell',selectedInward,'City').toString();
        subscriberName = jQuery("#inwardTable").jqGrid('getCell',selectedInward,'From').toString();
        selectSubscriber(city, subscriberName, selectedInward);
        return false;
    }else if(selectedSubscriberId == null && selectedInwardPurpose != _JDSConstants.INWARD_PURPOSE_NEW_SUBSCRIPTION){
        if(confirm("Do you want to continue without selecting subscriber ?") == false){
            return false;
        }
    }

    document.processInwardForm.action = "inward?action=processinward&" +
    "inwardNumber=" + selectedInward + "&" +
    "subscriberNumber=" + selectedSubscriberId + "&" +
    "purpose=" + selectedInwardPurpose
    return true;
}

function selectSubscriber(city, subscriberName, rowid){
    selectedSubscriberId = searchSubscriber("", "", city, subscriberName);
    jQuery("#inwardTable").jqGrid('setRowData', rowid, {
        'SubscriberId': selectedSubscriberId
    });
}