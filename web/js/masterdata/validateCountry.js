
function validateCountry(){
    if(isEmpty(document.getElementById("country")))
    {
        alert("Please enter mandatory fields");
        return false;
    }
    else
        return true;
}


