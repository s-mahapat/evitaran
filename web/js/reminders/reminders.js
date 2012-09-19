function emailReminders(){
    var act;
    $.ajax({
        type: 'POST',
        dataType: 'xml',
        async: false,
        url: "reminders?action=send"
        + "&reminderType=" +  $("#reminderType").val()
        + "&reminderDate=" + $("#reminderDate").val()
        + "&medium=" + $("#medium").val(),
        success: function(xmlResponse, textStatus, jqXHR){

            $(xmlResponse).find("results").each(function(){
                act = $(this).find("action").text();
            });
            if(act == 'failure')
            {
                alert("Failed to send emails");
                $("#btnPrintSend").button("disable");
                return false;
            }
            if(act == 'success')
                alert("Emails sent");

            $("#btnPrintSend").button("disable");

            return true;

        },
        error: function(jqXHR,textStatus,errorThrown){
            alert("Failed to sent mail " + textStatus + ": "+ errorThrown);
            return false;
        }
       });
}


