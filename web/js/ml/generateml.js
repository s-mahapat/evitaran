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

function checkMl(){
    
    //jQuery("#mlTable").trigger("clearGridData");
    $("#mlTable").jqGrid("clearGridData", true).trigger("reloadGrid");

    if ($("#year").val() == 0) {
        alert("Select Year");
    }

    else if ($("#journalName").val() == 0){
        alert("Select Journal");
    }

    else if ($("#month").val() == 'value'){
        alert("Select Month");
    }
    else if ($("#volume").val() == 'value'){
        alert("Select Volume Number");
    }

    else if ($("#issue").val() == 'value'){
        alert("Select Issue");
    }

    else if($("#mlCreationDate").val() == "") {
        alert("Please try again after logging in again ");
    }

    else {
        var mlid;
        $.ajax({
            type: 'POST',
            dataType: 'xml',
            async: false,
            url: "generateml?action=checkml&year=" +  $("#year").val()
            + "&journalName=" + $("#journalName").val()
            + "&volume=" + $("#volume").val()
            + "&mlCreationDate=" + $("#mlCreationDate").val()
            + "&issue=" + $("#issue").val(),

            success: function(xmlResponse, textStatus, jqXHR){

                $(xmlResponse).find("results").each(function(){
                    mlid = $(this).find("mlid").text();
                });
                if (mlid == 0){
                    $("#btnAdd").button("enable");
                }
                else {
                    alert("Mailing List already generated for Year: " +  $("#year").val() + ", Journal Name: " + $("#journalName").val()
                            + ", Volume Number: " + $("#volume").val() + ", Issue: " + $("#issue").val());
                }
                return true;
            },
            error: function(jqXHR,textStatus,errorThrown){
                alert("Failed to Generate Mailing List. : " + errorThrown);
                return false;
            }
           });
   }
 }

  function checkViewMl(){
      
    //jQuery("#mlTable").trigger("clearGridData");
    $("#mlTable").jqGrid("clearGridData", true).trigger("reloadGrid");    

    if ($("#year").val() == 0) {
        alert("Select Year");
    }
    else if ($("#month").val() == 0){
        alert("Select Month");
    }
    else if ($("#journalName").val() == 0){
        alert("Select Journal");
    }
    else if ($("#volume").val() == 'value'){
        alert("Select Volume Number");
    }
    else if ($("#issue").val() == 'value'){
        alert("Select Issue");
    }
    else if($("#mlCreationDate").val() == "") {
        alert("Please try again after logging in again ");
    }

    else {
        var mlid;
        $.ajax({
            type: 'POST',
            dataType: 'xml',
            async: false,
            url: "generateml?action=checkml&year=" +  $("#year").val()
            + "&journalName=" + $("#journalName").val()
            + "&volume=" + $("#volume").val()
            + "&mlCreationDate=" + $("#mlCreationDate").val()
            + "&issue=" + $("#issue").val(),

            success: function(xmlResponse, textStatus, jqXHR){

                $(xmlResponse).find("results").each(function(){
                    mlid = $(this).find("mlid").text();
                });
                if (mlid == 0){
                    alert("Mailing List not generated for Year: " +  $("#year").val() + ", Journal Name: " + $("#journalName").val()
                            + ", Volume Number: " + $("#volume").val() + ", Issue: " + $("#issue").val());

                }
                else {
                    $("#btnSearch").button("enable");
                }
                return true;
            },
            error: function(jqXHR,textStatus,errorThrown){
                alert("Failed to Generate Mailing List. : " + errorThrown);
                return false;
            }
           });
   }
 }




