
function disableJrnl(){
    if(document.getElementById("selAllJrnl").checked){
        document.getElementById("journalName").disabled = true;
    }else{
        document.getElementById("journalName").disabled = false;
    }
}

function setEndYear(){
    var startYear = parseInt($("#subscriptionStartYear").val(),10);
    var html;
    for(i=0;i<=4;i++){
        html += "<option value='" + (startYear+i) + "'>" + (startYear+i) + "</option>";
    }
    $("#endYear").html(html);
}

function addJournal(){
    // if the select all is checked
    if($("#selAllJrnl").attr("checked")){
        // clear the grid before adding all the journals
        deleteRow("All");
        for(strJournal in journalInfo){
            _addJournal(strJournal);
        }
    }else{
        var selectedJournal = $("#journalName").val();
        _addJournal(selectedJournal);
    }

}

function _addJournal(selectedJournal){
    var arrRowIds = $("#newSubscription").getDataIDs();
    //var selectedJournal = $("#journalName").val();
    var journalCode = journalInfo[selectedJournal].code;
    if(arrRowIds.length != 0){
        intIndex = arrRowIds.indexOf(journalCode);
        /* checks if the journal id bieng added is already existing in the grid.
         * Cannot add the same journal twice.
         */
        if(intIndex > -1){
            alert("An entry for the journal already exists.Cannot subscribe to the same journal twice");
            return false;
        }
    }
    var newRowData = {
        "journalName": selectedJournal,
        "journalCode": journalCode,
        "journalCost": journalInfo[selectedJournal].price,
        "startYear": $("#subscriptionStartYear").val(),
        "endYear" : $("#endYear").val(),
        "Copies": $("#copies").val(),
        "Discount":journalInfo[selectedJournal].discount,
        "Total":journalInfo[selectedJournal].price - (journalInfo[selectedJournal].discount * journalInfo[selectedJournal].price/100),
        "delete":"<img src='images/delete.png' onclick=\"deleteRow('" + journalCode + "')\"/>"
    };
    // the journal code is the rowid.
    bRet = $("#newSubscription").addRowData(journalCode, newRowData,"last");
    if(bRet == false){
        alert("Failed to add Journal to Subscription");
    }
    return(bRet);
}

function deleteRow(rowid){
    if(rowid == "All"){
        // clears the entire grid
        $("#newSubscription").clearGridData();
    }else{
        // to delete a single row from the grid
        $("#newSubscription").delRowData(rowid);
    }

}

function saveSubscription(){
    var arrRowData = $("#newSubscription").getRowData();
    var rowRequiredData = [];
    var subscriptionTotal = 0;
    for(intIndex in arrRowData){
        var rowObj = arrRowData[intIndex];

        //keep adding the row total to get final subscription total value
        subscriptionTotal += parseInt(rowObj.Total);

        /*pick on required fields from the UI. Not fields are requred, they can be derieved from the database itself.
         * e.g. the journal name can be derieved from the code if required.
         */

        rowRequiredData.push({
            name: "journalCode",
            value: rowObj.journalCode
        });
        rowRequiredData.push({
            name: "startYear",
            value: rowObj.startYear
        });
        rowRequiredData.push({
            name: "endYear",
            value: rowObj.endYear
        });
        rowRequiredData.push({
            name: "copies",
            value: rowObj.Copies
        });


    }
    rowRequiredData.push({
        name: "subscriptionTotal",
        value: subscriptionTotal
    });
    $.ajax({
        type: 'POST',
        url: "subscription?oper=add&subscriberNumber=" + $("#subscriberNumber").val() + "&remarks=" + $("#remarks").val(),
        data: $.param(rowRequiredData),
        success: function(xmlResponse, textStatus, jqXHR){

            $(xmlResponse).find("results").each(function(){
                var error = $(this).find("error").text();
                var subscriptionID = $(this).find("subscriptionID").text();
                if(error){
                    alert(error);
                }
                else if(subscriptionID){
                    alert("Subscription with ID: " + subscriptionID + " created successfully");
                    $("#btnSaveSubscription").attr("disabled",true);
                    $("#remarks").attr("disabled",true);
                }
            });
        },
        error: function(jqXHR,textStatus,errorThrown){
            alert("Failed to save subscription. " + textStatus + ": "+ errorThrown);
        },
        dataType: 'xml'
    });
}