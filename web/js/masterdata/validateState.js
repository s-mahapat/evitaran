
function validateState(){
    if(isEmpty(document.getElementById("state")))
    {
        alert("Please enter mandatory fields");
        return false;
    }
    else
        return true;
}


