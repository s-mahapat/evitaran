var journalNameToGroupIDMap = {};
var subscriberType = 0;
var subscriptionSaved = false;
var agent_discount = null;

function addJournal() {

    bRet = false;
    // merge the old selected data and the new one, else we loose the data while saving the
    // subscription
    var userSelection = getselected(document.getElementById("journalName"));
    if (jQuery.isEmptyObject(userSelection)) {
        alert("Please select atleast one Journal from the list");
        return false;
    }
    $.extend(journalNameToGroupIDMap, userSelection);

    if (subscriberType == 0) {
        subscriberType = getSubscriberType($("#subscriberNumber").val());
    }
    var arrRowIds = $("#newSubscription").getDataIDs();
    $.each(userSelection, function(selectedJournalGroupName, selectedJournalGroupCode) {
        if (arrRowIds.length != 0) {
            intIndex = $.inArray(selectedJournalGroupName, arrRowIds);
            //intIndex = arrRowIds.indexOf(selectedJournalGroupName);
            /* checks if the journal id bieng added is already existing in the grid.
             * Cannot add the same journal twice.
             */
            if (intIndex > -1) {
                alert("An entry for the journal " + selectedJournalGroupName + " already exists. You cannot add the same journal twice");
                return true;
            }
        }

        //else get the price details from the server
        startYear = parseInt($("#subscriptionStartYear").val());
        numYears = parseInt($("#endYear").val());
        startmonth = parseInt($("#startMonth").val());
        // handle the case where the start month may not be Jan
        if (startmonth > 1) {
            endyear = startYear + numYears;
        } else {
            endyear = startYear + numYears - 1;
        }

        //numYears = $("#endYear").val() - startYear + 1; // +1 to include the current year
        priceDetails = getPrice(startYear, numYears, selectedJournalGroupCode, subscriberType);
        var price = priceDetails[1];
        if (price != null && price != -1) { // check if the price group id is -1
            var newRowData = {
                "journalName": '<a color="blue" title="Click here for Journal List" href="#" onclick="getJournalGroupContents(' + selectedJournalGroupCode + ')">' + selectedJournalGroupName + '</a>',
                "journalPriceGroupID": priceDetails[0],
                "journalCost": price,
                //get the price
                "startYear": $("#subscriptionStartYear").val(),
                "startMonth": $("#startMonth").val(),
                //_JDSConstants.monthNames[$("#startMonth").val() - 1],
                "endYear": endyear,
                "Copies": $("#copies").val(),
                "Total": price * $("#copies").val(),
                "delete": "<img src='images/delete.png' onclick=\"deleteRow('" + selectedJournalGroupName + "')\"/>"
            };
            // the journal code is the rowid.
            bRet = $("#newSubscription").addRowData(selectedJournalGroupName, newRowData, "last");
            updateTotal(price * $("#copies").val());
        } else {
            alert("Failed to add subscription!!! No price defined for the selected Year and Journal Group");
            bRet = bRet && false;
            return (false);

        }
        return (true);
    });
    return (bRet);
}

function updateTotal(val) {
    var balance = 0;
    var currentTotal = $("#subscriptionTotalValue").text()
    var newTotal;
    var agentid = parseInt($("#agentid").val());

    // set the discount to 0% update later
    $("#discount").text(0);

    // if the subscription is from agent, we need to calculate discount
    if(agentid && agentid > 0){
        if(agent_discount == null){
            agent_discount = getAgentDiscount($("#agentid").val());
        }
        $("#discount").text(agent_discount);
        var discountedval = parseInt(val) - (agent_discount/100 * parseInt(val));
        newTotal = parseInt(currentTotal) + parseInt(discountedval);
    }
    else{
        newTotal = parseInt(currentTotal) + parseInt(val);
        balance = newTotal - $("#amount").text();
    }
    $("#subscriptionTotalValue").text(newTotal);
    $("#balancelabel").text(balance);
    $("#balance").val(balance);
}


function getJournalGroupContents(groupID) {
    var html = '<ol>';
    $.ajax({
        type: 'GET',
        dataType: 'xml',
        url: "subscription?oper=getJournalGroupContents&groupid=" + groupID,
        success: function(xmlResponse, textStatus, jqXHR) {

            $(xmlResponse).find("results").find("row").find("journalname").each(function() {
                html += '<li>' + $(this).text() + '</li>';
            });
            html += '</ol>';
            $("#journalGroupContents").html(html);
        },
        error: function(jqXHR, textStatus, errorThrown) {
            alert("Failed to get journal price. " + textStatus + ": " + errorThrown);
        }

    });
    //$( "#journalGroupContents").append("test");
    $("#journalGroupContents").dialog();
}

function deleteRow(rowid) {
    // do not allow to delete a row if the subscription is already saved
    if (subscriptionSaved) {
        return;
    }
    if (rowid == "All") {
        // clears the entire grid
        $("#newSubscription").clearGridData();
        // reset the total to zero
        $("#subscriptionTotalValue").text(0);
    } else {
        rowTotal = $("#newSubscription").getCell(rowid, "Total");
        //subbtract row value from total
        updateTotal(-rowTotal);
        // to delete a single row from the grid
        $("#newSubscription").delRowData(rowid);
    }

}

function saveSubscription() {

    var ids = $("#newSubscription").getDataIDs();
    if (ids.length == 0) {
        alert("No subscription data to save. Please select the journal group and click Add");
        return false;
    }
    // if the subscription is duplicate do not submit the form
    var isDuplicate = isSubscriptionDuplicate();
    if (isDuplicate == true) {
        window.location='main2/inward/converttopayment/' + $("#inwardNumber").val() + "/" + $("#subscriberNumber").val();
        return false;
    }else if(isDuplicate == -1){
        // user pressed Cancel
        return false;
    }

    var arrRowData = $("#newSubscription").getRowData();
    var rowRequiredData = [];
    var subscriptionTotal = $("#subscriptionTotalValue").text();
    
    for (intIndex in arrRowData) {
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
        url: "subscription?oper=add" +
        "&subscriberNumber=" +
        $("#subscriberNumber").val() +
        "&inwardNumber=" +
        $("#inwardNumber").val() +
        "&createAgntSubscription=" + $("#createAgntSubscription").val(),
        data: $.param(rowRequiredData),
        success: function(xmlResponse, textStatus, jqXHR) {

            if (xmlResponse == null) {
                alert("Failed to Save subscription");
                return false;
            }
            $(xmlResponse).find("results").each(function() {
                var error = $(this).find("success").text();
                var subscriptionID = $(this).find("subscriptionID").text();
                if (error == "false") {
                    alert($(this).find("message").text());
                } else if (subscriptionID) {
                    //alert("Subscription with ID: " + subscriptionID + " created successfully");
                    $("#subscriptionNumber").val(subscriptionID);
                    $("#btnSaveSubscription").button("disable");
                    $("#btnAddLine").button("disable");
                    $("#btnDeleteAll").button("disable");
                    //$("#remarks").attr("disabled", true);
                    $("#subid").val(subscriptionID);
                    subscriptionSaved = true;
                    document.subscriptionForm.submit();

                }
            });
            return true;
        },
        error: function(jqXHR, textStatus, errorThrown) {
            alert("Failed to save subscription. " + textStatus + ": " + errorThrown);
        },
        dataType: 'xml'
    });
    return true;
}

function isSubscriptionDuplicate() {
    var arrRowData = $("#newSubscription").getRowData();
    var rowRequiredData = [];
    var ids = $("#newSubscription").getDataIDs();
    var isDuplicate = false;
    for (intIndex in arrRowData) {
        var rowObj = arrRowData[intIndex];

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
    }

    // add the subscriber id also to the data to be sent to server
    rowRequiredData.push({
        name: "subscriberid",
        value: $("#subid").val()
    });

    $.ajax({
        type: 'GET',
        url: "main2/subscription/dupcheck/" + $("#subid").val(),
        data: $.param(rowRequiredData),
        async: false,
        cache: false,
        // has to be sync else the form gets submitted before the response comes back from server
        error: function(jqXHR, textStatus, errorThrown) {
            alert("Failed check for duplicate subscription " + textStatus + ": " + errorThrown);
        },
        dataType: 'xml',
        success: function(xmlResponse) {
            var dup_journal_grp_ids = $(xmlResponse).find("row");
            if (dup_journal_grp_ids.length > 0) {
                isDuplicate = false;
                markDuplicates(dup_journal_grp_ids);
                var width = 480;
                var height = 140;
                var x = (window.screen.availWidth - width) / 2;
                var y = (window.screen.availHeight - height) / 2;
                var windowParameters = "dialogHeight: " + height + "px; dialogWidth: " + width + "px; dialogTop:" + y + "px; dialogLeft:" + x + "px; center:yes; resizeable: no; location:no; status:no; menubar: no; scrollbars: no; toolbar: no;";
                var ret = openModalPopUp("jsp/subscription/duplicate_subscription_confirm.jsp", "", windowParameters);
                var jdsconstants = new JDSConstants();
                if(ret == jdsconstants.SAVE_DUPLICATE_SUBSCRIPTION){
                    isDuplicate = false;
                }else if(ret == jdsconstants.CONVERT_SUBSCRIPTION_TO_PAYMENT){
                    isDuplicate = true;
                }else if(ret == jdsconstants.CANCEL){
                    isDuplicate = -1;
                }
            }

        }
    });

    return isDuplicate;
}

function markDuplicates(dup_journal_grp_ids) {
    var columnNames = $("#newSubscription").jqGrid('getGridParam', 'colModel');
    for (var i = 0; i < dup_journal_grp_ids.length; i++) {
        var journal_grp_id = parseInt(dup_journal_grp_ids[i].textContent);
        for (var key in journalNameToGroupIDMap) {
            if (journalNameToGroupIDMap.hasOwnProperty(key)) {
                if (journalNameToGroupIDMap[key] == journal_grp_id) {
                    for (var index in columnNames) {
                        var columnname = columnNames[index].name;
                        jQuery("#newSubscription").setCell(key, columnname, '', {
                            'background': '#F5C3C3'
                        });
                    }

                }
            }
        }
    }

}