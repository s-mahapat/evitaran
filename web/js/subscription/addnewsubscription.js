
function makeAddNewSubscriptionReadOnly(){
    document.getElementById("btnEditSubscription").disabled = true;
    document.getElementById("subscriberID").disabled = true;
    document.getElementById("subscriberName").disabled = true;
}

function addJournalToList(){


    if(document.getElementById("selAllJrnl").checked){
        var jrnlArray= new Array();
        var jrnls=document.getElementById("journalName");
        for(j=0;j<jrnls.length;j++){
            jrnlArray[j]=document.subscriptionForm.journalName.options[j].text;
        }

        for(i=0;i<jrnls.length;i++){
            var rowId = jQuery("#subscriptionList").jqGrid('getDataIDs');
            var newRowData = [{
                "Journal Code": "34",
                "Journal Name": jrnlArray[i],
                "Copies#": document.subscriptionForm.noOfCopies.options[document.subscriptionForm.noOfCopies.selectedIndex].text,
                "Start Year": document.subscriptionForm.subscriptionStartYear.options[document.subscriptionForm.subscriptionStartYear.selectedIndex].text,
                "Number Of Years": document.subscriptionForm.noOfYears.options[document.subscriptionForm.noOfYears.selectedIndex].text,
                "Delete Journal": "<input type='Button' name='deleteJournal' value=\"Delete\" onclick=''/>"
            }];
            $("#subscriptionList").addRowData(rowId+1, newRowData);
        }
    }
    else{
        rowId = jQuery("#subscriptionList").jqGrid('getDataIDs');
        newRowData = [{
            "Journal Code": "34",
            "Journal Name": document.subscriptionForm.journalName.options[document.subscriptionForm.journalName.selectedIndex].text,
            "Copies#": document.subscriptionForm.noOfCopies.options[document.subscriptionForm.noOfCopies.selectedIndex].text,
            "Start Year": document.subscriptionForm.subscriptionStartYear.options[document.subscriptionForm.subscriptionStartYear.selectedIndex].text,
            "Number Of Years": document.subscriptionForm.noOfYears.options[document.subscriptionForm.noOfYears.selectedIndex].text,
            "Delete Journal": "<input type='Button' name='deleteJournal' value=\"Delete\" onclick=''/>"
        }];
        $("#subscriptionList").addRowData(rowId+1, newRowData);
    }


}

function disableJrnl(){
    if(document.getElementById("selAllJrnl").checked){
        document.getElementById("journalName").disabled = true;
    }else{
        document.getElementById("journalName").disabled = false;
    }
}
