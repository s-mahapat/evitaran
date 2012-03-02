
function validateAgent(){
    if(isEmpty(document.getElementById("agentName"))
        || isEmpty(document.getElementById("city"))
        || (document.getElementById("city").value == "NULL")
    ){
        alert("Please enter mandatory fields");
        return false;
    }
    else
        return true;
}

