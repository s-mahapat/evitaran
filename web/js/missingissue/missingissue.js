function addJournal(){

    if ($("#year").val() == 'value') {
        alert("Select Year");
    }

    else if ($("#journalName").val() == 'value'){
        alert("Select Journal");
    }

    else if ($("#month").val() == 'value'){
        alert("Select Month");
    }

    else if ($("#journalGroupName").val() == 'value'){
        alert("Select Journal Group Name");
    }

    else if($("#subscriptionId").val() == 'value') {
        alert("Select Subscription");
    }
    else if($("#missingcopies").val() == 0) {
        alert("Add Missing Copies");
    }
    else{
        var selectedJournalName = $("#journalName").val();
        var selectedYear = $("#year").val();
        var selectedMonth = $("#month").val();
        var selectedJournalGroupName = $("#journalGroupName").val();
        var selectedSubscriptionId = $("#subscriptionId").val();
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
            var copies = 0;
            copies = getCopies(selectedSubscriptionId, selectedJournalGroupName)
            var mcopies = $("#missingcopies").val();
            if (copies >= mcopies){
                var newRowData = {
                    "subscriptionId": $("#subscriptionId").val(),
                    "journalGroupName": $("#journalGroupName").val(),
                    "journalName": $("#journalName").val(),
                    "month": $("#month").val(),
                    "year": $("#year").val(),
                    "scopies": copies,
                    "mcopies": mcopies,
                    "delete":"<img src='images/delete.png' onclick=\"deleteRow('" + selectedJournalName + "')\"/>"
                };
                // the journal code is the rowid.
            bRet = $("#addmissingissueTable").addRowData(selectedJournalName, newRowData,"last");
            }else {
                alert("Failed to add missing issue!!! No of subscribed copies is less than the missing copies");
                bRet = false;
            }

        }else{
            alert("Failed to add missing issue!!! No subscription exists for the selected Year, Month and Journal ");
            bRet = false;
        }
        return(bRet);
    }
}

function getSubscription(selectedJournalName, selectedMonth, selectedYear){
   return 1;
}

function getCopies(subscriptionId, journalGroupName){
    var _copies = 0;

    $.ajax({
        type: 'GET',
        dataType: 'xml',
        async: false,
        url: "missingissue?action=getCopies&journalGroupName=" + journalGroupName + "&subscriptionId=" + subscriptionId,
        success: function(xmlResponse, textStatus, jqXHR){

            $(xmlResponse).find("results").each(function(){
                copies = $(this).find("copies").text();
            });
        },
        error: function(jqXHR,textStatus,errorThrown){
            alert("Failed to get Journal Copies. " + textStatus + ": "+ errorThrown);
        }
       });
   return copies;
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
            name: "subscriptionId",
            value: rowObj.subscriptionId
        });
        rowRequiredData.push({
            name: "journalGroupName",
            value: rowObj.journalGroupName
        });
        rowRequiredData.push({
            name: "journalName",
            value: rowObj.journalName
        });
        rowRequiredData.push({
            name: "month",
            value: rowObj.month
        });
        rowRequiredData.push({
            name: "year",
            value: rowObj.year
        });
        rowRequiredData.push({
            name: "mcopies",
            value: rowObj.mcopies
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
                var mi = $(this).find("missingissueId").text();
                document.forms["addMissingissueForm"].miId.value = mi;
                if(error){
                    alert(error);
                }
                else if(missingissueId){
                    alert("Missing issue with ID: " + $("#miId").val() + " created successfully");
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

function alreadySent(){
    var act;
    $.ajax({
        type: 'POST',
        dataType: 'xml',
        async: false,
        url: "missingissue?action=alreadySent&miId=" +  $("#miId").val()
        + "&inwardNumber=" + $("#inwardNumber").val(),
        success: function(xmlResponse, textStatus, jqXHR){

            $(xmlResponse).find("results").each(function(){
                act = $(this).find("action").text();
            });
            $("#btngMi").button("disable");
            $("#btnReprint").button("disable");
            $("#btnNoCopy").button("disable");
            $("#btnSentMsg").button("disable");
            return true;

        },
        error: function(jqXHR,textStatus,errorThrown){
            alert("Failed to sent mail/ Print. " + textStatus + ": "+ errorThrown);
            return false;
        }
       });
}

function noCopies(){
    var act;
    $.ajax({
        type: 'POST',
        dataType: 'xml',
        async: false,
        url: "missingissue?action=noCopies&miId=" +  $("#miId").val()
        + "&inwardNumber=" + $("#inwardNumber").val(),
        success: function(xmlResponse, textStatus, jqXHR){

            $(xmlResponse).find("results").each(function(){
                act = $(this).find("action").text();
            });
            $("#btngMi").button("disable");
            $("#btnReprint").button("disable");
            $("#btnNoCopy").button("disable");
            $("#btnSentMsg").button("disable");
            return true;

        },
        error: function(jqXHR,textStatus,errorThrown){
            alert("Failed to sent mail/ Print. " + textStatus + ": "+ errorThrown);
            return false;
        }
       });
}

function gMiList(){
    var act;
    $.ajax({
        type: 'POST',
        dataType: 'xml',
        async: false,
        url: "missingissue?action=gMiList&miId=" +  $("#miId").val()
        + "&inwardNumber=" + $("#inwardNumber").val(),
        success: function(xmlResponse, textStatus, jqXHR){

            $(xmlResponse).find("results").each(function(){
                act = $(this).find("action").text();
            });
            $("#btngMi").button("disable");
            $("#btnReprint").button("disable");
            $("#btnNoCopy").button("disable");
            $("#btnSentMsg").button("disable");
            return true;

        },
        error: function(jqXHR,textStatus,errorThrown){
            alert("Failed to sent mail/ Print. " + textStatus + ": "+ errorThrown);
            return false;
        }
       });
}

function reprint(){
    var act;
    $.ajax({
        type: 'POST',
        dataType: 'xml',
        async: false,
        url: "missingissue?action=reprint&miId=" +  $("#miId").val()
        + "&inwardNumber=" + $("#inwardNumber").val(),
        success: function(xmlResponse, textStatus, jqXHR){

            $(xmlResponse).find("results").each(function(){
                act = $(this).find("action").text();
            });
            $("#btngMi").button("disable");
            $("#btnReprint").button("disable");
            $("#btnNoCopy").button("disable");
            $("#btnSentMsg").button("disable");
            document.missingissueForm.submit();
            return true;
        },
        error: function(jqXHR,textStatus,errorThrown){
            alert("Failed to sent mail/ Print. " + textStatus + ": "+ errorThrown);
            return false;
        }
       });
}
