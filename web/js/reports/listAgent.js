/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
function validateSearchAgent()
{
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
