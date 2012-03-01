
function validateSearchJournal(){
    if(isEmpty(document.getElementById("journalCode"))
        && isEmpty(document.getElementById("journalName"))
    ){
        alert("Please select atleast one search criteria");
        return false;
    }
    else
        return true;
}

function validateJournal(){
    if(isEmpty(document.getElementById("journalCode"))
        || isEmpty(document.getElementById("journalName"))
    ){
        alert("Please enter mandatory fields");
        return false;
    }
    else
        return true;
}

