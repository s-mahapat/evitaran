var journalNameToGroupIDMap = {};
var subscriberType = 0;
var subscriptionSaved = false
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
    journalNameToGroupIDMap[selectedJournalGroupName] = selectedJournalGroupCode;
    if(isDuplicate(selectedJournalGroupName)){
        return false;
    }

    //else get the price details from the server
    startYear = $("#subscriptionStartYear").val();
    numYears = $("#endYear").val() - startYear + 1; // +1 to include the current year
    price = getPrice(startYear, numYears, selectedJournalGroupCode, subscriberType);
    if(price != -1){
        var newRowData = {
            "journalName": '<a color="blue" title="Click here for Journal List" href="#" onclick="getJournalGroupContents(' + selectedJournalGroupCode + ')">' + selectedJournalGroupName + '</a>',
            "journalCost": price,
            "startYear": $("#subscriptionStartYear").val(),
            "endYear" : $("#endYear").val(),
            "Copies": $("#copies").val(),
            "Total": price * $("#copies").val(),
            "delete":"<img src='images/delete.png' onclick=\"deleteRow('" + selectedJournalGroupName + "')\"/>"
        };
        // the journal code is the rowid.
        bRet = $("#newSubscription").addRowData(selectedJournalGroupName, newRowData,"last");
        updateTotal(price * $("#copies").val());
    }else{
        bRet = false;
    }
    return(bRet);
}

function isDuplicate(journalGroupName){
    var arrRowIds = $("#newSubscription").getDataIDs();
    for(i=0; i<arrRowIds.length; i++){
        if($("#newSubscription").getCell(arrRowIds[i], "journalGroupName") == journalGroupName){
            alert("An entry for the journal already exists. Please edit the existing entry");
            return true;
        }
    }
    return false;
}

function updateTotal(val){
    currentTotal = $("#subscriptionTotalValue").text()
    newTotal = parseInt(currentTotal) + parseInt(val);
    $("#subscriptionTotalValue").text(newTotal);
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
    var _price = -1;
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

function getJournalGroupContents(groupID){
    var html = '<ol>';
    $.ajax({
        type: 'GET',
        dataType: 'xml',
        url: "subscription?oper=getJournalGroupContents&groupid=" + groupID,
        success: function(xmlResponse, textStatus, jqXHR){

            $(xmlResponse).find("results").find("row").find("journalname").each(function(){
                html += '<li>' + $(this).text() + '</li>';
            });
            html += '</ol>';
            $( "#journalGroupContents").html(html);
        },
        error: function(jqXHR,textStatus,errorThrown){
            alert("Failed to get journal price. " + textStatus + ": "+ errorThrown);
        }

    });
    //$( "#journalGroupContents").append("test");
    $( "#journalGroupContents" ).dialog();
}

function deleteRow(rowid){
    // do not allow to delete a row if the subscription is already saved
    if(subscriptionSaved){
        return;
    }
    if(rowid == "All"){
        // clears the entire grid
        $("#newSubscription").clearGridData();
        // reset the total to zero
        updateTotal(-$("#subscriptionTotalValue").text());
    }else{
        rowTotal = $("#newSubscription").getCell(rowid,"Total");
        //subbtract row value from total
        updateTotal(-rowTotal);
        // to delete a single row from the grid
        $("#newSubscription").delRowData(rowid);
    }

}

function saveSubscription(){
    var arrRowData = $("#newSubscription").getRowData();
    var rowRequiredData = [];
    var subscriptionTotal = $("#subscriptionTotalValue").text();
    var ids = $("#newSubscription").getDataIDs();
    if(ids.length == 0){
        alert("No subscription data to save. Please select the journal jroup and click Add");
        return;
    }
    for(intIndex in arrRowData){
        var rowObj = arrRowData[intIndex];
        /*pick on required fields from the UI. Not fields are requred, they can be derieved from the database itself.
         * e.g. the journal name can be derieved from the code if required.
         */

        rowRequiredData.push({
            name: "journalGroupID",
            value: journalNameToGroupIDMap[ids[intIndex]]
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
        rowRequiredData.push({
            name: "total",
            value: rowObj.Total
        });


    }
    rowRequiredData.push({
        name: "subscriptionTotal",
        value: subscriptionTotal
    });
    $.ajax({
        type: 'POST',
        url: "subscription?oper=add"
            + "&subscriberNumber=" + $("#subscriberNumber").val()
            + "&remarks=" + $("#remarks").val()
            + "&inwardNumber=" + $("#inwardNumber").val(),
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
                    $("#subscriptionNumber").val(subscriptionID);
                    $("#btnSaveSubscription").button("disable");
                    $("#btnAddLine").button("disable");
                    $("#btnDeleteAll").button("disable");
                    $("#remarks").attr("disabled",true);
                    subscriptionSaved = true;

                    //ask if we have print inward acknowledgement
                    if(confirm("Do you want send the inward acknowledgement?")){
                        //document.subscriptionForm.submit();
                        window.location.href = "inward?action=sendAck"
                            + "&inwardNumber="   + $("#inwardNumber").val();
                    }
                }
            });
        },
        error: function(jqXHR,textStatus,errorThrown){
            alert("Failed to save subscription. " + textStatus + ": "+ errorThrown);
        },
        dataType: 'xml'
    });
}

/*Gets the subscription info from the server*/
function getSubscriptionInfo(){
    alert("here");
    $.ajax({
        type: 'GET',
        dataType: 'xml',
        async: true,
        url: "subscription?action=subscriptioninfo&id=" + $("#subscriptionID").val(),
        success: function(xmlResponse, textStatus, jqXHR){

            $(xmlResponse).find("results").each(function(){
                //_subscriberType = $(this).find("subtype").text();
            });
        },
        error: function(jqXHR,textStatus,errorThrown){
            alert("Failed to refresh subscription information. " + textStatus + ": "+ errorThrown);
        }

    });
}