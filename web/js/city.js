function loadCities(){
    jdsAutoComplete("cities", "city", "city");
    $("#city").bind( "autocompletechange", function(event, ui) {
        if(!ui.item){
            alert("Please select item from the list only");
            $(this).val('');
            $(this).focus();
        }
    }); 
}