
function makeAddNewSubscriptionReadOnly(){
    document.getElementById("btnEditSubscription").disabled = true;
    document.getElementById("subscriberID").disabled = true;
    document.getElementById("subscriberName").disabled = true;
}

function addJournalToList(subscriptionForm){
    
    
    
    var table = document.getElementById("subscriptionList"); 
  
    var rowCount = table.rows.length; 
    var row = table.insertRow(rowCount); 
    
    var colCount = table.rows[0].cells.length; 
            
    for(var i=0; i<colCount; i++) { 
  
        var newcell = row.insertCell(i); 
                      
        newcell.innerHTML = table.rows[0].cells[i].innerHTML; 
    
        switch(newcell.innerHTML) { 
            case "Journal Code":
                newcell.innerHTML = '34'; 
                break; 
            case "Journal Name":
                var journalName=document.subscriptionForm.journalName.options[document.subscriptionForm.journalName.selectedIndex].text;
                newcell.innerHTML = journalName; 
                break; 
            case "Number Of Copies":
                newcell.innerHTML = document.getElementById("noOfCopies").value; 
                break; 
            case "Number Of Years":
                newcell.innerHTML = document.getElementById("noOfYears").value; 
                break;
            case "Start Year":
                var subscriptionStartYear=document.subscriptionForm.subscriptionStartYear.options[document.subscriptionForm.subscriptionStartYear.selectedIndex].text;
                newcell.innerHTML = subscriptionStartYear; 
                break;
            case "Delete Journal":
                //var link = document.createElement("a"); 
                //link.setAttribute("href", "delete") 
                
                //var linkText = document.createTextNode("Delete"); 
                //link.appendChild(linkText);  
                //// Add the link to the previously created 
                newcell.innerHTML = '<a href="#" onClick=""><img class="deleteIcon" alt="Delete Subscription" src=""></a>';
                break;
        } 
    } 

    
}
    
