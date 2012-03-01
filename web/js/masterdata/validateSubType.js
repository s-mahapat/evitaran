
function validateSearchSubType(){
    if(isEmpty(document.getElementById("subtypecode"))
        && isEmpty(document.getElementById("subtype"))
    ){
        alert("Please select atleast one search criteria");
        return false;
    }
    else
        return true;
}

function validateSubType(){
    if(isEmpty(document.getElementById("subtypecode"))
        || isEmpty(document.getElementById("subtypedesc"))
        || isEmpty(document.getElementById("freejrnl"))
    ){
        alert("Please enter mandatory fields");
        return false;
    }
    else
        return true;
}




