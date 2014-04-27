/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

function showPrintPreview(){
    if($("#mlTypeSticker").attr('checked')){
        _showPrintPreviewSticker();
    }else if($("#mlTypeLabel").attr('checked')){
        _showPrintPreviewLabel();
    }
}

function getMailingList(){
    isPageLoaded = true;
    jQuery("#datatable").trigger("reloadGrid");
}

/*
 * Shows the print preview for sticker.
 */
function _showPrintPreviewSticker(){
    var htmlStr = _generateSticker();
    $("#printPreview").html(htmlStr);
    $("#btnPrintPreview").printPreview();
    return false;
}

/*
 * Shows the print preview for sticker.
 */
function _showPrintPreviewLabel(){
    var htmlStr = _generateLabel();
    $("#printPreview").html(htmlStr);
    $("#btnPrintPreview").printPreview();
    return false;
}


function _generateSticker(){
    var ids = jQuery("#datatable").jqGrid('getDataIDs');
    var htmlStr = '&nbsp;';
    var isLeftSticker = true;
    for (var i = 0; i < ids.length; i++) {
        var rowId = ids[i];
        var subscriberId = jQuery("#datatable").jqGrid('getCell',rowId, 'SubscriberID');
        var journalCode = jQuery("#datatable").jqGrid('getCell',rowId, 'JournalCode');
        var copies = jQuery("#datatable").jqGrid('getCell',rowId, 'CopiesCount');
        var subscriptionPeriod = jQuery("#datatable").jqGrid('getCell',rowId, 'SubscriptionPeriod');
        var subsriberName = jQuery("#datatable").jqGrid('getCell',rowId, 'SubscriberName');
        var subsriberAdd = jQuery("#datatable").jqGrid('getCell',rowId, 'Address');
        // for left sticker
        if(isLeftSticker){
            htmlStr += '<div class="IASFormLeftDiv"><div class="sticker"><div class="stickerAddressDiv">' +
            subscriberId + "  " + journalCode + "/" + copies + " " + subscriptionPeriod + "<br>" +
            subsriberName + "<br>" +
            subsriberAdd + '</div></div></div>';
            isLeftSticker = false;
        }else{
            htmlStr += '<div class="IASFormRightDiv"><div class="sticker"><div class="stickerAddressDiv">' +
            subscriberId + "  " + journalCode + "/" + copies + " " + subscriptionPeriod + "<br>" +
            subsriberName + "<br>" +
            subsriberAdd + '</div></div></div>';
            isLeftSticker = true;
        }
    }
    return htmlStr;
}

function _generateLabel(){
    var ids = jQuery("#datatable").jqGrid('getDataIDs');
    var htmlStr = '&nbsp;';
    var isLeftSticker = true;
    for (var i = 0; i < ids.length; i++) {
        var rowId = ids[i];
        var subscriberId = jQuery("#datatable").jqGrid('getCell',rowId, 'SubscriberID');
        var journalCode = jQuery("#datatable").jqGrid('getCell',rowId, 'JournalCode');
        var copies = jQuery("#datatable").jqGrid('getCell',rowId, 'CopiesCount');
        var subscriptionPeriod = jQuery("#datatable").jqGrid('getCell',rowId, 'SubscriptionPeriod');
        var subsriberName = jQuery("#datatable").jqGrid('getCell',rowId, 'SubscriberName');
        var subsriberAdd = jQuery("#datatable").jqGrid('getCell',rowId, 'Address');
        // for left sticker
        if(isLeftSticker){
            htmlStr += '<div class="IASFormFieldDiv"><div class="label"><div class="labelAddressDiv">' +
            subscriberId + "  " + journalCode + "/" + copies + " " + subscriptionPeriod + "<br>" +
            subsriberName + "<br>" +
            subsriberAdd + '</div></div></div>';
            isLeftSticker = false;
        }else{
            htmlStr += '<div class="IASFormFieldDiv"><div class="label"><div class="labelAddressDiv">' +
            subscriberId + "  " + journalCode + "/" + copies + " " + subscriptionPeriod + "<br>" +
            subsriberName + "<br>" +
            subsriberAdd + '</div></div></div>';
            isLeftSticker = true;
        }
    }
    return htmlStr;
}

function printLabelGbil()
{
    var arrRowData = $("#bilTable").getRowData();
    var rowRequiredData = [];
    var ids = $("#bilTable").getDataIDs();
    //var ids = jQuery("#bilTable").jqGrid('getDataIDs');

    for(intIndex in arrRowData){
        var rowObj = arrRowData[intIndex];
        /*pick on required fields from the UI. Not fields are requred, they can be derieved from the database itself.
         * e.g. the journal name can be derieved from the code if required.
         */
        rowRequiredData.push({
            name: "bilid",
            value: rowObj.bilid
        });        
    }
    
    
    $('#bilid').val($.param(rowRequiredData));
    //$('#bil_ids').val(rowRequiredData);
    var x = "printLabelGbil";
    $('#action').val(x);   

    /*
    $.ajax({
        type: 'POST',
        url: "generatebil?action=printLabelGbil",
        data: $.param(rowRequiredData),
        success: function(xmlResponse, textStatus, jqXHR){

            if(xmlResponse == null){
                alert("Failed to Print");
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
            alert("Failed to Print" + errorThrown);
        },
        dataType: 'xml'
    });
    */
}

function printStickerGbil()
{
    var arrRowData = $("#bilTable").getRowData();
    var rowRequiredData = [];
    var ids = $("#bilTable").getDataIDs();
    //var ids = jQuery("#bilTable").jqGrid('getDataIDs');

    for(intIndex in arrRowData){
        var rowObj = arrRowData[intIndex];
        /*pick on required fields from the UI. Not fields are requred, they can be derieved from the database itself.
         * e.g. the journal name can be derieved from the code if required.
         */
        rowRequiredData.push({
            name: "bilid",
            value: rowObj.bilid
        });        
    }
    
    
    $('#bilid').val($.param(rowRequiredData));
    //$('#bil_ids').val(rowRequiredData);
    var x = "printStickerGbil";
    $('#action').val(x); 
}
