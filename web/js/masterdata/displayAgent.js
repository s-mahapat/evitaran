/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

function makeAgentReadOnly(){

    //document.getElementById("btnEdit").disabled = true;
    document.getElementById("btnSave").disabled = true;
    //document.getElementById("regDate").disabled = true;
    //document.getElementById("regDate").setAttribute("readonly",true);
    //$("#regDate").datepicker("disable");
    document.getElementById("regDate").disabled = true;
    document.getElementById("agentName").disabled = true;
    document.getElementById("discount").disabled = true;
    document.getElementById("emailId").disabled = true;
    document.getElementById("address").disabled = true;
    document.getElementById("city").disabled = true;
    document.getElementById("district").disabled = true;
    document.getElementById("state").disabled = true;
    document.getElementById("country").disabled = true;
    document.getElementById("pinCode").disabled = true;

}