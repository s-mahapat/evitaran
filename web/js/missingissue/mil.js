/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

function printMissingInfo(){
    var arrRowData = $("#milTable").getRowData();
    var rowRequiredData = [];
    var ids = $("#milTable").getDataIDs();
    if(ids.length == 0){
        alert("No Missing Issue to print");
        return;
    }
    for(intIndex in arrRowData){
        var rowObj = arrRowData[intIndex];
        /*pick on required fields from the UI. Not fields are requred, they can be derieved from the database itself.
         * e.g. the journal name can be derieved from the code if required.
         */
        rowRequiredData.push({
            name: "miId",
            value: rowObj.id
        });
    }
    $('#rowRequiredData1').val(rowRequiredData);

    $.ajax({
        type: 'POST',
        url: "generatemil?action=print"
            + "&subscriberNumber=" + $("#subscriberNumber").val()
            + "&from=" + $("#from").val()
            + "&to=" + $("#to").val()
            + "&printType=" + $("#printType").val(),
        data: $.param(rowRequiredData),
        success: function(xmlResponse, textStatus, jqXHR){

            if(xmlResponse == null){
                alert("Failed to add Missing Issue");
                return false;
            }
            $(xmlResponse).find("results").each(function(){
                var error = $(this).find("error").text();
                var mailingids = $(this).find("mailingids").text(); 
                document.forms["milForm"].mailingids.value = mailingids;
                
                if(error){
                    alert(error);
                }
                else {
                    document.milForm.submit();
                }
            });
        },
        error: function(jqXHR,textStatus,errorThrown){
            alert("Failed to save missing issue " + textStatus + ": "+ errorThrown);
        },
        dataType: 'xml'
    });
}

