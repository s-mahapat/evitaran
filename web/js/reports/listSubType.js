/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
function validateSearchSubType()
{
    if (isEmpty(document.getElementById("subtype"))
        && isEmpty(document.getElementById("nationality"))
          &&  isEmpty(document.getElementById("institutional"))
           && isChecked(document.getElementById("selall"))
    ){
        alert("Please select atleast one search criteria");
        return false;
    }
    else
        return true;
}

