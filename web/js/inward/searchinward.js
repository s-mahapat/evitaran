/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

function init(){

    document.searchInwardForm.inwardNumber.focus();
}


function setInwardSubscriber(inwardId,subscriberId){
    selectedInward = inwardId;
    selectedSubscriberId = subscriberId || 0;

}