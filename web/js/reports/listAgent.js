/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
function validateSearchAgent()
{
        return true;
}

function printReport(){
    var url = "reports?action=listAgentPrint" +
        "&selall=" + $("#selall:checked").length +
        "&country=" + $("#country").val()+
        "&state=" + $("#state").val() +
        "&city=" + $("#city").val() +
        "&from=" + $("#from").val() +
        "&to=" + $("#to").val();
    var windowName = "popUp";
    var windowSize = "width=1000,height=600,scrollbars=yes,location=no";
    window.open(url, windowName, windowSize);

}
                        
                       