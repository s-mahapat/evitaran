/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */


function makeInwardReadOnly() {

    $("#btnSaveInward").hide();
    $("#btnCancel").hide();
    $("#btnSearchSubscriber").button("disable");
    $("#btnResetSubscriber").button("disable");
    $("#btnNewInward").button("enable");
    $("#paymentDate").attr("readonly", true);
    $("#chequeDDReturn").attr("disabled", true);

    //hide the calendar icon using jquery .ui-datepicker-trigger
    $("#paymentDate").datepicker("disable");
    //$(".ui-datepicker-trigger").hide();
    if (document.getElementById("chequeDDReturn").checked) {
        $("#btnSendReturn").button("enable");
    } else {
        $("#btnSendReturn").button("disable");
    }

    // dummy function to generate random inward numbers
    //document.getElementById("inwardNumber").value = "11K-" + Math.floor(Math.random()*99999);

}