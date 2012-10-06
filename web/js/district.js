function loadDistricts (){
    jdsAutoComplete("districts", "district", "district");
    $("#district").bind( "autocompletechange", function(event, ui) {
        if(!ui.item){
            alert("Please select item from the list only");
            $(this).val('');
            $(this).focus();
        }
    });

}