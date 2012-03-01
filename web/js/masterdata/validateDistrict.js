
function validateDistrict(){
    if(isEmpty(document.getElementById("district")))
    {
        alert("Please enter mandatory fields");
        return false;
    }
    else
        return true;
}
