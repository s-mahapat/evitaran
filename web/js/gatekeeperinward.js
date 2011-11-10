/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */


function validate(){

    if(document.getElementById("selectedInward").value.length == 0){
        window.status = "Please select an Inward";
        alert("Please select an Inward");
        return false;
    }
    return true;

}