/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
function validateSearchJournal()
{
    if (document.getElementById("journalGroupName").value == 0
    ){
        alert("Please select journal group");
        return false;
    }
    else
        return true;
}

function printReport(){
    var url = "reports?action=listJournalPrint" +
        "&journalGroupName=" + $("#journalGroupName").val();
    var windowName = "popUp";
    var windowSize = "width=1000,height=600,scrollbars=yes,location=no";
    window.open(url, windowName, windowSize);

}

