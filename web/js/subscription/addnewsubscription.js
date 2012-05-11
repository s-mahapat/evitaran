var journalNameToGroupIDMap = {};
var subscriberType = 0;
var subscriptionSaved = false

function addJournal(){

    var selectedJournalGroupCode = $("#journalName").val();
    var selectedJournalGroupName = $("#journalName :selected").text();
    var _JDSConstants = new JDSConstants();
    journalNameToGroupIDMap[selectedJournalGroupName] = selectedJournalGroupCode;
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
    priceDetails = getPrice(startYear, numYears, selectedJournalGroupCode, subscriberType);
    var price = priceDetails[1];
    if(price != -1){ // check if the price group id is -1
        var newRowData = {
            "journalName": '<a color="blue" title="Click here for Journal List" href="#" onclick="getJournalGroupContents(' + selectedJournalGroupCode + ')">' + selectedJournalGroupName + '</a>',
            "journalPriceGroupID":priceDetails[0],
            "journalCost": price, //get the price
            "startYear": $("#subscriptionStartYear").val(),
            "startMonth": $("#startMonth").val(), //_JDSConstants.monthNames[$("#startMonth").val() - 1],
            "endYear" : $("#endYear").val(),
            "Copies": $("#copies").val(),
            "Total": price * $("#copies").val(),
            "delete":"<img src='images/delete.png' onclick=\"deleteRow('" + selectedJournalGroupName + "')\"/>"
        };
        // the journal code is the rowid.
        bRet = $("#newSubscription").addRowData(selectedJournalGroupName, newRowData,"last");
        updateTotal(price * $("#copies").val());
    }else{
        alert("Failed to add subscription!!! No price defined for the selected Year and Journal Group");
        bRet = false;
    }
    return(bRet);
}

function updateTotal(val){
    currentTotal = $("#subscriptionTotalValue").text()
    newTotal = parseInt(currentTotal) + parseInt(val);
    $("#subscriptionTotalValue").text(newTotal);
}



/*function getPrice(startYear, years, journalGroupID, subscriberTypeID){
    var _price = -1;
    var _id = -1;
    var _priceDetails = new Array();
    $.ajax({
        type: 'GET',
        dataType: 'xml',
        async: false,
        url: "subscription?oper=getprice&startyear=" + startYear + "&years=" + years +
        "&journalgroupid=" + journalGroupID + "&subtypeid=" + subscriberTypeID,
        success: function(xmlResponse, textStatus, jqXHR){

            $(xmlResponse).find("results").find("row").each(function(){
                _id = $(this).find("id").text();
            });
            $(xmlResponse).find("results").find("row").each(function(){
                _price = $(this).find("rate").text();
            });
            _priceDetails[0] = _id;
            _priceDetails[1] = _price;
        },
        error: function(jqXHR,textStatus,errorThrown){
            alert("Failed to get Journal Group price. " + textStatus + ": "+ errorThrown);
        }

    });
    return _priceDetails;
}*/

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
            name: "journalPriceGroupID",
            value: rowObj.journalPriceGroupID
        });
        rowRequiredData.push({
            name: "startYear",
            value: rowObj.startYear
        });
        rowRequiredData.push({
            name: "startMonth",
            value: rowObj.startMonth
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

                    document.subscriptionForm.submit();

                    //ask if we have print inward acknowledgement
                    //if(confirm("Do you want send the inward acknowledgement?")){
                        //
                        //window.location.href = "inward?action=followOnProcess"
                            //+ "&inwardNumber="   + $("#inwardNumber").val() + "&purpose=" + inwardPurpose;
                    //}
                }
            });
        },
        error: function(jqXHR,textStatus,errorThrown){
            alert("Failed to save subscription. " + textStatus + ": "+ errorThrown);
        },
        dataType: 'xml'
    });
}