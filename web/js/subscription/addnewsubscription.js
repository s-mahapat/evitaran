var journalNameToGroupIDMap = {};
var subscriberType = 0;
var subscriptionSaved = false

function addJournal(){

    bRet = false;
    // merge the old selected data and the new one, else we loose the data while saving the
    // subscription
    var userSelection = getselected(document.getElementById("journalName"));
    $.extend(journalNameToGroupIDMap, userSelection);

    if(subscriberType == 0){
        subscriberType = getSubscriberType($("#subscriberNumber").val());
    }
    var arrRowIds = $("#newSubscription").getDataIDs();
    $.each(userSelection,function(selectedJournalGroupName,selectedJournalGroupCode){
        if(arrRowIds.length != 0){
            intIndex = $.inArray(selectedJournalGroupName, arrRowIds);
            //intIndex = arrRowIds.indexOf(selectedJournalGroupName);
            /* checks if the journal id bieng added is already existing in the grid.
            * Cannot add the same journal twice.
            */
            if(intIndex > -1){
                alert("An entry for the journal " + selectedJournalGroupName + " already exists. You cannot add the same journal twice");
                return true;
            }
        }

        //else get the price details from the server
        startYear = parseInt($("#subscriptionStartYear").val());
        numYears = parseInt($("#endYear").val());
        startmonth = parseInt($("#startMonth").val());
        // handle the case where the start month may not be Jan
        if(startmonth > 1){
            endyear = startYear + numYears;
        }else{
            endyear = startYear + numYears - 1;
        }

        //numYears = $("#endYear").val() - startYear + 1; // +1 to include the current year
        priceDetails = getPrice(startYear, numYears, selectedJournalGroupCode, subscriberType);
        var price = priceDetails[1];
        if(price != null && price != -1){ // check if the price group id is -1
            var newRowData = {
                "journalName": '<a color="blue" title="Click here for Journal List" href="#" onclick="getJournalGroupContents(' + selectedJournalGroupCode + ')">' + selectedJournalGroupName + '</a>',
                "journalPriceGroupID":priceDetails[0],
                "journalCost": price, //get the price
                "startYear": $("#subscriptionStartYear").val(),
                "startMonth": $("#startMonth").val(), //_JDSConstants.monthNames[$("#startMonth").val() - 1],
                "endYear" : endyear,
                "Copies": $("#copies").val(),
                "Total": price * $("#copies").val(),
                "delete":"<img src='images/delete.png' onclick=\"deleteRow('" + selectedJournalGroupName + "')\"/>"
            };
            // the journal code is the rowid.
            bRet = $("#newSubscription").addRowData(selectedJournalGroupName, newRowData,"last");
            updateTotal(price * $("#copies").val());
        }else{
            alert("Failed to add subscription!!! No price defined for the selected Year and Journal Group");
            bRet = bRet && false;
            return(false);

        }
        return(true);
    });
    return(bRet);


}

function updateTotal(val){
    currentTotal = $("#subscriptionTotalValue").text()
    newTotal = parseInt(currentTotal) + parseInt(val);
    var balance = newTotal - $("#amount").val();
    $("#subscriptionTotalValue").text(newTotal);
    $("#balance").val(balance);
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
        alert("No subscription data to save. Please select the journal group and click Add");
        return;
    }
    for(intIndex in arrRowData){
        var rowObj = arrRowData[intIndex];
        //alert(rowObj.startMonth)
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

            if(xmlResponse == null){
                alert("Failed to Save subscription");
                return false;
            }
            $(xmlResponse).find("results").each(function(){
                var error = $(this).find("error").text();
                var subscriptionID = $(this).find("subscriptionID").text();
                if(error){
                    alert(error);
                }
                else if(subscriptionID){
                    //alert("Subscription with ID: " + subscriptionID + " created successfully");
                    $("#subscriptionNumber").val(subscriptionID);
                    $("#btnSaveSubscription").button("disable");
                    $("#btnAddLine").button("disable");
                    $("#btnDeleteAll").button("disable");
                    $("#remarks").attr("disabled",true);
                    $("#subid").val(subscriptionID);
                    subscriptionSaved = true;
                    document.subscriptionForm.submit();

                }
            });
        },
        error: function(jqXHR,textStatus,errorThrown){
            alert("Failed to save subscription. " + textStatus + ": "+ errorThrown);
        },
        dataType: 'xml'
    });
}