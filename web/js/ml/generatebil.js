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