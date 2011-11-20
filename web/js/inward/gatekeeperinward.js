/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
function isInwardSelected(){
    if(selectedInward == 0){
        alert("Please select an Inward");
        return false;
    }else if(document.getElementById("nextAction").value != 'newsubscription' && selectedSubscriberId <= 0){

        openModalPopUp("jsp/subscriber/subscriberlist.jsp", 'Select Subscriber');
        return false;
    }
    return true;

}



