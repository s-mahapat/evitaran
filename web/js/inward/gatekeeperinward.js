var isSubscriberMandatory = true;
/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
function isInwardSelected(){

    if(selectedInward == 0){
        alert("Please select an Inward");
        return false;

    }else if(document.getElementById("nextAction").value != 'newsubscription' && selectedSubscriberId <= 0 && isSubscriberMandatory){
        /*
         *  if the dialog is for newsubscription we do not have check for the subscriber id, just show th next screen
         */
        var selectedSubscriberFromDialog = openModalPopUp("jsp/subscriber/subscriberlist.jsp");
        if(selectedSubscriberFromDialog > 0){
            selectedSubscriberId = selectedSubscriberFromDialog;
            jQuery("#inwardTable").jqGrid('setRowData', selectedInward, {'Subscriber Id': selectedSubscriberFromDialog });
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
