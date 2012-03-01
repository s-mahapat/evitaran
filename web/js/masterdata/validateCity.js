
function validateCity(){
    if(isEmpty(document.getElementById("city")))
    {
        alert("Please enter mandatory fields");
        return false;
    }
    else
        return true;
}


