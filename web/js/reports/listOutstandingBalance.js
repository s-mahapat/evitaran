/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
function validateSearchJournal()
{
    If (document.getElementById("subStart").value == 0)
    if (document.getElementById("subStart").value == 0){
        alert("Please select Subscription Start Year");
        return false;
    }
    else if (document.getElementById("subEnd").value == 0){
        alert("Please select Subscription End Year");
        return false;
    }
    else {
        return true;
    }
}

function printReport(){
    var url = "reports?action=listJournalPrint" +
        "&journalGroupName=" + $("#journalGroupName").val();
    var windowName = "popUp";
    var windowSize = "width=1000,height=600,scrollbars=yes,location=no";
    window.open(url, windowName, windowSize);

}

