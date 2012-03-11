/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
function validateSearchJournal()
{
    if (isEmpty(document.getElementById("group"))
        && document.getElementById("selall").checked == false
    ){
        alert("Please select atleast one search criteria");
        return false;
    }
    else
        return true;
}

