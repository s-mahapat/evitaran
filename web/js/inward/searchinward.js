function setInwardSubscriber(inwardId,subscriberId){
    selectedInward = inwardId;
    selectedSubscriberId = subscriberId || 0;

}

function validateSearch(){

    if(isEmpty(document.getElementById("inwardNumber"))
        && isEmpty(document.getElementById("chequeNumber"))
        && document.getElementById("city").value == "NULL"
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

function subscriberlink(cellvalue, options, rowObject){
    if(cellvalue.length > 0){
        link = "<a style='color:blue;' title='Click here to view subscriber details' href='subscriber?action=display&subscriberNumber=" + cellvalue + "'>" + cellvalue + "</a>";
        return link;
    }
    return cellvalue;
}