/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

function makeInwardReadOnly(){

    document.getElementById("btnEditInward").disabled = true;
    if(document.getElementById("chequeDDReturn").checked){
        document.getElementById("btnSendReturn").disabled = true;
    }else{
        document.getElementById("btnSendReturn").disabled = false;
    }
}
