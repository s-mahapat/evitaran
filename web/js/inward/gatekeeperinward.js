var isSubscriberMandatory = true;
/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
function isInwardSelected(){

    if(selectedInward == 0){
        alert("Please select an Inward");
        return false;

    }else if(document.getElementById("nextAction").value != 'newsubscription'
        && selectedSubscriberId <= 0
        && isSubscriberMandatory
        && document.getElementById("nextAction").value != 'createsubscriber'){
        /*
         *  if the dialog is for newsubscription we do not have check for the subscriber id, just show th next screen
         */
        var selectedSubscriberFromDialog = openModalPopUp("jsp/subscriber/subscriberlist.jsp");
        if(!isEmptyValue(selectedSubscriberFromDialog)){
            selectedSubscriberId = selectedSubscriberFromDialog;
            jQuery("#inwardTable").jqGrid('setRowData', selectedInward, {
                'SubscriberId': selectedSubscriberFromDialog
            });
        }


        /*
         * if the selected action from the left nav was generate profrma invoice(gpi) and a subscriber was not selected
         * just continue to the next screen. Dont mandate a subscriber id. For the others it is mandatory
         */
        if(document.getElementById("nextAction").value == 'gpi' && !selectedSubscriberFromDialog){
            isSubscriberMandatory = false;
        //alert("You have not selected any subscrber");
        }
        return false;
    }
    return true;

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