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
    $("#letterDate").datepicker("disable");

    // disable the email and print buttons if the subscriber id does not exist.
    // this can happen if the inward is created but the subscriber is not, we then do not
    // to whom to send the email/print.
    // also we need the subscriber if to maintain history
    if(isEmptyValue($("#subscriberId").val())){
        $("#btnSendReturn").button("disable");
    }

}