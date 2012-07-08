var journalNameToGroupIDMap = {};
var subscriberType = 0;
var subscriptionSaved = false

function addJournal(){

    var bRet = false;
    // merge the old selected data and the new one, else we loose the data while saving the
    // subscription
    var userSelection = getselected(document.getElementById("journalName"));
    $.extend(journalNameToGroupIDMap, userSelection);
    $.each(userSelection,function(selectedJournalGroupName,selectedJournalGroupCode){
        
        if(isDuplicate(selectedJournalGroupName)){
            alert("An entry for the journal " + selectedJournalGroupName + " already exists. Please edit the existing entry");
            return true;
        }

        //else get the price details from the server
        startYear = $("#subscriptionStartYear").val();
        numYears = $("#endYear").val() - startYear + 1; // +1 to include the current year
        priceInfo = getPrice(startYear, numYears, selectedJournalGroupCode, subscriberType);
        price = priceInfo[1];
        if(price != -1){
            $.ajax({
                type: 'POST',
                dataType: 'xml',
                async: true,
                url: "subscription?oper=adddetail",
                data:{
                    subid: $("#subscriptionID").val(),
                    journalGroupID: selectedJournalGroupCode,
                    startYear: startYear,
                    startMonth: $("#startMonth").val(),
                    endYear: $("#endYear").val(),
                    copies: $("#copies").val(),
                    total: price * $("#copies").val(),
                    journalPriceGroupID: priceInfo[0]

                },
                success: function(xmlResponse, textStatus, jqXHR){

                    jQuery("#newSubscription").setGridParam({
                        datatype: "xml"
                    });
                    jQuery("#newSubscription").trigger("reloadGrid");
                    getSubscriptionInfo();
                    bRet = true;
                },
                error: function(jqXHR,textStatus,errorThrown){
                    alert("Failed to add new subscription information. " + textStatus + ": "+ errorThrown);
                }

            });
        }else{
            alert("Failed to add subscription!!! No price defined for the selected Year and Journal Group");
            bRet = bRet && false;
            return(false);
        }
        return(true);
    });
    
    return(bRet);
}

function isDuplicate(journalGroupName){
    var arrRowIds = $("#newSubscription").getDataIDs();
    for(i=0; i<arrRowIds.length; i++){
        if($("#newSubscription").getCell(arrRowIds[i], "journalGroupName") == journalGroupName){            
            return true;
        }
    }
    return false;
}

/*Gets the subscription info from the server*/
function getSubscriptionInfo(){
    $.ajax({
        type: 'GET',
        dataType: 'xml',
        async: true,
        url: "subscription?action=subscriptioninfo&id=" + $("#subscriptionID").val(),
        success: function(xmlResponse, textStatus, jqXHR){

            $(xmlResponse).find("results").find("row").each(function(){
                $("#subscriptionTotalValue").val($(this).find("subscriptionTotal").text());
                $("#balance").val($(this).find("balance").text());
                $("#inwardNumber").val($(this).find("inwardNumber").text());
                $("#amount").val($(this).find("amount").text());
            });
        },
        error: function(jqXHR,textStatus,errorThrown){
            alert("Failed to refresh subscription information. " + textStatus + ": "+ errorThrown);
        }

    });
}