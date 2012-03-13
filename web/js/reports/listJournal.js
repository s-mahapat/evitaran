/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
function validateSearchJournal()
{
    if (document.getElementById("journalGroupName").value == 0
        && document.getElementById("selall").checked == false
    ){
        alert("Please select atleast one search criteria");
        return false;
    }
    else
        return true;
}

function printReport(){
    var url = "reports?action=listJournalPrint" +
        "&selall=" + $("#selall:checked").length +
        "&journalGroupName=" + $("#journalGroupName").val();
    var windowName = "popUp";
    var windowSize = "width=1000,height=600,scrollbars=yes,location=no";
    window.open(url, windowName, windowSize);

}

