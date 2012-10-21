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

    if($("#selall").val() == 1 && $("#to").val() == 0){
        alert("Add email IDs in the \"To\" field");
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
            url: "BulkEmail?action=sendEmail&to=" + $("#to").val() + "&subject=" + $("#subject").val() + "&selectFromDb=" + $("#selall:checked").length +"&content=" + encodeURIComponent(text),
            success: function(xmlResponse, textStatus, jqXHR){

                $(xmlResponse).find("results").each(function(){
                    success1 = $(this).find("success").text();
                    if(success1.valueOf() == "1") {
                        alert("Email sent");
                    } else {
                        alert("Email not sent");
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

    if (document.getElementById("selall").value == 1 ){
        document.getElementById("selall").value = 0;
        document.getElementById('to').value = "";
        document.getElementById('to').disabled=true;
    }else {
        document.getElementById("selall").value = 1;
        document.getElementById('to').disabled=false;
    }
}



