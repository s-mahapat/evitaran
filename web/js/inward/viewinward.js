/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */


function makeInwardReadOnly(){

    document.getElementById("btnSaveInward").disabled = true;
    document.getElementById("btnSearchSubscriber").disabled = true;
    document.getElementById("paymentDate").setAttribute("readonly",true);
    document.getElementById("chequeDDReturn").disabled = true;

    //hide the calendar icon using jquery .ui-datepicker-trigger
    $(".ui-datepicker-trigger").hide();

    if(document.getElementById("chequeDDReturn").checked){
        document.getElementById("btnSendReturn").disabled = false;
    }else{
        document.getElementById("btnSendReturn").disabled = true;
    }

    // dummy function to generate random inward numbers
    //document.getElementById("inwardNumber").value = "11K-" + Math.floor(Math.random()*99999);


}