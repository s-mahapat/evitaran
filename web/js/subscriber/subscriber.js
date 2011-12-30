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


function subtypeCodeAppend(){
    var subTypeDesc = document.subscriberForm.subtypedesc.options[document.subscriberForm.subtypedesc.selectedIndex].text;
    requestURL = "/JDS/CMasterData?md=subtype_code&mdvalue=" + subTypeDesc;
    $.ajax({
        type: "GET",
        url: requestURL, // change to full path of file on server
        dataType: "xml",
        success: function(xml){
            $(xml).find("subtypecode").each(function(){
                $("#subtypecode").text(("Subscriber Code - " + $(this).text()));
            });
        },
        error: function() {
            alert("XML File could not be found");
        }
    });
}