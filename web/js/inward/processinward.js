function validateSearch(){

    if(document.getElementById("inwardPurpose").value == "NULL"
        && isEmpty(document.getElementById("from"))
        && isEmpty(document.getElementById("to"))
        ){
        alert("Please select atleast one search criteria");
        return false;
    }else if(isEmpty(document.getElementById("from")) == false && isEmpty(document.getElementById("to"))){
        alert("Please select both from and to dates in the range");
        return false;
    }else if(isEmpty(document.getElementById("to")) == false && isEmpty(document.getElementById("from"))){
        alert("Please select both from and to dates in the range");
        return false;
    }

    return true;
}

function isInwardSelected(){
    if(selectedInward == 0){
        alert("Please select an Inward");
        return false;

    }else{
        if(selectedSubscriberId == null){
            // if its not a new subscription then we need a subscriber id, search for the subscriber id
            if(selectedInwardPurpose.toString().toLowerCase() != 1){
                city = jQuery("#inwardTable").jqGrid('getCell',selectedInward,'City').toString();
                subscriberName = jQuery("#inwardTable").jqGrid('getCell',selectedInward,'From').toString();
                selectedSubscriberId = searchSubscriber("", "", city, subscriberName);
                jQuery("#inwardTable").jqGrid('setRowData', selectedInward, {
                    'SubscriberId': selectedSubscriberId
                });
                document.processInwardForm.action = "inward?action=processinward&" +
                                                    "inwardNumber=" + selectedInward + "&" +
                                                    "subscriberNumber=" + selectedSubscriberId + "&" +
                                                    "purpose=" + selectedInwardPurpose;
            }
            else{
                // if the subscriber id is null and its a new subscription
                document.processInwardForm.action = "inward?action=processinward&" +
                "inwardNumber=" + selectedInward + "&" +
                "subscriberNumber=" + "&" +
                "purpose=" + selectedInwardPurpose
                return true;
            }
        }else{
            document.processInwardForm.action = "inward?action=processinward&" +
            "inwardNumber=" + selectedInward + "&" +
            "subscriberNumber=" + selectedSubscriberId + "&" +
            "purpose=" + selectedInwardPurpose
            return true;
        }

    }
    return false;
}