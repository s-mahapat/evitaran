/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
var selectedInward = 0;
var selectedSubscriberId = 0;
var selectedInwardRowIndex = -1;
var selectedInwardPurpose = "";
var bvalidsubscriber = false;

function enableSubscriptionID(value){
    if(value){
        $( "#btnSearchSubscription" ).button("enable");
        $( "#btnResetSubscription" ).button("enable");
        $("#subscriptionid").removeAttr("disabled");
    }else{
        $( "#btnSearchSubscription" ).button("disable");
        $( "#btnResetSubscription" ).button("disable");
        $("#subscriptionid").attr("disabled","disabled");
    }
}

function validateSearchSubscriber(){

    var isValidSearch = false;
    if(!isEmptyValue($("#pincode").val()) || !isEmptyValue($("#from").val())){
        isValidSearch = true;
    }

    if(!isValidSearch){
        alert("Please fill in From or Pincode to search for subscriber");
        return;
    }else{
        var selectedSubscriberFromDialog = searchSubscriber(
            document.getElementById("from").value
            ,document.getElementById("country").value
            ,document.getElementById("state").value
            ,document.getElementById("city").value
            ,document.getElementById("pincode").value
            ,document.getElementById("institution").value
            ,document.getElementById("department").value
            ,document.getElementById("email").value
            );

        if(!isEmptyValue(selectedSubscriberFromDialog.SubscriberNumber) && selectedSubscriberFromDialog.SubscriberNumber != 0){
            $("#subscriberId").val(selectedSubscriberFromDialog.SubscriberNumber);
            $("#institution").val(selectedSubscriberFromDialog.Instituttion);
            $("#department").val(selectedSubscriberFromDialog.Department);
            $("#email").val(selectedSubscriberFromDialog.Email);
            $("#pincode").val(selectedSubscriberFromDialog.PinCode);
            $("#from").val(selectedSubscriberFromDialog.SubscriberName);
            $("#city").val(selectedSubscriberFromDialog.City);
            $("#country").val(selectedSubscriberFromDialog.Country);

        }
    }
}

function validateSearchSubscription(){
    if(isEmptyValue($("#subscriberId").val())){
        alert("Please select subscriber to search for subscription");
        return false;
    }
    var subscriptionID = searchSubscription($("#subscriberId").val());
    $("#subscriptionid").val(subscriptionID);
    return true;
}

function searchSubscriber(subscriberName,country, state, city, pincode, institution, department, email){
    var subscriber = new Object();
    windowParams = "dialogHeight:650px; dialogWidth:1200px; center:yes; resizeable:no; status:no; menubar:no;\n\
                    scrollbars:yes; toolbar: no;";
    subscriber.country = country;
    subscriber.city = city;
    subscriber.name = subscriberName;
    subscriber.state = state;
    subscriber.pincode = pincode;
    subscriber.institution = institution;
    subscriber.department = department;
    subscriber.email = email;
    var selectedSubscriberFromDialog = openModalPopUp("jsp/subscriber/subscriberlist.jsp"
        , subscriber
        , windowParams);
    return selectedSubscriberFromDialog;
}

function searchSubscription(subscriberNumber){
    var subscriber = new Object();
    subscriber.Number = subscriberNumber;
    windowParams = "dialogHeight:800px; dialogWidth:1200px; center:yes; resizeable:no; status:no; menubar:no;\n\
                    scrollbars:yes; toolbar: no;";
    var selectedSubscriptionFromDialog = openModalPopUp("jsp/subscription/subscriptionforsubscriber.jsp"
        , subscriber
        , windowParams);
    return selectedSubscriptionFromDialog;

}

function clearSubscriber(){
    $("#subscriberId").val("");
}

function clearSubscription(){
    $("#subscriptionid").val("");
}

function setInwardSubscriber(rowid, purpose){
    selectedSubscriberId = jQuery("#inwardTable").jqGrid('getCell',rowid,'SubscriberId').toString();
    selectedInward = rowid;
    selectedInwardPurpose = purpose;
}

function validateNewInward(){

    var isInwardValid = true;

    // called from common.js
    //isInwardValid = checkMandatoryFields();

    // check the inward purpose field
    var InwardPurpose = document.getElementById("inwardPurpose").value.toLowerCase();
    //alert(parseFloat($("#amount").val()) <= 0);

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
    else if(InwardPurpose == 'payment' && isEmptyValue($("#subscriptionid").val())){
        alert("Payment Inward cannot be saved without subscription.Please select a subscription to save the Inward.");
        return false;
    }
    else if(InwardPurpose == 'payment' &&  ((parseFloat($("#amount").val()) <= 0) || isEmptyValue($("#paymentMode").val()))){
        alert("Payment Inward cannot be saved without amount and payment mode.\nPlease enter the amount and payment mode to save the Inward.");
        return false;
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

    // since selecting the subscriber is not mandatory, check if he is ok to proceed without
    // selecting subscriber. The inward should be alreay valid before we make this check
    // disabling this message for now. Inward dept do not want to enter any subscriber info
    /*if(InwardPurpose.toLowerCase() != 'new subscription' && isInwardValid && isEmptyValue($("#subscriberId").val())){
        if(confirm("Do you want to save the inward without selecting a subscriber?")){
            isInwardValid = true;
        }else{
            isInwardValid = false;
        }

    }*/

    return isInwardValid;
}

function subscriberlink(cellvalue, options, rowObject){
    rowid = options.rowId;
    var tagnames = ["subscriberId", "from", "city", "inwardNumber", "agentName"];
    var tagvalues = new Array();

    for(i=0; i<tagnames.length; i++){
        var obj = rowObject.getElementsByTagName(tagnames[i])[0];
        if(obj != null && obj.hasChildNodes()){
            tagvalues[i] = obj.childNodes[0].nodeValue;
        }
    }
    var subscriberID = tagvalues[0];
    var subscriberName = tagvalues[1];
    var city = tagvalues[2];
    var inwardid = tagvalues[3];
    var agentName = tagvalues[4];
    if(isEmptyValue(subscriberID) && (isEmptyValue(agentName))){
        var link = "<a href=\"#\" onclick=" + "\"" + "selectSubscriber('" + city + "','" + subscriberName + "','" + inwardid + "')" + "\"" + ">Select Subscriber</a>";
        //var link = "<a href=\"#\" onclick=" + "\"" + "selectSubscriber('" + rowid + "')" + "\"" + ">Select Subscriber</a>";
        return link;
    }
    return "";
}

function selectInwardFormatter(cellvalue, options, rowObject){
    rowid = options.rowId;
    //console.log(rowObject);
    var tagnames = ["inwardPurposeID", "inwardNumber", "subscriberId"];
    var tagvalues = new Array();

    for(i=0; i<tagnames.length; i++){
        var obj = rowObject.getElementsByTagName(tagnames[i])[0];
        if(obj != null && obj.hasChildNodes()){
            tagvalues[i] = obj.childNodes[0].nodeValue;
        }
    }
    var purposeId = tagvalues[0];
    //var inwardId = tagvalues[1];
    //var subscriberId = tagvalues[2];
    //action = "<input type='radio' name='selectedInwardRadio'" + " value=" + "\"" + rowid + "\"" + " onclick=" + "\"" + "setInwardSubscriber('" + inwardId + "','" + subscriberId + "','" + purposeId + "')" + "\"" + "/>";
    action = "<input type='radio' name='selectedInwardRadio'" + " value=" + "\"" + rowid + "\"" + " onclick=" + "\"" + "setInwardSubscriber('" + rowid + "','" + purposeId + "')" + "\"" + "/>";
    return action;
}

function isInwardSelected(){
    var _JDSConstants = new JDSConstants();
    if(parseInt(selectedInward) == 0){
        alert("Please select an Inward");
        return false;
    }else if(selectedSubscriberId == null && selectedInwardPurpose != _JDSConstants.INWARD_PURPOSE_NEW_SUBSCRIPTION){
        if(confirm("Do you want to continue without selecting subscriber ?") == false){
            return false;
        }
    }
    else if((selectedSubscriberId == "undefined" || selectedSubscriberId == null || selectedSubscriberId == 0)
        && (selectedInwardPurpose == _JDSConstants.INWARD_PURPOSE_RENEW_SUBSCRIPTION ||
            selectedInwardPurpose == _JDSConstants.INWARD_PURPOSE_ADDRESS_CHANGE ||
            //selectedInwardPurpose == _JDSConstants.INWARD_PURPOSE_REQUEST_FOR_INVOICE ||
            selectedInwardPurpose == _JDSConstants.INWARD_PURPOSE_PAYMENT ||
            selectedInwardPurpose == _JDSConstants.INWARD_PURPOSE_MISSING_ISSUE
            )){
        // if its not a new subscription then we need a subscriber id, search for the subscriber id
        city = jQuery("#inwardTable").jqGrid('getCell',selectedInward,'City').toString();
        subscriberName = jQuery("#inwardTable").jqGrid('getCell',selectedInward,'From').toString();
        selectSubscriber(city, subscriberName, selectedInward);
        return false;
    }
    if(selectedSubscriberId=="undefined"){
        selectedSubscriberId = "";
    }
    $("#inwardNumber").val(selectedInward);
    $("#subscriberNumber").val(selectedSubscriberId);
    $("#purpose").val(selectedInwardPurpose);
    return true;
}

function selectSubscriber(city, subscriberName, rowid){
    selectedSubscriberId = searchSubscriber(subscriberName,"","",city);
    // ensure that user has selected a subscriber
    if(!isEmptyValue(selectedSubscriberId.SubscriberNumber)){
        jQuery("#inwardTable").jqGrid('setRowData', rowid, {
            'SubscriberId': selectedSubscriberId.SubscriberNumber
        });
        selectedSubscriberId = selectedSubscriberId.SubscriberNumber;
        // set the subscriber if it is selected after selecting the inward,
        // or any changes are made
        $("#subscriberNumber").val(selectedSubscriberId);
    }else{
        selectedSubscriberId = 0;
    }

}

function selectPaymentType(inwardType){
    if(inwardType.toLowerCase() == "new subscription" ||
        inwardType.toLowerCase() == "renew subscription" ||
        inwardType.toLowerCase() == "payment"){
        $("#paymentMode").val("Demand Draft"); // select demand draft when one of these is selected from the drop down
        _MakePaymentFieldsMandatory(true);
    }else{
        _MakePaymentFieldsMandatory(false);
        $("#paymentMode").val("Select");
    }
}

function ValidateSubscriber(){
    // if the subscriber is already selected do not do anything
    if(bvalidsubscriber)
        return

    subscriber_number = $("#subscriberId").val();
    if(!subscriber_number){
        return;
    }else{
        $.ajax({
            url: "subscriber?action=search&page=1&rows=1&exact=true",
            data: {
                subscriberNumber: subscriber_number
            },
            success: function(data, textStatus, jqXHR){
                var rows = $(data).find("row");
                var rowcount = rows.length;
                var subscribers = new Array();
                if(rowcount == 1){
                    var from = $(data).find( "subscriberName" ).text();
                    var subscriber_number = $(data).find( "subscriberNumber" ).text();
                    var city = $(data).find( "city" ).text();
                    var state = $(data).find( "state" ).text();
                    var country = $(data).find( "country" ).text();
                    var pincode = $(data).find( "pincode" ).text();
                    var department = $(data).find( "department" ).text();
                    var institution = $(data).find( "institution" ).text();
                    var email = $(data).find( "email" ).text();
                    $("#from").val(from);
                    $("#subscriberId").val(subscriber_number);
                    $("#city").val(city);
                    $("#state").val(state);
                    $("#country").val(country);
                    if(pincode != 0)
                        $("#pincode").val(pincode);
                    $("#department").val(department);
                    $("#institution").val(institution);
                    $("#email").val(email);
                    bvalidsubscriber = true;
                }else{
                    /*$(data).find("subscriberNumber").each(function(){
                        subscribers.push($(this).text());
                    });
                    $("#subscriberId").autocomplete({
                        minLength: 0,
                        source: subscribers
                    });
                    $("#subscriberId").autocomplete("search", $("#subscriberId").val());*/
                    $("#subscriberId").focus();
                    alert("No such subscriber exists. Please enter a valid subscriber id");
                }
            },
            dataType: "xml"
        });
    }
}

function removeInvalidSubscriber(){
    if(!bvalidsubscriber)
        $("#subscriberId").val('');

}

function MakePaymentFieldsMandatory(){
    var payment_mode = $("#paymentMode").val();
    if(!payment_mode || payment_mode.toLowerCase() == "cash"){
        _MakePaymentFieldsMandatory(false);
    }else{
        _MakePaymentFieldsMandatory(true);
    }
}

function _MakePaymentFieldsMandatory(bmandatory){
    if(bmandatory){
        $("#chqddNumber").addClass("IASTextBoxMandatory required");
        $("#paymentDate").addClass("IASDateTextBoxMandatory");
        $("#amount").addClass("IASTextBoxMandatory required");
    }else{
        $("#chqddNumber").removeClass("IASTextBoxMandatory required");
        $("#paymentDate").removeClass("IASDateTextBoxMandatory");
        $("#amount").removeClass("IASTextBoxMandatory required");
    }
}