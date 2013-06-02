
function makeEditSubscriberReadOnly(){

    $("#btnEditSubscriber").hide();
    document.getElementById("deactive").disabled = false;
}

function subtypeDescriptionAppend(){
    var subType = document.subscriberForm.subtype.options[document.subscriberForm.subtype.selectedIndex].text;
    requestURL = "/JDS/CMasterData?md=subtype_desc&mdvalue=" + subType;
    jdsAppend(requestURL,"subtypedesc","subtypedesc");
}

function subtypeAppend(){
    $("#subtypedesc").empty();
    $("#subtypecode").text("");
    var newOption = new Option("Select", "value");
    $(newOption).html("Select");
    $("#subtypedesc").append(newOption);
    var subType = document.subscriberForm.subtype.options[document.subscriberForm.subtype.selectedIndex].text;
    requestURL = "/JDS/CMasterData?md=subtype_desc&mdvalue=" + subType;
    jdsAppend(requestURL,"subtypedesc","subtypedesc");
}


// called when the deactive user check box is clicked
function deActivateSubscriber(){

    if(document.getElementById("deactive").checked){
        jdsConfirm("Do you really want to deactivate the subscriber?","",function(ret){
            if(!ret){
                $("#deactive").attr("checked",false);
            }else{
                $("#btnViewSubscription").attr("disabled",true);
                $("#btnAddSubscription").attr("disabled",true);
                //set the deactivation date only in the UI.
                var now = $.datepicker.formatDate("dd/mm/yy", new Date());
                $( "#deactivationDate" ).val(now);
            }
        });
    }else{
        $("#btnViewSubscription").attr("disabled",false);
        $("#btnAddSubscription").attr("disabled",false);
        $( "#deactivationDate" ).val("");
        $("#deactivationReason").val("");
    }
}
