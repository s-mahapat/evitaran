var journalNameToCodeMap = {};
var subscriberType = 0;
function setEndYear(){
    var startYear = parseInt($("#subscriptionStartYear").val(),10);
    var html;
    for(i=0;i<=4;i++){
        html += "<option value='" + (startYear+i) + "'>" + (startYear+i) + "</option>";
    }
    $("#endYear").html(html);
}

function addJournal(){

    var selectedJournalGroupCode = $("#journalName").val();
    var selectedJournalGroupName = $("#journalName :selected").text();


    journalNameToCodeMap[selectedJournalGroupName] = selectedJournalGroupCode;
    if(subscriberType == 0){
        subscriberType = getSubscriberType($("#subscriberNumber").val());
    }
    var arrRowIds = $("#newSubscription").getDataIDs();
    if(arrRowIds.length != 0){
        intIndex = arrRowIds.indexOf(selectedJournalGroupName);
        /* checks if the journal id bieng added is already existing in the grid.
         * Cannot add the same journal twice.
         */
        if(intIndex > -1){
            alert("An entry for the journal already exists.Cannot subscribe to the same journal twice");
            return false;
        }
    }

    //else get the price details from the server
    startYear = $("#subscriptionStartYear").val();
    numYears = $("#endYear").val() - startYear + 1; // +1 to include the current year
    price = getPrice(startYear, numYears, selectedJournalGroupCode, subscriberType);
    var newRowData = {
        "journalName": selectedJournalGroupName,
        "journalCost": price,
        "startYear": $("#subscriptionStartYear").val(),
        "endYear" : $("#endYear").val(),
        "Copies": $("#copies").val(),
        "Total": price * $("#copies").val(),
        "delete":"<img src='images/delete.png' onclick=\"deleteRow('" + selectedJournalGroupName + "')\"/>"
    };
    // the journal code is the rowid.
    bRet = $("#newSubscription").addRowData(selectedJournalGroupName, newRowData,"last");
    if(bRet == false){
        alert("Failed to add Journal to Subscription");
    }
    return(bRet);
}

function getSubscriberType(subscriberNumber){
    var _subscriberType = 0;
    $.ajax({
        type: 'GET',
        dataType: 'xml',
        async: false,
        url: "subscriber?action=getSubscriberType&subscriberNumber=" + subscriberNumber,
        success: function(xmlResponse, textStatus, jqXHR){

            $(xmlResponse).find("results").each(function(){
                _subscriberType = $(this).find("subtype").text();
            });
        },
        error: function(jqXHR,textStatus,errorThrown){
            alert("Failed to get subscriber type. " + textStatus + ": "+ errorThrown);
        }

    });
    return _subscriberType;
}

function getPrice(startYear, years, journalGroupID, subscriberTypeID){
    var _price = 0;
    $.ajax({
        type: 'GET',
        dataType: 'xml',
        async: false,
        url: "subscription?oper=getprice&startyear=" + startYear + "&years=" + years +
            "&journalgroupid=" + journalGroupID + "&subtypeid=" + subscriberTypeID,
        success: function(xmlResponse, textStatus, jqXHR){

            $(xmlResponse).find("results").each(function(){
                _price = $(this).find("price").text();
            });
        },
        error: function(jqXHR,textStatus,errorThrown){
            alert("Failed to get journal price. " + textStatus + ": "+ errorThrown);
        }

    });
    return _price;
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