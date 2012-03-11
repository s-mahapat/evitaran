/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
function validateSearchSubType()
{
    if (isEmpty(document.getElementById("subtype"))
        && isEmpty(document.getElementById("nationality"))
          &&  isEmpty(document.getElementById("institutional"))
           && document.getElementById("selall").checked == false
    ){
        alert("Please select atleast one search criteria");
        return false;
    }
    else
        return true;
}

function printReport(){
    var url = "reports?action=listSubTypePrint" +
        "&selall=" + $("#selall:checked").length +
        "&subtype=" + $("#subtype").val() +
        "&nationality=" + $('#nationality').val() +
        "&institutional=" + $('#institutional').val();
    var windowName = "popUp";
    var windowSize = "width=1000,height=600,scrollbars=yes,location=no";
    window.open(url, windowName, windowSize);

}
