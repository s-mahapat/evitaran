function addJournal(){

    var selectedJournalName = $("#journalName").val();
    var selectedYear = $("#year").val();
    var selectedMonth = $("#month").val();
    var arrRowIds = $("#addmissingissueTable").getDataIDs();
    if(arrRowIds.length != 0){
        intIndex = arrRowIds.indexOf(selectedJournalName, selectedMonth, selectedYear);
        /* checks if the journal id bieng added is already existing in the grid.
         * Cannot add the same journal twice.
         */
        if(intIndex > -1){
            alert("An entry for the journal year and Month already exists. No duplicate entries allowed");
            return false;
        }
    }
    var validSubscription = 0;
    validSubscription = getSubscription(selectedJournalName, selectedMonth, selectedYear);
    
    if(validSubscription == 1){ // check the validity of subscription
        var newRowData = {
            "journalName": $("#journalName").val(),
            "month": $("#month").val(), 
            "year": $("#year").val(),
            "delete":"<img src='images/delete.png' onclick=\"deleteRow('" + selectedJournalName + "')\"/>"
        };
        // the journal code is the rowid.
        bRet = $("#addmissingissueTable").addRowData(selectedJournalName, newRowData,"last");
    }else{
        alert("Failed to add missing issue!!! No subscription exists for the selected Year, Month and Journal ");
        bRet = false;
    }
    return(bRet);
}

function getSubscription(selectedJournalName, selectedMonth, selectedYear){
   return 1;
}

function deleteRow(rowid){
    // do not allow to delete a row if the subscription is already saved

    if(rowid == "All"){
        // clears the entire grid
        $("#addmissingissueTable").clearGridData();
        // reset the total to zero
    }else{
        // to delete a single row from the grid
        $("#addmissingissueTable").delRowData(rowid);
    }
}

function saveMissingInfo(){
    var arrRowData = $("#addmissingissueTable").getRowData();
    var rowRequiredData = [];
    var ids = $("#addmissingissueTable").getDataIDs();
    if(ids.length == 0){
        alert("No Missing Issue to Save");
        return;
    }
    for(intIndex in arrRowData){
        var rowObj = arrRowData[intIndex];
        /*pick on required fields from the UI. Not fields are requred, they can be derieved from the database itself.
         * e.g. the journal name can be derieved from the code if required.
         */

        rowRequiredData.push({
            name: "journalName",
            value: rowObj.journalName
        });
        rowRequiredData.push({
            name: "month",
            value: rowObj.startMonth
        });
        rowRequiredData.push({
            name: "year",
            value: rowObj.startYear
        });        
    }

    $.ajax({
        type: 'POST',
        url: "missingissue?action=save"
            + "&subscriberNumber=" + $("#subscriberNumber").val()
            + "&inwardNumber=" + $("#inwardNumber").val(),
        data: $.param(rowRequiredData),
        success: function(xmlResponse, textStatus, jqXHR){

            if(xmlResponse == null){
                alert("Failed to add Missing Issue");
                return false;
            }
            $(xmlResponse).find("results").each(function(){
                var error = $(this).find("error").text();
                var missingissueId = $(this).find("missingissueId").text();
                if(error){
                    alert(error);
                }
                else if(missingissueId){
                    alert("Subscription with ID: " + missingissueId + " created successfully");
                    $("#btnsaveMissingInfo").button("disable");
                    $("#btnAddLine").button("disable");
                    $("#btnDeleteAll").button("disable");
                    document.addMissingissueForm.submit();
                }
            });
        },
        error: function(jqXHR,textStatus,errorThrown){
            alert("Failed to save missing issue " + textStatus + ": "+ errorThrown);
        },
        dataType: 'xml'
    });
}
