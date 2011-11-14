/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

function makeInwardReadOnly(){

    document.getElementById("btnEditInward").disabled = true;
    if(document.getElementById("checkReturn").checked){
        document.getElementById("btnSendReturn").disabled = false;
    }else{
        document.getElementById("btnSendReturn").disabled = true;
    }
}

function enableCheckReturn(){
    if(document.getElementById("checkReturn").checked){
        document.getElementById("btnSendReturn").disabled = false;
    }else{
        document.getElementById("btnSendReturn").disabled = true;
    }
}
