/*
* To change this template, choose Tools | Templates
* and open the template in the editor.
*/

function validateIds(){
    $.ajax({
        type: 'GET',
        dataType: 'xml',
        async: false,
        url: "BulkEmail?action=validateEmail&to=" + $("#to").val(),
        success: function(xmlResponse, textStatus, jqXHR){

            $(xmlResponse).find("results").each(function(){
                success = $(this).find("success").text();
                message = $(this).find("message").text();
                if(success.valueOf() == "1") {
                    //alert("Email ID valid");
                } else {
                    alert("Email ID not valid: " + message);
                    //alert("Email ID not valid");
                }
            });
        },
        error: function(jqXHR,textStatus,errorThrown){
            alert("Failed to validate email ids " + textStatus + ": "+ errorThrown);
        }
    });
}

function sendmail(){
    var text = tinyMCE.get('content').getContent();
    //var text = tinyMCE.content.selection.getContent({format : 'text'});

    if($("#to").val() == 0 && $("#personal:checked").length == 0 
        && $("#isc:checked").length == 0 && $("#ii:checked").length == 0
        && $("#ic:checked").length == 0 && $("#free:checked").length == 0
        && $("#fp:checked").length == 0 && $("#fi:checked").length == 0){
        alert("Add email IDs in the \"To\" field or select at least one checkbox to select the value from database");
    }else if ($("#subject").val() == 0){
        alert("Subject cannot be empty");
    }/*else if ($("#content").val() == 0){
        alert("Email Content cannot be empty");
    }*/
    else if(!text){
        alert("Email Content cannot be empty");
    }
    else {
        $.ajax({
            type: 'POST',
            dataType: 'xml',
            async: false,
            //url: "BulkEmail?action=sendEmail&to=" + $("#to").val() + "&subject=" + $("#subject").val() + "&selectFromDb=" + $("#selall:checked").length +"&content=" + $("#content").val(),
            //url: "BulkEmail?action=sendEmail&to=" + $("#to").val() + "&subject=" + $("#subject").val() + "&selectFromDb=" + $("#selall:checked").length +"&content=" + text,
            url: "BulkEmail?action=sendEmail&to=" + $("#to").val() + "&subject=" + $("#subject").val() +
                            "&personal=" + $("#personal:checked").length +  "&isc=" + $("#isc:checked").length + "&ii=" + $("#ii:checked").length +
                            "&ic=" + $("#ic:checked").length +  "&free=" + $("#free:checked").length + "&fp=" + $("#fp:checked").length + "&fi=" + $("#fi:checked").length +
                            "&content=" + encodeURIComponent(text),
            success: function(xmlResponse, textStatus, jqXHR){

                $(xmlResponse).find("results").each(function(){
                    success1 = $(this).find("success").text();
                    message = $(this).find("message").text();
                    if(success1.valueOf() == "1") {
                        alert("Email sent");
                    } else {
                        alert("Email not sent: " + message);
                    }
                    return true;
                });
            },
            error: function(jqXHR,textStatus,errorThrown){
                alert("Failed to send email " + textStatus + ": "+ errorThrown);
                return false;
            }
        });
    }
}

function getChecked(){

    if (document.getElementById("personal").value == 1 ){
        document.getElementById("personal").value = 0;        
    }else {
        document.getElementById("personal").value = 1;        
    }
    if (document.getElementById("isc").value == 1 ){
        document.getElementById("isc").value = 0;        
    }else {
        document.getElementById("isc").value = 1;        
    }
    if (document.getElementById("ic").value == 1 ){
        document.getElementById("ic").value = 0;        
    }else {
        document.getElementById("ic").value = 1;        
    }
    
    if (document.getElementById("ii").value == 1 ){
        document.getElementById("ii").value = 0;        
    }else {
        document.getElementById("ii").value = 1;        
    }
    
    if (document.getElementById("free").value == 1 ){
        document.getElementById("free").value = 0;        
    }else {
        document.getElementById("fp").value = 1;        
    }
    
    if (document.getElementById("fp").value == 1 ){
        document.getElementById("fp").value = 0;        
    }else {
        document.getElementById("fp").value = 1;        
    }
    
    if (document.getElementById("fi").value == 1 ){
        document.getElementById("fi").value = 0;        
    }else {
        document.getElementById("fi").value = 1;        
    }
}



